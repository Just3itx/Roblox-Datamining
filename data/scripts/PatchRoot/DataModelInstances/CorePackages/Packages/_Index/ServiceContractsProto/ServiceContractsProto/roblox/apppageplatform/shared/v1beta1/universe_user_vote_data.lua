-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UniverseUserVoteData = {}
UniverseUserVoteData.__index = UniverseUserVoteData

function UniverseUserVoteData.new(tbl3)
    return (setmetatable({
        user_vote = if tbl3 == nil or tbl3.user_vote == nil then nil else tbl3.user_vote,
        can_vote = not (tbl3 == nil or tbl3.can_vote == nil) and tbl3.can_vote,
        reason_for_not_voteable = if tbl3 == nil or tbl3.reason_for_not_voteable == nil then "" else tbl3.reason_for_not_voteable
    }, UniverseUserVoteData))
end

function UniverseUserVoteData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.user_vote ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.user_vote then 1 else 0)
    end

    if self.can_vote then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_vote then 1 else 0)
    end

    if self.reason_for_not_voteable ~= nil and self.reason_for_not_voteable ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.reason_for_not_voteable)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteData.decode(buf1: buffer)
    local var1 = UniverseUserVoteData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.user_vote = var4 ~= 0
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_vote = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.reason_for_not_voteable = buffer.tostring(buf)
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

function UniverseUserVoteData:jsonEncode()
    local result = {}

    if self.user_vote ~= nil then
        result.userVote = self.user_vote
    end

    if self.can_vote then
        result.canVote = self.can_vote
    end

    if self.reason_for_not_voteable ~= nil and self.reason_for_not_voteable ~= "" then
        result.reasonForNotVoteable = self.reason_for_not_voteable
    end

    return result
end

function UniverseUserVoteData:jsonDecode()
    local var1 = UniverseUserVoteData.new()

    if self.user_vote ~= nil then
        var1.user_vote = self.user_vote
    end

    if self.userVote ~= nil then
        var1.user_vote = self.userVote
    end

    if self.can_vote ~= nil then
        var1.can_vote = self.can_vote
    end

    if self.canVote ~= nil then
        var1.can_vote = self.canVote
    end

    if self.reason_for_not_voteable ~= nil then
        var1.reason_for_not_voteable = self.reason_for_not_voteable
    end

    if self.reasonForNotVoteable ~= nil then
        var1.reason_for_not_voteable = self.reasonForNotVoteable
    end

    return var1
end

UniverseUserVoteData.descriptor = {
    name = "UniverseUserVoteData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserVoteData"
}

tbl1.UniverseUserVoteData = UniverseUserVoteData

typeRegistry.default:register(tbl1.UniverseUserVoteData)

return {
    UniverseUserVoteData = tbl1.UniverseUserVoteData
}
