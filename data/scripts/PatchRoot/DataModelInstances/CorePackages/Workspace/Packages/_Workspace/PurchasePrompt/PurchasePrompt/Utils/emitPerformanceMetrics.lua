-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptLite = require(PurchasePromptParent.PurchasePromptLite)
local Enums = require(PurchasePromptParent.PurchasePromptLite).Enums
local _types = require(PurchasePrompt.types)
local getTTIEventName = PurchasePromptLite.getTTIEventName
local IntervalPerformanceTracker = require(PurchasePromptParent.IntervalPerformanceTracker).IntervalPerformanceTracker
local TimeToInteractiveTracker = require(PurchasePromptParent.TimeToInteractiveTracker).TimeToInteractiveTracker

local Constants = require(PurchasePrompt.Misc.Constants)
local num1 = game:DefineFastInt("ProductPurchaseContainerFPSDuration", 2)
local SharedFlags = require(PurchasePromptParent.SharedFlags)
local FIntTTIUnifiedPurchaseSamplingRate = SharedFlags.FIntTTIUnifiedPurchaseSamplingRate
local FFlagEnableEdpPreviewPurchaseSurface = SharedFlags.FFlagEnableEdpPreviewPurchaseSurface
local FFlagEnableInExperiencePurchaseModalMetrics = require(PurchasePrompt.Flags.FFlagEnableInExperiencePurchaseModalMetrics)

local tbl1 = {
    [Enums.ProductPurchaseSurface.Catalog] = true,
    [Enums.ProductPurchaseSurface.EDP] = true
}

if FFlagEnableInExperiencePurchaseModalMetrics then
    tbl1[Enums.ProductPurchaseSurface.InExperience] = true
end

if FFlagEnableEdpPreviewPurchaseSurface then
    tbl1[Enums.ProductPurchaseSurface.EDPPreview] = true
end

function emitPerformanceMetrics(str1: string, arg1)
    if arg1 ~= nil and tbl1[arg1] then
        emitFPSMetrics(str1, arg1)
        emitTTIMetrics(arg1)
    end
end

function emitFPSMetrics(str1: string, arg1)
    IntervalPerformanceTracker:startTracking(
        Constants.PerformanceMetrics.Prefix.UnifiedPurchaseModal .. "_" .. str1 .. "_" .. arg1,
        num1,
        nil,
        true,
        true
    )

    IntervalPerformanceTracker:startTracking(
        Constants.PerformanceMetrics.Prefix.PurchaseModal .. "_" .. str1 .. "_" .. arg1,
        num1,
        nil,
        true,
        true
    )
end

function emitTTIMetrics(arg1)
    local tTiEventName = getTTIEventName(arg1)
    TimeToInteractiveTracker.trackEnd(tTiEventName, { samplingRateOverride = FIntTTIUnifiedPurchaseSamplingRate })
end

return emitPerformanceMetrics
