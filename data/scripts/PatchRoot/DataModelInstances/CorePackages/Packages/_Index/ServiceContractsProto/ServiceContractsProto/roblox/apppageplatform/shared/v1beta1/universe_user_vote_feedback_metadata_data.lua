-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local _custom_options = require(script.Parent.custom_options)

local UniverseUserVoteFeedbackMetadataData = {}
UniverseUserVoteFeedbackMetadataData.__index = UniverseUserVoteFeedbackMetadataData

function UniverseUserVoteFeedbackMetadataData.new(tbl3)
    return (setmetatable({
        capabilities = if tbl3 == nil or tbl3.capabilities == nil then nil else tbl3.capabilities,
        categories = (tbl3 == nil or tbl3.categories == nil) and {} or tbl3.categories,
        comment = if tbl3 == nil or tbl3.comment == nil then nil else tbl3.comment,
        metadata = if tbl3 == nil or tbl3.metadata == nil then nil else tbl3.metadata
    }, UniverseUserVoteFeedbackMetadataData))
end

function UniverseUserVoteFeedbackMetadataData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.capabilities ~= nil then
        local buf = self.capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.categories ~= nil and #self.categories > 0 then
        for _, value in self.categories do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.comment ~= nil then
        local buf = self.comment:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.metadata ~= nil then
        local buf = self.metadata:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData.new()
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
                var1.capabilities = tbl1.UniverseUserVoteFeedbackMetadataData_Capabilities.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.categories, tbl1.UniverseUserVoteFeedbackMetadataData_Category.decode(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.comment = tbl1.UniverseUserVoteFeedbackMetadataData_Comment.decode(var4)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.metadata = tbl1.UniverseUserVoteFeedbackMetadataData_Metadata.decode(var4)
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

function UniverseUserVoteFeedbackMetadataData:jsonEncode()
    local result = {}

    if self.capabilities ~= nil then
        result.capabilities = self.capabilities:jsonEncode()
    end

    if self.categories ~= nil and #self.categories > 0 then
        local categories = {}
        for _, value in self.categories do
            table.insert(categories, value:jsonEncode())
        end
        result.categories = categories
    end

    if self.comment ~= nil then
        result.comment = self.comment:jsonEncode()
    end

    if self.metadata ~= nil then
        result.metadata = self.metadata:jsonEncode()
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData.new()

    if self.capabilities ~= nil then
        var1.capabilities = tbl1.UniverseUserVoteFeedbackMetadataData_Capabilities.jsonDecode(self.capabilities)
    end

    if self.categories ~= nil then
        local categories = {}
        for _, value in self.categories do
            table.insert(categories, tbl1.UniverseUserVoteFeedbackMetadataData_Category.jsonDecode(value))
        end

        var1.categories = categories
    end

    if self.comment ~= nil then
        var1.comment = tbl1.UniverseUserVoteFeedbackMetadataData_Comment.jsonDecode(self.comment)
    end

    if self.metadata ~= nil then
        var1.metadata = tbl1.UniverseUserVoteFeedbackMetadataData_Metadata.jsonDecode(self.metadata)
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniverseUserVoteFeedbackMetadataData"
}

tbl1.UniverseUserVoteFeedbackMetadataData = UniverseUserVoteFeedbackMetadataData

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData)

local UniverseUserVoteFeedbackMetadataData_Capabilities = {}
UniverseUserVoteFeedbackMetadataData_Capabilities.__index = UniverseUserVoteFeedbackMetadataData_Capabilities

function UniverseUserVoteFeedbackMetadataData_Capabilities.new(tbl4)
    return (setmetatable({
        can_submit_review = not (tbl4 == nil or tbl4.can_submit_review == nil) and tbl4.can_submit_review,
        can_submit_comment = not (tbl4 == nil or tbl4.can_submit_comment == nil) and tbl4.can_submit_comment,
        can_submit_category_options = if tbl4 == nil or tbl4.can_submit_category_options == nil then nil else tbl4.can_submit_category_options
    }, UniverseUserVoteFeedbackMetadataData_Capabilities))
end

function UniverseUserVoteFeedbackMetadataData_Capabilities:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.can_submit_review then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_submit_review then 1 else 0)
    end

    if self.can_submit_comment then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_submit_comment then 1 else 0)
    end

    if self.can_submit_category_options ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.can_submit_category_options then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData_Capabilities.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData_Capabilities.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_submit_review = var4 ~= 0
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_submit_comment = var4 ~= 0
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.can_submit_category_options = var4 ~= 0
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

