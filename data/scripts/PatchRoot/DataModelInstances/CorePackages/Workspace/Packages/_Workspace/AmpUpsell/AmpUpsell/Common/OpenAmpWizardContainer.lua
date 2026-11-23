-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local AppPage = require(AmpUpsellParent.RobloxAppEnums).AppPage
local _Types = require(AmpUpsell.Common.Types)
local NavigateDown = require(AmpUpsellParent.NavigationRodux).Thunks.NavigateDown
local NavigateFromWebView = require(AmpUpsellParent.NavigationRodux).Thunks.NavigateFromWebView
local NavigateBack = require(AmpUpsellParent.NavigationRodux).Thunks.NavigateBack
local Selectors = require(AmpUpsellParent.NavigationRodux).Selectors
local SharedFlags = require(AmpUpsellParent.SharedFlags)
local FFlagAmpWizardDeepLinkReplaceOnlyWebView = require(AmpUpsell.Flags.FFlagAmpWizardDeepLinkReplaceOnlyWebView)
local FFlagEnableAmpWizardDeepLink = SharedFlags.FFlagEnableAmpWizardDeepLink

local FFlagLuaAppWizardContainerBypassNavigationLock = require(AmpUpsellParent.SharedFlags).FFlagLuaAppWizardContainerBypassNavigationLock
local FFlagLuaAppPlayButtonWizardCloseDelay = SharedFlags.FFlagLuaAppPlayButtonWizardCloseDelay
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AmpUpsellParent.RobloxAppNavigation).NavigationCommands else nil
local GetLegacyNavigationStore = if FFlagSignalsNavP3Dispatch then require(AmpUpsellParent.NavigationRodux).GetLegacyNavigationStore else nil

return function(featureName, callback, recourseData, entryPointEventCtx, extraParameters, nameSpace: string?, skipFacialAgeEstimationWebLinkModal: boolean?, metadata, callback2: ((...any) -> (...any))?, usePrologue: boolean?, prologueOptions)
    local bool1 = FFlagEnableAmpWizardDeepLink

    if bool1 then
        bool1 = false

        if metadata ~= nil then
            bool1 = metadata.returnPage ~= nil
        end
    end

    return function(arg1)
        local tbl1 = {
            name = AppPage.AmpWizardContainer,
            extraProps = {
                featureName = featureName,
                recourseData = recourseData,
                entryPointEventCtx = entryPointEventCtx,
                nameSpace = nameSpace,
                extraParameters = extraParameters,
                metadata = metadata,
                completionCallback = function(arg2, arg3)
                    if FFlagLuaAppPlayButtonWizardCloseDelay and callback2 then
                        callback2(arg1, arg2, arg3)
                        return
                    end
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.back(if FFlagLuaAppWizardContainerBypassNavigationLock then true else nil)
                    else
                        arg1:dispatch(NavigateBack(if FFlagLuaAppWizardContainerBypassNavigationLock then true else nil))
                    end

                    callback(arg2, arg3)
                end,
                skipFacialAgeEstimationWebLinkModal = skipFacialAgeEstimationWebLinkModal,
                usePrologue = usePrologue,
                prologueOptions = prologueOptions
            }
        }

        if FFlagAmpWizardDeepLinkReplaceOnlyWebView and bool1 then
            local bool2 = (if FFlagSignalsNavP3Dispatch then GetLegacyNavigationStore(false).getCurrentPageName(false) else Selectors.selectCurrentPageName(arg1:getState())) == AppPage.GenericWebPage
            bool1 = bool1 and bool2
        end

        if bool1 then
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.fromWebView(NavigationCommands.fromLegacyPage(tbl1), true)
                return
            end
            arg1:dispatch(NavigateFromWebView(tbl1, true))
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1), true)
        else
            arg1:dispatch(NavigateDown(tbl1, true))
        end
    end
end
