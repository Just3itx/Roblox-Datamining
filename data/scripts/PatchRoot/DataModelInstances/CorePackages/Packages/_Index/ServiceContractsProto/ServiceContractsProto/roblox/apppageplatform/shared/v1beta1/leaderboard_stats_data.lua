-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local LeaderboardStatsData = {}
LeaderboardStatsData.__index = LeaderboardStatsData

function LeaderboardStatsData.new(tbl3)
    return (setmetatable({
        id = if tbl3 == nil or tbl3.id == nil then "" else tbl3.id,
        rank = if tbl3 == nil or tbl3.rank == nil then nil else tbl3.rank,
        score = if tbl3 == nil or tbl3.score == nil then 0 else tbl3.score
    }, LeaderboardStatsData))
end

function LeaderboardStatsData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.rank ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.rank)
    end

    if self.score ~= nil and self.score ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.score)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function LeaderboardStatsData.decode(buf1: buffer)
    local var1 = LeaderboardStatsData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.rank = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.score = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.id = buffer.tostring(buf)
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

function LeaderboardStatsData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.rank ~= nil then
        result.rank = self.rank
    end

    if self.score ~= nil and self.score ~= 0 then
        result.score = self.score
    end

    return result
end

function LeaderboardStatsData:jsonDecode()
    local var1 = LeaderboardStatsData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.rank ~= nil then
        var1.rank = self.rank
    end

    if self.score ~= nil then
        var1.score = self.score
    end

    return var1
end

LeaderboardStatsData.descriptor = {
    name = "LeaderboardStatsData",
    fullName = "roblox.apppageplatform.shared.v1beta1.LeaderboardStatsData"
}

tbl1.LeaderboardStatsData = LeaderboardStatsData

typeRegistry.default:register(tbl1.LeaderboardStatsData)

return {
    LeaderboardStatsData = tbl1.LeaderboardStatsData
}
