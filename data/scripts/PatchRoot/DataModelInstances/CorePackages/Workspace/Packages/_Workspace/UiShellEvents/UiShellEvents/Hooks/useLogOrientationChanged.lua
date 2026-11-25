-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UiShellEventsParent = UiShellEvents.Parent
local React = require(UiShellEventsParent.React)
local useNavigation = require(UiShellEventsParent.Navigation).useNavigation
local useCurrentCamera = require(UiShellEventsParent.RobloxAppHooks).useCurrentCamera
local useDeviceOrientation = require(UiShellEventsParent.RobloxAppHooks).useDeviceOrientation
local getCurrentRouteState = require(UiShellEventsParent.Navigation).getCurrentRouteState
local _RobloxAppEnums = require(UiShellEventsParent.RobloxAppEnums)
local orientationChangedEvent = require(UiShellEvents.Analytics.orientationChangedEvent)

local bool1 = game:DefineFastFlag("LogSessionOnOrientationChange", false)
local SessionService = if bool1 then game:GetService("SessionService") else nil
local tbl1 = {
    [Enum.ScreenOrientation.LandscapeLeft] = "LandscapeLeft",
    [Enum.ScreenOrientation.LandscapeRight] = "LandscapeRight",
    [Enum.ScreenOrientation.LandscapeSensor] = "LandscapeSensor",
    [Enum.ScreenOrientation.Portrait] = "Portrait",
    [Enum.ScreenOrientation.Sensor] = "Sensor"
}

local function round(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.floor(num1 or 0.5)
end

local function useLogOrientationChanged(arg1, arg2, str1: string?)
    local var1 = useNavigation()
    local var2 = useCurrentCamera()
    local deviceOrientation = useDeviceOrientation()

    local currentRouteState = getCurrentRouteState(var1) or {}
    local page = str1 or currentRouteState.name
    local experienceOrientation = tbl1[arg2]

    React.useEffect(function()
        local universeId = tostring(game.GameId)
        local str3 = if universeId == "0" then "app" else "experience"

        if not deviceOrientation and not experienceOrientation then
            return
        end

        local sessionId = nil
        local sessionId2 = nil
        local sessionTag = nil
        local sessionTag2 = nil

        if bool1 and SessionService then
            if SessionService:SessionExists("level2a") then
                sessionId = SessionService:GetSessionID("level2a")
                sessionTag = SessionService:GetSessionTag("level2a")
            end
            if SessionService:SessionExists("level2b") then
                sessionId2 = SessionService:GetSessionID("level2b")
                sessionTag2 = SessionService:GetSessionTag("level2b")
            end
        end

        orientationChangedEvent(arg1, str3, {
            deviceOrientation = deviceOrientation,
            experienceOrientation = experienceOrientation,
            page = page,
            viewportX = round(var2.ViewportSize.X),
            viewportY = round(var2.ViewportSize.Y),
            universeId = universeId,
            l2a_session_id = sessionId,
            l2b_session_id = sessionId2,
            l2a_session_tag = sessionTag,
            l2b_session_tag = sessionTag2
        })
    end, { arg1, deviceOrientation, experienceOrientation })
end

return useLogOrientationChanged
