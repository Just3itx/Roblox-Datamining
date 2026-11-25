-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local AmpUpsell = require(SocialUpsellParent.AmpUpsell)
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer
local AppPage = require(SocialUpsellParent.RobloxAppEnums).AppPage
local NavigateBack = require(SocialUpsellParent.NavigationRodux).Thunks.NavigateBack
local NavigateDown = require(SocialUpsellParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialUpsellParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialUpsellParent.RobloxAppNavigation).NavigationCommands else nil
local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local FFlagEnableAEGIS2CommsFAEUpsell = require(SocialUpsellParent.SharedFlags).FFlagEnableAEGIS2CommsFAEUpsell
local bool1 = game:DefineFastFlag("ManuallyInvokeAmpUpsell2", false)
local manuallyInvokeAmpUpsell = require(SocialUpsell.Utils.manuallyInvokeAmpUpsell)

local FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature = require(SocialUpsellParent.SharedFlags).FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature
local FStringCoreContentAmpNameSpace = require(SocialUpsellParent.SharedFlags).FStringCoreContentAmpNameSpace

local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController
local featureName = if bool1 then require(SocialUpsell.Flag.FStringCommsFAEFeatureName) else game:DefineFastString("CommsFAEFeatureName", "TriggerAgeVerifyRecourse")
local nameSpace = if bool1 then require(SocialUpsell.Flag.FStringCommsFAENamespace) else game:DefineFastString("CommsFAENamespace", "social/Upsells")

return function(entryPointEventCtx: string?, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?, source: string?, bool2: boolean?, bool3: boolean?)
    return function(arg1)
        if bool3 then
            local var3 = entryPointEventCtx or SocialUpsellType.FacialAgeEstimation .. (source or "")
            local function vpcCompletionCallback(granted, _)
                if granted == AccessResponseEnum.Granted then
                    if callback then
                        callback()
                    end
                elseif callback2 then
                    callback2()
                end
            end

            if FFlagEnableAEGIS2CommsFAEUpsell and bool2 then
                return InExpAmpWizardController.OpenAmpWizardContainerInExp(
                    FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature,
                    vpcCompletionCallback,
                    nil,
                    var3,
                    nil,
                    FStringCoreContentAmpNameSpace
                )
            end

            return arg1:dispatch(
                OpenAmpWizardContainer(
                    FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature,
                    vpcCompletionCallback,
                    nil,
                    var3,
                    nil,
                    FStringCoreContentAmpNameSpace
                )
            )
        elseif FFlagEnableAEGIS2CommsFAEUpsell and bool2 then
            local var3 = entryPointEventCtx or SocialUpsellType.FacialAgeEstimation
            if bool1 then
                return (manuallyInvokeAmpUpsell(var3, callback, callback2))
            end

            return (InExpAmpWizardController.OpenAmpWizardContainerInExp(featureName, function(granted, _)
                if granted == AccessResponseEnum.Granted then
                    if callback then
                        callback()
                    end
                elseif callback2 then
                    callback2()
                end
            end, nil, var3, nil, nameSpace))
        else
            local tbl1 = {
                name = AppPage.AmpWizardContainer,
                extraProps = {
                    featureName = featureName,
                    nameSpace = nameSpace,
                    entryPointEventCtx = entryPointEventCtx or SocialUpsellType.FacialAgeEstimation,
                    metadata = { source = source },
                    skipFacialAgeEstimationWebLinkModal = true,
                    completionCallback = function(granted, _)
                        if FFlagSignalsNavP3Dispatch then
                            NavigationCommands.back(true)
                        else
                            arg1:dispatch(NavigateBack(true))
                        end
                        if granted == AccessResponseEnum.Granted then
                            if callback then
                                callback()
                            end
                        elseif callback2 then
                            callback2()
                        end
                    end
                }
            }

            if FFlagSignalsNavP3Dispatch then
                return NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            end
            return arg1:dispatch(NavigateDown(tbl1))
        end
    end
end
