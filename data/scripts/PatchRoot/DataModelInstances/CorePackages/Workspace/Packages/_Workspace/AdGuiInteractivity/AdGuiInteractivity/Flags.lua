-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("AdsVolumeOffImageLua", "rbxassetid://14986179621")
game:DefineFastString("AdsVolumeOnImageLua", "rbxassetid://14986178697")
game:DefineFastString("AdsEnterFullscreenImageLua", "rbxassetid://14986182327")
game:DefineFastString("AdsExitFullscreenImageLua", "rbxassetid://14986181606")
game:DefineFastString("AdsEudsaPromptActiveImageLua", "rbxassetid://16017622465")
game:DefineFastString("AdsEudsaPromptInactiveImageLua", "rbxassetid://16040129720")
game:DefineFastString("AdGuiPlayButtonImageLua", "rbxassetid://16639542545")
game:DefineFastString("AdGuiPauseButtonImageLua", "rbxassetid://16639540538")
game:DefineFastString("AdGuiCloseButtonImageLua", "rbxassetid://16639540023")
game:DefineFastString("AdGuiLivePreviewWatermark", "rbxassetid://18539441909")
game:DefineFastString("AdGuiLivePreviewWatermarkV2", "rbxassetid://18641531344")
game:DefineFastString("LivePreviewPlaceId", "-1")
game:DefineFastFlag("UseV2LivePreviewWatermark", false)
game:DefineFastFlag("EnableReportAdDropdown5", false)
game:DefineFastInt("UniversalAppPolicyFailureTelemetryThrottleHundredthsPercent", 10000)
game:DefineFastFlag("EnableHideReportAdModalDuringScreenshot2", false)
game:DefineFastInt("AdGuiInteractivityPixelsPerStud", 50)

return {
    GetFStringAdsVolumeOffImageLua = function(): string
        return game:GetFastString("AdsVolumeOffImageLua")
    end,
    GetFStringAdsVolumeOnImageLua = function(): string
        return game:GetFastString("AdsVolumeOnImageLua")
    end,
    GetFStringAdsEnterFullscreenImageLua = function(): string
        return game:GetFastString("AdsEnterFullscreenImageLua")
    end,
    GetFStringAdsExitFullscreenImageLua = function(): string
        return game:GetFastString("AdsExitFullscreenImageLua")
    end,
    GetFStringAdsEudsaPromptActiveImageLua = function(): string
        return game:GetFastString("AdsEudsaPromptActiveImageLua")
    end,
    GetFStringAdsEudsaPromptInactiveImageLua = function(): string
        return game:GetFastString("AdsEudsaPromptInactiveImageLua")
    end,
    GetFStringAdGuiPlayButtonImageLua = function(): string
        return game:GetFastString("AdGuiPlayButtonImageLua")
    end,
    GetFStringAdGuiPauseButtonImageLua = function(): string
        return game:GetFastString("AdGuiPauseButtonImageLua")
    end,
    GetFStringAdGuiCloseButtonImageLua = function(): string
        return game:GetFastString("AdGuiCloseButtonImageLua")
    end,
    GetFStringAdGuiLivePreviewWatermark = function(): string
        return game:GetFastString("AdGuiLivePreviewWatermark")
    end,
    GetFStringLivePreviewPlaceId = function(): string
        return game:GetFastString("LivePreviewPlaceId")
    end,
    GetFFlagUseV2LivePreviewWatermark = function(): boolean
        return game:GetFastFlag("UseV2LivePreviewWatermark")
    end,
    GetFStringAdGuiLivePreviewWatermarkV2 = function(): string
        return game:GetFastString("AdGuiLivePreviewWatermarkV2")
    end,
    GetFFlagEnableReportAdDropdown = function(): boolean
        return game:GetFastFlag("EnableReportAdDropdown5")
    end,
    FFlagFixReportAdInfoDuringRotation = game:DefineFastFlag("FixReportAdInfoDuringRotation", false),
    GetFIntUniversalAppPolicyFailureTelemetryThrottleHundredthsPercent = function(): number
        return game:GetFastInt("UniversalAppPolicyFailureTelemetryThrottleHundredthsPercent")
    end,
    GetEnableHideReportAdModalDuringScreenshot = function(): boolean
        return game:GetFastFlag("EnableHideReportAdModalDuringScreenshot2")
    end,
    GetAdGuiInteractivityPixelsPerStud = function(): number
        return game:GetFastInt("AdGuiInteractivityPixelsPerStud")
    end
}
