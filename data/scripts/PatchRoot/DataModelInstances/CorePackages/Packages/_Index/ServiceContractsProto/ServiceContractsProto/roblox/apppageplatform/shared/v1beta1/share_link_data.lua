-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local prop_types = require(script.Parent.prop_types)

local GenericShareLinkData = {}
GenericShareLinkData.__index = GenericShareLinkData

function GenericShareLinkData.new(tbl3)
    return (setmetatable({ kind = if tbl3 == nil or tbl3.kind == nil then nil else tbl3.kind }, GenericShareLinkData))
end

function GenericShareLinkData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "literal" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GenericShareLinkData.decode(buf1: buffer)
    local var1 = GenericShareLinkData.new()
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
                var1.kind = {
                    type = "literal",
                    value = tbl1.GenericShareLinkData_GenericShareLinkLiteralData.decode(var4)
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

function GenericShareLinkData:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "literal" then
        result.literal = self.kind.value:jsonEncode()
    end

    return result
end

function GenericShareLinkData.jsonDecode(tbl3)
    local var1 = GenericShareLinkData.new()

    if tbl3.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.GenericShareLinkData_GenericShareLinkLiteralData.jsonDecode(tbl3.literal)
        }
    end

    return var1
end

GenericShareLinkData.descriptor = {
    name = "GenericShareLinkData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GenericShareLinkData"
}

tbl1.GenericShareLinkData = GenericShareLinkData

typeRegistry.default:register(tbl1.GenericShareLinkData)

local GenericShareLinkData_GenericShareLinkLiteralData = {}
GenericShareLinkData_GenericShareLinkLiteralData.__index = GenericShareLinkData_GenericShareLinkLiteralData

function GenericShareLinkData_GenericShareLinkLiteralData.new(tbl4)
    return (setmetatable({
        url = if tbl4 == nil or tbl4.url == nil then nil else tbl4.url,
        share_url_context = if tbl4 == nil or tbl4.share_url_context == nil then nil else tbl4.share_url_context
    }, GenericShareLinkData_GenericShareLinkLiteralData))
end

function GenericShareLinkData_GenericShareLinkLiteralData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.url ~= nil then
        local buf = self.url:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.share_url_context ~= nil then
        local buf = self.share_url_context:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function GenericShareLinkData_GenericShareLinkLiteralData.decode(buf1: buffer)
    local var1 = GenericShareLinkData_GenericShareLinkLiteralData.new()
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
                var1.url = prop_types.StringProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.share_url_context = prop_types.StringProp.decode(var4)
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

function GenericShareLinkData_GenericShareLinkLiteralData:jsonEncode()
    local result = {}

    if self.url ~= nil then
        result.url = self.url:jsonEncode()
    end

    if self.share_url_context ~= nil then
        result.shareUrlContext = self.share_url_context:jsonEncode()
    end

    return result
end

function GenericShareLinkData_GenericShareLinkLiteralData:jsonDecode()
    local var1 = GenericShareLinkData_GenericShareLinkLiteralData.new()

    if self.url ~= nil then
        var1.url = prop_types.StringProp.jsonDecode(self.url)
    end

    if self.share_url_context ~= nil then
        var1.share_url_context = prop_types.StringProp.jsonDecode(self.share_url_context)
    end

    if self.shareUrlContext ~= nil then
        var1.share_url_context = prop_types.StringProp.jsonDecode(self.shareUrlContext)
    end

    return var1
end

GenericShareLinkData_GenericShareLinkLiteralData.descriptor = {
    name = "GenericShareLinkData_GenericShareLinkLiteralData",
    fullName = "roblox.apppageplatform.shared.v1beta1.GenericShareLinkLiteralData"
}

tbl1.GenericShareLinkData_GenericShareLinkLiteralData = GenericShareLinkData_GenericShareLinkLiteralData

typeRegistry.default:register(tbl1.GenericShareLinkData_GenericShareLinkLiteralData)

local ShareLinkFetchData = {}
ShareLinkFetchData.__index = ShareLinkFetchData

function ShareLinkFetchData.new(tbl5)
    return (setmetatable({ kind = if tbl5 == nil or tbl5.kind == nil then nil else tbl5.kind }, ShareLinkFetchData))
end

function ShareLinkFetchData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "literal" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ShareLinkFetchData.decode(buf1: buffer)
    local var1 = ShareLinkFetchData.new()
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
                var1.kind = {
                    type = "literal",
                    value = tbl1.ShareLinkFetchData_ShareLinkFetchLiteralData.decode(var4)
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

function ShareLinkFetchData:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "literal" then
        result.literal = self.kind.value:jsonEncode()
    end

    return result
end

function ShareLinkFetchData.jsonDecode(tbl5)
    local var1 = ShareLinkFetchData.new()

    if tbl5.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ShareLinkFetchData_ShareLinkFetchLiteralData.jsonDecode(tbl5.literal)
        }
    end

    return var1
