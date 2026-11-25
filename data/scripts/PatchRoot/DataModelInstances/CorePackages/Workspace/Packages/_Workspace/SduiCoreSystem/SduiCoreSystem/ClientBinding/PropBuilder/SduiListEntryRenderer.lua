-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Cryo = require(SduiCoreSystemParent.Cryo)
local _Signals = require(SduiCoreSystemParent.Signals)

local buildInputsForNestedComponent = require(SduiCoreSystem.ClientBinding.PropBuilder.buildInputsForNestedComponent)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiListEntryNormalizer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryNormalizer)

local buildConfigForComponent = SduiClientBindingBuilder.buildConfigForComponent

local SduiDeferredItemStub = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiDeferredItemStub)

local tbl1 = {}

local function unwrapEntryData(value)
    if typeof(value) ~= "table" then
        return { value = value }
    end
    local inputData = value.input_data
    if not (inputData and inputData.kind and inputData.kind.value) then
        return table.clone(value)
    end

    local result = ({})
    if typeof(inputData.kind.value) == "table" then
        for value, value2 in inputData.kind.value do
            result[value] = value2
        end
    end
    return result
end

local function fillInputs(tbl2, inputs, arg1, arg2, arg3, arg4, tbl3)
    if inputs == nil then
        return
    end
    local success, result = pcall(function()
        buildInputsForNestedComponent(arg1, inputs, arg2, arg3, tbl2, arg4)
    end)
    if success then
        return
    end

    local tbl4 = {
        message = `Failed to build inputs for ComponentList item: {SduiParseHelpers.stringifyValue(result)}`,
        name = tbl3.name,
        componentType = tbl3.componentType,
        parserName = tbl3.parserName
    }
    if FFlagSduiErrorPaths then
        addSduiErrorContextFields(tbl4, tbl3.nodeContext)
    end
    SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl4, tbl3.appPage)
end

return {
    captureErrorContext = function(arg1)
        return {
            name = arg1.debugName,
            nodeContext = if FFlagSduiErrorPaths then arg1.errorContext else nil,
            componentType = arg1.currentComponentType,
            parserName = arg1.currentParserName,
            appPage = arg1.appPage
        }
    end,
    createInputSlicer = function(arg1, arg2, arg3, tbl2, func1: ((...any) -> (...any))?): (any, any) -> ((any) -> any) | (any, boolean) -> any
        local function rawSlice(arg4, bool1: boolean)
            if arg4.sourceMode == "literal" then
                return if bool1 then arg1 else function(arg5)
                    local result = {}
                    fillInputs(result, arg4.inputs, arg1, arg2, arg5, arg3, tbl2)

                    return result
                end
            end

            local item = arg4.item
            return if bool1 then function(arg5)
                return Cryo.Dictionary.join(arg1(arg5), if typeof(item) == "table" then item else tbl1)
            end else function(arg5)
                local var1 = unwrapEntryData(item)
                fillInputs(var1, arg4.inputs, arg1, arg2, arg5, arg3, tbl2)

                return var1
            end
        end

        return if func1 == nil then rawSlice else function(arg4, arg5)
            local var1 = rawSlice(arg4, arg5)
            return function(arg6)
                local var2 = func1(arg4)
                if var2 == nil then
                    return var1(arg6)
                end

                return Cryo.Dictionary.join(var1(arg6), var2)
            end
        end
    end,
    buildEntryConfigs = function(tbl2, func1: (...any) -> (...any), tbl3, arg1, tbl4, arg2, arg3, arg4, bool1: boolean?, func2: ((...any) -> (...any))?)
        local tbl5 = {}
        local tbl6 = {}
        local bool2 = func2 ~= nil
        for value, value2 in tbl2 do
            if tbl3 and tbl3[value] then
                local var1 = tbl3[value]
                if SduiPropUtils.isComponentVisible(var1, arg4) then
                    if bool2 then
                        local var2 = func2(value2, arg4)
                        if var2 ~= nil then
                            for value3, value4 in var2 do
                                var1[value3] = value4
                            end
                        end
                    end
                    table.insert(tbl5, var1)
                    table.insert(tbl6, value)
                end
            elseif value2.template == nil then
                local tbl7 = {
                    message = `No template found for ComponentList item (identifier: {value2.identifier or tostring(value)})`,
                    name = tbl4.name,
                    componentType = tbl4.componentType,
                    parserName = tbl4.parserName
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl7, tbl4.nodeContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl7, tbl4.appPage)
            else
                local var1 = func1(value2, value2.isInline)
                local var2 = if value2.isInline then arg3 else nil

                if bool1
                    and (not value2.template
                        or not (value2.template.kind and value2.template.kind.value)
                        or not value2.template.kind.value.shared
                        or value2.template.kind.value.shared.is_component_filtered == nil)
                then
                    local stub = SduiDeferredItemStub.makeStub(
                        value2.template,
                        var1,
                        arg1,
                        arg2,
                        var2,
                        tbl4,
                        if FFlagSduiErrorPaths then value2.robloxComponent else nil,
                        if FFlagSduiErrorPaths then value2.identifier else nil
                    )

                    if bool2 then
                        local var3 = func2(value2, arg4)
                        if var3 ~= nil then
                            for value3, value4 in var3 do
                                stub[value3] = value4
                            end
                        end
                    end
                    table.insert(tbl5, stub)
                    table.insert(tbl6, value)
                else
                    local configForComponent = buildConfigForComponent(
                        value2.template,
                        var1,
                        arg1,
                        arg2,
                        nil,
                        var2,
                        nil,
                        if FFlagSduiErrorPaths then value2.robloxComponent else nil,
                        if FFlagSduiErrorPaths then value2.identifier else nil
                    )

                    if configForComponent and SduiPropUtils.isComponentVisible(configForComponent, arg4) then
                        if bool2 then
                            local var3 = func2(value2, arg4)
                            if var3 ~= nil then
                                for value3, value4 in var3 do
                                    configForComponent[value3] = value4
                                end
                            end
                        end
                        table.insert(tbl5, configForComponent)
                        table.insert(tbl6, value)
                    end
                end
            end
        end

        return tbl5, tbl6
    end
}
