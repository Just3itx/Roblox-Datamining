-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local actions = require(script.Parent.actions)
local capability = require(script.Parent.capability)
local ui_component_type = require(script.Parent.ui_component_type)

local ClientCapabilities = {}
ClientCapabilities.__index = ClientCapabilities

function ClientCapabilities.new(tbl3)
    local tbl4 = {
        enabled_capabilities = (tbl3 == nil or tbl3.enabled_capabilities == nil) and {} or tbl3.enabled_capabilities,
        proto_version = if tbl3 == nil or tbl3.proto_version == nil then "" else tbl3.proto_version,
        platform = if tbl3 == nil or tbl3.platform == nil then assert(tbl1.Platform.fromNumber(0), "Enum has no 0 default") else tbl3.platform,
        registered_ui_component_types = (tbl3 == nil or tbl3.registered_ui_component_types == nil) and {} or tbl3.registered_ui_component_types,
        registered_action_types = (tbl3 == nil or tbl3.registered_action_types == nil) and {} or tbl3.registered_action_types,
        runtime_flag_values = (tbl3 == nil or tbl3.runtime_flag_values == nil) and {} or tbl3.runtime_flag_values
    }
    return (setmetatable(tbl4, ClientCapabilities))
end

function ClientCapabilities:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.enabled_capabilities ~= nil and #self.enabled_capabilities > 0 then
        for _, value in self.enabled_capabilities do
            local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, capability.Capability.toNumber(value))
        end
    end

    if self.proto_version ~= nil and self.proto_version ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.proto_version)
    end

    if self.platform ~= nil and (self.platform ~= nil and self.platform ~= 0 or self.platform ~= tbl1.Platform.fromNumber(0)) then
        local var1, var2 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, tbl1.Platform.toNumber(self.platform))
    end

    if self.registered_ui_component_types ~= nil and #self.registered_ui_component_types > 0 then
        for _, value in self.registered_ui_component_types do
            local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, ui_component_type.UiComponentType.toNumber(value))
        end
    end

    if self.registered_action_types ~= nil and #self.registered_action_types > 0 then
        for _, value in self.registered_action_types do
            local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.varint)
            buffer2, num1 = proto.writeVarInt(var1, var2, actions.ActionType.toNumber(value))
        end
    end

    if self.runtime_flag_values ~= nil and next(self.runtime_flag_values) ~= nil then
        for value, value2 in self.runtime_flag_values do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.varint)
            local var7, var8 = proto.writeVarInt(var5, var6, if value2 then 1 else 0)
            local var9, var10 = proto.writeTag(buffer2, num1, 7, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ClientCapabilities.decode(buf1: buffer)
    local var1 = ClientCapabilities.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                table.insert(var1.enabled_capabilities, capability.Capability.fromNumber(var4) or var4)
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.platform = tbl1.Platform.fromNumber(var4) or var4
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                table.insert(var1.registered_ui_component_types, ui_component_type.UiComponentType.fromNumber(var4) or var4)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                table.insert(var1.registered_action_types, actions.ActionType.fromNumber(var4) or var4)
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.proto_version = buffer.tostring(buf)
            elseif var2 == 7 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.ClientCapabilities_RuntimeFlagValuesEntry.decode(var4)

                var1.runtime_flag_values[var5.key or ""] = var5.value or false
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

function ClientCapabilities:jsonEncode()
    local result = {}

    if self.enabled_capabilities ~= nil and #self.enabled_capabilities > 0 then
        local enabledCapabilities = {}
        for _, value in self.enabled_capabilities do
            if typeof(value) ~= "number" then
                value = capability.Capability.toNumber(value)
            end

            table.insert(enabledCapabilities, value)
        end

        result.enabledCapabilities = enabledCapabilities
    end

    if self.proto_version ~= nil and self.proto_version ~= "" then
        result.protoVersion = self.proto_version
    end

    if self.platform ~= nil and (self.platform ~= nil and self.platform ~= 0 or self.platform ~= tbl1.Platform.fromNumber(0)) then
        result.platform = if typeof(self.platform) == "number" then self.platform else tbl1.Platform.toNumber(self.platform)
    end

    if self.registered_ui_component_types ~= nil and #self.registered_ui_component_types > 0 then
        local registeredUiComponentTypes = {}
        for _, value in self.registered_ui_component_types do
            if typeof(value) ~= "number" then
                value = ui_component_type.UiComponentType.toNumber(value)
            end

            table.insert(registeredUiComponentTypes, value)
        end

        result.registeredUiComponentTypes = registeredUiComponentTypes
    end

    if self.registered_action_types ~= nil and #self.registered_action_types > 0 then
        local registeredActionTypes = {}
        for _, value in self.registered_action_types do
            if typeof(value) ~= "number" then
                value = actions.ActionType.toNumber(value)
            end

            table.insert(registeredActionTypes, value)
        end

        result.registeredActionTypes = registeredActionTypes
    end

    if self.runtime_flag_values ~= nil and next(self.runtime_flag_values) ~= nil then
        local runtimeFlagValues = ({})
        for value, value2 in self.runtime_flag_values do
            runtimeFlagValues[value] = value2
        end
        result.runtimeFlagValues = runtimeFlagValues
    end

    return result
end

function ClientCapabilities:jsonDecode()
    local var1 = ClientCapabilities.new()

    if self.enabled_capabilities ~= nil then
        local enabledCapabilities = {}
        for _, value in self.enabled_capabilities do
            table.insert(
                enabledCapabilities,
                if typeof(value) == "number" then capability.Capability.fromNumber(value) or value else capability.Capability.fromName(value) or value
            )
        end

        var1.enabled_capabilities = enabledCapabilities
    end

    if self.enabledCapabilities ~= nil then
        local enabledCapabilities = {}
        for _, value in self.enabledCapabilities do
            table.insert(
                enabledCapabilities,
                if typeof(value) == "number" then capability.Capability.fromNumber(value) or value else capability.Capability.fromName(value) or value
            )
        end

        var1.enabled_capabilities = enabledCapabilities
    end

    if self.proto_version ~= nil then
        var1.proto_version = self.proto_version
    end

    if self.protoVersion ~= nil then
        var1.proto_version = self.protoVersion
    end

    if self.platform ~= nil then
        var1.platform = if typeof(self.platform) == "number" then tbl1.Platform.fromNumber(self.platform) or self.platform else tbl1.Platform.fromName(self.platform) or self.platform
    end

    if self.registered_ui_component_types ~= nil then
        local registeredUiComponentTypes = {}
        for _, value in self.registered_ui_component_types do
            table.insert(
                registeredUiComponentTypes,
                if typeof(value) == "number" then ui_component_type.UiComponentType.fromNumber(value) or value else ui_component_type.UiComponentType.fromName(value) or value
            )
        end

        var1.registered_ui_component_types = registeredUiComponentTypes
    end

    if self.registeredUiComponentTypes ~= nil then
        local registeredUiComponentTypes = {}
        for _, value in self.registeredUiComponentTypes do
            table.insert(
                registeredUiComponentTypes,
                if typeof(value) == "number" then ui_component_type.UiComponentType.fromNumber(value) or value else ui_component_type.UiComponentType.fromName(value) or value
            )
        end

        var1.registered_ui_component_types = registeredUiComponentTypes
    end

    if self.registered_action_types ~= nil then
        local registeredActionTypes = {}
        for _, value in self.registered_action_types do
            table.insert(
                registeredActionTypes,
                if typeof(value) == "number" then actions.ActionType.fromNumber(value) or value else actions.ActionType.fromName(value) or value
            )
        end

        var1.registered_action_types = registeredActionTypes
    end

    if self.registeredActionTypes ~= nil then
        local registeredActionTypes = {}
        for _, value in self.registeredActionTypes do
            table.insert(
                registeredActionTypes,
                if typeof(value) == "number" then actions.ActionType.fromNumber(value) or value else actions.ActionType.fromName(value) or value
            )
        end

        var1.registered_action_types = registeredActionTypes
    end

    if self.runtime_flag_values ~= nil then
        local runtimeFlagValues = ({})
        for value, value2 in self.runtime_flag_values do
            runtimeFlagValues[value] = value2
        end

        var1.runtime_flag_values = runtimeFlagValues
    end

    if self.runtimeFlagValues ~= nil then
        local runtimeFlagValues = ({})
        for value, value2 in self.runtimeFlagValues do
            runtimeFlagValues[value] = value2
        end

        var1.runtime_flag_values = runtimeFlagValues
    end

    return var1
end

ClientCapabilities.descriptor = {
    name = "ClientCapabilities",
    fullName = "roblox.apppageplatform.shared.v1beta1.ClientCapabilities"
}

tbl1.ClientCapabilities = ClientCapabilities

typeRegistry.default:register(tbl1.ClientCapabilities)

local ClientCapabilities_RuntimeFlagValuesEntry = {}
ClientCapabilities_RuntimeFlagValuesEntry.__index = ClientCapabilities_RuntimeFlagValuesEntry

function ClientCapabilities_RuntimeFlagValuesEntry.new(tbl4)
    return (setmetatable({
        key = if tbl4 == nil or tbl4.key == nil then "" else tbl4.key,
        value = not (tbl4 == nil or tbl4.value == nil) and tbl4.value
    }, ClientCapabilities_RuntimeFlagValuesEntry))
end

function ClientCapabilities_RuntimeFlagValuesEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.value then 1 else 0)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ClientCapabilities_RuntimeFlagValuesEntry.decode(buf1: buffer)
    local var1 = ClientCapabilities_RuntimeFlagValuesEntry.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.value = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 1 then
                local buf
                buf, num1 = proto.readBuffer(buf1, num1)
                var1.key = buffer.tostring(buf)
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

