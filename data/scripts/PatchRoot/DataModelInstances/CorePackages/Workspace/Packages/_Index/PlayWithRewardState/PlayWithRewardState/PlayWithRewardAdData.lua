-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayWithRewardState = script:FindFirstAncestor("PlayWithRewardState")
local PlayWithRewardExperimentData = require(PlayWithRewardState.PlayWithRewardExperimentData)

local module = {}

function module.new(adAvailabilityResult, productId, productName, productImageAssetId, arg1)
    return {
        adAvailabilityResult = adAvailabilityResult,
        productId = productId,
        productName = productName,
        productImageAssetId = productImageAssetId,
        experimentVariantData = PlayWithRewardExperimentData.fromJsonData(arg1)
    }
end
return module
