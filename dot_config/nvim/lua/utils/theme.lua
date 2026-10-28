local M = {}

local theme_file = vim.fn.stdpath("state") .. "/theme.txt"
local default_theme = "catppuccin-mocha"

M.transparent = true

M.plugins = {
    "catppuccin",
    "rose-pine",
    "tokyonight.nvim",
    "kanagawa.nvim",
    "gruvbox-material",
    "vesper.nvim",
    "cyberdream.nvim",
    "onedarkpro.nvim",
}

function M.is_transparent()
    return M.transparent
end

local function read_state()
    local f = io.open(theme_file, "r")
    if not f then
        return default_theme, true
    end
    local theme = f:read("*l")
    local trans = f:read("*l")
    f:close()
    local resolved_theme = (theme and theme ~= "") and vim.trim(theme) or default_theme
    local resolved_trans = true
    if trans and vim.trim(trans) == "opaque" then
        resolved_trans = false
    end
    return resolved_theme, resolved_trans
end

local function write_state(theme, transparent)
    if not theme or theme == "" then
        return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(theme_file, ":h"), "p")
    local f = io.open(theme_file, "w")
    if f then
        f:write(theme .. "\n")
        f:write((transparent and "transparent" or "opaque") .. "\n")
        f:close()
    end
end

local function apply_transparency()
    if not M.transparent then
        return
    end
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        "FloatFooter",
        "SignColumn",
        "FoldColumn",
        "EndOfBuffer",
        "StatusLine",
        "StatusLineNC",
        "WinBar",
        "WinBarNC",
        "WinSeparator",
        "VertSplit",
        "Pmenu",
        "PmenuBorder",
        "PmenuSbar",
        "PmenuKind",
        "PmenuExtra",
        "SnacksNormal",
        "SnacksNormalNC",
        "SnacksWinBar",
        "SnacksWinBarNC",
        "SnacksBorder",
        "SnacksTitle",
        "SnacksFooter",
        "SnacksBackdrop",
        "SnacksPicker",
        "SnacksPickerBorder",
        "SnacksPickerTitle",
        "SnacksPickerFooter",
        "SnacksPickerBox",
        "SnacksPickerBoxBorder",
        "SnacksPickerBoxTitle",
        "SnacksPickerInput",
        "SnacksPickerInputBorder",
        "SnacksPickerInputTitle",
        "SnacksPickerList",
        "SnacksPickerListBorder",
        "SnacksPickerListTitle",
        "SnacksPickerPreview",
        "SnacksPickerPreviewBorder",
        "SnacksPickerPreviewTitle",
        "SnacksInputNormal",
        "SnacksInputBorder",
        "SnacksInputTitle",
        "SnacksNotifierMinimal",
        "SnacksNotifierHistory",
    }
    for _, group in ipairs(groups) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl and next(hl) ~= nil then
            hl.bg = nil
            hl.ctermbg = nil
            pcall(vim.api.nvim_set_hl, 0, group, hl)
        end
    end
end

local transparent_opacity = "0.65" -- debe coincidir con background_opacity de kitty.conf
local in_kitty = vim.env.KITTY_WINDOW_ID ~= nil or vim.env.KITTY_LISTEN_ON ~= nil
local last_kitty_state

local function kitty_send(seq)
    if vim.env.TMUX then
        -- passthrough de tmux: requiere `set -g allow-passthrough on`
        seq = "\27Ptmux;" .. seq:gsub("\27", "\27\27") .. "\27\\"
    end
    vim.api.nvim_chan_send(vim.v.stderr, seq)
end

-- Dentro de tmux, KITTY_LISTEN_ON puede venir de un kitty que ya no existe.
-- tmux guarda el valor actual en el entorno de la sesión.
local function kitty_socket()
    if vim.env.TMUX then
        local out = vim.fn.system({ "tmux", "show-environment", "KITTY_LISTEN_ON" })
        local sock = out:match("^KITTY_LISTEN_ON=(.-)%s*$")
        if vim.v.shell_error == 0 and sock and sock ~= "" then
            return sock
        end
    end
    return vim.env.KITTY_LISTEN_ON
end

local warned_socket = false

