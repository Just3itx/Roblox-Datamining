-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent
local CentralOverlay = require(PlayerContextualMenuParent.CentralOverlay)
local RobloxAppEnums = require(PlayerContextualMenuParent.RobloxAppEnums)

local _Components = require(script.Parent.Components)

return function(arg1)
    return function(arg2)
        arg2:dispatch(CentralOverlay.Actions.SetCentralOverlay(RobloxAppEnums.CentralOverlayType.PlayerContextualMenu, arg1))
    end
end