function UniverseUserVoteFeedbackMetadataData_Capabilities:jsonEncode()
    local result = {}

    if self.can_submit_review then
        result.canSubmitReview = self.can_submit_review
    end

    if self.can_submit_comment then
        result.canSubmitComment = self.can_submit_comment
    end

    if self.can_submit_category_options ~= nil then
        result.canSubmitCategoryOptions = self.can_submit_category_options
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData_Capabilities:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData_Capabilities.new()

    if self.can_submit_review ~= nil then
        var1.can_submit_review = self.can_submit_review
    end

    if self.canSubmitReview ~= nil then
        var1.can_submit_review = self.canSubmitReview
    end

    if self.can_submit_comment ~= nil then
        var1.can_submit_comment = self.can_submit_comment
    end

    if self.canSubmitComment ~= nil then
        var1.can_submit_comment = self.canSubmitComment
    end

    if self.can_submit_category_options ~= nil then
        var1.can_submit_category_options = self.can_submit_category_options
    end

    if self.canSubmitCategoryOptions ~= nil then
        var1.can_submit_category_options = self.canSubmitCategoryOptions
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData_Capabilities.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData_Capabilities",
    fullName = "roblox.apppageplatform.shared.v1beta1.Capabilities"
}

tbl1.UniverseUserVoteFeedbackMetadataData_Capabilities = UniverseUserVoteFeedbackMetadataData_Capabilities

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData_Capabilities)

local UniverseUserVoteFeedbackMetadataData_Category = {}
UniverseUserVoteFeedbackMetadataData_Category.__index = UniverseUserVoteFeedbackMetadataData_Category

function UniverseUserVoteFeedbackMetadataData_Category.new(tbl5)
    return (setmetatable({
        type = if tbl5 == nil or tbl5.type == nil then "" else tbl5.type,
        label = if tbl5 == nil or tbl5.label == nil then "" else tbl5.label,
        allows_multiple_selections = not (tbl5 == nil or tbl5.allows_multiple_selections == nil) and tbl5.allows_multiple_selections,
        options = (tbl5 == nil or tbl5.options == nil) and {} or tbl5.options
    }, UniverseUserVoteFeedbackMetadataData_Category))
end

function UniverseUserVoteFeedbackMetadataData_Category:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.type ~= nil and self.type ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.type)
    end

    if self.label ~= nil and self.label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.label)
    end

    if self.allows_multiple_selections then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.allows_multiple_selections then 1 else 0)
    end

    if self.options ~= nil and #self.options > 0 then
        for _, option in self.options do
            local buf = option:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData_Category.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData_Category.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.allows_multiple_selections = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.type = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.label = buffer.tostring(buf)
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.options, tbl1.UniverseUserVoteFeedbackMetadataData_Category_Option.decode(var4))
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

function UniverseUserVoteFeedbackMetadataData_Category:jsonEncode()
    local result = {}

    if self.type ~= nil and self.type ~= "" then
        result.type = self.type
    end

    if self.label ~= nil and self.label ~= "" then
        result.label = self.label
    end

    if self.allows_multiple_selections then
        result.allowsMultipleSelections = self.allows_multiple_selections
    end

    if self.options ~= nil and #self.options > 0 then
        local options = {}
        for _, option in self.options do
            table.insert(options, option:jsonEncode())
        end
        result.options = options
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData_Category:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData_Category.new()

    if self.type ~= nil then
        var1.type = self.type
    end

    if self.label ~= nil then
        var1.label = self.label
    end

    if self.allows_multiple_selections ~= nil then
        var1.allows_multiple_selections = self.allows_multiple_selections
    end

    if self.allowsMultipleSelections ~= nil then
        var1.allows_multiple_selections = self.allowsMultipleSelections
    end

    if self.options ~= nil then
        local options = {}
        for _, option in self.options do
            table.insert(options, tbl1.UniverseUserVoteFeedbackMetadataData_Category_Option.jsonDecode(option))
        end

        var1.options = options
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData_Category.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData_Category",
    fullName = "roblox.apppageplatform.shared.v1beta1.Category"
}

