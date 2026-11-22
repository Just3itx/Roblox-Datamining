-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)
local FFlagMomentsTextOverlayV2Redesign = require(MomentsCreationParent.MomentsCommon).Flags.FFlagMomentsTextOverlayV2Redesign

local FFlagMomentsCommentsCreatorControl = require(MomentsCreation.Flags.FFlagMomentsCommentsCreatorControl)
local FFlagMomentsCreationSessionId = require(MomentsCreation.Flags.FFlagMomentsCreationSessionId)

local function enumName(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return if typeof(arg1) == "EnumItem" then arg1.Name else arg1
end

local function convertTextOverlayStyle(textOverlayStyle)
    return {
        font = if FFlagMomentsTextOverlayV2Redesign then enumName(textOverlayStyle.font) else textOverlayStyle.font.Name,
        fontColor = { textOverlayStyle.fontColor.R, textOverlayStyle.fontColor.G, textOverlayStyle.fontColor.B },
        fontSize = textOverlayStyle.fontSize,
        textXAlignment = if FFlagMomentsTextOverlayV2Redesign then enumName(textOverlayStyle.textXAlignment) else textOverlayStyle.textXAlignment.Name
    }
end

local function convertTextOverlay(arg1)
    return {
        text = arg1.text,
        rotation = arg1.rotation,
        scale = arg1.scale,
        zIndex = arg1.zIndex,
        position = { arg1.position.X.Scale, arg1.position.Y.Scale },
        textOverlayStyle = convertTextOverlayStyle(arg1.textOverlayStyle)
    }
end

local function makePostMetadata(arg1, capture, creationSessionId: string?)
    local tbl1 = {
        caption = arg1.description
    }
    if FFlagMomentsCreationSessionId and creationSessionId ~= nil and creationSessionId ~= "" then
        tbl1.creationSessionId = creationSessionId
    end

    if FFlagMomentsCommentsCreatorControl and arg1.commentsEnabled == false then
        tbl1.commentsEnabled = false
    end

    if enumName(arg1.captureType) == Enum.CaptureType.Screenshot.Name then
        tbl1.widthPixels = arg1.widthPixels
        tbl1.heightPixels = arg1.heightPixels
    end

    if arg1.edits then
        if arg1.edits.music then
            tbl1.music = {
                assetId = arg1.edits.music.assetId,
                startTime = arg1.edits.music.startTime
            }
        end

        if arg1.edits.trim then
            tbl1.trim = {
                startTime = arg1.edits.trim.startTime,
                endTime = arg1.edits.trim.endTime
            }
        end

        if arg1.edits.textOverlays then
            local textOverlays = {}
            for _, textOverlay in arg1.edits.textOverlays do
                table.insert(textOverlays, (convertTextOverlay(textOverlay)))
            end
            tbl1.textOverlays = textOverlays
        end

        if GetFFlagMomentsTTSAudioOverlay and arg1.edits.tts and arg1.edits.tts.text ~= nil and arg1.edits.tts.text ~= "" then
            local tts = arg1.edits.tts
            tbl1.textToSpeech = {{
                text = tts.text,
                voiceId = tts.voiceId,
                pitch = 0,
                speed = 1,
                startTime = tts.startTime
            }}
        end
    end

    if not arg1.universeIdOverride then
        local _universeId = arg1.universeId
    end

    local universeId = arg1.universeId
    if universeId == nil or not (universeId > 0) then
        universeId = arg1.universeIdOverride
    end
    if universeId and arg1.placeId then
        tbl1.primaryCta = {
            experienceId = universeId,
            placeId = arg1.placeId
        }
    end

    if if FFlagMomentsTextOverlayV2Redesign then enumName(arg1.captureType) == Enum.CaptureType.Video.Name else arg1.captureType == Enum.CaptureType.Video then
        tbl1.durationSeconds = arg1.assetTotalDuration
    end

    if capture ~= nil then
        tbl1.media = {{
            capture = capture,
            widthPixels = tbl1.widthPixels,
            heightPixels = tbl1.heightPixels,
            durationSeconds = tbl1.durationSeconds,
            trim = tbl1.trim
        }}

        tbl1.widthPixels = nil
        tbl1.heightPixels = nil
        tbl1.durationSeconds = nil
        tbl1.trim = nil
    end

    return tbl1
end

return makePostMetadata
