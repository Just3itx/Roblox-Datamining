-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local VoteData = {}
VoteData.__index = VoteData

function VoteData.new(tbl3)
    return (setmetatable({
        total_up_votes = if tbl3 == nil or tbl3.total_up_votes == nil then 0 else tbl3.total_up_votes,
        total_down_votes = if tbl3 == nil or tbl3.total_down_votes == nil then 0 else tbl3.total_down_votes,
        user_vote = if tbl3 == nil or tbl3.user_vote == nil then nil else tbl3.user_vote
    }, VoteData))
end

function VoteData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.total_up_votes ~= nil and self.total_up_votes ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_up_votes)
    end

    if self.total_down_votes ~= nil and self.total_down_votes ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_down_votes)
    end

    if self.user_vote ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.user_vote then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function VoteData.decode(buf1: buffer)
    local var1 = VoteData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_up_votes = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_down_votes = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.user_vote = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
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

function VoteData:jsonEncode()
    local result = {}

    if self.total_up_votes ~= nil and self.total_up_votes ~= 0 then
        result.totalUpVotes = self.total_up_votes
    end

    if self.total_down_votes ~= nil and self.total_down_votes ~= 0 then
        result.totalDownVotes = self.total_down_votes
    end

    if self.user_vote ~= nil then
        result.userVote = self.user_vote
    end

    return result
end

function VoteData:jsonDecode()
    local var1 = VoteData.new()

    if self.total_up_votes ~= nil then
        var1.total_up_votes = self.total_up_votes
    end

    if self.totalUpVotes ~= nil then
        var1.total_up_votes = self.totalUpVotes
    end

    if self.total_down_votes ~= nil then
        var1.total_down_votes = self.total_down_votes
    end

    if self.totalDownVotes ~= nil then
        var1.total_down_votes = self.totalDownVotes
    end

    if self.user_vote ~= nil then
        var1.user_vote = self.user_vote
    end

    if self.userVote ~= nil then
        var1.user_vote = self.userVote
    end

    return var1
end

VoteData.descriptor = {
    name = "VoteData",
    fullName = "roblox.apppageplatform.shared.v1beta1.VoteData"
}

tbl1.VoteData = VoteData

typeRegistry.default:register(tbl1.VoteData)

return {
    VoteData = tbl1.VoteData
}
