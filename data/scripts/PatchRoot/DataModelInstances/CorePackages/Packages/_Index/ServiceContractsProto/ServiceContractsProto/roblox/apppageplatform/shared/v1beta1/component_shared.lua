-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local hydration_data_spec = require(script.Parent.hydration_data_spec)
local ui_component_type = require(script.Parent.ui_component_type)
local analytics_data = require(script.Parent.analytics_data)
local prop_types = require(script.Parent.prop_types)

local AccessibilityProps = {}
AccessibilityProps.__index = AccessibilityProps

function AccessibilityProps.new(tbl3)
    return (setmetatable({
        hidden = if tbl3 == nil or tbl3.hidden == nil then nil else tbl3.hidden,
        label = if tbl3 == nil or tbl3.label == nil then nil else tbl3.label
    }, AccessibilityProps))
end

function AccessibilityProps:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.hidden ~= nil then
        local buf = self.hidden:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.label ~= nil then
        local buf = self.label:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function AccessibilityProps.decode(buf1: buffer)
    local var1 = AccessibilityProps.new()
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
                var1.hidden = prop_types.BoolProp.decode(var4)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.label = prop_types.StringProp.decode(var4)
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

function AccessibilityProps:jsonEncode()
    local result = {}

    if self.hidden ~= nil then
        result.hidden = self.hidden:jsonEncode()
    end

    if self.label ~= nil then
        result.label = self.label:jsonEncode()
    end

    return result
end

function AccessibilityProps:jsonDecode()
    local var1 = AccessibilityProps.new()

    if self.hidden ~= nil then
        var1.hidden = prop_types.BoolProp.jsonDecode(self.hidden)
    end

    if self.label ~= nil then
        var1.label = prop_types.StringProp.jsonDecode(self.label)
    end

    return var1
end

AccessibilityProps.descriptor = {
    name = "AccessibilityProps",
    fullName = "roblox.apppageplatform.shared.v1beta1.AccessibilityProps"
}

tbl1.AccessibilityProps = AccessibilityProps

typeRegistry.default:register(tbl1.AccessibilityProps)

local ComponentShared = {}
ComponentShared.__index = ComponentShared

function ComponentShared.new(tbl4)
    local tbl5 = {
        component_type = if tbl4 == nil or tbl4.component_type == nil then assert(ui_component_type.UiComponentType.fromNumber(0), "Enum has no 0 default") else tbl4.component_type,
        data = (tbl4 == nil or tbl4.data == nil) and {} or tbl4.data,
        analytics_data = (tbl4 == nil or tbl4.analytics_data == nil) and {} or tbl4.analytics_data,
        is_component_filtered = if tbl4 == nil or tbl4.is_component_filtered == nil then nil else tbl4.is_component_filtered,
        accessibility = if tbl4 == nil or tbl4.accessibility == nil then nil else tbl4.accessibility
    }
    return (setmetatable(tbl5, ComponentShared))
end

function ComponentShared:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.component_type ~= nil
        and (self.component_type ~= nil and self.component_type ~= 0
            or self.component_type ~= ui_component_type.UiComponentType.fromNumber(0))
    then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, ui_component_type.UiComponentType.toNumber(self.component_type))
    end

    if self.data ~= nil and #self.data > 0 then
        for _, value in self.data do
            local buf = value:encode()
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
        end
    end

    if self.analytics_data ~= nil and next(self.analytics_data) ~= nil then
        for value, value2 in self.analytics_data do
            local buffer3 = buffer.create(0)
            local var1, var2 = proto.writeTag(buffer3, 0, 1, proto.wireTypes.lengthDelimited)
            local var3, var4 = proto.writeString(var1, var2, value)
            local buf = value2:encode()
            local var5, var6 = proto.writeTag(var3, var4, 2, proto.wireTypes.lengthDelimited)
            local var7, var8 = proto.writeBuffer(var5, var6, buf, buffer.len(buf))
            local var9, var10 = proto.writeTag(buffer2, num1, 3, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeBuffer(var9, var10, var7, var8)
        end
    end

    if self.is_component_filtered ~= nil then
        local buf = self.is_component_filtered:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 4, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    if self.accessibility ~= nil then
        local buf = self.accessibility:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 5, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ComponentShared.decode(buf1: buffer)
    local var1 = ComponentShared.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.component_type = ui_component_type.UiComponentType.fromNumber(var4) or var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.data, hydration_data_spec.HydrationDataSpec.decode(var4))
            elseif var2 == 3 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)

                local var5 = tbl1.ComponentShared_AnalyticsDataEntry.decode(var4)

                local analyticsDataField = analytics_data.AnalyticsDataField.new()

                var1.analytics_data[var5.key or ""] = var5.value or analyticsDataField
            elseif var2 == 4 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.is_component_filtered = prop_types.BoolProp.decode(var4)
            elseif var2 == 5 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.accessibility = tbl1.AccessibilityProps.decode(var4)
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

