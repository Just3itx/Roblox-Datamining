-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local ReactFocusNavigation = require(AppShortcutBarParent.ReactFocusNavigation)
local Responsive = require(AppShortcutBarParent.Responsive)
local RoactUtils = require(AppShortcutBarParent.RoactUtils)
local useProperty = require(AppShortcutBarParent.GuiObjectUtils).useProperty
local useSignalState = require(AppShortcutBarParent.SignalsReact).useSignalState
local RobloxAppEnums = require(AppShortcutBarParent.RobloxAppEnums)
local LoginStatus = RobloxAppEnums.LoginStatus
local AppPage = RobloxAppEnums.AppPage

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useIsTvRemoteDevice = RoactUtils.Hooks.useIsTvRemoteDevice
local useIsRealGamepadConnected = RoactUtils.Hooks.useIsRealGamepadConnected

local SharedFlags = require(AppShortcutBarParent.SharedFlags)
local FFlagUseSignalsForAuthenticationStatus = SharedFlags.FFlagUseSignalsForAuthenticationStatus
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput
local FFlagStickyShortcutBarTvRemoteWithGamepad = require(AppShortcutBar.Flags).FFlagStickyShortcutBarTvRemoteWithGamepad
local FFlagUnifyShortcutBarQA = SharedFlags.FFlagUnifyShortcutBarQA
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AppShortcutBarParent.AuthenticationStatus).GetAuthenticationStatusStore else nil

local function selectUserLoggedIn(arg1)
    return arg1.AuthenticationStatus and arg1.AuthenticationStatus.status == LoginStatus.LOGGED_IN
end

local function useIsStickyShortcutBarEnabled(adjustScreen: string?)
    local bool1 = ReactFocusNavigation.useFocusedGuiObject() ~= nil
    local bool2 = Responsive.usePreferredInput() == Responsive.Input.Directional
    local bool3 = Responsive.useOrientation() == Responsive.Keys.Portrait
    if FFlagUnifyShortcutBarQA then
        local var1 = useProperty(UserInputService, "TouchEnabled")
        bool3 = bool3 and var1
    end

    local bool4 = if FFlagStickyShortcutBarTvRemoteWithGamepad then useIsTvRemoteDevice() elseif FFlagLuaSupportMicroGamepadPreferredInput then useProperty(UserInputService, "PreferredInput") == Enum.PreferredInput.MicroGamepad else useIsTvRemoteDevice()
    local var1 = if FFlagStickyShortcutBarTvRemoteWithGamepad then useIsRealGamepadConnected() else false
    local bool5 = if FFlagUseSignalsForAuthenticationStatus then useSignalState(GetAuthenticationStatusStore(false).getStatus) == LoginStatus.LOGGED_IN else useSelector(selectUserLoggedIn)
    return (bool1 or bool2) and bool5 and adjustScreen ~= AppPage.AdjustScreen and not bool3 and (not bool4 or var1)
end

return useIsStickyShortcutBarEnabled
