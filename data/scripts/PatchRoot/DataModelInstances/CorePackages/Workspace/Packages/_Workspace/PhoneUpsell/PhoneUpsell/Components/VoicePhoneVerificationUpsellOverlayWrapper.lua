-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)

local RoactNetworking = require(PhoneUpsellParent.RoactServiceTags).RoactNetworking

local _LuauPolyfill = require(PhoneUpsellParent.LuauPolyfill)

local PostUserOptIn = require(PhoneUpsellParent.VoiceChat).PostUserOptIn

local _PhoneVerificationUpsellOverlay = require(PhoneUpsell.Components.PhoneVerificationUpsellOverlay)
local UpsellContainer = require(PhoneUpsell.Components.UpsellContainer)
local PhoneVerificationStatusOverlay = require(PhoneUpsell.Components.PhoneVerificationStatusOverlay)

local Cryo = require(PhoneUpsellParent.Cryo)
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local useRoactService = require(PhoneUpsellParent.RobloxAppHooks).useRoactService
local useAppPolicy = require(PhoneUpsellParent.UniversalAppPolicy).useAppPolicy
local mergeProps = require(PhoneUpsell.Utils.mergeProps)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Logging = require(PhoneUpsellParent.AppCommonLib).Logging

local FFlagFixUpsellVerificationToNavigateToOverlays = require(PhoneUpsell.Flags.FFlagFixUpsellVerificationToNavigateToOverlays)
local GetFFlagDisablePVUpsellDataConsent = require(PhoneUpsellParent.SharedFlags).GetFFlagDisablePVUpsellDataConsent
local FFlagHomePhoneVerificationUpsellNewCopy = require(PhoneUpsellParent.SharedFlags).FFlagHomePhoneVerificationUpsellNewCopy

local tbl1 = {
    onSuccess = function() end,
    closeUpsell = function() end,
    addPhoneTitleKey = "Feature.VerificationUpsell.Action.AddPhoneVoice",
    addPhoneDescriptionKey = "Feature.VerificationUpsell.Description.AddPhoneBodyVoice"
}

local function VoicePhoneVerificationUpsellOverlayWrapper(arg1)
    local var1 = mergeProps(tbl1, arg1)
    local var2 = useRoactService(RoactNetworking)

    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)

    local requireAddPhoneLegalTextCheckbox = useAppPolicy(function(arg2)
        return arg2.RequireExplicitVoiceConsent()
    end)

    local image = React.createElement(
        ImageSetLabel,
        {
            Size = UDim2.fromOffset(40, 40),
            Image = Images["icons/status/success_large"],
            BackgroundTransparency = 1
        }
    )

    local function onSuccess()
        PostUserOptIn(var2, true, false):andThen(function(arg2)
            if arg2 then
                var4(true)
                task.delay(3, function()
                    if FFlagFixUpsellVerificationToNavigateToOverlays then
                        var1.closeUpsell()
                        var1.onSuccess()
                        return
                    end
                    var1.onSuccess()
                    var1.closeUpsell()
                end)

                return
            end

            var6(true)
            task.delay(5, function()
                if FFlagFixUpsellVerificationToNavigateToOverlays then
                    var1.closeUpsell()
                    var1.onSuccess()
                    return
                end
                var1.onSuccess()
                var1.closeUpsell()
            end)

            Logging.warn("Error getting UserOptIn. " .. tostring(arg2))
        end):catch(function()
            var6(true)
            task.delay(5, function()
                if FFlagFixUpsellVerificationToNavigateToOverlays then
                    var1.closeUpsell()
                    var1.onSuccess()
                    return
                end
                var1.onSuccess()
                var1.closeUpsell()
            end)

            Logging.warn("Exception posting PostUserOptIn")
        end)
    end

    local var8 = useLocalization({
        verifySuccessKey = "Feature.VerificationUpsell.Heading.VoiceChatEnabledMobile",
        voiceErrorKey = "Feature.VerificationUpsell.Heading.VoiceChatError"
    })

    return React.createElement(React.Fragment, nil, {
        PhoneVerificationUpsellOverlay = React.createElement(
            UpsellContainer,
            Cryo.Dictionary.join(var1, {
                onSuccess = onSuccess,
                addPhoneTitleKey = var1.addPhoneTitleKey,
                addPhoneDescriptionKey = var1.addPhoneDescriptionKey,
                addPhoneButtonKey = if FFlagHomePhoneVerificationUpsellNewCopy then "Feature.AccountSettings.Action.Verify" else "Feature.VerificationUpsell.Action.EnableVoice",
                addPhoneLegalTextKey = if requireAddPhoneLegalTextCheckbox then "Feature.VerificationUpsell.Description.VoiceLegalConsent" elseif FFlagHomePhoneVerificationUpsellNewCopy then "Feature.VerificationUpsell.Description.VoiceLegalDisclaimer3" else "Feature.VerificationUpsell.Description.VoiceLegalDisclaimer",
                alwaysShowAddPhoneLegalText = true,
                requireAddPhoneLegalTextCheckbox = requireAddPhoneLegalTextCheckbox,
                disableLegalText = GetFFlagDisablePVUpsellDataConsent(),
                shouldShowVerificationText = if FFlagHomePhoneVerificationUpsellNewCopy then true else nil
            })
        ),
        SuccessOverlay = var3 and React.createElement(PhoneVerificationStatusOverlay, { image = image, text = var8.verifySuccessKey }),
        ErrorOverlay = var5 and React.createElement(PhoneVerificationStatusOverlay, { image = image, text = var8.voiceErrorKey })
    })
end

return VoicePhoneVerificationUpsellOverlayWrapper