function ComponentShared:jsonEncode()
    local result = {}

    if self.component_type ~= nil
        and (self.component_type ~= nil and self.component_type ~= 0
            or self.component_type ~= ui_component_type.UiComponentType.fromNumber(0))
    then
        result.componentType = if typeof(self.component_type) == "number" then self.component_type else ui_component_type.UiComponentType.toNumber(self.component_type)
    end

    if self.data ~= nil and #self.data > 0 then
        local tbl4 = {}
        for _, value in self.data do
            table.insert(tbl4, value:jsonEncode())
        end
        result.data = tbl4
    end

    if self.analytics_data ~= nil and next(self.analytics_data) ~= nil then
        local analyticsData = ({})
        for value, value2 in self.analytics_data do
            analyticsData[value] = value2:jsonEncode()
        end
        result.analyticsData = analyticsData
    end

    if self.is_component_filtered ~= nil then
        result.isComponentFiltered = self.is_component_filtered:jsonEncode()
    end

    if self.accessibility ~= nil then
        result.accessibility = self.accessibility:jsonEncode()
    end

    return result
end

function ComponentShared:jsonDecode()
    local var1 = ComponentShared.new()

    if self.component_type ~= nil then
        var1.component_type = if typeof(self.component_type) == "number" then ui_component_type.UiComponentType.fromNumber(self.component_type) or self.component_type else ui_component_type.UiComponentType.fromName(self.component_type) or self.component_type
    end

    if self.componentType ~= nil then
        var1.component_type = if typeof(self.componentType) == "number" then ui_component_type.UiComponentType.fromNumber(self.componentType) or self.componentType else ui_component_type.UiComponentType.fromName(self.componentType) or self.componentType
    end

    if self.data ~= nil then
        local tbl4 = {}
        for _, value in self.data do
            table.insert(tbl4, hydration_data_spec.HydrationDataSpec.jsonDecode(value))
        end

        var1.data = tbl4
    end

    if self.analytics_data ~= nil then
        local analyticsData = ({})
        for value, value2 in self.analytics_data do
            analyticsData[value] = analytics_data.AnalyticsDataField.jsonDecode(value2)
        end

        var1.analytics_data = analyticsData
    end

    if self.analyticsData ~= nil then
        local analyticsData = ({})
        for value, value2 in self.analyticsData do
            analyticsData[value] = analytics_data.AnalyticsDataField.jsonDecode(value2)
        end

        var1.analytics_data = analyticsData
    end

    if self.is_component_filtered ~= nil then
        var1.is_component_filtered = prop_types.BoolProp.jsonDecode(self.is_component_filtered)
    end

    if self.isComponentFiltered ~= nil then
        var1.is_component_filtered = prop_types.BoolProp.jsonDecode(self.isComponentFiltered)
    end

    if self.accessibility ~= nil then
        var1.accessibility = tbl1.AccessibilityProps.jsonDecode(self.accessibility)
    end

    return var1
end

ComponentShared.descriptor = {
    name = "ComponentShared",
    fullName = "roblox.apppageplatform.shared.v1beta1.ComponentShared"
}

tbl1.ComponentShared = ComponentShared

typeRegistry.default:register(tbl1.ComponentShared)

local ComponentShared_AnalyticsDataEntry = {}
ComponentShared_AnalyticsDataEntry.__index = ComponentShared_AnalyticsDataEntry

function ComponentShared_AnalyticsDataEntry.new(tbl5)
    return (setmetatable({
        key = if tbl5 == nil or tbl5.key == nil then "" else tbl5.key,
        value = if tbl5 == nil or tbl5.value == nil then nil else tbl5.value
    }, ComponentShared_AnalyticsDataEntry))
end

function ComponentShared_AnalyticsDataEntry:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.key ~= nil and self.key ~= "" then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeString(var1, var2, self.key)
    end

    if self.value ~= nil then
        local buf = self.value:encode()
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
        buffer2, num1 = proto.writeBuffer(var1, var2, buf, buffer.len(buf))
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function ComponentShared_AnalyticsDataEntry.decode(buf1: buffer)
    local var1 = ComponentShared_AnalyticsDataEntry.new()
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
                var1.key = buffer.tostring(buf)
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                var1.value = analytics_data.AnalyticsDataField.decode(var4)
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

function ComponentShared_AnalyticsDataEntry:jsonEncode()
    local result = {}

    if self.key ~= nil and self.key ~= "" then
        result.key = self.key
    end

    if self.value ~= nil then
        result.value = self.value:jsonEncode()
    end

    return result
end

function ComponentShared_AnalyticsDataEntry:jsonDecode()
    local var1 = ComponentShared_AnalyticsDataEntry.new()

    if self.key ~= nil then
        var1.key = self.key
    end

    if self.value ~= nil then
        var1.value = analytics_data.AnalyticsDataField.jsonDecode(self.value)
    end

    return var1
end

ComponentShared_AnalyticsDataEntry.descriptor = {
    name = "ComponentShared_AnalyticsDataEntry",
    fullName = "roblox.apppageplatform.shared.v1beta1.AnalyticsDataEntry"
}

tbl1.ComponentShared_AnalyticsDataEntry = ComponentShared_AnalyticsDataEntry

typeRegistry.default:register(tbl1.ComponentShared_AnalyticsDataEntry)

return {
    AccessibilityProps = tbl1.AccessibilityProps,
    ComponentShared = tbl1.ComponentShared
}
