-- Window rules
hl.window_rule({workspace = "2", match = {title = ".*Brave.*"}})
hl.window_rule({workspace = "3", match = {title = ".*Visual Studio.*"}})
hl.window_rule({workspace = "4", match = {title = ".*Obsidian.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Dolphin.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Discord.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Telegram.*"}})

hl.layer_rule({
  name = "noctalia",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true
})
