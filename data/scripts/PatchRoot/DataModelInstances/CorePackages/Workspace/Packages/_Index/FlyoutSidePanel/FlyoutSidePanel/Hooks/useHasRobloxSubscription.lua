-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local useSelector = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useSelector

local FFlagEnableBlackbirdCheck = require(FlyoutSidePanelParent.SharedFlags).FFlagEnableBlackbirdCheck

local function useHasRobloxSubscription()
    if not FFlagEnableBlackbirdCheck then
        return false
    end
    return useSelector(function(arg1): boolean
        local user = arg1.Users[arg1.LocalUserId]
        return not not (user and user.hasRobloxSubscription == true)
    end)
end

return useHasRobloxSubscription
