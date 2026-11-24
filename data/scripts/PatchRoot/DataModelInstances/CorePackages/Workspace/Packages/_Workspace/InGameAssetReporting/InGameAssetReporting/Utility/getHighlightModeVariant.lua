-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")

local IXPService = game:GetService("IXPService")

local InGameAssetReportingParent = InGameAssetReporting.Parent
local SharedFlags = require(InGameAssetReportingParent.SharedFlags)

local FStringReportMenuIXPLayer = SharedFlags.FStringReportMenuIXPLayer
local FFlagHighlightModePreciseSelectionEnabled = SharedFlags.FFlagHighlightModePreciseSelectionEnabled
local FStringHighlightModePreciseSelectionIXPField = SharedFlags.FStringHighlightModePreciseSelectionIXPField
local FStringHighlightModePreciseSelectionForceVariant = SharedFlags.FStringHighlightModePreciseSelectionForceVariant

local Constants = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants)

local function getHighlightModeVariant()
    if not FFlagHighlightModePreciseSelectionEnabled then
        return Constants.HighlightModeVariants.Default
    end

    if FStringHighlightModePreciseSelectionForceVariant ~= "" then
        return FStringHighlightModePreciseSelectionForceVariant
    end

    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(FStringReportMenuIXPLayer)
    end)
    return if success and result and result[FStringHighlightModePreciseSelectionIXPField] ~= nil then result[FStringHighlightModePreciseSelectionIXPField] else Constants.HighlightModeVariants.Default
end

return getHighlightModeVariant
