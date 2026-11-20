-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local BuyRobuxOneTimeProductData = {}
BuyRobuxOneTimeProductData.__index = BuyRobuxOneTimeProductData

function BuyRobuxOneTimeProductData.new(tbl3)
    return (setmetatable({
        product_id = if tbl3 == nil or tbl3.product_id == nil then "" else tbl3.product_id,
        provider_product_id = if tbl3 == nil or tbl3.provider_product_id == nil then "" else tbl3.provider_product_id,
        robux_amount = if tbl3 == nil or tbl3.robux_amount == nil then 0 else tbl3.robux_amount,
        non_promotional_platform_robux_amount = if tbl3 == nil or tbl3.non_promotional_platform_robux_amount == nil then nil else tbl3.non_promotional_platform_robux_amount,
        display_price = if tbl3 == nil or tbl3.display_price == nil then "" else tbl3.display_price,
        display_name = if tbl3 == nil or tbl3.display_name == nil then "" else tbl3.display_name,
        inline_badge = if tbl3 == nil or tbl3.inline_badge == nil then nil else tbl3.inline_badge,
        is_call_to_action = not (tbl3 == nil or tbl3.is_call_to_action == nil) and tbl3.is_call_to_action,
        bonus_robux = if tbl3 == nil or tbl3.bonus_robux == nil then nil else tbl3.bonus_robux
    }, BuyRobuxOneTimeProductData))
end

function BuyRobuxOneTimeProductData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.product_id ~= nil and self.product_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.product_id)
    end

    if self.provider_product_id ~= nil and self.provider_product_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.provider_product_id)
    end

    if self.robux_amount ~= nil and self.robux_amount ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.robux_amount)
    end

    if self.non_promotional_platform_robux_amount ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.non_promotional_platform_robux_amount)
    end

    if self.display_price ~= nil and self.display_price ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_price)
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.inline_badge ~= nil then
        local buf = self.inline_badge:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.is_call_to_action then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_call_to_action then 1 else 0)
    end

    if self.bonus_robux ~= nil then
        local buf = self.bonus_robux:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxOneTimeProductData.decode(buf1: buffer)
    local var1 = BuyRobuxOneTimeProductData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.robux_amount = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.non_promotional_platform_robux_amount = var4
            elseif var2 == 8 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_call_to_action = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.product_id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.provider_product_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_price = buffer.tostring(buf)
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.inline_badge = tbl1.BuyRobuxInlineBadgeData.decode(var4)
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.bonus_robux = tbl1.BuyRobuxBonusRobuxData.decode(var4)
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

function BuyRobuxOneTimeProductData:jsonEncode()
    local result = {}

    if self.product_id ~= nil and self.product_id ~= "" then
        result.productId = self.product_id
    end

    if self.provider_product_id ~= nil and self.provider_product_id ~= "" then
        result.providerProductId = self.provider_product_id
    end

    if self.robux_amount ~= nil and self.robux_amount ~= 0 then
        result.robuxAmount = self.robux_amount
    end

    if self.non_promotional_platform_robux_amount ~= nil then
        result.nonPromotionalPlatformRobuxAmount = self.non_promotional_platform_robux_amount
    end

    if self.display_price ~= nil and self.display_price ~= "" then
        result.displayPrice = self.display_price
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.inline_badge ~= nil then
        result.inlineBadge = self.inline_badge:jsonEncode()
    end

    if self.is_call_to_action then
        result.isCallToAction = self.is_call_to_action
    end

    if self.bonus_robux ~= nil then
        result.bonusRobux = self.bonus_robux:jsonEncode()
    end

    return result
end

