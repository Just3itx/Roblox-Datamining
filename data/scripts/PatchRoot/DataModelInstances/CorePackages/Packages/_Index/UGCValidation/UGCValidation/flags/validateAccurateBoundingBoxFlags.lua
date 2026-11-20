-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("UGCValidationAccurateBoundingBoxTargetPercentage", "98.0")

game:DefineFastString("UGCValidationAccurateBoundingBoxPercentageWeight", "0.05")

game:DefineFastInt("UGCValidationAccurateBoundingBoxMaxIterations", 500)

game:DefineFastString("UGCValidationAccurateBoundingBoxConvergedLength", "0.001")

game:DefineFastString("UGCValidateAccurateBoundingBoxInflationThreshold", "0.334")

game:DefineFastFlag("UGCValidateAccurateBoundingBoxRasterMethod", false)

game:DefineFastFlag("UGCValidateAccurateBoundingBoxRasterMethodNeckAttachmentCrop", false)

game:DefineFastString("UGCValidateAccurateBoundingBoxRasterMethodNeckAttachmentCropMargin", "0.05")

local module = {}

function module.targetPercentage(): number?
    return tonumber(game:GetFastString("UGCValidationAccurateBoundingBoxTargetPercentage"))
end

function module.percentageWeight(): number?
    return tonumber(game:GetFastString("UGCValidationAccurateBoundingBoxPercentageWeight"))
end

function module.maxIterations(): number
    return game:GetFastInt("UGCValidationAccurateBoundingBoxMaxIterations")
end

function module.convergedLength(): number?
    return tonumber(game:GetFastString("UGCValidationAccurateBoundingBoxConvergedLength"))
end

function module.inflationThreshold(): number?
    return tonumber(game:GetFastString("UGCValidateAccurateBoundingBoxInflationThreshold"))
end

function module.neckAttachmentCrop(): boolean
    return game:GetFastFlag("UGCValidateAccurateBoundingBoxRasterMethodNeckAttachmentCrop")
end

function module.neckAttachmentCropMargin(): number?
    return tonumber(game:GetFastString("UGCValidateAccurateBoundingBoxRasterMethodNeckAttachmentCropMargin"))
end

game:DefineFastString("UGCValidationInflationThresholdDynamicHeadX", "0.334")
game:DefineFastString("UGCValidationInflationThresholdDynamicHeadY", "0.334")
game:DefineFastString("UGCValidationInflationThresholdDynamicHeadZ", "0.334")

game:DefineFastString("UGCValidationInflationThresholdTorsoX", "0.334")
game:DefineFastString("UGCValidationInflationThresholdTorsoY", "0.334")
game:DefineFastString("UGCValidationInflationThresholdTorsoZ", "0.334")

game:DefineFastString("UGCValidationInflationThresholdArmsX", "1.0")
game:DefineFastString("UGCValidationInflationThresholdArmsY", "0.334")
game:DefineFastString("UGCValidationInflationThresholdArmsZ", "1.0")

game:DefineFastString("UGCValidationInflationThresholdLegsX", "0.7")
game:DefineFastString("UGCValidationInflationThresholdLegsY", "0.334")
game:DefineFastString("UGCValidationInflationThresholdLegsZ", "0.7")

local tbl1 = {
    X = tonumber(game:GetFastString("UGCValidationInflationThresholdDynamicHeadX")),
    Y = tonumber(game:GetFastString("UGCValidationInflationThresholdDynamicHeadY")),
    Z = tonumber(game:GetFastString("UGCValidationInflationThresholdDynamicHeadZ"))
}

local tbl2 = {
    X = tonumber(game:GetFastString("UGCValidationInflationThresholdTorsoX")),
    Y = tonumber(game:GetFastString("UGCValidationInflationThresholdTorsoY")),
    Z = tonumber(game:GetFastString("UGCValidationInflationThresholdTorsoZ"))
}

local tbl3 = {
    X = tonumber(game:GetFastString("UGCValidationInflationThresholdArmsX")),
    Y = tonumber(game:GetFastString("UGCValidationInflationThresholdArmsY")),
    Z = tonumber(game:GetFastString("UGCValidationInflationThresholdArmsZ"))
}

local tbl4 = {
    X = tonumber(game:GetFastString("UGCValidationInflationThresholdLegsX")),
    Y = tonumber(game:GetFastString("UGCValidationInflationThresholdLegsY")),
    Z = tonumber(game:GetFastString("UGCValidationInflationThresholdLegsZ"))
}

module.AssetTypeToAxisThresholds = {
    [Enum.AssetType.DynamicHead] = tbl1,
    [Enum.AssetType.Torso] = tbl2,
    [Enum.AssetType.LeftArm] = tbl3,
    [Enum.AssetType.RightArm] = tbl3,
    [Enum.AssetType.LeftLeg] = tbl4,
    [Enum.AssetType.RightLeg] = tbl4
}

return module
