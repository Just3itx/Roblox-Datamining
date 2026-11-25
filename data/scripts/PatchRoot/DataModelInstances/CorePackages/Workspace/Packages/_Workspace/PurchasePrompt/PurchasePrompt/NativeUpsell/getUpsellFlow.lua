-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local getAppFeaturePolicies = require(PurchasePromptParent.UniversalAppPolicy).getAppFeaturePolicies

local GetFFlagEnablePalisadesPaymentsPlatform = require(PurchasePrompt.Flags.GetFFlagEnablePalisadesPaymentsPlatform)
local FFlagEnablePioneerPaymentsPlatform = require(PurchasePrompt.Flags.FFlagEnablePioneerPaymentsPlatform)
local getIsPioneerBuild = require(PurchasePrompt.Utils.getIsPioneerBuild)

local function getUpsellFlow(platform)
    if getAppFeaturePolicies().getRobuxUpsellFlowMobile() then
        return UpsellFlow.Mobile
    end

    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        if FFlagEnablePioneerPaymentsPlatform and getIsPioneerBuild() then
            return UpsellFlow.Mobile
        end

        return UpsellFlow.Web
    end

    if platform == Enum.Platform.IOS or platform == Enum.Platform.Android or platform == Enum.Platform.UWP then
        return UpsellFlow.Mobile
    end

    if platform == Enum.Platform.XBoxOne then
        return UpsellFlow.Xbox
    end

    if GetFFlagEnablePalisadesPaymentsPlatform() and (platform == Enum.Platform.PS4 or platform == Enum.Platform.PS5) then
        return UpsellFlow.Mobile
    end

    return UpsellFlow.None
end

return getUpsellFlow
