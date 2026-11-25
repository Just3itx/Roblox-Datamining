-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local React = require(SduiCoreSystemParent.React)

local SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrorType = require(SduiCoreSystem.SduiErrors).SduiErrorType
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local SduiBuilderProcessingPhase = SduiBuilderTypes.SduiBuilderProcessingPhase

local ServerBindingPropMap = require(SduiCoreSystemParent.SduiCompat).ServerBindingPropMap

local function parseProps(componentType, tbl1, name: string, arg1, arg2, arg3, render)
    if not tbl1 then
        return
    end
    assert(tbl1, "props must exist")

    local var1 = arg3 or arg1.componentDefinitions:getPropParsers(componentType)

    if not var1 then
        return
    end
    assert(var1, "componentInterface must exist")

    for propName, value2 in tbl1 do
        local var2 = var1[propName]
        if not var2
            or render == SduiBuilderProcessingPhase.Render and not arg1.componentDefinitions:doesParserRequireRenderContext(var2)
        then
            continue
        end

        local success, result = pcall(function()
            if typeof(var2) == "table" then
                if typeof(value2) ~= "table" then
                    error({ message = `Invalid input {typeof(value2)} for prop. Expected table` })
                end

                local var3 = nil
                for value3, _ in value2 do
                    local var4 = ServerBindingPropMap[value3]
                    if var4 then
                        var3 = var3 or {}
                        var3[value3] = var4
                    end
                end
                if var3 then
                    for value3, value4 in var3 do
                        value2[value4] = value2[value3]
                    end
                end

                parseProps(componentType, value2, name, arg1, arg2, var2, render)

                return value2
            elseif value2 == "NULL_PROP" then
                return React.None
            else
                return var2(value2, arg1, arg2, render)
            end
        end)

        if not success then
            arg1.dependencies.logger.reportError(
                SduiErrorType.FailedToParseProp,
                Cryo.Dictionary.union(
                    {
                        name = name,
                        componentType = componentType,
                        propName = propName,
                        value = SduiParseHelpers.stringifyValue(value2)
                    },
                    if typeof(result) == "table" then result else typeof(result) == "string" and {
                        message = result
                    } or {}
                ),
                arg1.appPage
            )

            if typeof(result) == "table" then
                if result.overrideValue then
                    tbl1[propName] = result.overrideValue
                else
                    tbl1[propName] = nil
                end
            end
        elseif result == React.None then
            tbl1[propName] = nil
        else
            tbl1[propName] = result
        end
    end
end

return parseProps
