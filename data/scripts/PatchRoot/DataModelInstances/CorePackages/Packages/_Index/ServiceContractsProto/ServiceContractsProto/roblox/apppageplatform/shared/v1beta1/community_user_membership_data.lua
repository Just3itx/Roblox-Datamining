-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local CommunityUserMembershipData = {}
CommunityUserMembershipData.__index = CommunityUserMembershipData

function CommunityUserMembershipData.new(tbl3)
    return (setmetatable({
        can_join = not (tbl3 == nil or tbl3.can_join == nil) and tbl3.can_join,
        is_pending_approval = not (tbl3 == nil or tbl3.is_pending_approval == nil) and tbl3.is_pending_approval
    }, CommunityUserMembershipData))
end

function CommunityUserMembershipData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.can_join then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_join then 1 else 0)
    end

    if self.is_pending_approval then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_pending_approval then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function CommunityUserMembershipData.decode(buf1: buffer)
    local var1 = CommunityUserMembershipData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_join = var4 ~= 0
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_pending_approval = var4 ~= 0
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

function CommunityUserMembershipData:jsonEncode()
    local result = {}

    if self.can_join then
        result.canJoin = self.can_join
    end

    if self.is_pending_approval then
        result.isPendingApproval = self.is_pending_approval
    end

    return result
end

function CommunityUserMembershipData:jsonDecode()
    local var1 = CommunityUserMembershipData.new()

    if self.can_join ~= nil then
        var1.can_join = self.can_join
    end

    if self.canJoin ~= nil then
        var1.can_join = self.canJoin
    end

    if self.is_pending_approval ~= nil then
        var1.is_pending_approval = self.is_pending_approval
    end

    if self.isPendingApproval ~= nil then
        var1.is_pending_approval = self.isPendingApproval
    end

    return var1
end

CommunityUserMembershipData.descriptor = {
    name = "CommunityUserMembershipData",
    fullName = "roblox.apppageplatform.shared.v1beta1.CommunityUserMembershipData"
}

tbl1.CommunityUserMembershipData = CommunityUserMembershipData

typeRegistry.default:register(tbl1.CommunityUserMembershipData)

return {
    CommunityUserMembershipData = tbl1.CommunityUserMembershipData
}
