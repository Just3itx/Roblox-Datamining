-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UniversePrivateServerData = {}
UniversePrivateServerData.__index = UniversePrivateServerData

function UniversePrivateServerData.new(tbl3)
    return (setmetatable(
        {
            private_servers_enabled = not (tbl3 == nil or tbl3.private_servers_enabled == nil) and tbl3.private_servers_enabled
        },
        UniversePrivateServerData
    ))
end

function UniversePrivateServerData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.private_servers_enabled then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.private_servers_enabled then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UniversePrivateServerData.decode(buf1: buffer)
    local var1 = UniversePrivateServerData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.private_servers_enabled = var4 ~= 0
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

function UniversePrivateServerData:jsonEncode()
    local result = {}

    if self.private_servers_enabled then
        result.privateServersEnabled = self.private_servers_enabled
    end

    return result
end

function UniversePrivateServerData:jsonDecode()
    local var1 = UniversePrivateServerData.new()

    if self.private_servers_enabled ~= nil then
        var1.private_servers_enabled = self.private_servers_enabled
    end

    if self.privateServersEnabled ~= nil then
        var1.private_servers_enabled = self.privateServersEnabled
    end

    return var1
end

UniversePrivateServerData.descriptor = {
    name = "UniversePrivateServerData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UniversePrivateServerData"
}

tbl1.UniversePrivateServerData = UniversePrivateServerData

typeRegistry.default:register(tbl1.UniversePrivateServerData)

return {
    UniversePrivateServerData = tbl1.UniversePrivateServerData
}
