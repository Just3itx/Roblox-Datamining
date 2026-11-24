-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local MomentsTypes = require(DataHydrationParent.MomentsTypes)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local FFlagMomentsServeEDPVideos = SharedFlags.FFlagMomentsServeEDPVideos
local GetFFlagMomentsRenderPostAssets = require(DataHydrationParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local convertApiMomentComments = require(DataHydration.Moments.Util.convertApiMomentComments)

local FFlagMomentsStickerOverlayNormalization = require(DataHydration.Moments.FFlagMomentsStickerOverlayNormalization)

local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentsIxpEnabled = SharedFlags.FFlagMomentsCommentsIxpEnabled
local FFlagProfileMomentSceneOutfitPoster = SharedFlags.FFlagProfileMomentSceneOutfitPoster
local FFlagEnableMomentsCommentReporting = SharedFlags.FFlagEnableMomentsCommentReporting
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local MomentStatus = MomentsTypes.Enums.MomentStatus

local BuilderSansMedium = Enum.Font.BuilderSansMedium
local black = Color3.new(0, 0, 0)

local Center = Enum.TextXAlignment.Center

local uDim2 = UDim2.fromScale(0.5, 0.5)

local function toCaptureType(str1: string?): Enum.CaptureType -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "Screenshot" then Enum.CaptureType.Screenshot else Enum.CaptureType.Video
end

local function toMomentStatus(deleted: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return if deleted == MomentStatus.Deleted then MomentStatus.Deleted else MomentStatus.Public
end

local function toMomentEntityType(entityType: string?): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if entityType == "experience" or entityType == "ad" then entityType elseif FFlagMomentsServeEDPVideos and entityType == "edpVideo" then entityType else nil
end

local function toEnumItem(arg1, arg2, arg3)
    if typeof(arg2) == "EnumItem" then
        return arg2
    end
    if type(arg2) ~= "string" then
        return arg3
    end

    local var1 = string.match(arg2, "([^%.]+)$") or arg2
    local success, result = pcall(function()
        return arg1[var1]
    end)
    return if success and result ~= nil then result else arg3
end

local function toColor3(fontColor)
    if typeof(fontColor) == "Color3" then
        return fontColor
    elseif type(fontColor) ~= "table" then
        return black
    else
        local var1 = fontColor.R or fontColor.r or fontColor.Red or fontColor.red or fontColor[1]
        local var2 = fontColor.G or fontColor.g or fontColor.Green or fontColor.green or fontColor[2]
        local var3 = fontColor.B or fontColor.b or fontColor.Blue or fontColor.blue or fontColor[3]
        if type(var1) ~= "number" or type(var2) ~= "number" or type(var3) ~= "number" then
            return black
        elseif var1 > 1 or var2 > 1 or var3 > 1 then
            return Color3.fromRGB(var1, var2, var3)
        end
        return Color3.new(var1, var2, var3)
    end
end

local function toUDim2(position)
    if typeof(position) == "UDim2" then
        return position
    elseif type(position) ~= "table" then
        return uDim2
    elseif type(position[1]) == "number" and type(position[2]) == "number" then
        return UDim2.fromScale(position[1], position[2])
    else
        local var1 = position.X or position.x
        local var2 = position.Y or position.y
        if type(var1) == "table" and type(var2) == "table" then
            return UDim2.new(
                var1.Scale or var1.scale or 0,
                var1.Offset or var1.offset or 0,
                var2.Scale or var2.scale or 0,
                var2.Offset or var2.offset or 0
            )
        end

        return UDim2.new(
            position.XScale or position.xScale or position.scaleX or position[1] or 0.5,
            position.XOffset or position.xOffset or position.offsetX or position[2] or 0,
            position.YScale or position.yScale or position.scaleY or position[3] or 0.5,
            position.YOffset or position.yOffset or position.offsetY or position[4] or 0
        )
    end
end

local function normalizeTextOverlayEdit(arg1): {position: UDim2, rotation: number, scale: number, text: number, textOverlayStyle: number, zIndex: number}?
    if type(arg1) ~= "table" then
        return nil
    end

    local textOverlayStyle = arg1.textOverlayStyle or {}
    return {
        position = toUDim2(arg1.position),
        rotation = if type(arg1.rotation) ~= "number" then 0 else arg1.rotation,
        scale = if type(arg1.scale) ~= "number" then 1 else arg1.scale,
        text = if type(arg1.text) ~= "string" then "" else arg1.text,
        textOverlayStyle = {
            font = toEnumItem(Enum.Font, textOverlayStyle.font, BuilderSansMedium),
            fontColor = toColor3(textOverlayStyle.fontColor),
            fontSize = if type(textOverlayStyle.fontSize) ~= "number" then 16 else textOverlayStyle.fontSize,
            textXAlignment = toEnumItem(Enum.TextXAlignment, textOverlayStyle.textXAlignment, Center)
        },
        zIndex = if type(arg1.zIndex) ~= "number" then 1 else arg1.zIndex
    }
end

local function normalizeStickerOverlayEdit(arg1): {position: UDim2, rotation: number, scale: number, stickerSize: number, stickerURI: number, zIndex: number}?
    if type(arg1) ~= "table" then
        return nil
    end

    if type(arg1.stickerURI) ~= "string" or arg1.stickerURI == "" then
        return nil
    end

    return {
        position = toUDim2(arg1.position),
        rotation = if type(arg1.rotation) ~= "number" then 0 else arg1.rotation,
        scale = if type(arg1.scale) ~= "number" then 1 else arg1.scale,
        stickerSize = if type(arg1.stickerSize) ~= "number" then 1 else arg1.stickerSize,
        stickerURI = if type(arg1.stickerURI) ~= "string" then "" else arg1.stickerURI,
        zIndex = if type(arg1.zIndex) ~= "number" then 1 else arg1.zIndex
    }
end

local function normalizeTtsEdit(arg1): {assetAccessContext: number, assetId: number, startTime: number, text: number, voiceId: number}?
    if type(arg1) ~= "table" then
        return nil
    end
    local assetId = tonumber(arg1.assetId)
    if assetId == nil or assetId <= 0 then
        return nil
    end

    return {
        text = if type(arg1.text) ~= "string" then "" else arg1.text,
        voiceId = if type(arg1.voiceId) ~= "number" then 0 else arg1.voiceId,
        startTime = if type(arg1.startTime) ~= "number" then 0 else arg1.startTime,
        assetId = assetId,
        assetAccessContext = if type(arg1.assetAccessContext) == "string" then arg1.assetAccessContext else nil
    }
end

local function normalizeCaptureEdits(arg1)
    if arg1 == nil then
        return nil
    end

    local var1 = nil
    local textOverlays = arg1.textOverlays
    local tbl1

    if type(textOverlays) == "table" then
        tbl1 = {}
        for _, textOverlay in arg1.textOverlays do
            local var2 = normalizeTextOverlayEdit(textOverlay)
            if var2 ~= nil then
                table.insert(tbl1, var2)
            end
        end
        if not (#tbl1 > 0) then
            tbl1 = var1
        end
    else
        tbl1 = var1
    end

    local var2 = nil
    local tbl2

    if FFlagMomentsStickerOverlayNormalization() and type(arg1.stickerOverlays) == "table" then
        tbl2 = {}
        for _, stickerOverlay in arg1.stickerOverlays do
            local var3 = normalizeStickerOverlayEdit(stickerOverlay)
            if var3 ~= nil then
                table.insert(tbl2, var3)
            end
        end
        if not (#tbl2 > 0) then
            tbl2 = var2
        end
    else
        tbl2 = var2
    end

    local var3 = nil
    local ttsAudios = arg1.ttsAudios
    local tbl3

    if type(ttsAudios) == "table" then
        tbl3 = {}
        for _, ttsAudio in arg1.ttsAudios do
            local var4 = normalizeTtsEdit(ttsAudio)
            if var4 ~= nil then
                table.insert(tbl3, var4)
            end
        end
        if not (#tbl3 > 0) then
            tbl3 = var3
        end
    else
        tbl3 = var3
    end

    return {
        trim = arg1.trim,
        music = arg1.music,
        ttsAudios = tbl3,
        textOverlays = tbl1,
        stickerOverlays = tbl2
    }
end

local function reactionTotal(reactions) -- Luacid: Inlined by compiler; 1 call site recovered
    if reactions == nil or reactions.counts == nil then
        return nil
    end

    local num1 = 0
    for _, count in reactions.counts do
        num1 += count
    end

    return num1
end

local function convertApiMomentToMomentItem(arg1): {assetId: any, channelId: number, creatorId: number, entityType: number, isModerated: number, metadata: number, momentId: number, postAsset: number, recommendationMetadata: number, status: number}?
    local captionedAssetMoment = arg1.captionedAssetMoment
    local postAssetId = if FFlagMomentsRenderAvatarPostsInFeed and arg1.postAsset ~= nil then arg1.postAsset.postAssetId else nil
    local bool1 = FFlagMomentsRenderAvatarPostsInFeed

    if bool1 then
        if (captionedAssetMoment == nil or captionedAssetMoment.captureType ~= "Avatar") and arg1.entityType ~= "avatar"
            or typeof(postAssetId) ~= "number"
        then
            bool1 = false
        else
            bool1 = postAssetId > 0
        end
    end

    if FFlagMomentsRenderAvatarPostsInFeed and captionedAssetMoment == nil then
        captionedAssetMoment = bool1 and { assetId = 0, captureType = "Avatar" } or captionedAssetMoment
    end

    local owner = arg1.owner
    local bool2 = if FFlagMomentsServeEDPVideos then arg1.entityType == "edpVideo" else nil
    local id

    if FFlagMomentsServeEDPVideos and bool2 then
        id = arg1.id

        if not id then
            if captionedAssetMoment == nil or captionedAssetMoment.assetId == nil then
                id = nil
            else
                id = tostring(captionedAssetMoment.assetId)
            end
        end
    else
        id = arg1.entityId or arg1.id
    end

    local feedItemId = arg1.feedItemId

    if captionedAssetMoment == nil
        or captionedAssetMoment.assetId == nil
        or not (FFlagMomentsServeEDPVideos and bool2) and (owner == nil or owner.id == nil)
        or id == nil
        or feedItemId == nil
        or feedItemId == ""
    then
        return nil
    end

    local experienceCta = if arg1.primaryCta == nil then nil else arg1.primaryCta.experienceCta
    local experienceId = if FFlagMomentsServeEDPVideos then if experienceCta ~= nil then experienceCta.experienceId elseif bool2 then tonumber(arg1.entityId) else nil else nil
    local var1 = if captionedAssetMoment.captureType == "Screenshot" then captionedAssetMoment.screenshotCaptureEdits else captionedAssetMoment.videoCaptureEdits
    local edits = normalizeCaptureEdits(var1)
    local status = toMomentStatus(captionedAssetMoment.status or arg1.status)

    local tbl1 = {
        assetId = captionedAssetMoment.assetId,
        channelId = if FFlagEnableMomentsCommentReporting and type(arg1.channelId) == "string" and arg1.channelId ~= "" then arg1.channelId else nil,
        creatorId = if FFlagMomentsServeEDPVideos and (owner == nil or owner.id == nil) then 0 else owner.id,
        isModerated = captionedAssetMoment.isModerated,
        metadata = 0,
        entityType = 0,
        momentId = 0,
        postAsset = 0,
        recommendationMetadata = 0,
        status = 0
    }
    local metadata = {
        assetToken = captionedAssetMoment.assetToken,
        assetTotalDuration = captionedAssetMoment.assetTotalDuration,
        assetAccessContext = captionedAssetMoment.assetAccessContext,
        captureType = if captionedAssetMoment.captureType == "Screenshot" then toCaptureType("Screenshot") else Enum.CaptureType.Video,
        description = captionedAssetMoment.caption,
        edits = edits,
        experienceName = if experienceCta == nil then nil else experienceCta.experienceName,
        likeCount = reactionTotal(arg1.reactions),
        partnerUploadType = captionedAssetMoment.partnerUploadType,
        placeId = if experienceCta == nil then nil else experienceCta.placeId,
        universeId = 0
    }

    if not FFlagMomentsServeEDPVideos then
        if experienceCta == nil then
            experienceId = nil
        else
            experienceId = experienceCta.experienceId
        end
    end

    metadata.universeId = experienceId
    tbl1.metadata = metadata

    tbl1.entityType = if FFlagMomentsServeEDPVideos then toMomentEntityType(arg1.entityType) else nil
    tbl1.momentId = id
    tbl1.postAsset = if FFlagMomentsRenderAvatarPostsInFeed and bool1 then {
        postAssetId = postAssetId,
        isAvatar = true
    } elseif GetFFlagMomentsRenderPostAssets() and arg1.postAsset ~= nil then arg1.postAsset.postAssetId ~= nil and {
        postAssetId = arg1.postAsset.postAssetId
    } or nil else nil

    tbl1.recommendationMetadata = {
        feedItemId = feedItemId,
        tracingId = arg1.feedSessionId
    }
    tbl1.status = status

    if type(arg1.feedCreatedTime) == "string" and arg1.feedCreatedTime ~= "" then
        tbl1.createdAt = arg1.feedCreatedTime
    end

    if FFlagMomentsComments or FFlagMomentsCommentsIxpEnabled then
        local comments = convertApiMomentComments(arg1.comments)
        if comments ~= nil then
            tbl1.comments = comments
        end
    end

    if FFlagProfileMomentSceneOutfitPoster and captionedAssetMoment.captureType == "Avatar" then
        tbl1.metadata.isMomentScene = true
        local postAsset = arg1.postAsset
        if tbl1.postAsset == nil and postAsset ~= nil and postAsset.postAssetId ~= nil then
            tbl1.postAsset = {
                postAssetId = postAsset.postAssetId
            }
        end
    end
    return tbl1
end

local function convertApiMomentsToMomentItems(tbl1)
    local result = {}

    if tbl1 == nil then
        return result
    end

    for _, value in ipairs(tbl1) do
        local var1 = convertApiMomentToMomentItem(value)
        if var1 ~= nil then
            table.insert(result, var1)
        end
    end

    return result
end

return convertApiMomentsToMomentItems
