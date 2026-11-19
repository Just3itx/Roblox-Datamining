-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagPromptsHandlerEnabled = require(script.Parent.FFlagPromptsHandlerEnabled)

return game:DefineFastFlag("EdpOpenPromptsHandlerEnabled", false) and FFlagPromptsHandlerEnabled
