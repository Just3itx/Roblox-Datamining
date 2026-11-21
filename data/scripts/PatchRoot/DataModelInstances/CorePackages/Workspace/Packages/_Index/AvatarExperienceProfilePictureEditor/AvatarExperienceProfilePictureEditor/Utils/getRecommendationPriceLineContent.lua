-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local _AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local function getRecommendationPriceLineContent(tbl1)
    local priceStatus = tbl1.priceStatus
    if typeof(priceStatus) == "string" and priceStatus ~= "" then
        return { type = "text", text = priceStatus }
    end

    local price = tbl1.lowestPrice or tbl1.priceInRobux
    return if price == nil or price <= 0 then {
        type = "text",
        text = tbl1.freeLabel
    } else { type = "price", price = price }
end

return getRecommendationPriceLineContent