local function kitty_opacity(value, sync)
    local socket = kitty_socket()
    if not socket then
        if not warned_socket then
            warned_socket = true
            vim.notify(
                "kitty: falta el socket de control. Agrega 'listen_on unix:/tmp/kitty' a kitty.conf y reinicia kitty.",
                vim.log.levels.WARN
            )
        end
        return
    end
    local cmd = { "kitten", "@", "--to", socket, "set-background-opacity", value }
    if sync then
        vim.fn.system(cmd)
        return
    end
    local err = {}
    local ok, id = pcall(vim.fn.jobstart, cmd, {
        stderr_buffered = true,
        on_stderr = function(_, data)
            err = data
        end,
        on_exit = function(_, code)
            if code ~= 0 then
                local msg = vim.trim(table.concat(err or {}, "\n"))
                vim.schedule(function()
                    vim.notify("kitty: no se pudo cambiar la opacidad. " .. msg, vim.log.levels.WARN)
                end)
            end
        end,
    })
    if not ok or id <= 0 then
        vim.notify("kitty: no se encontró el comando 'kitten'", vim.log.levels.WARN)
    end
end

-- Sincroniza el padding de kitty con el fondo actual de Neovim
function M.sync_kitty()
    if not in_kitty then
        return
    end

    local state
    if M.transparent then
        state = "transparent"
    else
        local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
        state = bg and string.format("#%06x", bg) or "default"
    end

    if state == last_kitty_state then
        return
    end
    last_kitty_state = state

    if state == "transparent" or state == "default" then
        kitty_send("\27]111\27\\") -- restaura el fondo por defecto de kitty
        kitty_opacity(transparent_opacity)
    else
        kitty_send(string.format("\27]11;%s\27\\", state)) -- el padding toma el fondo del tema
        kitty_opacity("1") -- sin esto el padding queda translúcido
    end
end

local function restore_kitty()
    if not in_kitty then
        return
    end
    kitty_send("\27]111\27\\")
    kitty_opacity(transparent_opacity, true) -- síncrono: Neovim está cerrando
    last_kitty_state = nil
end

local function reconfigure_loaded_themes()
    local cfg = require("config.plugins")
    if package.loaded["catppuccin"] then
        require("catppuccin").setup(cfg.catppuccin())
    end
    if package.loaded["rose-pine"] then
        require("rose-pine").setup(cfg.rose_pine())
    end
    if package.loaded["tokyonight"] then
        require("tokyonight").setup(cfg.tokyonight())
    end
    if package.loaded["kanagawa"] then
        require("kanagawa").setup(cfg.kanagawa())
    end
    if package.loaded["vesper"] then
        require("vesper").setup(cfg.vesper())
    end
    if package.loaded["cyberdream"] then
        require("cyberdream").setup(cfg.cyberdream())
    end
    if package.loaded["onedarkpro"] then
        require("onedarkpro").setup(cfg.onedarkpro())
    end
    if vim.g.gruvbox_material_background ~= nil then
        cfg.gruvbox_material()
    end
end

function M.setup()
    local current, trans = read_state()
    M.transparent = trans

    local group = vim.api.nvim_create_augroup("DynamicTheme", { clear = true })

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = function()
            if M.transparent then
                apply_transparency()
                vim.schedule(apply_transparency)
            end
            if vim.g.colors_name then
                write_state(vim.g.colors_name, M.transparent)
            end
            M.sync_kitty()
        end,
    })

    vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
        group = group,
        callback = restore_kitty,
    })
    vim.api.nvim_create_autocmd({ "VimResume", "FocusGained" }, {
        group = group,
        callback = function()
            last_kitty_state = nil
            M.sync_kitty()
        end,
    })

    if not pcall(vim.cmd.colorscheme, current) then
        pcall(vim.cmd.colorscheme, default_theme)
    end
end

function M.toggle_transparency()
    M.transparent = not M.transparent
    reconfigure_loaded_themes()
    local current = vim.g.colors_name or default_theme
    pcall(vim.cmd.colorscheme, current)
    vim.notify("Fondo: " .. (M.transparent and "transparente" or "opaco"))
end

function M.pick()
    require("lazy").load({ plugins = M.plugins })
    reconfigure_loaded_themes()
    Snacks.picker.colorschemes()
end

return M
