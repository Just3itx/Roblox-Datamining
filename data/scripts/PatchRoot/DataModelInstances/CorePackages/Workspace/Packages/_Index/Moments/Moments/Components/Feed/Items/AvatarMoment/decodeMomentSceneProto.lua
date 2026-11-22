-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readVarint(buf: buffer, offset: number)
    local num1 = 0
    local num2 = 1
    for _ = 1, 10 do
        if buffer.len(buf) <= offset then
            error("MomentScene protobuf ended inside a varint")
        end
        local num3 = buffer.readu8(buf, offset)
        offset += 1
        num1 += bit32.band(num3, 0x7F) * num2
        if num3 < 128 then
            return num1, offset
        end
        num2 *= 128
    end
    error("MomentScene protobuf contains an invalid varint")
end

local function readLengthDelimited(buffer2: buffer, offset: number): (string, number)
    local count
    count, offset = readVarint(buffer2, offset)
    local num1 = offset + count
    if count < 0 or buffer.len(buffer2) < num1 then
        error("MomentScene protobuf contains an invalid byte field")
    end
    return buffer.readstring(buffer2, offset, count), num1
end

local function skipField(buffer2: buffer, num1: number, num2: number)
    if num2 == 0 then
        local _
        _, num1 = readVarint(buffer2, num1)
        return num1
    end

    if num2 == 1 then
        num1 += 8
    else
        if num2 == 2 then
            local _
            _, num1 = readLengthDelimited(buffer2, num1)
            return num1
        end

        if num2 == 5 then
            num1 += 4
        else
            error(`MomentScene protobuf uses unsupported wire type {num2}`)
        end
    end

    if buffer.len(buffer2) < num1 then
        error("MomentScene protobuf ended inside a fixed-width field")
    end
    return num1
end

local function decodeMomentSceneProto(buffer2: buffer)
    local num1 = 0
    local result = {}

    while num1 < buffer.len(buffer2) do
        local num2, num3 = readVarint(buffer2, num1)
        local num4 = math.floor(num2 / 8)
        local num5 = num2 % 8
        if num4 == 0 then
            error("MomentScene protobuf contains field number zero")
        end

        if num4 == 1 or num4 == 5 then
            if num5 ~= 2 then
                error(`MomentScene protobuf field {num4} has the wrong wire type`)
            end

            local var1
            var1, num1 = readLengthDelimited(buffer2, num3)
            if num4 == 1 then
                result.camera_metadata = var1
            else
                result.emote_name = var1
            end
        elseif num4 >= 2 and num4 <= 4 then
            if num5 ~= 0 then
                error(`MomentScene protobuf field {num4} has the wrong wire type`)
            end

            local var1
            var1, num1 = readVarint(buffer2, num3)
            if num4 == 2 then
                result.outfit_id = var1
            elseif num4 == 3 then
                result.emote_asset_id = var1
            else
                result.background_asset_id = var1
            end
        else
            num1 = skipField(buffer2, num3, num5)
        end
    end
    return result
end

return decodeMomentSceneProto
