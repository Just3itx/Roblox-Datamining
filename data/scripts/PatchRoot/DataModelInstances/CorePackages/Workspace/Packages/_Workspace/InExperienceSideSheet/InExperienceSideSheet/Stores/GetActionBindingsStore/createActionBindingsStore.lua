-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")

local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Signals = require(InExperienceSideSheetParent.Signals)

local AnalyticsConstants = require(InExperienceSideSheet.Analytics.AnalyticsConstants)
local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)

local Enums = require(InExperienceSideSheet.Common.Enums)

local GetIntegrationsStore = require(InExperienceSideSheet.Stores.GetIntegrationsStore)

local closePeoplePageOpenedWithSideSheet = require(InExperienceSideSheet.Utils.closePeoplePageOpenedWithSideSheet)
local getSideSheetVisibility = require(InExperienceSideSheet.Utils.getSideSheetVisibility)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local Flags = require(InExperienceSideSheet.Flags)
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagSideSheetOpenPeoplePage = Flags.FFlagSideSheetOpenPeoplePage
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(InExperienceSideSheetParent.PioneerUtils).isPioneerLaunch

local function createActionBinding(keyCodes)
    local getIsEnabled, setIsEnabled = Signals.createSignal(true)
    local getOnActivated, setOnActivated = Signals.createSignal(function()
        return function() end
    end)

    return {
        keyCodes = keyCodes,
        getOnActivated = getOnActivated,
        setOnActivated = setOnActivated,
        getIsEnabled = getIsEnabled,
        setIsEnabled = setIsEnabled
    }
end

local function createActionBindingsStore()
    local sessionActionBindings = {
        [Enums.ActionBinding.Leave] = createActionBinding({ Enum.KeyCode.L, Enum.KeyCode.ButtonX }),
        [Enums.ActionBinding.Respawn] = createActionBinding({ Enum.KeyCode.R, Enum.KeyCode.ButtonY })
    }
    if FFlagShowSwitchServerButton or isPioneerLaunch() then
        sessionActionBindings[Enums.ActionBinding.SwitchServer] = createActionBinding(nil)
    end

    local effect = Signals.createEffect(function(arg1)
        for _, value in (GetIntegrationsStore(arg1).getSessionActionIntegrations(arg1)) do
            local var1 = sessionActionBindings[value.id]

            if not var1 then
                continue
            end

            var1.setOnActivated(function()
                return function()
                    value.activated()
                    if FFlagSideSheetOpenPeoplePage then
                        closePeoplePageOpenedWithSideSheet()
                    end
                    toggleSideSheet(false)
                    SidesheetAnalytics.logSidesheetClosed(AnalyticsConstants.Source.ItemSelected)
                end
            end)
        end
    end)

    local effect2 = Signals.createEffect(function(arg1)
        if not getSideSheetVisibility(arg1) then
            for value in sessionActionBindings do
                ContextActionService:UnbindCoreAction(value)
            end

            return
        end

        for value, value2 in sessionActionBindings do
            if (isPioneerLaunch() or FFlagShowSwitchServerButton) and value2.keyCodes == nil then
                continue
            end

            local function func1(_, userInputState, _)
                if userInputState == Enum.UserInputState.Begin then
                    value2.getOnActivated()()
                end
            end

            if value2.getIsEnabled(arg1) then
                local contextActionService = ContextActionService
                local keyCodes = value2.keyCodes
                contextActionService:BindCoreAction(value, func1, false, unpack(keyCodes))
            else
                ContextActionService:UnbindCoreAction(value)
            end
        end
    end)

    return {
        sessionActionBindings = sessionActionBindings,
        cleanUp = function()
            effect2()
            effect()
        end
    }
end
return createActionBindingsStore
