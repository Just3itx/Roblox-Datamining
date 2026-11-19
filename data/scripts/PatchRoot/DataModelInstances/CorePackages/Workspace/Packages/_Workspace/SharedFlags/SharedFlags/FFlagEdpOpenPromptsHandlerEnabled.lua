-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:31:17Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagPromptsHandlerEnabled = require(script.Parent.FFlagPromptsHandlerEnabled)

return game:DefineFastFlag("EdpOpenPromptsHandlerEnabled", false) and FFlagPromptsHandlerEnabled
