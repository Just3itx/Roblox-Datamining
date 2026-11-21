-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryRoutingParent = script:FindFirstAncestor("DiscoveryRouting").Parent
local NavigateDown = require(DiscoveryRoutingParent.NavigationRodux).Thunks.NavigateDown
local RobloxAppEnums = require(DiscoveryRoutingParent.RobloxAppEnums)
local AppPage = RobloxAppEnums.AppPage
local DeviceType = RobloxAppEnums.DeviceType
local getDeviceType = require(DiscoveryRoutingParent.AppCommonLib).getDeviceType
local SharedFlags = require(DiscoveryRoutingParent.SharedFlags)
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(DiscoveryRoutingParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagUseSignalsForDeviceOrientation = SharedFlags.FFlagUseSignalsForDeviceOrientation
local GetDeviceOrientationStore = if FFlagUseSignalsForDeviceOrientation then require(DiscoveryRoutingParent.DeviceOrientationStore).GetDeviceOrientationStore else nil

return function(title: string, body: string)
    return function(arg1)
        local var1 = if FFlagUseSignalsForDeviceOrientation then GetDeviceOrientationStore(false).getDeviceOrientation(false) else arg1:getState().DeviceOrientation
        local deviceType = getDeviceType(var1)
        if deviceType ~= DeviceType.Phone and deviceType ~= DeviceType.Tablet then
            return
        end

        local tbl1 = {
            name = AppPage.InfoPeekView,
            extraProps = { title = title, body = body }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end