function BuyRobuxOneTimeProductData:jsonDecode()
    local var1 = BuyRobuxOneTimeProductData.new()

    if self.product_id ~= nil then
        var1.product_id = self.product_id
    end

    if self.productId ~= nil then
        var1.product_id = self.productId
    end

    if self.provider_product_id ~= nil then
        var1.provider_product_id = self.provider_product_id
    end

    if self.providerProductId ~= nil then
        var1.provider_product_id = self.providerProductId
    end

    if self.robux_amount ~= nil then
        var1.robux_amount = self.robux_amount
    end

    if self.robuxAmount ~= nil then
        var1.robux_amount = self.robuxAmount
    end

    if self.non_promotional_platform_robux_amount ~= nil then
        var1.non_promotional_platform_robux_amount = self.non_promotional_platform_robux_amount
    end

    if self.nonPromotionalPlatformRobuxAmount ~= nil then
        var1.non_promotional_platform_robux_amount = self.nonPromotionalPlatformRobuxAmount
    end

    if self.display_price ~= nil then
        var1.display_price = self.display_price
    end

    if self.displayPrice ~= nil then
        var1.display_price = self.displayPrice
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.inline_badge ~= nil then
        var1.inline_badge = tbl1.BuyRobuxInlineBadgeData.jsonDecode(self.inline_badge)
    end

    if self.inlineBadge ~= nil then
        var1.inline_badge = tbl1.BuyRobuxInlineBadgeData.jsonDecode(self.inlineBadge)
    end

    if self.is_call_to_action ~= nil then
        var1.is_call_to_action = self.is_call_to_action
    end

    if self.isCallToAction ~= nil then
        var1.is_call_to_action = self.isCallToAction
    end

    if self.bonus_robux ~= nil then
        var1.bonus_robux = tbl1.BuyRobuxBonusRobuxData.jsonDecode(self.bonus_robux)
    end

    if self.bonusRobux ~= nil then
        var1.bonus_robux = tbl1.BuyRobuxBonusRobuxData.jsonDecode(self.bonusRobux)
    end

    return var1
end

BuyRobuxOneTimeProductData.descriptor = {
    name = "BuyRobuxOneTimeProductData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxOneTimeProductData"
}

tbl1.BuyRobuxOneTimeProductData = BuyRobuxOneTimeProductData

typeRegistry.default:register(tbl1.BuyRobuxOneTimeProductData)

local BuyRobuxIconData = {}
BuyRobuxIconData.__index = BuyRobuxIconData

function BuyRobuxIconData.new(tbl4)
    return (setmetatable({
        name = if tbl4 == nil or tbl4.name == nil then "" else tbl4.name,
        variant = if tbl4 == nil or tbl4.variant == nil then "" else tbl4.variant
    }, BuyRobuxIconData))
end

function BuyRobuxIconData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.variant ~= nil and self.variant ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.variant)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxIconData.decode(buf1: buffer)
    local var1 = BuyRobuxIconData.new()
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
                var1.name = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.variant = buffer.tostring(buf)
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

function BuyRobuxIconData:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.variant ~= nil and self.variant ~= "" then
        result.variant = self.variant
    end

    return result
end

function BuyRobuxIconData:jsonDecode()
    local var1 = BuyRobuxIconData.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.variant ~= nil then
        var1.variant = self.variant
    end

    return var1
end

BuyRobuxIconData.descriptor = {
    name = "BuyRobuxIconData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxIconData"
}

tbl1.BuyRobuxIconData = BuyRobuxIconData

typeRegistry.default:register(tbl1.BuyRobuxIconData)

local BuyRobuxInlineBadgeData = {}
BuyRobuxInlineBadgeData.__index = BuyRobuxInlineBadgeData

function BuyRobuxInlineBadgeData.new(tbl5)
    return (setmetatable({
        icon = if tbl5 == nil or tbl5.icon == nil then nil else tbl5.icon,
        text = if tbl5 == nil or tbl5.text == nil then "" else tbl5.text
    }, BuyRobuxInlineBadgeData))
end

function BuyRobuxInlineBadgeData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.icon ~= nil then
        local buf = self.icon:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.text ~= nil and self.text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxInlineBadgeData.decode(buf1: buffer)
    local var1 = BuyRobuxInlineBadgeData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.icon = tbl1.BuyRobuxIconData.decode(var4)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
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