end

ShareLinkFetchData.descriptor = {
    name = "ShareLinkFetchData",
    fullName = "roblox.apppageplatform.shared.v1beta1.ShareLinkFetchData"
}

tbl1.ShareLinkFetchData = ShareLinkFetchData

typeRegistry.default:register(tbl1.ShareLinkFetchData)

local ShareLinkFetchData_ShareLinkFetchLiteralData = {}
ShareLinkFetchData_ShareLinkFetchLiteralData.__index = ShareLinkFetchData_ShareLinkFetchLiteralData

function ShareLinkFetchData_ShareLinkFetchLiteralData.new(tbl6)
    return (setmetatable({
        share_url_context = if tbl6 == nil or tbl6.share_url_context == nil then nil else tbl6.share_url_context,
        link_type = if tbl6 == nil or tbl6.link_type == nil then nil else tbl6.link_type,
        link_data = if tbl6 == nil or tbl6.link_data == nil then nil else tbl6.link_data
    }, ShareLinkFetchData_ShareLinkFetchLiteralData))
end

function ShareLinkFetchData_ShareLinkFetchLiteralData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.share_url_context ~= nil then
        local buf = self.share_url_context:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.link_type ~= nil then
        local buf = self.link_type:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.link_data ~= nil then
        local buf = self.link_data:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ShareLinkFetchData_ShareLinkFetchLiteralData.decode(buf1: buffer)
    local var1 = ShareLinkFetchData_ShareLinkFetchLiteralData.new()
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
                var1.share_url_context = prop_types.StringProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.link_type = prop_types.StringProp.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.link_data = tbl1.ShareLinkPayload.decode(var4)
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

function ShareLinkFetchData_ShareLinkFetchLiteralData:jsonEncode()
    local result = {}

    if self.share_url_context ~= nil then
        result.shareUrlContext = self.share_url_context:jsonEncode()
    end

    if self.link_type ~= nil then
        result.linkType = self.link_type:jsonEncode()
    end

    if self.link_data ~= nil then
        result.linkData = self.link_data:jsonEncode()
    end

    return result
end

function ShareLinkFetchData_ShareLinkFetchLiteralData:jsonDecode()
    local var1 = ShareLinkFetchData_ShareLinkFetchLiteralData.new()

    if self.share_url_context ~= nil then
        var1.share_url_context = prop_types.StringProp.jsonDecode(self.share_url_context)
    end

    if self.shareUrlContext ~= nil then
        var1.share_url_context = prop_types.StringProp.jsonDecode(self.shareUrlContext)
    end

    if self.link_type ~= nil then
        var1.link_type = prop_types.StringProp.jsonDecode(self.link_type)
    end

    if self.linkType ~= nil then
        var1.link_type = prop_types.StringProp.jsonDecode(self.linkType)
    end

    if self.link_data ~= nil then
        var1.link_data = tbl1.ShareLinkPayload.jsonDecode(self.link_data)
    end

    if self.linkData ~= nil then
        var1.link_data = tbl1.ShareLinkPayload.jsonDecode(self.linkData)
    end

    return var1
end

ShareLinkFetchData_ShareLinkFetchLiteralData.descriptor = {
    name = "ShareLinkFetchData_ShareLinkFetchLiteralData",
    fullName = "roblox.apppageplatform.shared.v1beta1.ShareLinkFetchLiteralData"
}

tbl1.ShareLinkFetchData_ShareLinkFetchLiteralData = ShareLinkFetchData_ShareLinkFetchLiteralData

typeRegistry.default:register(tbl1.ShareLinkFetchData_ShareLinkFetchLiteralData)

local ShareLinkPayload = {}
ShareLinkPayload.__index = ShareLinkPayload

function ShareLinkPayload.new(tbl7)
    return (setmetatable({ oneof_prop = if tbl7 == nil or tbl7.oneof_prop == nil then nil else tbl7.oneof_prop }, ShareLinkPayload))
end

