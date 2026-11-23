-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXUseUFRForTimeoutPromptInApp = require(script.Parent.FFlagAXUseUFRForTimeoutPromptInApp)
local FFlagAXUseUFRForTimeoutPromptInExperience = require(script.Parent.FFlagAXUseUFRForTimeoutPromptInExperience)

return game:DefineFastFlag("AXTimeoutAcknowledgementGating", false)
    and FFlagAXUseUFRForTimeoutPromptInApp
    and FFlagAXUseUFRForTimeoutPromptInExperience