function BuyRobuxInlineBadgeData:jsonEncode()
    local result = {}

    if self.icon ~= nil then
        result.icon = self.icon:jsonEncode()
    end

    if self.text ~= nil and self.text ~= "" then
        result.text = self.text
    end

    return result
end

function BuyRobuxInlineBadgeData:jsonDecode()
    local var1 = BuyRobuxInlineBadgeData.new()

    if self.icon ~= nil then
        var1.icon = tbl1.BuyRobuxIconData.jsonDecode(self.icon)
    end

    if self.text ~= nil then
        var1.text = self.text
    end

    return var1
end

BuyRobuxInlineBadgeData.descriptor = {
    name = "BuyRobuxInlineBadgeData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxInlineBadgeData"
}

tbl1.BuyRobuxInlineBadgeData = BuyRobuxInlineBadgeData

typeRegistry.default:register(tbl1.BuyRobuxInlineBadgeData)

local BuyRobuxBonusRobuxData = {}
BuyRobuxBonusRobuxData.__index = BuyRobuxBonusRobuxData

function BuyRobuxBonusRobuxData.new(tbl6)
    return (setmetatable({
        amount = if tbl6 == nil or tbl6.amount == nil then 0 else tbl6.amount,
        icon = if tbl6 == nil or tbl6.icon == nil then nil else tbl6.icon,
        text = if tbl6 == nil or tbl6.text == nil then "" else tbl6.text
    }, BuyRobuxBonusRobuxData))
end

function BuyRobuxBonusRobuxData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.amount ~= nil and self.amount ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.amount)
    end

    if self.icon ~= nil then
        local buf = self.icon:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.text ~= nil and self.text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxBonusRobuxData.decode(buf1: buffer)
    local var1 = BuyRobuxBonusRobuxData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.amount = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.icon = tbl1.BuyRobuxIconData.decode(var4)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
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

function BuyRobuxBonusRobuxData:jsonEncode()
    local result = {}

    if self.amount ~= nil and self.amount ~= 0 then
        result.amount = self.amount
    end

    if self.icon ~= nil then
        result.icon = self.icon:jsonEncode()
    end

    if self.text ~= nil and self.text ~= "" then
        result.text = self.text
    end

    return result
end

function BuyRobuxBonusRobuxData:jsonDecode()
    local var1 = BuyRobuxBonusRobuxData.new()

    if self.amount ~= nil then
        var1.amount = self.amount
    end

    if self.icon ~= nil then
        var1.icon = tbl1.BuyRobuxIconData.jsonDecode(self.icon)
    end

    if self.text ~= nil then
        var1.text = self.text
    end

    return var1
end

BuyRobuxBonusRobuxData.descriptor = {
    name = "BuyRobuxBonusRobuxData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxBonusRobuxData"
}

tbl1.BuyRobuxBonusRobuxData = BuyRobuxBonusRobuxData

typeRegistry.default:register(tbl1.BuyRobuxBonusRobuxData)

local BuyRobuxSubscriptionProductData = {}
BuyRobuxSubscriptionProductData.__index = BuyRobuxSubscriptionProductData

function BuyRobuxSubscriptionProductData.new(tbl7)
    return (setmetatable({
        product_id = if tbl7 == nil or tbl7.product_id == nil then "" else tbl7.product_id,
        is_free_trial = not (tbl7 == nil or tbl7.is_free_trial == nil) and tbl7.is_free_trial,
        display_price = if tbl7 == nil or tbl7.display_price == nil then "" else tbl7.display_price,
        benefits = (tbl7 == nil or tbl7.benefits == nil) and {} or tbl7.benefits,
        robux_amount = if tbl7 == nil or tbl7.robux_amount == nil then 0 else tbl7.robux_amount,
        strikethrough_display_price = if tbl7 == nil or tbl7.strikethrough_display_price == nil then nil else tbl7.strikethrough_display_price,
        is_redirect = not (tbl7 == nil or tbl7.is_redirect == nil) and tbl7.is_redirect,
        button_text = if tbl7 == nil or tbl7.button_text == nil then "" else tbl7.button_text,
        title = if tbl7 == nil or tbl7.title == nil then "" else tbl7.title
    }, BuyRobuxSubscriptionProductData))