function ShareLinkPayload:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "experience_share_link_payload" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.oneof_prop.type == "event_share_link_payload" then
            local buf = self.oneof_prop.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ShareLinkPayload.decode(buf1: buffer)
    local var1 = ShareLinkPayload.new()
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
                var1.oneof_prop = {
                    type = "experience_share_link_payload",
                    value = tbl1.ExperienceShareLinkPayload.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.oneof_prop = {
                    type = "event_share_link_payload",
                    value = tbl1.EventShareLinkPayload.decode(var4)
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

function ShareLinkPayload:jsonEncode()
    local result = {}

    if self.oneof_prop ~= nil then
        if self.oneof_prop.type == "experience_share_link_payload" then
            result.experienceShareLinkPayload = self.oneof_prop.value:jsonEncode()
            return result
        end

        if self.oneof_prop.type == "event_share_link_payload" then
            result.eventShareLinkPayload = self.oneof_prop.value:jsonEncode()
        end
    end

    return result
end

function ShareLinkPayload.jsonDecode(tbl7)
    local var1 = ShareLinkPayload.new()

    if tbl7.experience_share_link_payload ~= nil then
        var1.oneof_prop = {
            type = "experience_share_link_payload",
            value = tbl1.ExperienceShareLinkPayload.jsonDecode(tbl7.experience_share_link_payload)
        }
    end

    if tbl7.experienceShareLinkPayload ~= nil then
        var1.oneof_prop = {
            type = "experience_share_link_payload",
            value = tbl1.ExperienceShareLinkPayload.jsonDecode(tbl7.experienceShareLinkPayload)
        }
    end

    if tbl7.event_share_link_payload ~= nil then
        var1.oneof_prop = {
            type = "event_share_link_payload",
            value = tbl1.EventShareLinkPayload.jsonDecode(tbl7.event_share_link_payload)
        }
    end

    if tbl7.eventShareLinkPayload ~= nil then
        var1.oneof_prop = {
            type = "event_share_link_payload",
            value = tbl1.EventShareLinkPayload.jsonDecode(tbl7.eventShareLinkPayload)
        }
    end

    return var1
end

ShareLinkPayload.descriptor = {
    name = "ShareLinkPayload",
    fullName = "roblox.apppageplatform.shared.v1beta1.ShareLinkPayload"
}

tbl1.ShareLinkPayload = ShareLinkPayload

typeRegistry.default:register(tbl1.ShareLinkPayload)

local ExperienceShareLinkPayload = {}
ExperienceShareLinkPayload.__index = ExperienceShareLinkPayload

function ExperienceShareLinkPayload.new(tbl8)
    return (setmetatable({ kind = if tbl8 == nil or tbl8.kind == nil then nil else tbl8.kind }, ExperienceShareLinkPayload))
end

function ExperienceShareLinkPayload:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "literal" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ExperienceShareLinkPayload.decode(buf1: buffer)
    local var1 = ExperienceShareLinkPayload.new()
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
                var1.kind = {
                    type = "literal",
                    value = tbl1.ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.decode(var4)
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

function ExperienceShareLinkPayload:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "literal" then
        result.literal = self.kind.value:jsonEncode()
    end

    return result
end

function ExperienceShareLinkPayload.jsonDecode(tbl8)
    local var1 = ExperienceShareLinkPayload.new()

    if tbl8.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.jsonDecode(tbl8.literal)
        }
    end

    return var1
end

ExperienceShareLinkPayload.descriptor = {
    name = "ExperienceShareLinkPayload",
    fullName = "roblox.apppageplatform.shared.v1beta1.ExperienceShareLinkPayload"
}

tbl1.ExperienceShareLinkPayload = ExperienceShareLinkPayload

typeRegistry.default:register(tbl1.ExperienceShareLinkPayload)

local ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload = {}
ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.__index = ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload

function ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.new(tbl9)
    return (setmetatable(
        {
            universe_id = if tbl9 == nil or tbl9.universe_id == nil then nil else tbl9.universe_id
        },
        ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload
    ))
end

function ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.universe_id ~= nil then
        local buf = self.universe_id:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.decode(buf1: buffer)
    local var1 = ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.new()
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
                var1.universe_id = prop_types.StringProp.decode(var4)
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

function ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload:jsonEncode()
    local result = {}

    if self.universe_id ~= nil then
        result.universeId = self.universe_id:jsonEncode()
    end

    return result
end

function ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload:jsonDecode()
    local var1 = ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.new()

    if self.universe_id ~= nil then
        var1.universe_id = prop_types.StringProp.jsonDecode(self.universe_id)
    end

    if self.universeId ~= nil then
        var1.universe_id = prop_types.StringProp.jsonDecode(self.universeId)
    end

    return var1
end

ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload.descriptor = {
    name = "ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload",
    fullName = "roblox.apppageplatform.shared.v1beta1.ExperienceShareLinkLiteralPayload"
}

tbl1.ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload = ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload

typeRegistry.default:register(tbl1.ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload)

local EventShareLinkPayload = {}
EventShareLinkPayload.__index = EventShareLinkPayload

function EventShareLinkPayload.new(tbl10)
    return (setmetatable({ kind = if tbl10 == nil or tbl10.kind == nil then nil else tbl10.kind }, EventShareLinkPayload))
end

function EventShareLinkPayload:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil and self.kind.type == "literal" then
        local buf = self.kind.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function EventShareLinkPayload.decode(buf1: buffer)
    local var1 = EventShareLinkPayload.new()
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
                var1.kind = {
                    type = "literal",
                    value = tbl1.EventShareLinkPayload_EventShareLinkLiteralPayload.decode(var4)
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

function EventShareLinkPayload:jsonEncode()
    local result = {}

    if self.kind ~= nil and self.kind.type == "literal" then
        result.literal = self.kind.value:jsonEncode()
    end

    return result
end

function EventShareLinkPayload.jsonDecode(tbl10)
    local var1 = EventShareLinkPayload.new()

    if tbl10.literal ~= nil then
        var1.kind = {
            type = "literal",
            value = tbl1.EventShareLinkPayload_EventShareLinkLiteralPayload.jsonDecode(tbl10.literal)
        }
    end

    return var1
end

EventShareLinkPayload.descriptor = {
    name = "EventShareLinkPayload",
    fullName = "roblox.apppageplatform.shared.v1beta1.EventShareLinkPayload"
}

tbl1.EventShareLinkPayload = EventShareLinkPayload

typeRegistry.default:register(tbl1.EventShareLinkPayload)

local EventShareLinkPayload_EventShareLinkLiteralPayload = {}
EventShareLinkPayload_EventShareLinkLiteralPayload.__index = EventShareLinkPayload_EventShareLinkLiteralPayload

function EventShareLinkPayload_EventShareLinkLiteralPayload.new(tbl11)
    return (setmetatable(
        {
            event_id = if tbl11 == nil or tbl11.event_id == nil then nil else tbl11.event_id
        },
        EventShareLinkPayload_EventShareLinkLiteralPayload
    ))
end

function EventShareLinkPayload_EventShareLinkLiteralPayload:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.event_id ~= nil then
        local buf = self.event_id:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function EventShareLinkPayload_EventShareLinkLiteralPayload.decode(buf1: buffer)
    local var1 = EventShareLinkPayload_EventShareLinkLiteralPayload.new()
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
                var1.event_id = prop_types.StringProp.decode(var4)
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

function EventShareLinkPayload_EventShareLinkLiteralPayload:jsonEncode()
    local result = {}

    if self.event_id ~= nil then
        result.eventId = self.event_id:jsonEncode()
    end

    return result
end

function EventShareLinkPayload_EventShareLinkLiteralPayload:jsonDecode()
    local var1 = EventShareLinkPayload_EventShareLinkLiteralPayload.new()

    if self.event_id ~= nil then
        var1.event_id = prop_types.StringProp.jsonDecode(self.event_id)
    end

    if self.eventId ~= nil then
        var1.event_id = prop_types.StringProp.jsonDecode(self.eventId)
    end

    return var1
end

EventShareLinkPayload_EventShareLinkLiteralPayload.descriptor = {
    name = "EventShareLinkPayload_EventShareLinkLiteralPayload",
    fullName = "roblox.apppageplatform.shared.v1beta1.EventShareLinkLiteralPayload"
}

tbl1.EventShareLinkPayload_EventShareLinkLiteralPayload = EventShareLinkPayload_EventShareLinkLiteralPayload

typeRegistry.default:register(tbl1.EventShareLinkPayload_EventShareLinkLiteralPayload)

return {
    GenericShareLinkData = tbl1.GenericShareLinkData,
    GenericShareLinkData_GenericShareLinkLiteralData = tbl1.GenericShareLinkData_GenericShareLinkLiteralData,
    ShareLinkFetchData = tbl1.ShareLinkFetchData,
    ShareLinkFetchData_ShareLinkFetchLiteralData = tbl1.ShareLinkFetchData_ShareLinkFetchLiteralData,
    ShareLinkPayload = tbl1.ShareLinkPayload,
    ExperienceShareLinkPayload = tbl1.ExperienceShareLinkPayload,
    ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload = tbl1.ExperienceShareLinkPayload_ExperienceShareLinkLiteralPayload,
    EventShareLinkPayload = tbl1.EventShareLinkPayload,
    EventShareLinkPayload_EventShareLinkLiteralPayload = tbl1.EventShareLinkPayload_EventShareLinkLiteralPayload
}