tbl1.UniverseUserVoteFeedbackMetadataData_Category = UniverseUserVoteFeedbackMetadataData_Category

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData_Category)

local UniverseUserVoteFeedbackMetadataData_Category_Option = {}
UniverseUserVoteFeedbackMetadataData_Category_Option.__index = UniverseUserVoteFeedbackMetadataData_Category_Option

function UniverseUserVoteFeedbackMetadataData_Category_Option.new(tbl6)
    return (setmetatable({
        id = if tbl6 == nil or tbl6.id == nil then "" else tbl6.id,
        label = if tbl6 == nil or tbl6.label == nil then "" else tbl6.label
    }, UniverseUserVoteFeedbackMetadataData_Category_Option))
end

function UniverseUserVoteFeedbackMetadataData_Category_Option:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.id ~= nil and self.id ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.id)
    end

    if self.label ~= nil and self.label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.label)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData_Category_Option.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData_Category_Option.new()
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
                var1.id = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.label = buffer.tostring(buf)
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

function UniverseUserVoteFeedbackMetadataData_Category_Option:jsonEncode()
    local result = {}

    if self.id ~= nil and self.id ~= "" then
        result.id = self.id
    end

    if self.label ~= nil and self.label ~= "" then
        result.label = self.label
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData_Category_Option:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData_Category_Option.new()

    if self.id ~= nil then
        var1.id = self.id
    end

    if self.label ~= nil then
        var1.label = self.label
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData_Category_Option.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData_Category_Option",
    fullName = "roblox.apppageplatform.shared.v1beta1.Option"
}

tbl1.UniverseUserVoteFeedbackMetadataData_Category_Option = UniverseUserVoteFeedbackMetadataData_Category_Option

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData_Category_Option)

local UniverseUserVoteFeedbackMetadataData_Comment = {}
UniverseUserVoteFeedbackMetadataData_Comment.__index = UniverseUserVoteFeedbackMetadataData_Comment

function UniverseUserVoteFeedbackMetadataData_Comment.new(tbl7)
    return (setmetatable({
        label = if tbl7 == nil or tbl7.label == nil then "" else tbl7.label,
        placeholder_text = if tbl7 == nil or tbl7.placeholder_text == nil then "" else tbl7.placeholder_text,
        minimum_length = if tbl7 == nil or tbl7.minimum_length == nil then 0 else tbl7.minimum_length,
        maximum_length = if tbl7 == nil or tbl7.maximum_length == nil then 0 else tbl7.maximum_length
    }, UniverseUserVoteFeedbackMetadataData_Comment))
end

function UniverseUserVoteFeedbackMetadataData_Comment:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.label ~= nil and self.label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.label)
    end

    if self.placeholder_text ~= nil and self.placeholder_text ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.placeholder_text)
    end

    if self.minimum_length ~= nil and self.minimum_length ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.minimum_length)
    end

    if self.maximum_length ~= nil and self.maximum_length ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.maximum_length)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData_Comment.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData_Comment.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.minimum_length = var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.maximum_length = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.label = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.placeholder_text = buffer.tostring(buf)
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

function UniverseUserVoteFeedbackMetadataData_Comment:jsonEncode()
    local result = {}

    if self.label ~= nil and self.label ~= "" then
        result.label = self.label
    end

    if self.placeholder_text ~= nil and self.placeholder_text ~= "" then
        result.placeholderText = self.placeholder_text
    end

    if self.minimum_length ~= nil and self.minimum_length ~= 0 then
        result.minimumLength = self.minimum_length
    end

    if self.maximum_length ~= nil and self.maximum_length ~= 0 then
        result.maximumLength = self.maximum_length
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData_Comment:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData_Comment.new()

    if self.label ~= nil then
        var1.label = self.label
    end

    if self.placeholder_text ~= nil then
        var1.placeholder_text = self.placeholder_text
    end

    if self.placeholderText ~= nil then
        var1.placeholder_text = self.placeholderText
    end

    if self.minimum_length ~= nil then
        var1.minimum_length = self.minimum_length
    end

    if self.minimumLength ~= nil then
        var1.minimum_length = self.minimumLength
    end

    if self.maximum_length ~= nil then
        var1.maximum_length = self.maximum_length
    end

    if self.maximumLength ~= nil then
        var1.maximum_length = self.maximumLength
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData_Comment.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData_Comment",
    fullName = "roblox.apppageplatform.shared.v1beta1.Comment"
}

