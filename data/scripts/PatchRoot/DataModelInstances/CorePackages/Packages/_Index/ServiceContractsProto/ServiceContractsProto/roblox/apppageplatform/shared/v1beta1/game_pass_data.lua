-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local timestamp = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.timestamp)
local _custom_options = require(script.Parent.custom_options)

local PriceDiscountDetail = {}
PriceDiscountDetail.__index = PriceDiscountDetail

function PriceDiscountDetail.new(tbl3)
    return (setmetatable({
        type = if tbl3 == nil or tbl3.type == nil then "" else tbl3.type,
        amount_in_robux = if tbl3 == nil or tbl3.amount_in_robux == nil then 0 else tbl3.amount_in_robux,
        percent = if tbl3 == nil or tbl3.percent == nil then 0 else tbl3.percent
    }, PriceDiscountDetail))
end

function PriceDiscountDetail:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.amount_in_robux ~= nil and self.amount_in_robux ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.amount_in_robux)
    end

    if self.percent ~= nil and self.percent ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.percent)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PriceDiscountDetail.decode(buf1: buffer)
    local var1 = PriceDiscountDetail.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.amount_in_robux = var4
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.percent = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.type = buffer.tostring(buf)
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

function PriceDiscountDetail:jsonEncode()
    local result = {}

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    if self.amount_in_robux ~= nil and self.amount_in_robux ~= 0 then
        result.amountInRobux = self.amount_in_robux
    end

    if self.percent ~= nil and self.percent ~= 0 then
        result.percent = self.percent
    end

    return result
end

function PriceDiscountDetail:jsonDecode()
    local var1 = PriceDiscountDetail.new()

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.amount_in_robux ~= nil then
        var1.amount_in_robux = self.amount_in_robux
    end

    if self.amountInRobux ~= nil then
        var1.amount_in_robux = self.amountInRobux
    end

    if self.percent ~= nil then
        var1.percent = self.percent
    end

    return var1
end

PriceDiscountDetail.descriptor = {
    name = "PriceDiscountDetail",
    fullName = "roblox.apppageplatform.shared.v1beta1.PriceDiscountDetail"
}

tbl1.PriceDiscountDetail = PriceDiscountDetail

typeRegistry.default:register(tbl1.PriceDiscountDetail)

local GamePassData = {}
GamePassData.__index = GamePassData

function GamePassData.new(tbl4)
    return (setmetatable({
        id = if tbl4 == nil or tbl4.id == nil then "" else tbl4.id,
        display_name = if tbl4 == nil or tbl4.display_name == nil then "" else tbl4.display_name,
        price = if tbl4 == nil or tbl4.price == nil then 0 else tbl4.price,
        product_id = if tbl4 == nil or tbl4.product_id == nil then 0 else tbl4.product_id,
        is_owned = not (tbl4 == nil or tbl4.is_owned == nil) and tbl4.is_owned,
        display_icon_image_asset_id = if tbl4 == nil or tbl4.display_icon_image_asset_id == nil then 0 else tbl4.display_icon_image_asset_id,
        display_description = if tbl4 == nil or tbl4.display_description == nil then "" else tbl4.display_description,
        price_discount_details = (tbl4 == nil or tbl4.price_discount_details == nil) and {} or tbl4.price_discount_details,
        user_base_price_in_robux = if tbl4 == nil or tbl4.user_base_price_in_robux == nil then 0 else tbl4.user_base_price_in_robux,
        is_discounted = not (tbl4 == nil or tbl4.is_discounted == nil) and tbl4.is_discounted,
        can_configure = not (tbl4 == nil or tbl4.can_configure == nil) and tbl4.can_configure,
        created_time = if tbl4 == nil or tbl4.created_time == nil then nil else tbl4.created_time,
        updated_time = if tbl4 == nil or tbl4.updated_time == nil then nil else tbl4.updated_time,
        total_up_votes = if tbl4 == nil or tbl4.total_up_votes == nil then nil else tbl4.total_up_votes,
        total_down_votes = if tbl4 == nil or tbl4.total_down_votes == nil then nil else tbl4.total_down_votes,
        user_vote = if tbl4 == nil or tbl4.user_vote == nil then nil else tbl4.user_vote,
        is_purchasable = not (tbl4 == nil or tbl4.is_purchasable == nil) and tbl4.is_purchasable
    }, GamePassData))
