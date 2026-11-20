-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local BuyRobuxBonusItemData = {}
BuyRobuxBonusItemData.__index = BuyRobuxBonusItemData

function BuyRobuxBonusItemData.new(tbl3)
    return (setmetatable({
        bonus_id = if tbl3 == nil or tbl3.bonus_id == nil then "" else tbl3.bonus_id,
        product_identifier = if tbl3 == nil or tbl3.product_identifier == nil then "" else tbl3.product_identifier,
        details = if tbl3 == nil or tbl3.details == nil then nil else tbl3.details
    }, BuyRobuxBonusItemData))
end

function BuyRobuxBonusItemData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.bonus_id ~= nil and self.bonus_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.bonus_id)
    end

    if self.product_identifier ~= nil and self.product_identifier ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.product_identifier)
    end

    if self.details ~= nil then
        if self.details.type == "game_pass" then
            local buf = self.details.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.details.type == "collectible_item" then
            local buf = self.details.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxBonusItemData.decode(buf1: buffer)
    local var1 = BuyRobuxBonusItemData.new()
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
                var1.bonus_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.product_identifier = buffer.tostring(buf)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.details = {
                    type = "game_pass",
                    value = tbl1.BuyRobuxGamePassBonusData.decode(var4)
                }
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.details = {
                    type = "collectible_item",
                    value = tbl1.BuyRobuxCollectibleItemBonusData.decode(var4)
                }
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

function BuyRobuxBonusItemData:jsonEncode()
    local result = {}

    if self.bonus_id ~= nil and self.bonus_id ~= "" then
        result.bonusId = self.bonus_id
    end

    if self.product_identifier ~= nil and self.product_identifier ~= "" then
        result.productIdentifier = self.product_identifier
    end

    if self.details ~= nil then
        if self.details.type == "game_pass" then
            result.gamePass = self.details.value:jsonEncode()
            return result
        end

        if self.details.type == "collectible_item" then
            result.collectibleItem = self.details.value:jsonEncode()
        end
    end

    return result
end

function BuyRobuxBonusItemData:jsonDecode()
    local var1 = BuyRobuxBonusItemData.new()

    if self.bonus_id ~= nil then
        var1.bonus_id = self.bonus_id
    end

    if self.bonusId ~= nil then
        var1.bonus_id = self.bonusId
    end

    if self.product_identifier ~= nil then
        var1.product_identifier = self.product_identifier
    end

    if self.productIdentifier ~= nil then
        var1.product_identifier = self.productIdentifier
    end

    if self.game_pass ~= nil then
        var1.details = {
            type = "game_pass",
            value = tbl1.BuyRobuxGamePassBonusData.jsonDecode(self.game_pass)
        }
    end
    if self.gamePass ~= nil then
        var1.details = {
            type = "game_pass",
            value = tbl1.BuyRobuxGamePassBonusData.jsonDecode(self.gamePass)
        }
    end
    if self.collectible_item ~= nil then
        var1.details = {
            type = "collectible_item",
            value = tbl1.BuyRobuxCollectibleItemBonusData.jsonDecode(self.collectible_item)
        }
    end

    if self.collectibleItem ~= nil then
        var1.details = {
            type = "collectible_item",
            value = tbl1.BuyRobuxCollectibleItemBonusData.jsonDecode(self.collectibleItem)
        }
    end

    return var1
end

BuyRobuxBonusItemData.descriptor = {
    name = "BuyRobuxBonusItemData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxBonusItemData"
}

tbl1.BuyRobuxBonusItemData = BuyRobuxBonusItemData

typeRegistry.default:register(tbl1.BuyRobuxBonusItemData)

local BuyRobuxGamePassBonusData = {}
BuyRobuxGamePassBonusData.__index = BuyRobuxGamePassBonusData

function BuyRobuxGamePassBonusData.new(tbl4)
    return (setmetatable({
        root_place_id = if tbl4 == nil or tbl4.root_place_id == nil then "" else tbl4.root_place_id,
        game_pass_display_name = if tbl4 == nil or tbl4.game_pass_display_name == nil then "" else tbl4.game_pass_display_name,
        experience_display_name = if tbl4 == nil or tbl4.experience_display_name == nil then "" else tbl4.experience_display_name
    }, BuyRobuxGamePassBonusData))
end

function BuyRobuxGamePassBonusData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.root_place_id ~= nil and self.root_place_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.root_place_id)
    end

    if self.game_pass_display_name ~= nil and self.game_pass_display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.game_pass_display_name)
    end

    if self.experience_display_name ~= nil and self.experience_display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.experience_display_name)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxGamePassBonusData.decode(buf1: buffer)
    local var1 = BuyRobuxGamePassBonusData.new()
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
                var1.root_place_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.game_pass_display_name = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.experience_display_name = buffer.tostring(buf)
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

function BuyRobuxGamePassBonusData:jsonEncode()
    local result = {}

    if self.root_place_id ~= nil and self.root_place_id ~= "" then
        result.rootPlaceId = self.root_place_id
    end

    if self.game_pass_display_name ~= nil and self.game_pass_display_name ~= "" then
        result.gamePassDisplayName = self.game_pass_display_name
    end

    if self.experience_display_name ~= nil and self.experience_display_name ~= "" then
        result.experienceDisplayName = self.experience_display_name
    end

    return result
