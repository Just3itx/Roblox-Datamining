-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url

local function trackSponsoredItemClick(arg1, encryptedAdTrackingData: string)
    return arg1(string.format("%sv2/tracking/click", Url.AD_CONFIGURATION_URL), "POST", {
        postBody = HttpService:JSONEncode(
            {
                encryptedAdTrackingData = encryptedAdTrackingData,
                campaignTargetType = "Asset",
                placementLocation = "AvatarShop"
            }
        )
    })
end

return trackSponsoredItemClick
