-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local Http = require(AvatarExperienceProfilePictureEditorParent.Http)

local Constants = require(script.Parent.Parent.Constants)
local normalize = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceCommon).Utils.normalize

local Url = Http.Url
local normalizeNumber = normalize.normalizeNumber
local normalizeString = normalize.normalizeString

local EMOTE_ASSET_TYPE_ID = tostring(Enum.AvatarAssetType.EmoteAnimation.Value)

local function buildEmoteRecommendationsUrl(numItems: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Url:makeQueryString({ numItems = numItems, details = true })

    return `{Url.CATALOG_URL}v2/recommendations/user-inventory?assetTypeId={EMOTE_ASSET_TYPE_ID}&{var1}`
end

return {
    EMOTE_ASSET_TYPE_ID = EMOTE_ASSET_TYPE_ID,
    buildEmoteRecommendationsUrl = buildEmoteRecommendationsUrl,
    parseEmoteRecommendationsResponse = function(arg1)
        local data = if arg1 then arg1.data else nil

        if typeof(data) ~= "table" then
            return {}
        end

        local result = {}
        for _, value in data do
            if typeof(value) ~= "table" or value.id == nil then
                continue
            end

            local name = value.name
            local var1 = normalizeString(value.priceStatus)
            local tbl1 = {
                id = tostring(value.id),
                label = if typeof(name) ~= "string" then "" else name,
                priceInRobux = normalizeNumber(value.price),
                lowestPrice = normalizeNumber(value.lowestPrice),
                priceStatus = 0
            }

            if var1 == nil or var1 == "" then
                var1 = nil
            end

            tbl1.priceStatus = var1
            table.insert(result, tbl1)
        end

        return result
    end,
    getEmoteRecommendationsUrl = function(tbl1): string
        return buildEmoteRecommendationsUrl((tbl1 or {}).numItems or Constants.RecommendedEmoteCount)
    end
}
