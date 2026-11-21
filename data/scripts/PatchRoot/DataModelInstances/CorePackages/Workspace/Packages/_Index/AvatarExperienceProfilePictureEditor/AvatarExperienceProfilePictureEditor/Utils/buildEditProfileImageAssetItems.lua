-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local _AssetPickerTile = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerTile)

local UserLib = require(AvatarExperienceProfilePictureEditorParent.UserLib)
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants
local _useOwnedEmotes = require(AvatarExperienceProfilePictureEditor.Hooks.useOwnedEmotes)
local _useRecommendedEmotes = require(AvatarExperienceProfilePictureEditor.Hooks.useRecommendedEmotes)
local _mapWidgetContentToFrameItems = require(AvatarExperienceProfilePictureEditor.Utils.mapWidgetContentToFrameItems)

local getRecommendationPriceLineContent = require(AvatarExperienceProfilePictureEditor.Utils.getRecommendationPriceLineContent)

local function buildOwnedEmoteItems(ownedEmotes)
    local ownedEmoteItems = {}
    for _, value in ownedEmotes do
        table.insert(ownedEmoteItems, {
            id = value.id,
            label = value.label,
            image = getRbxthumbWithTypeSizeAndOptions(value.id, Constants.RbxthumbTypes.Asset, 150)
        })
    end

    return ownedEmoteItems
end

local function buildRecommendedEmoteItems(ownedEmotes, recommendedEmotes, freeLabel: string)
    local recommendedEmoteItems = {}
    local tbl1 = {}
    for _, value in ownedEmotes do
        tbl1[value.id] = true
    end
    for _, value in recommendedEmotes do
        if tbl1[value.id] then
            continue
        end

        table.insert(recommendedEmoteItems, {
            id = value.id,
            label = value.label,
            image = getRbxthumbWithTypeSizeAndOptions(value.id, Constants.RbxthumbTypes.Asset, 150),
            priceLineContent = getRecommendationPriceLineContent({
                priceInRobux = value.priceInRobux,
                lowestPrice = value.lowestPrice,
                priceStatus = value.priceStatus,
                freeLabel = freeLabel
            })
        })
    end

    return recommendedEmoteItems
end

local function buildCombinedEmoteItems(ownedEmoteItems, recommendedEmoteItems) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(ownedEmoteItems)
    for _, recommendedEmoteItem in recommendedEmoteItems do
        table.insert(var1, recommendedEmoteItem)
    end
    return var1
end

local function buildFrameAssetItems(frameItems)
    local frameAssetItems = {}
    for _, frameItem in frameItems do
        table.insert(frameAssetItems, { id = frameItem.id, label = frameItem.label, image = frameItem.image })
    end

    return frameAssetItems
end

local function buildEditProfileImageAssetItems(tbl1)
    local ownedEmoteItems = buildOwnedEmoteItems(tbl1.ownedEmotes)

    local recommendedEmoteItems = buildRecommendedEmoteItems(tbl1.ownedEmotes, tbl1.recommendedEmotes, tbl1.freeLabel)

    return {
        ownedEmoteItems = ownedEmoteItems,
        recommendedEmoteItems = recommendedEmoteItems,
        combinedEmoteItems = buildCombinedEmoteItems(ownedEmoteItems, recommendedEmoteItems),
        frameAssetItems = buildFrameAssetItems(tbl1.frameItems)
    }
end

return buildEditProfileImageAssetItems
