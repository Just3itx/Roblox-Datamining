-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Signals = require(SduiCoreSystemParent.Signals)
local tutils = require(SduiCoreSystemParent.tutils)
local DataStatus = require(SduiCoreSystemParent.DataHydration).DataHydrationTypes.DataStatus

local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local FFlagSduiArrayMapEmptyWhileHydrationNotReady = require(SduiCoreSystemParent.SharedFlags).FFlagSduiArrayMapEmptyWhileHydrationNotReady

local function buildRepeatedProp(str1: string, arg1, arg2, arg3, arg4, arg5, func1: ((...any) -> (...any))?)
    local currentComponentType = arg4.currentComponentType
    local currentParserName = arg4.currentParserName

    if str1 == "literal" then
        if typeof(arg1) ~= "table" then
            error("buildRepeatedProp: propDefinitionValue must be a table for literal type")
        end

        local array = arg1.array
        if array == nil then
            error("buildRepeatedProp: wrapper message must have 'array' field")
        end
        if typeof(array) ~= "table" then
            error("buildRepeatedProp: array field must be a table/array")
        end

        return SduiPropUtils.generateTablePropSignalValue(
            array,
            arg2,
            arg4,
            arg5,
            arg3,
            SduiClientBindingBuilder.buildPropTable,
            func1
        ), PropResultCategory.PropSignal
    elseif str1 == "binding_path" then
        return SduiPropUtils.generateDynamicBindingPropValue(arg1, arg2, arg4, arg3, function(tbl1, arg6) -- name: evaluatePropArray
            local var1, var2, var3 = SduiClientBindingBuilder.buildPropTable(tbl1, arg2, arg3, arg4, arg5)

            return SduiPropUtils.resolveTablePropValue(
                arg6,
                var1,
                var2,
                var3,
                arg2,
                arg4,
                arg5,
                arg3,
                SduiClientBindingBuilder.buildPropTable
            )
        end), PropResultCategory.PropSignal
    elseif str1 == "array_map" then
        local type = arg1.kind and arg1.kind.type
        local value = arg1.kind and arg1.kind.value
        local itemHydrationSpecs = arg1.item_hydration_specs
        local fieldMap = arg1.field_map

        if fieldMap == nil then
            error("buildRepeatedProp array_map: missing field_map")
        end

        return Signals.createComputed(function(arg6)
            local success, result = pcall(function()
                local var1, var2 = SduiPropUtils.resolveSourceArray(type, value, arg6, arg2, arg3, arg4)

                if FFlagSduiArrayMapEmptyWhileHydrationNotReady and var1 == nil and var2 == DataStatus.NotReady then
                    return {}
                end

                if var1 == nil then
                    error("buildRepeatedProp array_map: source array resolved to nil")
                end

                return SduiPropUtils.mapArrayWithFieldMap(
                    var1,
                    itemHydrationSpecs or {},
                    fieldMap,
                    arg4,
                    arg5,
                    arg6,
                    SduiClientBindingBuilder.buildPropTable
                )
            end)

            if success then
                return { data = result }
            end
            local tbl1 = {
                message = `Failed to build array_map: {SduiParseHelpers.stringifyValue(result)}`,
                name = arg4.debugName,
                componentType = currentComponentType,
                parserName = currentParserName
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl1, arg4.errorContext)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl1, arg4.appPage)

            return {
                data = {}
            }
        end, tutils.shallowEqual), PropResultCategory.PropSignal
    elseif str1 == "conditional" then
        return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, buildRepeatedProp, func1), PropResultCategory.PropSignal
    else
        return nil, PropResultCategory.Failed
    end
end
return buildRepeatedProp
