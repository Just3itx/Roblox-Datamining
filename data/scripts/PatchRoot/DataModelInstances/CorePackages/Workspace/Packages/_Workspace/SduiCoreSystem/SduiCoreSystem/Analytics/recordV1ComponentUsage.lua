-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiUsageRecorder = require(SduiCoreSystem.Analytics.SduiUsageRecorder)

local function recordV1ComponentUsage(str1: string, arg1)
    if not arg1 then
        return
    end
    local var1 = SduiUsageRecorder.isTypeSamplingEnabled()
    local var2 = SduiUsageRecorder.isParamSamplingEnabled()
    if not (var1 or var2) then
        return
    end

    local componentType = arg1.componentType
    if typeof(componentType) ~= "string" then
        return
    end

    if var1 then
        SduiUsageRecorder.recordComponentType(str1, "v1", componentType)
    end

    local recordActionConfig = nil

    local function visitValueForActions(arg2)
        if typeof(arg2) ~= "table" then
            return
        end

        if typeof(arg2.actionType) == "string" then
            recordActionConfig(arg2)
            return
        end

        for _, value in arg2 do
            if typeof(value) == "table" then
                visitValueForActions(value)
            end
        end
    end

    recordActionConfig = function(arg2)
        local actionType = arg2.actionType
        if typeof(actionType) ~= "string" then
            return
        end
        if var1 then
            SduiUsageRecorder.recordActionType(str1, "v1", actionType)
        end
        local actionParams = arg2.actionParams
        if typeof(actionParams) ~= "table" then
            return
        end
        for k, actionParam in actionParams do
            if typeof(k) == "string" and var2 then
                SduiUsageRecorder.recordActionParam(str1, "v1", actionType, k)
            end
            visitValueForActions(actionParam)
        end
    end

    local function walkProps(arg2)
        if typeof(arg2) ~= "table" then
            return
        end
        for value, value2 in arg2 do
            if typeof(value) == "string" and var2 then
                SduiUsageRecorder.recordProp(str1, "v1", componentType, value)
            end
            visitValueForActions(value2)
        end
    end

    walkProps(arg1.props)

    if typeof(arg1.conditionalProps) == "table" then
        for _, conditionalProp in arg1.conditionalProps do
            if typeof(conditionalProp) == "table" then
                walkProps(conditionalProp.propOverrides)
            end
        end
    end

    if typeof(arg1.children) ~= "table" then
        return
    end

    for _, child in arg1.children do
        recordV1ComponentUsage(str1, child)
    end
end

return recordV1ComponentUsage
