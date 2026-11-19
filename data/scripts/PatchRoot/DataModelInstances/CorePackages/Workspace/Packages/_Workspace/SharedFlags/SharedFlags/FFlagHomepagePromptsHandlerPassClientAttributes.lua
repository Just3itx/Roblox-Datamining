-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:20:59Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagPromptsHandlerEnabled = require(script.Parent.FFlagPromptsHandlerEnabled)

return game:DefineFastFlag("HomepagePromptsHandlerPassClientAttributes", false) and FFlagPromptsHandlerEnabled
