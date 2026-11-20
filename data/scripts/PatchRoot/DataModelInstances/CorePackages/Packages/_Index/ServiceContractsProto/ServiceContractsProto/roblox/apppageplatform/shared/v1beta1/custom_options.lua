-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local ClientSideHydrationField = {}
ClientSideHydrationField.__index = ClientSideHydrationField

function ClientSideHydrationField.new(tbl3)
    return (setmetatable({
        name = if tbl3 == nil or tbl3.name == nil then "" else tbl3.name,
        description = if tbl3 == nil or tbl3.description == nil then "" else tbl3.description
    }, ClientSideHydrationField))
end

function ClientSideHydrationField:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.name ~= nil and self.name ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.name)
    end

    if self.description ~= nil and self.description ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.description)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ClientSideHydrationField.decode(buf1: buffer)
    local var1 = ClientSideHydrationField.new()
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
                var1.description = buffer.tostring(buf)
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

function ClientSideHydrationField:jsonEncode()
    local result = {}

    if self.name ~= nil and self.name ~= "" then
        result.name = self.name
    end

    if self.description ~= nil and self.description ~= "" then
        result.description = self.description
    end

    return result
end

function ClientSideHydrationField:jsonDecode()
    local var1 = ClientSideHydrationField.new()

    if self.name ~= nil then
        var1.name = self.name
    end

    if self.description ~= nil then
        var1.description = self.description
    end

    return var1
end

ClientSideHydrationField.descriptor = {
    name = "ClientSideHydrationField",
    fullName = "roblox.apppageplatform.shared.v1beta1.ClientSideHydrationField"
}

tbl1.ClientSideHydrationField = ClientSideHydrationField

typeRegistry.default:register(tbl1.ClientSideHydrationField)

return {
    ClientSideHydrationField = tbl1.ClientSideHydrationField
}
