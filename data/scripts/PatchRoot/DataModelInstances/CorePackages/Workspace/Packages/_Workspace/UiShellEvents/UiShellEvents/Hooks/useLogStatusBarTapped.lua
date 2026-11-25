-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UiShellEventsParent = UiShellEvents.Parent
local React = require(UiShellEventsParent.React)
local useNavigation = require(UiShellEventsParent.Navigation).useNavigation
local useRoactService = require(UiShellEventsParent.RobloxAppHooks).useRoactService
local getCurrentRouteState = require(UiShellEventsParent.Navigation).getCurrentRouteState
local AppEventIngestService = require(UiShellEventsParent.RoactServiceTags).AppEventIngestService
local AppUserInputService = require(UiShellEventsParent.RoactServiceTags).AppUserInputService
local uiStatusBarTappedEvent = require(UiShellEvents.Analytics.uiStatusBarTappedEvent)

local function useLogStatusBarTapped(str1: string?)
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useRoactService(AppUserInputService)
    local var3 = useNavigation()

    local currentRouteState = getCurrentRouteState(var3) or {}
    local page = str1 or currentRouteState.name or "Unknown"

    React.useEffect(function()
        local connection = var2.StatusBarTapped:Connect(function()
            uiStatusBarTappedEvent(var1, "StatusBar", { page = page })
        end)

        return function()
            connection:Disconnect()
        end
    end, { var1, var2, page })
end

return useLogStatusBarTapped
