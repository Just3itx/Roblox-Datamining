-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local PlayabilityData = {}
PlayabilityData.__index = PlayabilityData

function PlayabilityData.new(tbl3)
    return (setmetatable({
        is_playable = not (tbl3 == nil or tbl3.is_playable == nil) and tbl3.is_playable,
        playability_status = if tbl3 == nil or tbl3.playability_status == nil then "" else tbl3.playability_status
    }, PlayabilityData))
end

function PlayabilityData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.is_playable then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_playable then 1 else 0)
    end

    if self.playability_status ~= nil and self.playability_status ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.playability_status)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PlayabilityData.decode(buf1: buffer)
    local var1 = PlayabilityData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_playable = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.playability_status = buffer.tostring(buf)
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

function PlayabilityData:jsonEncode()
    local result = {}

    if self.is_playable then
        result.isPlayable = self.is_playable
    end

    if self.playability_status ~= nil and self.playability_status ~= "" then
        result.playabilityStatus = self.playability_status
    end

    return result
end

function PlayabilityData:jsonDecode()
    local var1 = PlayabilityData.new()

    if self.is_playable ~= nil then
        var1.is_playable = self.is_playable
    end

    if self.isPlayable ~= nil then
        var1.is_playable = self.isPlayable
    end

    if self.playability_status ~= nil then
        var1.playability_status = self.playability_status
    end

    if self.playabilityStatus ~= nil then
        var1.playability_status = self.playabilityStatus
    end

    return var1
end

PlayabilityData.descriptor = {
    name = "PlayabilityData",
    fullName = "roblox.apppageplatform.shared.v1beta1.PlayabilityData"
}

tbl1.PlayabilityData = PlayabilityData

typeRegistry.default:register(tbl1.PlayabilityData)

return {
    PlayabilityData = tbl1.PlayabilityData
}
