-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local Utility = require(RobloxGui.Modules.Settings.Utility)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local scriptParent = script.Parent

local FFlagPlayerListPersistVisibility = require(scriptParent.Flags.FFlagPlayerListPersistVisibility)
local FStringPlayerListOverrideType = require(scriptParent.Flags.FStringPlayerListOverrideType)
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local isReskinConsoleMobileRoute = PlayerList.Common.isReskinConsoleMobileRoute
local FFlagPlayerListUseMobileOnSmallDisplay = PlayerList.Flags.FFlagPlayerListUseMobileOnSmallDisplay

local FFlagLuaSupportMicroGamepadPreferredInput = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function isTouchOrGamepad(preferredInput) -- Luacid: Inlined by compiler; 1 call site recovered
    return preferredInput == Enum.PreferredInput.Touch
        or preferredInput == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and preferredInput == Enum.PreferredInput.MicroGamepad
end

local function isCurrentReskinConsoleMobileRoute(preferredInput) -- Luacid: Inlined by compiler; 2 call sites recovered
    return isReskinConsoleMobileRoute({ displaySize = GuiService.ViewportDisplaySize, preferredInput = preferredInput })
end

local function isSmallTouchScreen(preferredInput)
    if isCurrentReskinConsoleMobileRoute(preferredInput) then
        return true
    end

    local bool1 = if FFlagPlayerListUseMobileOnSmallDisplay then GuiService.ViewportDisplaySize == Enum.DisplaySize.Small else false
    local bool2 = if FFlagEnableMobilePlayerListOnConsole then GuiService.ViewportDisplaySize == Enum.DisplaySize.Large else false
    local var1 = if FFlagEnableMobilePlayerListOnConsole or FFlagPlayerListUseMobileOnSmallDisplay then isTouchOrGamepad(preferredInput) else false
    return Utility:IsSmallTouchScreen()
        or FFlagEnableMobilePlayerListOnConsole and bool2 and var1
        or FFlagPlayerListUseMobileOnSmallDisplay and bool1 and var1
        or FStringPlayerListOverrideType == "mobile"
end

return function(arg1)
    if arg1 == nil then
        arg1 = UserInputService.PreferredInput
    end

    local var1 = not isSmallTouchScreen(arg1)
        and not VRService.VREnabled
        and (isCurrentReskinConsoleMobileRoute(arg1) or FFlagEnableMobilePlayerListOnConsole or not TenFootInterface:IsEnabled())

    if var1 then
        if FFlagPlayerListPersistVisibility then
            return UserSettings().GameSettings.PlayerListVisible
        end

        var1 = true
    end

    return var1
end
