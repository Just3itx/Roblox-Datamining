-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local struct = require(script.Parent.Parent.Parent.Parent.Parent.google.protobuf.struct)

local ConfigDrivenFormInputData = {}
ConfigDrivenFormInputData.__index = ConfigDrivenFormInputData

function ConfigDrivenFormInputData.new(tbl3)
    return (setmetatable({
        saved = if tbl3 == nil or tbl3.saved == nil then nil else tbl3.saved,
        catalogs = if tbl3 == nil or tbl3.catalogs == nil then nil else tbl3.catalogs,
        capabilities = if tbl3 == nil or tbl3.capabilities == nil then nil else tbl3.capabilities
    }, ConfigDrivenFormInputData))
end

function ConfigDrivenFormInputData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.saved ~= nil then
        local buf = self.saved:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.catalogs ~= nil then
        local buf = self.catalogs:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.capabilities ~= nil then
        local buf = self.capabilities:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ConfigDrivenFormInputData.decode(buf1: buffer)
    local var1 = ConfigDrivenFormInputData.new()
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
                var1.saved = struct.Struct.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.catalogs = struct.Struct.decode(var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.capabilities = struct.Struct.decode(var4)
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

function ConfigDrivenFormInputData:jsonEncode()
    local result = {}

    if self.saved ~= nil then
        result.saved = self.saved:jsonEncode()
    end

    if self.catalogs ~= nil then
        result.catalogs = self.catalogs:jsonEncode()
    end

    if self.capabilities ~= nil then
        result.capabilities = self.capabilities:jsonEncode()
    end

    return result
end

function ConfigDrivenFormInputData:jsonDecode()
    local var1 = ConfigDrivenFormInputData.new()

    if self.saved ~= nil then
        var1.saved = struct.Struct.jsonDecode(self.saved)
    end

    if self.catalogs ~= nil then
        var1.catalogs = struct.Struct.jsonDecode(self.catalogs)
    end

    if self.capabilities ~= nil then
        var1.capabilities = struct.Struct.jsonDecode(self.capabilities)
    end

    return var1
end

ConfigDrivenFormInputData.descriptor = {
    name = "ConfigDrivenFormInputData",
    fullName = "roblox.apppageplatform.shared.v1beta1.ConfigDrivenFormInputData"
}

tbl1.ConfigDrivenFormInputData = ConfigDrivenFormInputData

typeRegistry.default:register(tbl1.ConfigDrivenFormInputData)

return {
    ConfigDrivenFormInputData = tbl1.ConfigDrivenFormInputData
}
