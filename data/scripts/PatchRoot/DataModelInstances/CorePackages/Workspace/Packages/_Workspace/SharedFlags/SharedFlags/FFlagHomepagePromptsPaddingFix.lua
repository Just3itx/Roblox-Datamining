-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:21:01Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagHomePagePromptsHandlerEnabled = require(script.Parent.FFlagHomePagePromptsHandlerEnabled)
return game:DefineFastFlag("HomepagePromptsPaddingFix", false) and FFlagHomePagePromptsHandlerEnabled