end

function GamePassData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.price ~= nil and self.price ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.price)
    end

    if self.product_id ~= nil and self.product_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.product_id)
    end

    if self.is_owned then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_owned then 1 else 0)
    end

    if self.display_icon_image_asset_id ~= nil and self.display_icon_image_asset_id ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.display_icon_image_asset_id)
    end

    if self.display_description ~= nil and self.display_description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_description)
    end

    if self.price_discount_details ~= nil and #self.price_discount_details > 0 then
        for _, priceDiscountDetail in self.price_discount_details do
            local buf = priceDiscountDetail:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.user_base_price_in_robux ~= nil and self.user_base_price_in_robux ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.user_base_price_in_robux)
    end

    if self.is_discounted then
        local var1, var2 = proto.writeTag(buffer2, num1, 10, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_discounted then 1 else 0)
    end

    if self.can_configure then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_configure then 1 else 0)
    end

    if self.created_time ~= nil then
        local buf = self.created_time:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.updated_time ~= nil then
        local buf = self.updated_time:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 13, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.total_up_votes ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 14, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_up_votes)
    end

    if self.total_down_votes ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 15, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.total_down_votes)
    end

    if self.user_vote ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 16, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.user_vote then 1 else 0)
    end

    if self.is_purchasable then
        local var1, var2 = proto.writeTag(buffer2, num1, 17, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_purchasable then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GamePassData.decode(buf1: buffer)
    local var1 = GamePassData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.price = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.product_id = var4
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_owned = var4 ~= 0
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.display_icon_image_asset_id = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.user_base_price_in_robux = var4
            elseif var2 == 10 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_discounted = var4 ~= 0
            elseif var2 == 11 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_configure = var4 ~= 0
            elseif var2 == 14 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_up_votes = var4
            elseif var2 == 15 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.total_down_votes = var4
            elseif var2 == 16 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.user_vote = var4 ~= 0
            elseif var2 == 17 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_purchasable = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 7 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_description = buffer.tostring(buf)
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.price_discount_details, tbl1.PriceDiscountDetail.decode(var4))
            elseif var2 == 12 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.created_time = timestamp.Timestamp.decode(var4)
            elseif var2 == 13 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.updated_time = timestamp.Timestamp.decode(var4)
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

function GamePassData:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.price ~= nil and self.price ~= 0 then
        result.price = self.price
    end

    if self.product_id ~= nil and self.product_id ~= 0 then
        result.productId = self.product_id
    end

    if self.is_owned then
        result.isOwned = self.is_owned
    end

    if self.display_icon_image_asset_id ~= nil and self.display_icon_image_asset_id ~= 0 then
        result.displayIconImageAssetId = self.display_icon_image_asset_id
    end

    if self.display_description ~= nil and self.display_description ~= "" then
        result.displayDescription = self.display_description
    end

    if self.price_discount_details ~= nil and #self.price_discount_details > 0 then
        local priceDiscountDetails = {}
        for _, priceDiscountDetail in self.price_discount_details do
            table.insert(priceDiscountDetails, priceDiscountDetail:jsonEncode())
        end
        result.priceDiscountDetails = priceDiscountDetails
    end

    if self.user_base_price_in_robux ~= nil and self.user_base_price_in_robux ~= 0 then
        result.userBasePriceInRobux = self.user_base_price_in_robux
    end

    if self.is_discounted then
        result.isDiscounted = self.is_discounted
    end

    if self.can_configure then
        result.canConfigure = self.can_configure
    end

    if self.created_time ~= nil then
        result.createdTime = self.created_time:jsonEncode()
    end

    if self.updated_time ~= nil then
        result.updatedTime = self.updated_time:jsonEncode()
    end

    if self.total_up_votes ~= nil then
        result.totalUpVotes = self.total_up_votes
    end

    if self.total_down_votes ~= nil then
        result.totalDownVotes = self.total_down_votes
    end

    if self.user_vote ~= nil then
        result.userVote = self.user_vote
    end

    if self.is_purchasable then
        result.isPurchasable = self.is_purchasable
    end

    return result
