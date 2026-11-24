-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnableInExperienceShopUnifiedLogging = require(script.Parent.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagLuaAppEnableGamePassFreeTrials = require(script.Parent.FFlagLuaAppEnableGamePassFreeTrials)

return game:DefineFastFlag("EnableGamePassTrialUnifiedLogging", false)
    and FFlagEnableInExperienceShopUnifiedLogging
    and FFlagLuaAppEnableGamePassFreeTrials
