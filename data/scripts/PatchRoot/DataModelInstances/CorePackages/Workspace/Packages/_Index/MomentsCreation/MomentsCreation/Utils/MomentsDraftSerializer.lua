-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local FFlagMomentsTTSDraftRestore = require(MomentsCreation.Flags.FFlagMomentsTTSDraftRestore)

local function encodeUDim2(uDim2: UDim2) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        xScale = uDim2.X.Scale,
        xOffset = uDim2.X.Offset,
        yScale = uDim2.Y.Scale,
        yOffset = uDim2.Y.Offset
    }
end

local function encodeColor3(color3: Color3) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        r = color3.R,
        g = color3.G,
        b = color3.B
    }
end

local function encodeTextOverlay(arg1)
    local textOverlayStyle = arg1.textOverlayStyle
    return {
        position = encodeUDim2(arg1.position),
        rotation = arg1.rotation,
        scale = arg1.scale,
        text = arg1.text,
        zIndex = arg1.zIndex,
        textOverlayStyle = {
            font = textOverlayStyle.font.Name,
            fontColor = encodeColor3(textOverlayStyle.fontColor),
            fontSize = textOverlayStyle.fontSize,
            textXAlignment = textOverlayStyle.textXAlignment.Name
        }
    }
end

local function encodeStickerOverlay(arg1) -- Luacid: unused: defined but never referenced
    return {
        stickerURI = arg1.stickerURI,
        position = encodeUDim2(arg1.position),
        stickerSize = arg1.stickerSize,
        rotation = arg1.rotation,
        scale = arg1.scale,
        zIndex = arg1.zIndex
    }
end

local function encodeVoice(voice) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        text = voice.text,
        voiceId = voice.voiceId,
        startTime = voice.startTime
    }
end

local function decodeUDim2(position)
    if type(position) ~= "table"
        or type(position.xScale) ~= "number"
        or type(position.xOffset) ~= "number"
        or type(position.yScale) ~= "number"
        or type(position.yOffset) ~= "number"
    then
        return nil
    end

    return UDim2.new(position.xScale, position.xOffset, position.yScale, position.yOffset)
end

local function decodeColor3(fontColor) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(fontColor) ~= "table"
        or type(fontColor.r) ~= "number"
        or type(fontColor.g) ~= "number"
        or type(fontColor.b) ~= "number"
    then
        return nil
    end

    return Color3.new(fontColor.r, fontColor.g, fontColor.b)
end

