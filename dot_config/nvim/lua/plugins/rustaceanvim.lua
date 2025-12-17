return {
	"mrcjkb/rustaceanvim",
	ft = "rust",
	config = function()
		local mason_root = require("mason.settings").current.install_root_dir
		local extension_path = mason_root .. "packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
		local cfg = require("rustaceanvim.config")

		vim.g.rustaceanvim = {
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
			}
		}
	end
}