end

function BuyRobuxSubscriptionProductData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.product_id ~= nil and self.product_id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.product_id)
    end

    if self.is_free_trial then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_free_trial then 1 else 0)
    end

    if self.display_price ~= nil and self.display_price ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_price)
    end

    if self.benefits ~= nil and #self.benefits > 0 then
        for _, benefit in self.benefits do
            local buf = benefit:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.robux_amount ~= nil and self.robux_amount ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.robux_amount)
    end

    if self.strikethrough_display_price ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 8, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.strikethrough_display_price)
    end

    if self.is_redirect then
        local var1, var2 = proto.writeTag(buffer2, num1, 9, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_redirect then 1 else 0)
    end

    if self.button_text ~= nil and self.button_text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 11, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.button_text)
    end

    if self.title ~= nil and self.title ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 12, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.title)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxSubscriptionProductData.decode(buf1: buffer)
    local var1 = BuyRobuxSubscriptionProductData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 4 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_free_trial = var4 ~= 0
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.robux_amount = var4
            elseif var2 == 9 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_redirect = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.product_id = buffer.tostring(buf)
            elseif var2 == 5 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_price = buffer.tostring(buf)
            elseif var2 == 6 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.benefits, tbl1.BuyRobuxSubscriptionBenefitData.decode(var4))
            elseif var2 == 8 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.strikethrough_display_price = buffer.tostring(buf)
            elseif var2 == 11 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.button_text = buffer.tostring(buf)
            elseif var2 == 12 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.title = buffer.tostring(buf)
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

function BuyRobuxSubscriptionProductData:jsonEncode()
    local result = {}

    if self.product_id ~= nil and self.product_id ~= "" then
        result.productId = self.product_id
    end

    if self.is_free_trial then
        result.isFreeTrial = self.is_free_trial
    end

    if self.display_price ~= nil and self.display_price ~= "" then
        result.displayPrice = self.display_price
    end

    if self.benefits ~= nil and #self.benefits > 0 then
        local benefits = {}
        for _, benefit in self.benefits do
            table.insert(benefits, benefit:jsonEncode())
        end
        result.benefits = benefits
    end

    if self.robux_amount ~= nil and self.robux_amount ~= 0 then
        result.robuxAmount = self.robux_amount
    end

    if self.strikethrough_display_price ~= nil then
        result.strikethroughDisplayPrice = self.strikethrough_display_price
    end

    if self.is_redirect then
        result.isRedirect = self.is_redirect
    end

    if self.button_text ~= nil and self.button_text ~= "" then
        result.buttonText = self.button_text
    end

    if self.title ~= nil and self.title ~= "" then
        result.title = self.title
    end

    return result
end