local function safeDecodeEnum(arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    if type(arg2) ~= "string" then
        return nil
    end
    local success, result = pcall(function()
        return arg1[arg2]
    end)
    return if success then result else nil
end

local function decodeTextOverlay(arg1)
    if type(arg1) ~= "table" or type(arg1.textOverlayStyle) ~= "table" then
        return nil
    end

    local textOverlayStyle = arg1.textOverlayStyle
    local position = decodeUDim2(arg1.position)
    local font = safeDecodeEnum(Enum.Font, textOverlayStyle.font)
    local fontColor = decodeColor3(textOverlayStyle.fontColor)
    local textXAlignment = safeDecodeEnum(Enum.TextXAlignment, textOverlayStyle.textXAlignment)

    if position == nil or font == nil or fontColor == nil or textXAlignment == nil then
        return nil
    end

    if type(arg1.rotation) ~= "number"
        or type(arg1.scale) ~= "number"
        or type(arg1.text) ~= "string"
        or type(arg1.zIndex) ~= "number"
        or type(textOverlayStyle.fontSize) ~= "number"
    then
        return nil
    end

    return {
        position = position,
        rotation = arg1.rotation,
        scale = arg1.scale,
        text = arg1.text,
        zIndex = arg1.zIndex,
        textOverlayStyle = {
            font = font,
            fontColor = fontColor,
            fontSize = textOverlayStyle.fontSize,
            textXAlignment = textXAlignment
        }
    }
end

local function decodeStickerOverlay(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local position = decodeUDim2(arg1.position)
    if position == nil then
        return nil
    end

    if arg1.stickerURI ~= nil and type(arg1.stickerURI) ~= "string" then
        return nil
    end

    if type(arg1.stickerSize) ~= "number"
        or type(arg1.rotation) ~= "number"
        or type(arg1.scale) ~= "number"
        or type(arg1.zIndex) ~= "number"
    then
        return nil
    end

    return {
        stickerURI = arg1.stickerURI,
        position = position,
        stickerSize = arg1.stickerSize,
        rotation = arg1.rotation,
        scale = arg1.scale,
        zIndex = arg1.zIndex
    }
end

local function decodeTrim(trim)
    if type(trim) ~= "table" then
        return nil
    end

    return if type(trim.startTime) == "number" and type(trim.endTime) == "number" then {
        startTime = trim.startTime,
        endTime = trim.endTime
    } else nil
end

local function decodeMusic(music)
    if type(music) ~= "table" then
        return nil
    end

    return if type(music.assetId) == "number" and type(music.startTime) == "number" then {
        assetId = music.assetId,
        startTime = music.startTime
    } else nil
end

local function decodeVoice(voice)
    if type(voice) ~= "table" then
        return nil
    end

    if type(voice.text) ~= "string"
        or voice.text == ""
        or type(voice.voiceId) ~= "number"
        or type(voice.startTime) ~= "number"
    then
        return nil
    end

    return encodeVoice(voice)
end

return {
    serialize = function(arg1)
        local edits = arg1.edits

        local tbl1 = {
            trim = edits.trim,
            music = edits.music
        }

        if edits.text then
            local text = {}
            for _, value in edits.text do
                table.insert(text, (encodeTextOverlay(value)))
            end
            tbl1.text = text
        end

        if edits.sticker then
            local sticker = {}
            for _, value in edits.sticker do
                local tbl3 = {
                    stickerURI = value.stickerURI,
                    position = 0,
                    stickerSize = 0,
                    rotation = 0,
                    scale = 0,
                    zIndex = 0
                }
                local position = value.position
                tbl3.position = encodeUDim2(position)
                tbl3.stickerSize = value.stickerSize
                tbl3.rotation = value.rotation
                tbl3.scale = value.scale
                tbl3.zIndex = value.zIndex

                table.insert(sticker, tbl3)
            end
            tbl1.sticker = sticker
        end

        if FFlagMomentsTTSDraftRestore and edits.voice then
            tbl1.voice = encodeVoice(edits.voice)
        end

        return {
            userId = arg1.userId,
            captureRef = {
                localId = arg1.captureRef.localId,
                captureType = arg1.captureRef.captureType.Name
            },
            description = arg1.description,
            commentsEnabled = arg1.commentsEnabled,
            edits = tbl1,
            lastSaveTime = arg1.lastSaveTime
        }
    end,
    deserialize = function(arg1)
        if type(arg1) ~= "table" then
            return nil
        end

        local captureRef = arg1.captureRef
        if type(captureRef) ~= "table" or type(captureRef.localId) ~= "string" or captureRef.localId == "" then
            return nil
        end
        local captureType = safeDecodeEnum(Enum.CaptureType, captureRef.captureType)
        if captureType == nil then
            return nil
        end

        local edits = arg1.edits
        if type(edits) ~= "table" then
            return nil
        end

        local tbl1 = {}

        if edits.trim ~= nil then
            local trim = decodeTrim(edits.trim)
            if trim == nil then
                return nil
            end
            tbl1.trim = trim
        end

        if edits.music ~= nil then
            local music = decodeMusic(edits.music)
            if music == nil then
                return nil
            end
            tbl1.music = music
        end

        if edits.text ~= nil then
            if type(edits.text) ~= "table" then
                return nil
            end
            local text = {}
            for _, value in edits.text do
                local var2 = decodeTextOverlay(value)
                if var2 == nil then
                    return nil
                end
                table.insert(text, var2)
            end
            tbl1.text = text
        end

        if edits.sticker ~= nil then
            if type(edits.sticker) ~= "table" then
                return nil
            end
            local sticker = {}
            for _, value in edits.sticker do
                local var2 = decodeStickerOverlay(value)
                if var2 == nil then
                    return nil
                end
                table.insert(sticker, var2)
            end
            tbl1.sticker = sticker
        end

        if FFlagMomentsTTSDraftRestore and edits.voice ~= nil then
            tbl1.voice = decodeVoice(edits.voice)
        end

        if type(arg1.userId) ~= "string" then
            return nil
        end
        if arg1.description ~= nil and type(arg1.description) ~= "string" then
            return nil
        end
        if arg1.commentsEnabled ~= nil and type(arg1.commentsEnabled) ~= "boolean" then
            return nil
        end
        if type(arg1.lastSaveTime) ~= "number" then
            return nil
        end

        return {
            userId = arg1.userId,
            captureRef = {
                localId = captureRef.localId,
                captureType = captureType
            },
            description = arg1.description,
            commentsEnabled = arg1.commentsEnabled,
            edits = tbl1,
            lastSaveTime = arg1.lastSaveTime
        }
    end
}