tbl1.UniverseUserVoteFeedbackMetadataData_Comment = UniverseUserVoteFeedbackMetadataData_Comment

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData_Comment)

local UniverseUserVoteFeedbackMetadataData_Metadata = {}
UniverseUserVoteFeedbackMetadataData_Metadata.__index = UniverseUserVoteFeedbackMetadataData_Metadata

function UniverseUserVoteFeedbackMetadataData_Metadata.new(tbl8)
    return (setmetatable({
        disclaimer_label = if tbl8 == nil or tbl8.disclaimer_label == nil then "" else tbl8.disclaimer_label,
        submit_button_label = if tbl8 == nil or tbl8.submit_button_label == nil then "" else tbl8.submit_button_label,
        form_title_label = if tbl8 == nil or tbl8.form_title_label == nil then "" else tbl8.form_title_label
    }, UniverseUserVoteFeedbackMetadataData_Metadata))
end

function UniverseUserVoteFeedbackMetadataData_Metadata:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.disclaimer_label ~= nil and self.disclaimer_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.disclaimer_label)
    end

    if self.submit_button_label ~= nil and self.submit_button_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.submit_button_label)
    end

    if self.form_title_label ~= nil and self.form_title_label ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.form_title_label)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniverseUserVoteFeedbackMetadataData_Metadata.decode(buf1: buffer)
    local var1 = UniverseUserVoteFeedbackMetadataData_Metadata.new()
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
                var1.disclaimer_label = buffer.tostring(buf)
            elseif var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.submit_button_label = buffer.tostring(buf)
            elseif var2 == 3 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.form_title_label = buffer.tostring(buf)
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

function UniverseUserVoteFeedbackMetadataData_Metadata:jsonEncode()
    local result = {}

    if self.disclaimer_label ~= nil and self.disclaimer_label ~= "" then
        result.disclaimerLabel = self.disclaimer_label
    end

    if self.submit_button_label ~= nil and self.submit_button_label ~= "" then
        result.submitButtonLabel = self.submit_button_label
    end

    if self.form_title_label ~= nil and self.form_title_label ~= "" then
        result.formTitleLabel = self.form_title_label
    end

    return result
end

function UniverseUserVoteFeedbackMetadataData_Metadata:jsonDecode()
    local var1 = UniverseUserVoteFeedbackMetadataData_Metadata.new()

    if self.disclaimer_label ~= nil then
        var1.disclaimer_label = self.disclaimer_label
    end

    if self.disclaimerLabel ~= nil then
        var1.disclaimer_label = self.disclaimerLabel
    end

    if self.submit_button_label ~= nil then
        var1.submit_button_label = self.submit_button_label
    end

    if self.submitButtonLabel ~= nil then
        var1.submit_button_label = self.submitButtonLabel
    end

    if self.form_title_label ~= nil then
        var1.form_title_label = self.form_title_label
    end

    if self.formTitleLabel ~= nil then
        var1.form_title_label = self.formTitleLabel
    end

    return var1
end

UniverseUserVoteFeedbackMetadataData_Metadata.descriptor = {
    name = "UniverseUserVoteFeedbackMetadataData_Metadata",
    fullName = "roblox.apppageplatform.shared.v1beta1.Metadata"
}

tbl1.UniverseUserVoteFeedbackMetadataData_Metadata = UniverseUserVoteFeedbackMetadataData_Metadata

typeRegistry.default:register(tbl1.UniverseUserVoteFeedbackMetadataData_Metadata)

return {
    UniverseUserVoteFeedbackMetadataData = tbl1.UniverseUserVoteFeedbackMetadataData,
    UniverseUserVoteFeedbackMetadataData_Capabilities = tbl1.UniverseUserVoteFeedbackMetadataData_Capabilities,
    UniverseUserVoteFeedbackMetadataData_Category = tbl1.UniverseUserVoteFeedbackMetadataData_Category,
    UniverseUserVoteFeedbackMetadataData_Category_Option = tbl1.UniverseUserVoteFeedbackMetadataData_Category_Option,
    UniverseUserVoteFeedbackMetadataData_Comment = tbl1.UniverseUserVoteFeedbackMetadataData_Comment,
    UniverseUserVoteFeedbackMetadataData_Metadata = tbl1.UniverseUserVoteFeedbackMetadataData_Metadata
}