function ClientCapabilities_RuntimeFlagValuesEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value then
        result.value = self.value
    end

    return result
end

function ClientCapabilities_RuntimeFlagValuesEntry:jsonDecode()
    local var1 = ClientCapabilities_RuntimeFlagValuesEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = self.value
    end

    return var1
end

ClientCapabilities_RuntimeFlagValuesEntry.descriptor = {
    name = "ClientCapabilities_RuntimeFlagValuesEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.RuntimeFlagValuesEntry"
}

tbl1.ClientCapabilities_RuntimeFlagValuesEntry = ClientCapabilities_RuntimeFlagValuesEntry

typeRegistry.default:register(tbl1.ClientCapabilities_RuntimeFlagValuesEntry)

tbl1.Platform = {
    fromNumber = function(num1: number): string?
        return if num1 == 0 then "PLATFORM_INVALID" elseif num1 == 1 then "PLATFORM_WEB" elseif num1 == 2 then "PLATFORM_APP" else nil
    end,
    toNumber = function(arg1)
        return if arg1 == "PLATFORM_INVALID" then 0 elseif arg1 == "PLATFORM_WEB" then 1 elseif arg1 == "PLATFORM_APP" then 2 else arg1
    end,
    fromName = function(str1: string): string?
        return if str1 == "PLATFORM_INVALID" then "PLATFORM_INVALID" elseif str1 == "PLATFORM_WEB" then "PLATFORM_WEB" elseif str1 == "PLATFORM_APP" then "PLATFORM_APP" else nil
    end
}

return {
    ClientCapabilities = tbl1.ClientCapabilities,
    Platform = tbl1.Platform
}
