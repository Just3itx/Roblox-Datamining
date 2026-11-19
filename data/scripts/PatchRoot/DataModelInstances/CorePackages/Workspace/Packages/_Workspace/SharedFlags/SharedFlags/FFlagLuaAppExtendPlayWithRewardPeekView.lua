-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T14:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnablePlayWithRewardComponent = require(script.Parent.FFlagEnablePlayWithRewardComponent)

local FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable = require(script.Parent.FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable)

return FFlagEnablePlayWithRewardComponent
    and FFlagLuaAppEdpUseHidePlayWithRewardVisibilityVariable
    and game:DefineFastFlag("LuaAppExtendPlayWithRewardPeekView", false)
