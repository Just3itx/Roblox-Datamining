-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:40:53Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagEnablePlayWithRewardComponent = require(script.Parent.FFlagEnablePlayWithRewardComponent)

local FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable = require(script.Parent.FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable)

return FFlagEnablePlayWithRewardComponent
    and FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable
    and game:DefineFastFlag("LuaAppExtendPlayWithRewardPeekView", false)
