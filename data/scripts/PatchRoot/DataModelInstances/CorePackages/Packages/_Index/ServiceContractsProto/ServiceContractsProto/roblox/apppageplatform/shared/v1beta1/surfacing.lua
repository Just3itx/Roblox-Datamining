-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local Surfacing = {}
Surfacing.__index = Surfacing

function Surfacing.new(tbl3)
    return (setmetatable({ kind = if tbl3 == nil or tbl3.kind == nil then nil else tbl3.kind }, Surfacing))
end

function Surfacing:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.kind ~= nil then
        if self.kind.type == "peek_view" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        elseif self.kind.type == "full_page" then
            local buf = self.kind.value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Surfacing.decode(buf1: buffer)
    local var1 = Surfacing.new()
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
                    type = "peek_view",
                    value = tbl1.PeekView.decode(var4)
                }
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.kind = {
                    type = "full_page",
                    value = tbl1.FullPage.decode(var4)
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

function Surfacing:jsonEncode()
    local result = {}

    if self.kind ~= nil then
        if self.kind.type == "peek_view" then
            result.peekView = self.kind.value:jsonEncode()
            return result
        end

        if self.kind.type == "full_page" then
            result.fullPage = self.kind.value:jsonEncode()
        end
    end

    return result
end

function Surfacing.jsonDecode(tbl3)
    local var1 = Surfacing.new()

    if tbl3.peek_view ~= nil then
        var1.kind = {
            type = "peek_view",
            value = tbl1.PeekView.jsonDecode(tbl3.peek_view)
        }
    end
    if tbl3.peekView ~= nil then
        var1.kind = {
            type = "peek_view",
            value = tbl1.PeekView.jsonDecode(tbl3.peekView)
        }
    end
    if tbl3.full_page ~= nil then
        var1.kind = {
            type = "full_page",
            value = tbl1.FullPage.jsonDecode(tbl3.full_page)
        }
    end
    if tbl3.fullPage ~= nil then
        var1.kind = {
            type = "full_page",
            value = tbl1.FullPage.jsonDecode(tbl3.fullPage)
        }
    end
    return var1
end

Surfacing.descriptor = {
    name = "Surfacing",
    fullName = "roblox.apppageplatform.shared.v1beta1.Surfacing"
}

tbl1.Surfacing = Surfacing

typeRegistry.default:register(tbl1.Surfacing)

local PeekView = {}
PeekView.__index = PeekView

function PeekView.new(tbl4)
    return (setmetatable({ height_offset = if tbl4 == nil or tbl4.height_offset == nil then nil else tbl4.height_offset }, PeekView))
end

function PeekView:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.height_offset ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.height_offset)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function PeekView.decode(buf1: buffer)
    local var1 = PeekView.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.height_offset = var4
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

function PeekView:jsonEncode()
    local result = {}

    if self.height_offset ~= nil then
        result.heightOffset = self.height_offset
    end

    return result
end

function PeekView:jsonDecode()
    local var1 = PeekView.new()

    if self.height_offset ~= nil then
        var1.height_offset = self.height_offset
    end

    if self.heightOffset ~= nil then
        var1.height_offset = self.heightOffset
    end

    return var1
end

PeekView.descriptor = {
    name = "PeekView",
    fullName = "roblox.apppageplatform.shared.v1beta1.PeekView"
}

tbl1.PeekView = PeekView

typeRegistry.default:register(tbl1.PeekView)

local FullPage = {}
FullPage.__index = FullPage

function FullPage.new(tbl5)
    return (setmetatable(
        {
            content_top_padding = if tbl5 == nil or tbl5.content_top_padding == nil then nil else tbl5.content_top_padding
        },
        FullPage
    ))
end

function FullPage:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.content_top_padding ~= nil then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.content_top_padding)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function FullPage.decode(buf1: buffer)
    local var1 = FullPage.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.content_top_padding = var4
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

function FullPage:jsonEncode()
    local result = {}

    if self.content_top_padding ~= nil then
        result.contentTopPadding = self.content_top_padding
    end

    return result
end

function FullPage:jsonDecode()
    local var1 = FullPage.new()

    if self.content_top_padding ~= nil then
        var1.content_top_padding = self.content_top_padding
    end

    if self.contentTopPadding ~= nil then
        var1.content_top_padding = self.contentTopPadding
    end

    return var1
end

FullPage.descriptor = {
    name = "FullPage",
    fullName = "roblox.apppageplatform.shared.v1beta1.FullPage"
}

tbl1.FullPage = FullPage

typeRegistry.default:register(tbl1.FullPage)

return {
    Surfacing = tbl1.Surfacing,
    PeekView = tbl1.PeekView,
    FullPage = tbl1.FullPage
}
