-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")
local GuiService = game:GetService("GuiService")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local scriptParentParent = script.Parent.Parent

local Actions = script.Parent.Parent.Actions
local SetPlayerListVisibility = require(Actions.SetPlayerListVisibility)
local SetPlayerListEnabled = require(Actions.SetPlayerListEnabled)
local SetTempHideKey = require(Actions.SetTempHideKey)
local SetPerformanceStatsVisible = require(Actions.SetPerformanceStatsVisible)
local SetSmallTouchDevice = require(Actions.SetSmallTouchDevice)
local SetTenFootInterface = require(Actions.SetTenFootInterface)
local SetInspectMenuEnabled = require(Actions.SetInspectMenuEnabled)
local SetIsUsingGamepad = require(Actions.SetIsUsingGamepad)
local SetHasPermissionToVoiceChat = require(Actions.SetHasPermissionToVoiceChat)
local SetMinimized = require(Actions.SetMinimized)
local SetSubjectToChinaPolicies = require(Actions.SetSubjectToChinaPolicies)

local FFlagPlayerListPersistVisibility = require(scriptParentParent.Flags.FFlagPlayerListPersistVisibility)
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav
local FFlagPlayerListUseMobileOnSmallDisplay = PlayerList.Flags.FFlagPlayerListUseMobileOnSmallDisplay
local GameSettings = if FFlagPlayerListPersistVisibility then UserSettings().GameSettings else nil
local tbl1 = {
    isMinimized = false,
    setVisible = not FFlagPlayerListUseMobileOnSmallDisplay and (not FFlagPlayerListPersistVisibility or GameSettings.PlayerListVisible),
    isVisible = true,
    isSmallTouchDevice = false,
    performanceStatsVisible = false,
    vrEnabled = VRService.VREnabled,
    inspectMenuEnabled = GuiService:GetInspectMenuEnabled(),
    playerlistCoreGuiEnabled = true,
    isTenFootInterface = false,
    isUsingGamepad = false,
    hasPermissionToVoiceChat = false,
    tempHideKeys = {},
    subjectToChinaPolicies = true
}

local function updateIsVisible(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    arg1.isVisible = arg1.setVisible

    if not arg1.isTenFootInterface then
        arg1.isVisible = arg1.isVisible
    end

    arg1.isVisible = arg1.isVisible and Cryo.isEmpty(arg1.tempHideKeys)
    return arg1
end

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetPlayerListVisibility.name] = function(arg1, arg2)
    if FFlagPlayerListPersistVisibility and not (arg1.isSmallTouchDevice or arg1.isTenFootInterface) then
        GameSettings.PlayerListVisible = arg2.isVisible
    end

    return updateIsVisible((Cryo.Dictionary.join(arg1, { setVisible = arg2.isVisible })))
end

tbl2[SetPlayerListEnabled.name] = function(arg1, arg2)
    local var1 = nil
    if FFlagAddNewPlayerListMobileFocusNav and not arg2.isEnabled then
        var1 = false
    end

    local join = Cryo.Dictionary.join
    local tbl3 = {
        playerlistCoreGuiEnabled = arg2.isEnabled,
        setVisible = 0
    }

    if not FFlagAddNewPlayerListMobileFocusNav then
        var1 = nil
    end

    tbl3.setVisible = var1
    return updateIsVisible((join(arg1, tbl3)))
end

tbl2[SetTempHideKey.name] = function(arg1, arg2)
    local tempHideValue = arg2.tempHideValue
    if tempHideValue == nil then
        tempHideValue = Cryo.None
    end
    local join = Cryo.Dictionary.join
    local tbl3 = {
        tempHideKeys = Cryo.Dictionary.join(arg1.tempHideKeys, { [arg2.tempHideKey] = tempHideValue })
    }
    return updateIsVisible((join(arg1, tbl3)))
end

tbl2[SetPerformanceStatsVisible.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { performanceStatsVisible = arg2.isVisible })
end

tbl2[SetSmallTouchDevice.name] = function(arg1, arg2)
    return updateIsVisible((Cryo.Dictionary.join(arg1, { isSmallTouchDevice = arg2.isSmallTouchDevice })))
end

tbl2[SetTenFootInterface.name] = function(arg1, arg2)
    local setVisible = arg1.setVisible
    if arg2.isTenFootInterface then
        setVisible = false
    end

    return updateIsVisible((Cryo.Dictionary.join(arg1, { isTenFootInterface = arg2.isTenFootInterface, setVisible = setVisible })))
end

tbl2[SetInspectMenuEnabled.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { inspectMenuEnabled = arg2.enabled })
end

tbl2[SetIsUsingGamepad.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { isUsingGamepad = arg2.isUsingGamepad })
end

tbl2[SetHasPermissionToVoiceChat.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { hasPermissionToVoiceChat = arg2.hasPermissionToVoiceChat })
end

tbl2[SetMinimized.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { isMinimized = arg2.isMinimized })
end

tbl2[SetSubjectToChinaPolicies.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { subjectToChinaPolicies = arg2.subjectToChinaPolicies })
end

return (createReducer(tbl1, tbl2))
