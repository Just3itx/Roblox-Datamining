-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiUsageRecorder = require(SduiCoreSystem.Analytics.SduiUsageRecorder)

local function unwrapOneofProp(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 and arg1.oneof_prop and arg1.oneof_prop.value then arg1.oneof_prop.value else arg1
end

local recordV2ActionPropDefinition = nil

local function unwrapInnerActionConfig(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "table" then
        return nil
    end
    local kind = arg1.kind
    if typeof(kind) == "table" and typeof(kind.value) == "table" then
        return kind.value
    end

    return if typeof(arg1.action_type) == "string" then arg1 else nil
end

local function recordV2ActionConfig(str1: string, arg1)
    if typeof(arg1) ~= "table" then
        return
    end
    local actionType = arg1.action_type
    if typeof(actionType) ~= "string" then
        return
    end
    local var1 = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper).mapActionTypeToLua(actionType)
    if not var1 then
        return
    end
    if SduiUsageRecorder.isTypeSamplingEnabled() then
        SduiUsageRecorder.recordActionType(str1, "v2", var1)
    end

    local actionParams = arg1.action_params
    if typeof(actionParams) ~= "table" then
        return
    end
    local var2 = SduiUsageRecorder.isParamSamplingEnabled()
    for k, actionParam in actionParams do
        if typeof(k) == "string" and var2 then
            SduiUsageRecorder.recordActionParam(str1, "v2", var1, k)
        end

        local var3 = unwrapOneofProp(actionParam)
        local descriptor = var3 and var3.descriptor
        if descriptor and descriptor.name == "ActionProp" then
            recordV2ActionPropDefinition(str1, var3)
        end
    end
end

recordV2ActionPropDefinition = function(arg1, arg2)
    local kind = arg2 and arg2.kind
    local value = kind and kind.value
    if not value then
        return
    end

    if kind.type ~= "conditional" then
        local var1 = unwrapInnerActionConfig(value)

        if var1 then
            recordV2ActionConfig(arg1, var1)
        end

        return
    end

    local options = value.options
    if typeof(options) ~= "table" then
        return
    end
    for _, option in options do
        local var1 = unwrapInnerActionConfig(option and option.kind and option.kind.value)

        if var1 then
            recordV2ActionConfig(arg1, var1)
        end
    end
end

local function recordTemplateUsage(str1: string, arg1)
    if not arg1 then
        return
    end
    local var1 = SduiUsageRecorder.isTypeSamplingEnabled()
    local var2 = SduiUsageRecorder.isParamSamplingEnabled()
    if not (var1 or var2) then
        return
    end

    local value = arg1.kind and arg1.kind.value
    if not value then
        return
    end

    local componentType = value.shared and value.shared.component_type
    if not componentType then
        return
    end
    local var3 = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper).mapUiComponentTypeToLua(componentType)
    if not var3 then
        return
    end

    if var1 then
        SduiUsageRecorder.recordComponentType(str1, "v2", var3)
    end

    local props = value.props
    if not props then
        return
    end

    for k, prop in props do
        if typeof(k) ~= "string" then
            continue
        end

        if var2 then
            SduiUsageRecorder.recordProp(str1, "v2", var3, k)
        end

        local var4 = unwrapOneofProp(prop)
        local descriptor = var4 and var4.descriptor
        if descriptor and descriptor.name == "ActionProp" then
            recordV2ActionPropDefinition(str1, var4)
        end
    end
end
return recordTemplateUsage
