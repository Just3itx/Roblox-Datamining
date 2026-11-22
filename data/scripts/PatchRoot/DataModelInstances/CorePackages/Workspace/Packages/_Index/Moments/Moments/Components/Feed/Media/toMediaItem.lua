-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local HttpService = game:GetService("HttpService")

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local FFlagMomentsOptimisticProfilePending = require(MomentsParent.SharedFlags).FFlagMomentsOptimisticProfilePending
local tutils = require(MomentsParent.tutils)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos
local FFlagMomentsTTSFeedPlayback = require(Moments.Flags.FFlagMomentsTTSFeedPlayback)
local FFlagMomentsTTSPendingPreviewPlayback = require(Moments.Flags.FFlagMomentsTTSPendingPreviewPlayback)
local GetFFlagMomentsRenderPostAssets = require(MomentsParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)
local deriveMomentFromPost = require(Moments.Utils.deriveMomentFromPost)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)

local FFlagMomentsVideoPermissionContextFix = MomentsCommon.Flags.FFlagMomentsVideoPermissionContextFix

local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType

local function getMediaContentUri(assetId: number, captureType, str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    local str2 = `rbxassetid://{assetId}`
    if captureType ~= Enum.CaptureType.Video or str1 == nil then
        return str2
    end

    return `{str2}&accessContext={str1}&permissionContext=ignoreUniverse`
end

local function getMediaContents(assetId: number, captureType, str1: string?)
    local content = Content.fromUri((getMediaContentUri(assetId, captureType, str1)))

    if FFlagMomentsVideoPermissionContextFix and game.GameId == 0 and captureType == Enum.CaptureType.Video and str1 ~= nil then
        return Content.fromUri(`rbxassetid://{assetId}&accessContext={str1}`), content
    end

    return content, nil
end

local function getLocalTts(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg2 == nil then
        return nil
    end
    local tts = arg2.tts
    return if tts == nil or tts.text == nil or tts.text == "" then nil else tts
end

local function toMediaItem(arg1, tbl1)
    local bool1 = not (tbl1 == nil) and tbl1.includeLocalTts == true

    if FFlagMomentsRenderAvatarPostsInFeed and arg1.kind == "avatarMoment" then
        local moment = arg1.moment
        local edits = moment.metadata.edits
        if not FFlagMomentsTTSFeedPlayback and edits ~= nil and edits.ttsAudios ~= nil then
            edits = table.clone(edits)
            edits.ttsAudios = nil
        end
        return {
            momentId = moment.momentId,
            sourceKey = `avatar-post:{moment.momentId}`,
            content = Content.none,
            posterContent = nil,
            captureType = Enum.CaptureType.Screenshot,
            isExternalBase = true,
            edits = edits
        }
    end
    if arg1.kind ~= "moment" then
        return nil
    end
    local moment = arg1.moment

    if moment == nil or moment.metadata == nil then
        return nil
    end

    if not GetFFlagMomentsRenderPostAssets() then
        local assetId = moment.assetId
        local localContent = if FFlagMomentsOptimisticProfilePending then moment.localContent else nil
        local assetAccessContext = if FFlagMomentsServeEDPVideos and moment.entityType == "edpVideo" then nil else moment.metadata.assetAccessContext
        local var1 = if assetAccessContext == nil or assetAccessContext == "" then nil else HttpService:UrlEncode(assetAccessContext)
        local uri = if localContent ~= nil then localContent elseif assetId > 0 then Content.fromUri(
            if var1 ~= nil then `{getRbxThumb(ThumbnailType.Asset, assetId)}&accessContext={var1}` else getRbxThumb(ThumbnailType.Asset, assetId)
        ) else nil
        local edits = moment.metadata.edits
        if not FFlagMomentsTTSFeedPlayback and edits ~= nil and edits.ttsAudios ~= nil then
            edits = table.clone(edits)
            edits.ttsAudios = nil
        end

        local content, var2 = getMediaContents(assetId, moment.metadata.captureType, var1)
        local tbl2 = {
            momentId = moment.momentId,
            content = localContent or content,
            preloadContent = 0,
            posterContent = 0,
            captureType = 0,
            edits = 0,
            localTts = 0
        }

        if localContent ~= nil then
            var2 = nil
        end

        tbl2.preloadContent = var2
        tbl2.posterContent = uri
        tbl2.captureType = moment.metadata.captureType
        tbl2.edits = edits
        tbl2.localTts = if FFlagMomentsTTSPendingPreviewPlayback and FFlagMomentsTTSFeedPlayback and bool1 then getLocalTts(localContent, edits) else nil
        return tbl2
    end

    local function createMediaItem(arg2, sourceKey: string)
        local localContent = if FFlagMomentsOptimisticProfilePending then arg2.localContent else nil
        local assetId = arg2.assetId
        local assetAccessContext = if FFlagMomentsServeEDPVideos and arg2.entityType == "edpVideo" then nil else arg2.metadata.assetAccessContext
        local var1 = if assetAccessContext == nil or assetAccessContext == "" then nil else HttpService:UrlEncode(assetAccessContext)
        local uri = if localContent ~= nil then localContent elseif assetId > 0 then Content.fromUri(
            if var1 ~= nil then `{getRbxThumb(ThumbnailType.Asset, assetId)}&accessContext={var1}` else getRbxThumb(ThumbnailType.Asset, assetId)
        ) else nil
        local edits = arg2.metadata.edits
        if not FFlagMomentsTTSFeedPlayback and edits ~= nil and edits.ttsAudios ~= nil then
            edits = table.clone(edits)
            edits.ttsAudios = nil
        end

        local content, var2 = getMediaContents(assetId, arg2.metadata.captureType, var1)

        local tbl2 = {
            momentId = arg2.momentId,
            sourceKey = sourceKey,
            content = localContent or content,
            preloadContent = 0,
            posterContent = 0,
            captureType = 0,
            edits = 0,
            localTts = 0
        }

        if localContent ~= nil then
            var2 = nil
        end

        tbl2.preloadContent = var2
        tbl2.posterContent = uri
        tbl2.captureType = arg2.metadata.captureType
        tbl2.edits = edits
        tbl2.localTts = if FFlagMomentsTTSPendingPreviewPlayback and FFlagMomentsTTSFeedPlayback and bool1 then getLocalTts(localContent, edits) else nil
        return tbl2
    end

    local mediaItem = createMediaItem(moment, `json:{moment.assetId}`)
    local postAssetId = if moment.postAsset == nil then nil else moment.postAsset.postAssetId

    if postAssetId == nil or postAssetId <= 0 then
        return mediaItem
    end

    function mediaItem.resolve(arg2)
        local var1 = MomentsGetPostAssetStore(false).getAndFetchPostAsset(postAssetId).data(arg2)
        if var1 ~= nil then
            local var2 = deriveMomentFromPost(moment, var1)
            if var2 ~= nil then
                local mediaItem2 = createMediaItem(var2, `post:{postAssetId}`)
                mediaItem2.cornerRadius = mediaItem.cornerRadius

                if mediaItem2.content.Uri == mediaItem.content.Uri
                    and mediaItem2.captureType == mediaItem.captureType
                    and tutils.deepEqual(mediaItem2.edits or {}, mediaItem.edits or {})
                then
                    mediaItem2.sourceKey = mediaItem.sourceKey
                end
                return mediaItem2
            end
        end
        return mediaItem
    end

    return mediaItem
end

return toMediaItem
