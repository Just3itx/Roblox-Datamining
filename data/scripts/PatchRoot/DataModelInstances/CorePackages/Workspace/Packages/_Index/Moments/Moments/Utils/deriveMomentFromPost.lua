-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagMomentsAvatarLookTryOn = SharedFlags.FFlagMomentsAvatarLookTryOn
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed

local tbl1 = {
    TEXT_X_ALIGNMENT_LEFT = Enum.TextXAlignment.Left,
    TEXT_X_ALIGNMENT_CENTER = Enum.TextXAlignment.Center,
    TEXT_X_ALIGNMENT_RIGHT = Enum.TextXAlignment.Right
}

local function toEnumFont(arg1)
    if type(arg1) ~= "string" then
        return nil
    end
    local var1 = string.match(arg1, "^ENUMERATED_FONT_(.+)$")
    if var1 == nil or var1 == "INVALID" then
        return nil
    end
    local tbl2 = {}
    for value in string.gmatch(var1, "[^_]+") do
        table.insert(tbl2, string.upper(string.sub(value, 1, 1)) .. string.lower(string.sub(value, 2)))
    end
    local success, result = pcall(function()
        return Enum.Font[table.concat(tbl2)]
    end)
    return if success then result else nil
end

local function durationSeconds(arg1) -- Luacid: Inlined by compiler; 8 call sites recovered
    if arg1 == nil then
        return 0
    end

    return (arg1.seconds or 0) + (arg1.nanos or 0) / 1000000000
end

local function toTrim(trim) -- Luacid: Inlined by compiler; 1 call site recovered
    if trim == nil then
        return nil
    end
    local startTime = durationSeconds(trim.offset_duration)
    local var2 = durationSeconds(trim.duration)
    return if var2 <= 0 then nil else {
        startTime = startTime,
        endTime = startTime + var2
    }
end

local function toTextOverlay(arg1, arg2, arg3)
    local transform = arg1.transform
    local uDim2 = if transform ~= nil and transform.position ~= nil then UDim2.fromScale(transform.position.x, transform.position.y) else UDim2.fromScale(0.5, 0.5)
    local fontSource = if arg2.font == nil then nil else arg2.font.font_source
    local font = if fontSource == nil or fontSource.type ~= "enumerated_font" then nil else toEnumFont(fontSource.value)
    local fontColor = arg2.font_color

    return {
        position = uDim2,
        rotation = if transform == nil then 0 else transform.rotation,
        scale = if transform == nil or transform.scale == 0 then 1 else transform.scale,
        text = arg2.text,
        textOverlayStyle = {
            font = font or arg3 or Enum.Font.BuilderSansMedium,
            fontColor = if fontColor ~= nil then Color3.new(fontColor.r, fontColor.g, fontColor.b) else Color3.new(0, 0, 0),
            fontSize = if arg2.font_size > 0 then arg2.font_size else 16,
            textXAlignment = tbl1[arg2.text_x_alignment] or Enum.TextXAlignment.Center
        },
        zIndex = if type(arg1.z_index) ~= "number" or not (arg1.z_index > 0) then 1 else arg1.z_index
    }
end

