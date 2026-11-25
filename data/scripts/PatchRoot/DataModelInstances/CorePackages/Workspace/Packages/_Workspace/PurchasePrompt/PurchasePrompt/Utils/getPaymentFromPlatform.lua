-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PaymentPlatform = require(PurchasePrompt.Enums.PaymentPlatform)
local GetFFlagEnablePalisadesPaymentsPlatform = require(PurchasePrompt.Flags.GetFFlagEnablePalisadesPaymentsPlatform)
local FFlagEnablePioneerPaymentsPlatform = require(PurchasePrompt.Flags.FFlagEnablePioneerPaymentsPlatform)
local getIsPioneerBuild = require(PurchasePrompt.Utils.getIsPioneerBuild)

local FFlagEnableMicrosoftStorePaymentsPlatform = require(PurchasePromptParent.SharedFlags).FFlagEnableMicrosoftStorePaymentsPlatform
local FFlagEnableMilkyWayPaymentsPlatformV2 = require(PurchasePromptParent.SharedFlags).FFlagEnableMilkyWayPaymentsPlatformV2

local getAppFeaturePolicies = require(PurchasePromptParent.UniversalAppPolicy).getAppFeaturePolicies

return function(platform, arg1, arg2, arg3)
    if platform == Enum.Platform.XBoxOne then
        return PaymentPlatform.Xbox
    end

    if platform == Enum.Platform.IOS then
        if arg1 then
            return PaymentPlatform.Midas
        end

        return PaymentPlatform.Apple
    end

    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        if FFlagEnablePioneerPaymentsPlatform and getIsPioneerBuild() then
            return PaymentPlatform.Pioneer
        end

        if FFlagEnableMicrosoftStorePaymentsPlatform and getAppFeaturePolicies().getUsePaymentPlatformMicrosoftStore() then
            return PaymentPlatform.Microsoft
        end

        return PaymentPlatform.Web
    end

    if platform ~= Enum.Platform.Android then
        if platform == Enum.Platform.UWP then
            return PaymentPlatform.UWP
        end

        if GetFFlagEnablePalisadesPaymentsPlatform() and (platform == Enum.Platform.PS4 or platform == Enum.Platform.PS5) then
            return PaymentPlatform.Palisades
        end

        return PaymentPlatform.None
    end

    if arg1 then
        return PaymentPlatform.Midas
    end

    if arg2 then
        return PaymentPlatform.Amazon
    end

    if arg3 then
        return PaymentPlatform.Maquettes
    end

    if FFlagEnableMilkyWayPaymentsPlatformV2 and getAppFeaturePolicies().getUsePaymentPlatformMilkyWayStore() then
        return PaymentPlatform.MilkyWay
    end

    return PaymentPlatform.Google
end
