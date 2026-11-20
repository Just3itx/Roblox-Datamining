-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local BuyRobuxPendingTransferData = {}
BuyRobuxPendingTransferData.__index = BuyRobuxPendingTransferData

function BuyRobuxPendingTransferData.new(tbl3)
    return (setmetatable({
        transfer_request_id = if tbl3 == nil or tbl3.transfer_request_id == nil then "" else tbl3.transfer_request_id,
        net_transfer_robux_amount = if tbl3 == nil or tbl3.net_transfer_robux_amount == nil then 0 else tbl3.net_transfer_robux_amount,
        created_timestamp_ms = if tbl3 == nil or tbl3.created_timestamp_ms == nil then 0 else tbl3.created_timestamp_ms,
        sender = if tbl3 == nil or tbl3.sender == nil then nil else tbl3.sender
    }, BuyRobuxPendingTransferData))
end

function BuyRobuxPendingTransferData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.transfer_request_id ~= nil and self.transfer_request_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.transfer_request_id)
    end

    if self.net_transfer_robux_amount ~= nil and self.net_transfer_robux_amount ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.net_transfer_robux_amount)
    end

    if self.created_timestamp_ms ~= nil and self.created_timestamp_ms ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.created_timestamp_ms)
    end

    if self.sender ~= nil then
        local buf = self.sender:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxPendingTransferData.decode(buf1: buffer)
    local var1 = BuyRobuxPendingTransferData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.net_transfer_robux_amount = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.created_timestamp_ms = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.transfer_request_id = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.sender = tbl1.BuyRobuxTransferSenderData.decode(var4)
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

function BuyRobuxPendingTransferData:jsonEncode()
    local result = {}

    if self.transfer_request_id ~= nil and self.transfer_request_id ~= "" then
        result.transferRequestId = self.transfer_request_id
    end

    if self.net_transfer_robux_amount ~= nil and self.net_transfer_robux_amount ~= 0 then
        result.netTransferRobuxAmount = self.net_transfer_robux_amount
    end

    if self.created_timestamp_ms ~= nil and self.created_timestamp_ms ~= 0 then
        result.createdTimestampMs = self.created_timestamp_ms
    end

    if self.sender ~= nil then
        result.sender = self.sender:jsonEncode()
    end

    return result
end

function BuyRobuxPendingTransferData:jsonDecode()
    local var1 = BuyRobuxPendingTransferData.new()

    if self.transfer_request_id ~= nil then
        var1.transfer_request_id = self.transfer_request_id
    end

    if self.transferRequestId ~= nil then
        var1.transfer_request_id = self.transferRequestId
    end

    if self.net_transfer_robux_amount ~= nil then
        var1.net_transfer_robux_amount = self.net_transfer_robux_amount
    end

    if self.netTransferRobuxAmount ~= nil then
        var1.net_transfer_robux_amount = self.netTransferRobuxAmount
    end

    if self.created_timestamp_ms ~= nil then
        var1.created_timestamp_ms = self.created_timestamp_ms
    end

    if self.createdTimestampMs ~= nil then
        var1.created_timestamp_ms = self.createdTimestampMs
    end

    if self.sender ~= nil then
        var1.sender = tbl1.BuyRobuxTransferSenderData.jsonDecode(self.sender)
    end

    return var1
end

BuyRobuxPendingTransferData.descriptor = {
    name = "BuyRobuxPendingTransferData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxPendingTransferData"
}

tbl1.BuyRobuxPendingTransferData = BuyRobuxPendingTransferData

typeRegistry.default:register(tbl1.BuyRobuxPendingTransferData)

local BuyRobuxTransferSenderData = {}
BuyRobuxTransferSenderData.__index = BuyRobuxTransferSenderData

function BuyRobuxTransferSenderData.new(tbl4)
    return (setmetatable({
        user_id = if tbl4 == nil or tbl4.user_id == nil then "" else tbl4.user_id,
        display_name = if tbl4 == nil or tbl4.display_name == nil then "" else tbl4.display_name,
        thumbnail_url = if tbl4 == nil or tbl4.thumbnail_url == nil then "" else tbl4.thumbnail_url
    }, BuyRobuxTransferSenderData))
end

function BuyRobuxTransferSenderData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.user_id ~= nil and self.user_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.user_id)
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.thumbnail_url ~= nil and self.thumbnail_url ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.thumbnail_url)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxTransferSenderData.decode(buf1: buffer)
    local var1 = BuyRobuxTransferSenderData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.user_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.thumbnail_url = buffer.tostring(buf)
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

function BuyRobuxTransferSenderData:jsonEncode()
    local result = {}

    if self.user_id ~= nil and self.user_id ~= "" then
        result.userId = self.user_id
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.thumbnail_url ~= nil and self.thumbnail_url ~= "" then
        result.thumbnailUrl = self.thumbnail_url
    end

    return result
end

function BuyRobuxTransferSenderData:jsonDecode()
    local var1 = BuyRobuxTransferSenderData.new()

    if self.user_id ~= nil then
        var1.user_id = self.user_id
    end

    if self.userId ~= nil then
        var1.user_id = self.userId
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.thumbnail_url ~= nil then
        var1.thumbnail_url = self.thumbnail_url
    end

    if self.thumbnailUrl ~= nil then
        var1.thumbnail_url = self.thumbnailUrl
    end

    return var1
end

BuyRobuxTransferSenderData.descriptor = {
    name = "BuyRobuxTransferSenderData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxTransferSenderData"
}

tbl1.BuyRobuxTransferSenderData = BuyRobuxTransferSenderData

typeRegistry.default:register(tbl1.BuyRobuxTransferSenderData)

return {
    BuyRobuxPendingTransferData = tbl1.BuyRobuxPendingTransferData,
    BuyRobuxTransferSenderData = tbl1.BuyRobuxTransferSenderData
}