local function musicStartTime(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if arg2.source_trim ~= nil then arg2.source_trim else arg1.time_range

    if var1 ~= nil then
        return durationSeconds(var1.offset_duration)
    end

    return 0
end

local function getTtsAssetAccessContext(arg1, assetId: number) -- Luacid: unused: defined but never referenced
    if arg1 == nil or arg1.ttsAudios == nil then
        return nil
    end
    for _, ttsAudio in arg1.ttsAudios do
        if ttsAudio.assetId == assetId then
            return ttsAudio.assetAccessContext
        end
    end
    return nil
end

local function applyPostMetadata(arg1, metadata)
    if metadata == nil then
        return
    end
    if metadata.caption ~= nil and metadata.caption ~= "" then
        arg1.description = metadata.caption
    end
    if metadata.total_duration ~= nil then
        arg1.assetTotalDuration = durationSeconds(metadata.total_duration)
    end
    if metadata.origin ~= nil and metadata.origin ~= 0 and metadata.origin ~= "POST_ORIGIN_INVALID" then
        arg1.hasAuthoritativePartnerUploadType = true
        arg1.partnerUploadType = if metadata.origin == "POST_ORIGIN_INFLUENCER_UPLOAD" then "influencer" else nil
    end
end

local function deriveMomentFromPost(arg1, arg2)
    local metadata = table.clone(arg1.metadata)
    local edits = metadata.edits
    local tbl2 = {
        stickerOverlays = if edits == nil then nil else edits.stickerOverlays
    }
    local textOverlays = {}
    local ttsAudios = {}
    local var2 = nil
    local var3 = nil
    local bool1 = false

    for _, value in arg2.tracks or {} do
        local assetAccessContext

        for _, value2 in value.slots or {} do
            local content = value2.content
            if content == nil then
                continue
            end

            if content.type == "visual" then
                local value3 = content.value
                local content2 = value3.content
                if content2 ~= nil then
                    if content2.type == "video" and var2 == nil and content2.value.asset_id > 0 then
                        var2 = content2.value.asset_id
                        var3 = Enum.CaptureType.Video
                        local trim = content2.value.trim
                        local tbl3 = toTrim(trim)
                        tbl2.trim = tbl3
                    elseif content2.type == "image" and var2 == nil and content2.value.asset_id > 0 then
                        var2 = content2.value.asset_id
                        var3 = Enum.CaptureType.Screenshot
                    elseif FFlagMomentsRenderAvatarPostsInFeed and content2.type == "scene" then
                        bool1 = true
                    elseif content2.type == "text_label" then
                        local num1 = #textOverlays + 1
                        local textOverlay = if edits == nil or edits.textOverlays == nil then nil else edits.textOverlays[num1]
                        local font = if textOverlay == nil then nil else textOverlay.textOverlayStyle.font
                        table.insert(textOverlays, (toTextOverlay(value3, content2.value, font)))
                    end
                end
            elseif content.type == "audio" then
                local value3 = content.value
                if value3.audio_type == "AUDIO_TYPE_MUSIC" and tbl2.music == nil and value3.asset_id > 0 then
                    tbl2.music = {
                        assetId = value3.asset_id,
                        startTime = musicStartTime(value2, value3)
                    }
                elseif value3.audio_type == "AUDIO_TYPE_TTS" and value3.context ~= nil and value3.context.type == "tts" and value3.asset_id > 0 then
                    local value4 = value3.context.value
                    local tbl5 = {
                        text = value4.text,
                        voiceId = value4.voice_id,
                        startTime = if value2.time_range == nil then 0 else durationSeconds(value2.time_range.offset_duration),
                        assetId = value3.asset_id,
                        assetAccessContext = 0
                    }
                    local assetId = value3.asset_id
                    local var4

                    if edits == nil or edits.ttsAudios == nil then
                        var4 = false
                    else
                        var4 = false

                        for _, ttsAudio in edits.ttsAudios do
                            if ttsAudio.assetId == assetId then
                                assetAccessContext = ttsAudio.assetAccessContext
                                var4 = true
                                break
                            end
                        end
                    end

                    if not var4 then
                        assetAccessContext = nil
                    end

                    tbl5.assetAccessContext = assetAccessContext
                    table.insert(ttsAudios, tbl5)
                end
            elseif content.type == "experience_annotation" then
                if content.value.universe_id > 0 then
                    metadata.universeId = content.value.universe_id
                end
                if content.value.place_id > 0 then
                    metadata.placeId = content.value.place_id
                end
            elseif FFlagMomentsAvatarLookTryOn and content.type == "avatar_annotation" and content.value.outfit_id > 0 then
                metadata.outfitId = content.value.outfit_id
            end
        end
    end

    if (var2 == nil or var3 == nil) and not (FFlagMomentsRenderAvatarPostsInFeed and bool1) then
        return nil
    end

    if #textOverlays > 0 then
        tbl2.textOverlays = textOverlays
    end
    if #ttsAudios > 0 then
        tbl2.ttsAudios = ttsAudios
    end

    applyPostMetadata(metadata, arg2.metadata)
    if FFlagMomentsRenderAvatarPostsInFeed and var3 == nil then
        var3 = metadata.captureType
    end

    metadata.captureType = var3

    metadata.edits = tbl2

    local var4 = table.clone(arg1)
    if FFlagMomentsRenderAvatarPostsInFeed and var2 == nil then
        var2 = arg1.assetId
    end

    var4.assetId = var2

    var4.metadata = metadata
    return var4
end

return deriveMomentFromPost