function BuyRobuxSubscriptionProductData:jsonDecode()
    local var1 = BuyRobuxSubscriptionProductData.new()

    if self.product_id ~= nil then
        var1.product_id = self.product_id
    end

    if self.productId ~= nil then
        var1.product_id = self.productId
    end

    if self.is_free_trial ~= nil then
        var1.is_free_trial = self.is_free_trial
    end

    if self.isFreeTrial ~= nil then
        var1.is_free_trial = self.isFreeTrial
    end

    if self.display_price ~= nil then
        var1.display_price = self.display_price
    end

    if self.displayPrice ~= nil then
        var1.display_price = self.displayPrice
    end

    if self.benefits ~= nil then
        local benefits = {}
        for _, benefit in self.benefits do
            table.insert(benefits, tbl1.BuyRobuxSubscriptionBenefitData.jsonDecode(benefit))
        end

        var1.benefits = benefits
    end

    if self.robux_amount ~= nil then
        var1.robux_amount = self.robux_amount
    end

    if self.robuxAmount ~= nil then
        var1.robux_amount = self.robuxAmount
    end

    if self.strikethrough_display_price ~= nil then
        var1.strikethrough_display_price = self.strikethrough_display_price
    end

    if self.strikethroughDisplayPrice ~= nil then
        var1.strikethrough_display_price = self.strikethroughDisplayPrice
    end

    if self.is_redirect ~= nil then
        var1.is_redirect = self.is_redirect
    end

    if self.isRedirect ~= nil then
        var1.is_redirect = self.isRedirect
    end

    if self.button_text ~= nil then
        var1.button_text = self.button_text
    end

    if self.buttonText ~= nil then
        var1.button_text = self.buttonText
    end

    if self.title ~= nil then
        var1.title = self.title
    end

    return var1
end

BuyRobuxSubscriptionProductData.descriptor = {
    name = "BuyRobuxSubscriptionProductData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxSubscriptionProductData"
}

tbl1.BuyRobuxSubscriptionProductData = BuyRobuxSubscriptionProductData

typeRegistry.default:register(tbl1.BuyRobuxSubscriptionProductData)

local BuyRobuxSubscriptionBenefitData = {}
BuyRobuxSubscriptionBenefitData.__index = BuyRobuxSubscriptionBenefitData

function BuyRobuxSubscriptionBenefitData.new(tbl8)
    return (setmetatable({
        icon = if tbl8 == nil or tbl8.icon == nil then nil else tbl8.icon,
        text = if tbl8 == nil or tbl8.text == nil then "" else tbl8.text
    }, BuyRobuxSubscriptionBenefitData))
end

function BuyRobuxSubscriptionBenefitData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.icon ~= nil then
        local buf = self.icon:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.text ~= nil and self.text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.text)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function BuyRobuxSubscriptionBenefitData.decode(buf1: buffer)
    local var1 = BuyRobuxSubscriptionBenefitData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            local _
            _, num1 = proto.readVarInt(buf1, num1)
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.icon = tbl1.BuyRobuxIconData.decode(var4)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.text = buffer.tostring(buf)
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

function BuyRobuxSubscriptionBenefitData:jsonEncode()
    local result = {}

    if self.icon ~= nil then
        result.icon = self.icon:jsonEncode()
    end

    if self.text ~= nil and self.text ~= "" then
        result.text = self.text
    end

    return result
end

function BuyRobuxSubscriptionBenefitData:jsonDecode()
    local var1 = BuyRobuxSubscriptionBenefitData.new()

    if self.icon ~= nil then
        var1.icon = tbl1.BuyRobuxIconData.jsonDecode(self.icon)
    end

    if self.text ~= nil then
        var1.text = self.text
    end

    return var1
end

BuyRobuxSubscriptionBenefitData.descriptor = {
    name = "BuyRobuxSubscriptionBenefitData",
    fullName = "roblox.apppageplatform.shared.v1beta1.BuyRobuxSubscriptionBenefitData"
}

tbl1.BuyRobuxSubscriptionBenefitData = BuyRobuxSubscriptionBenefitData

typeRegistry.default:register(tbl1.BuyRobuxSubscriptionBenefitData)

return {
    BuyRobuxOneTimeProductData = tbl1.BuyRobuxOneTimeProductData,
    BuyRobuxIconData = tbl1.BuyRobuxIconData,
    BuyRobuxInlineBadgeData = tbl1.BuyRobuxInlineBadgeData,
    BuyRobuxBonusRobuxData = tbl1.BuyRobuxBonusRobuxData,
    BuyRobuxSubscriptionProductData = tbl1.BuyRobuxSubscriptionProductData,
    BuyRobuxSubscriptionBenefitData = tbl1.BuyRobuxSubscriptionBenefitData
}
