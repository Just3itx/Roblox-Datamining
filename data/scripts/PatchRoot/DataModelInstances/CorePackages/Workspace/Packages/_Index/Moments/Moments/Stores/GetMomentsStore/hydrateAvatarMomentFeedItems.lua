-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local deriveMomentFromPost = require(Moments.Utils.deriveMomentFromPost)

local Analytics = MomentsCommon.Analytics

local function getAvatarPostPayload(arg1)
    local var1 = nil
    local var2 = nil

    for _, value in arg1.tracks or {} do
        for _, value2 in value.slots or {} do
            local content = value2.content
            if content == nil then
                continue
            end

            if content.type == "avatar_annotation" then
                local outfitId = content.value.outfit_id
                if typeof(outfitId) == "number" and outfitId > 0 then
                    var2 = outfitId
                end
            elseif content.type == "visual" then
                local content2 = content.value.content
                if content2 ~= nil and content2.type == "scene" then
                    local rbxmData = content2.value.rbxm_data
                    if typeof(rbxmData) == "buffer" and buffer.len(rbxmData) > 0 then
                        var1 = rbxmData
                    end
                end
            end
        end
    end

    return var1, var2
end

local function classifyPost(item, arg1, rbxmData: buffer, id: number)
    local var1 = deriveMomentFromPost(item.moment, arg1) or item.moment
    if var1 == item.moment then
        local metadata = arg1.metadata
        if metadata ~= nil and typeof(metadata.caption) == "string" and metadata.caption ~= "" then
            var1 = table.clone(var1)
            var1.metadata = table.clone(item.moment.metadata)
            var1.metadata.description = metadata.caption
        end
    end

    return {
        kind = "avatarMoment",
        moment = var1,
        outfit = {
            source = { type = "outfit", id = id }
        },
        rbxmData = rbxmData
    }
end

local function hydrateAvatarMomentFeedItemsImpl(tbl1, arg1)
    local var1 = table.clone(tbl1)
    local tbl2 = ({})

    for value, value2 in tbl1 do
        if value2.kind ~= "moment" then
            continue
        end

        local postAsset = value2.moment.postAsset
        if postAsset == nil or postAsset.isAvatar ~= true then
            continue
        end

        local postAssetId = postAsset.postAssetId
        if typeof(postAssetId) ~= "number" or postAssetId <= 0 then
            Analytics.fireAnalyticsEvent(Analytics.EventNames.AvatarMomentLoadFailed, {
                stage = "validatePostAssetId",
                momentId = value2.moment.momentId,
                feedItemId = value2.moment.recommendationMetadata.feedItemId
            })
        else
            var1[value] = nil
            local success, result = pcall(arg1.getAndFetchPostAsset, postAssetId)
            if success then
                tbl2[value] = { item = value2, postAssetId = postAssetId, result = result }
            else
                Analytics.fireAnalyticsEvent(Analytics.EventNames.AvatarMomentLoadFailed, {
                    stage = "fetchPostAsset",
                    momentId = value2.moment.momentId,
                    feedItemId = value2.moment.recommendationMetadata.feedItemId,
                    postAssetId = tostring(postAssetId)
                })
            end
        end
    end
    for value, value2 in tbl2 do
        local item = value2.item
        local postAssetId = value2.postAssetId
        local result = value2.result
        local str1 = "loadPostAsset"
        local success, result2 = pcall(function()
            local var2 = result.status(false)
            while var2 == "NotReady" do
                task.wait()
                var2 = result.status(false)
            end
            local var3 = result.data(false)
            if var3 == nil then
                return nil
            end
            str1 = "extractAvatarPostPayload"
            local rbxmData, var4 = getAvatarPostPayload(var3)
            if rbxmData == nil then
                str1 = "findInlineScene"
                return nil
            elseif var4 == nil then
                str1 = "findOutfitAnnotation"
                return nil
            else
                str1 = "classifyAvatarPost"
                return (classifyPost(item, var3, rbxmData, var4))
            end
        end)

        if success and result2 ~= nil then
            var1[value] = result2
        else
            Analytics.fireAnalyticsEvent(Analytics.EventNames.AvatarMomentLoadFailed, {
                stage = str1,
                momentId = item.moment.momentId,
                feedItemId = item.moment.recommendationMetadata.feedItemId,
                postAssetId = tostring(postAssetId)
            })
        end
    end

    local result = {}
    for i = 1, #tbl1 do
        local var2 = var1[i]
        if var2 ~= nil then
            table.insert(result, var2)
        end
    end
    return result
end

local function hydrateAvatarMomentFeedItems(tbl1, arg1)
    if FFlagMomentsRenderAvatarPostsInFeed then
        return (hydrateAvatarMomentFeedItemsImpl(tbl1, arg1))
    end
    return tbl1
end

return hydrateAvatarMomentFeedItems
