-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local AgeRecommendationDescriptor = {}
AgeRecommendationDescriptor.__index = AgeRecommendationDescriptor

function AgeRecommendationDescriptor.new(tbl3)
    return (setmetatable({
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        display_name = if tbl3 == nil or tbl3.display_name == nil then "" else tbl3.display_name,
        contains = not (tbl3 == nil or tbl3.contains == nil) and tbl3.contains
    }, AgeRecommendationDescriptor))
end

function AgeRecommendationDescriptor:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.contains then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.contains then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AgeRecommendationDescriptor.decode(buf1: buffer)
    local var1 = AgeRecommendationDescriptor.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.contains = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.name = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name = buffer.tostring(buf)
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

function AgeRecommendationDescriptor:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.contains then
        result.contains = self.contains
    end

    return result
end

function AgeRecommendationDescriptor:jsonDecode()
    local var1 = AgeRecommendationDescriptor.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.contains ~= nil then
        var1.contains = self.contains
    end

    return var1
end

AgeRecommendationDescriptor.descriptor = {
    name = "AgeRecommendationDescriptor",
    fullName = "roblox.apppageplatform.shared.v1beta1.AgeRecommendationDescriptor"
}

tbl1.AgeRecommendationDescriptor = AgeRecommendationDescriptor

typeRegistry.default:register(tbl1.AgeRecommendationDescriptor)

local AgeRecommendationData = {}
AgeRecommendationData.__index = AgeRecommendationData

function AgeRecommendationData.new(tbl4)
    return (setmetatable({
        display_name = if tbl4 == nil or tbl4.display_name == nil then "" else tbl4.display_name,
        display_name_with_header_short = if tbl4 == nil or tbl4.display_name_with_header_short == nil then "" else tbl4.display_name_with_header_short,
        igrs_rating = if tbl4 == nil or tbl4.igrs_rating == nil then "" else tbl4.igrs_rating,
        igrs_rating_display_message = if tbl4 == nil or tbl4.igrs_rating_display_message == nil then "" else tbl4.igrs_rating_display_message,
        descriptors = (tbl4 == nil or tbl4.descriptors == nil) and {} or tbl4.descriptors,
        minimum_age_display = if tbl4 == nil or tbl4.minimum_age_display == nil then nil else tbl4.minimum_age_display
    }, AgeRecommendationData))
end

function AgeRecommendationData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.display_name ~= nil and self.display_name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name)
    end

    if self.display_name_with_header_short ~= nil and self.display_name_with_header_short ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.display_name_with_header_short)
    end

    if self.igrs_rating ~= nil and self.igrs_rating ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.igrs_rating)
    end

    if self.igrs_rating_display_message ~= nil and self.igrs_rating_display_message ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.igrs_rating_display_message)
    end

    if self.descriptors ~= nil and #self.descriptors > 0 then
        for _, descriptor in self.descriptors do
            local buf = descriptor:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.minimum_age_display ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 6, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.minimum_age_display)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AgeRecommendationData.decode(buf1: buffer)
    local var1 = AgeRecommendationData.new()
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
                var1.display_name = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.display_name_with_header_short = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.igrs_rating = buffer.tostring(buf)
            elseif var2 == 4 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.igrs_rating_display_message = buffer.tostring(buf)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.descriptors, tbl1.AgeRecommendationDescriptor.decode(var4))
            elseif var2 == 6 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.minimum_age_display = buffer.tostring(buf)
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

function AgeRecommendationData:jsonEncode()
    local result = {}

    if self.display_name ~= nil and self.display_name ~= "" then
        result.displayName = self.display_name
    end

    if self.display_name_with_header_short ~= nil and self.display_name_with_header_short ~= "" then
        result.displayNameWithHeaderShort = self.display_name_with_header_short
    end

    if self.igrs_rating ~= nil and self.igrs_rating ~= "" then
        result.igrsRating = self.igrs_rating
    end

    if self.igrs_rating_display_message ~= nil and self.igrs_rating_display_message ~= "" then
        result.igrsRatingDisplayMessage = self.igrs_rating_display_message
    end

    if self.descriptors ~= nil and #self.descriptors > 0 then
        local descriptors = {}
        for _, descriptor in self.descriptors do
            table.insert(descriptors, descriptor:jsonEncode())
        end
        result.descriptors = descriptors
    end

    if self.minimum_age_display ~= nil then
        result.minimumAgeDisplay = self.minimum_age_display
    end

    return result
end

function AgeRecommendationData:jsonDecode()
    local var1 = AgeRecommendationData.new()

    if self.display_name ~= nil then
        var1.display_name = self.display_name
    end

    if self.displayName ~= nil then
        var1.display_name = self.displayName
    end

    if self.display_name_with_header_short ~= nil then
        var1.display_name_with_header_short = self.display_name_with_header_short
    end

    if self.displayNameWithHeaderShort ~= nil then
        var1.display_name_with_header_short = self.displayNameWithHeaderShort
    end

    if self.igrs_rating ~= nil then
        var1.igrs_rating = self.igrs_rating
    end

    if self.igrsRating ~= nil then
        var1.igrs_rating = self.igrsRating
    end

    if self.igrs_rating_display_message ~= nil then
        var1.igrs_rating_display_message = self.igrs_rating_display_message
    end

    if self.igrsRatingDisplayMessage ~= nil then
        var1.igrs_rating_display_message = self.igrsRatingDisplayMessage
    end

    if self.descriptors ~= nil then
        local descriptors = {}
        for _, descriptor in self.descriptors do
            table.insert(descriptors, tbl1.AgeRecommendationDescriptor.jsonDecode(descriptor))
        end

        var1.descriptors = descriptors
    end

    if self.minimum_age_display ~= nil then
        var1.minimum_age_display = self.minimum_age_display
    end

    if self.minimumAgeDisplay ~= nil then
        var1.minimum_age_display = self.minimumAgeDisplay
    end

    return var1
end

AgeRecommendationData.descriptor = {
    name = "AgeRecommendationData",
    fullName = "roblox.apppageplatform.shared.v1beta1.AgeRecommendationData"
}

tbl1.AgeRecommendationData = AgeRecommendationData

typeRegistry.default:register(tbl1.AgeRecommendationData)

return {
    AgeRecommendationDescriptor = tbl1.AgeRecommendationDescriptor,
    AgeRecommendationData = tbl1.AgeRecommendationData
}