end

function BuyRobuxGamePassBonusData:jsonDecode()
    local var1 = BuyRobuxGamePassBonusData.new()

    if self.root_place_id ~= nil then
        var1.root_place_id = self.root_place_id
    end

    if self.rootPlaceId ~= nil then
        var1.root_place_id = self.rootPlaceId
    end

    if self.game_pass_display_name ~= nil then
        var1.game_pass_display_name = self.game_pass_display_name
    end

    if self.gamePassDisplayName ~= nil then
        var1.game_pass_display_name = self.gamePassDisplayName
    end

    if self.experience_display_name ~= nil then
        var1.experience_display_name = self.experience_display_name
    end

    if self.experienceDisplayName ~= nil then
        var1.experience_display_name = self.experienceDisplayName
    end

    return var1
end

BuyRobuxGamePassBonusData.descriptor = {
    name = "BuyRobuxGamePassBonusData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxGamePassBonusData"
}

tbl1.BuyRobuxGamePassBonusData = BuyRobuxGamePassBonusData

typeRegistry.default:register(tbl1.BuyRobuxGamePassBonusData)

local BuyRobuxCollectibleItemBonusData = {}
BuyRobuxCollectibleItemBonusData.__index = BuyRobuxCollectibleItemBonusData

function BuyRobuxCollectibleItemBonusData.new(tbl5)
    return (setmetatable({
        display_name = if tbl5 == nil or tbl5.display_name == nil then "" else tbl5.display_name,
        image_2d_url = if tbl5 == nil or tbl5.image_2d_url == nil then "" else tbl5.image_2d_url,
        background_image_2d_url = if tbl5 == nil or tbl5.background_image_2d_url == nil then nil else tbl5.background_image_2d_url,
        creator_display_name = if tbl5 == nil or tbl5.creator_display_name == nil then nil else tbl5.creator_display_name,
        creator_is_verified = not (tbl5 == nil or tbl5.creator_is_verified == nil) and tbl5.creator_is_verified
    }, BuyRobuxCollectibleItemBonusData))
end

function BuyRobuxCollectibleItemBonusData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.image_2d_url ~= nil and self.image_2d_url ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.image_2d_url)
    end

    if self.background_image_2d_url ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.background_image_2d_url)
    end

    if self.creator_display_name ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.creator_display_name)
    end

    if self.creator_is_verified then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.creator_is_verified then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxCollectibleItemBonusData.decode(buf1: buffer)
    local var1 = BuyRobuxCollectibleItemBonusData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 5 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.creator_is_verified = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.image_2d_url = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.background_image_2d_url = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.creator_display_name = buffer.tostring(buf)
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

function BuyRobuxCollectibleItemBonusData:jsonEncode()
    local result = {}

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.image_2d_url ~= nil and self.image_2d_url ~= "" then
        result.image2dUrl = self.image_2d_url
    end

    if self.background_image_2d_url ~= nil then
        result.backgroundImage2dUrl = self.background_image_2d_url
    end

    if self.creator_display_name ~= nil then
        result.creatorDisplayName = self.creator_display_name
    end

    if self.creator_is_verified then
        result.creatorIsVerified = self.creator_is_verified
    end

    return result
end

function BuyRobuxCollectibleItemBonusData:jsonDecode()
    local var1 = BuyRobuxCollectibleItemBonusData.new()

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.image_2d_url ~= nil then
        var1.image_2d_url = self.image_2d_url
    end

    if self.image2dUrl ~= nil then
        var1.image_2d_url = self.image2dUrl
    end

    if self.background_image_2d_url ~= nil then
        var1.background_image_2d_url = self.background_image_2d_url
    end

    if self.backgroundImage2dUrl ~= nil then
        var1.background_image_2d_url = self.backgroundImage2dUrl
    end

    if self.creator_display_name ~= nil then
        var1.creator_display_name = self.creator_display_name
    end

    if self.creatorDisplayName ~= nil then
        var1.creator_display_name = self.creatorDisplayName
    end

    if self.creator_is_verified ~= nil then
        var1.creator_is_verified = self.creator_is_verified
    end

    if self.creatorIsVerified ~= nil then
        var1.creator_is_verified = self.creatorIsVerified
    end

    return var1
end

BuyRobuxCollectibleItemBonusData.descriptor = {
    name = "BuyRobuxCollectibleItemBonusData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxCollectibleItemBonusData"
}

tbl1.BuyRobuxCollectibleItemBonusData = BuyRobuxCollectibleItemBonusData

typeRegistry.default:register(tbl1.BuyRobuxCollectibleItemBonusData)

return {
    BuyRobuxBonusItemData = tbl1.BuyRobuxBonusItemData,
    BuyRobuxGamePassBonusData = tbl1.BuyRobuxGamePassBonusData,
    BuyRobuxCollectibleItemBonusData = tbl1.BuyRobuxCollectibleItemBonusData
}