end

function GamePassData:jsonDecode()
    local var1 = GamePassData.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.price ~= nil then
        var1.price = self.price
    end

    if self.product_id ~= nil then
        var1.product_id = self.product_id
    end

    if self.productId ~= nil then
        var1.product_id = self.productId
    end

    if self.is_owned ~= nil then
        var1.is_owned = self.is_owned
    end

    if self.isOwned ~= nil then
        var1.is_owned = self.isOwned
    end

    if self.display_icon_image_asset_id ~= nil then
        var1.display_icon_image_asset_id = self.display_icon_image_asset_id
    end

    if self.displayIconImageAssetId ~= nil then
        var1.display_icon_image_asset_id = self.displayIconImageAssetId
    end

    if self.display_description ~= nil then
        var1.display_description = self.display_description
    end

    if self.displayDescription ~= nil then
        var1.display_description = self.displayDescription
    end

    if self.price_discount_details ~= nil then
        local priceDiscountDetails = {}
        for _, priceDiscountDetail in self.price_discount_details do
            table.insert(priceDiscountDetails, tbl1.PriceDiscountDetail.jsonDecode(priceDiscountDetail))
        end

        var1.price_discount_details = priceDiscountDetails
    end

    if self.priceDiscountDetails ~= nil then
        local priceDiscountDetails = {}
        for _, priceDiscountDetail in self.priceDiscountDetails do
            table.insert(priceDiscountDetails, tbl1.PriceDiscountDetail.jsonDecode(priceDiscountDetail))
        end

        var1.price_discount_details = priceDiscountDetails
    end

    if self.user_base_price_in_robux ~= nil then
        var1.user_base_price_in_robux = self.user_base_price_in_robux
    end

    if self.userBasePriceInRobux ~= nil then
        var1.user_base_price_in_robux = self.userBasePriceInRobux
    end

    if self.is_discounted ~= nil then
        var1.is_discounted = self.is_discounted
    end

    if self.isDiscounted ~= nil then
        var1.is_discounted = self.isDiscounted
    end

    if self.can_configure ~= nil then
        var1.can_configure = self.can_configure
    end

    if self.canConfigure ~= nil then
        var1.can_configure = self.canConfigure
    end

    if self.created_time ~= nil then
        var1.created_time = timestamp.Timestamp.jsonDecode(self.created_time)
    end

    if self.createdTime ~= nil then
        var1.created_time = timestamp.Timestamp.jsonDecode(self.createdTime)
    end

    if self.updated_time ~= nil then
        var1.updated_time = timestamp.Timestamp.jsonDecode(self.updated_time)
    end

    if self.updatedTime ~= nil then
        var1.updated_time = timestamp.Timestamp.jsonDecode(self.updatedTime)
    end

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

    if self.is_purchasable ~= nil then
        var1.is_purchasable = self.is_purchasable
    end

    if self.isPurchasable ~= nil then
        var1.is_purchasable = self.isPurchasable
    end

    return var1
end

GamePassData.descriptor = {
    name = "GamePassData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GamePassData"
}

tbl1.GamePassData = GamePassData

typeRegistry.default:register(tbl1.GamePassData)

return {
    PriceDiscountDetail = tbl1.PriceDiscountDetail,
    GamePassData = tbl1.GamePassData
}
