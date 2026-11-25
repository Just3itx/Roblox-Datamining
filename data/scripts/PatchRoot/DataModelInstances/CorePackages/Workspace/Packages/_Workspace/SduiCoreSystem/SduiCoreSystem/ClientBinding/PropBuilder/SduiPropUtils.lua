-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local DataHydration = require(SduiCoreSystemParent.DataHydration)
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
local Signals = require(SduiCoreSystemParent.Signals)
local Cryo = require(SduiCoreSystemParent.Cryo)
local tutils = require(SduiCoreSystemParent.tutils)
local SduiDataBinder = require(SduiCoreSystem.ClientBinding.SduiDataBinder)
local tryGetPathFromData = require(SduiCoreSystem.ClientBinding.tryGetPathFromData)
local splitDottedPath = require(SduiCoreSystem.ClientBinding.splitDottedPath)
local buildDataBindingSourcesForTemplate = require(SduiCoreSystem.ClientBinding.buildDataBindingSourcesForTemplate)
local SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local getSduiTokensStore = require(SduiCoreSystem.ClientBinding.getSduiTokensStore)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local SduiParsers = require(SduiCoreSystem.SduiParsers)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local PropResultCategory = SduiClientBindingTypes.PropResultCategory
local applyFormatArgFormatter = require(SduiCoreSystem.ClientBinding.PropBuilder.applyFormatArgFormatter).applyFormatArgFormatter

local DataStatus = DataHydration.DataHydrationTypes.DataStatus
local FFlagSduiDismissPromptPageScope = require(SduiCoreSystemParent.SharedFlags).FFlagSduiDismissPromptPageScope

local var1 = table.freeze({ status = DataStatus.Failed })

local var2 = table.freeze({})

local function resolveHydrationBinding(tbl1, arg1, arg2, bool1: boolean?)
    local str1 = table.concat(tbl1, ".")
    local var3 = tbl1[1]
    local var4 = arg1 and arg1[var3]

    if var4 == nil then
        if SduiDataBindingContentType[var3] ~= nil then
            error(`Could not find data bindingSource for key {var3}, bindingPath: {str1}`)
        end

        return nil, nil
    end

    local contentType = var4.contentType
    local id = var4.id

    if #tbl1 < 2 then
        error(`Unsupported path for contentType {contentType}, bindingPath: {str1}`)
    end

    local var5 = var4.fetchIfMissing or bool1

    local var6, var7 = SduiDataBinder.getFieldValue(contentType, tbl1, id, arg2, var5)
    return var6, var7
end

local function resolveBindingPathValue(arg1, tbl1, arg2, arg3, func1: ((...any) -> (...any))?, bool1: boolean?, arg4)
    local var3, var4 = tryGetPathFromData(arg3(arg1), tbl1)
    if var3 and var4 ~= nil then
        if func1 then
            return func1(var4, arg1)
        end
        return var4
    end

    local var5 = tbl1 and tbl1[1]
    if SduiDataBinder.isClientContentType(var5) then
        local fieldValueForClientContentType = SduiDataBinder.getFieldValueForClientContentType(var5, tbl1, arg1, arg4)
        if func1 and fieldValueForClientContentType ~= nil then
            return func1(fieldValueForClientContentType, arg1)
        end
        return fieldValueForClientContentType
    end

    local var6 = arg2(arg1)
    local var7, var8 = resolveHydrationBinding(tbl1, var6, arg1, bool1)

    if func1 and var7 ~= nil then
        var7 = func1(var7, arg1)
    end
    return var7, var8
end

local function generateStaticPropValue(arg1, func1: ((...any) -> (...any))?)
    if func1 then
        return func1(arg1)
    end
    return arg1
end

local function generateDynamicBindingPropValue(value: string, arg1, arg2, arg3, func1: ((...any) -> (...any))?, bool1: boolean?)
    local currentComponentType = arg2.currentComponentType
    local currentParserName = arg2.currentParserName

    local var3 = splitDottedPath(value)
    if not var3 or #var3 == 0 then
        error(`Invalid bindingPath: {value}`)
    end

    return Signals.createComputed(function(arg4)
        local success, result, result2 = pcall(function()
            local var4, var5 = resolveBindingPathValue(arg4, var3, arg1, arg3, func1, bool1, arg2)

            return var4, var5
        end)

        if success then
            return { data = result, status = result2 }
        end

        local tbl1 = {
            value = value,
            message = SduiParseHelpers.stringifyValue(result),
            name = arg2.debugName,
            componentType = currentComponentType,
            parserName = currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl1, arg2.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToComputeDynamicBinding, tbl1, arg2.appPage)

        return var1
    end, tutils.shallowEqual)
end

local function generateTokenBindingPropValue(str1: string, arg1, func1: ((...any) -> (...any))?)
    local currentComponentType = arg1.currentComponentType
    local currentParserName = arg1.currentParserName

    local var3 = splitDottedPath(str1)

    return Signals.createComputed(function(arg2)
        local var4 = getSduiTokensStore().getTokens(arg2, arg1.appPage)
        local var5, var6 = tryGetPathFromData(var4, var3)
        if var5 then
            if func1 then
                var6 = func1(var6)
            end

            return {
                data = var6,
                status = DataStatus.Ready
            }
        end

        local tbl1 = {
            message = `Could not find token with tokenPath {table.concat(var3, ".")}`,
            name = arg1.debugName,
            componentType = currentComponentType,
            parserName = currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl1, arg1.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.TokenBindingFailed, tbl1, arg1.appPage)

        return var1
    end, tutils.shallowEqual)
end

local function substituteFormatArg(str1: string, str2: string, str3: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return str1:gsub("{" .. str2 .. "}", function()
        return str3
    end)
end

local function generateFormatStringPropValue(tbl1, arg1, arg2, arg3, func1: ((...any) -> (...any))?)
    local currentComponentType = arg2.currentComponentType
    local currentParserName = arg2.currentParserName

    if typeof(tbl1) ~= "table" then
        error(`Unexpected type for stringFormat {typeof(tbl1)}`)
    end
    local str = tbl1.str

    if (not str or str == "") and tbl1.translation then
        str = arg2.resolveLocalizedLiteral(tbl1.translation, if FFlagSduiErrorPaths then arg2.errorContext else nil)
    end

    if not str or str == "" then
        error("No format string for prop")
    end
    if not tbl1.args then
        error(`No args found for format. If no args needed, use literal. {str}`)
    end

    local tbl2 = ({})
    local tbl3 = ({})
    for k, arg in tbl1.args do
        local type = arg.kind.type
        local value = arg.kind.value
        if type == "literal" then
            if arg.formatter then
                local var3 = applyFormatArgFormatter(value, arg.formatter, arg2.appPage, if FFlagSduiErrorPaths then arg2.errorContext else nil)

                if var3 == nil then
                    return function()
                        return var1
                    end
                end

                str = substituteFormatArg(str, k, var3)
            else
                str = substituteFormatArg(str, k, tostring(value))
            end
        elseif type == "binding_path" then
            tbl2[k] = generateDynamicBindingPropValue(value, arg1, arg2, arg3)
            if arg.formatter then
                tbl3[k] = arg.formatter
            end
        else
            warn(`Unrecognized argType in buildFormatString {type}`)
        end
    end

    return Signals.createComputed(function(arg4)
        local var3 = str
        for value, value2 in tbl2 do
            local var4 = value2(arg4)
            local data = var4.data
            local status = var4.status

            if data == nil then
                return { status = status }
            end

            local var5 = if tbl3 then tbl3[value] else nil

            if var5 then
                local var6 = applyFormatArgFormatter(data, var5, arg2.appPage, if FFlagSduiErrorPaths then arg2.errorContext else nil)

                if var6 == nil then
                    return var1
                end

                var3 = var3 and substituteFormatArg(var3, value, var6)
            else
                local var6 = var3 and substituteFormatArg(var3, value, tostring(data))
                var3 = var6
            end
        end

        if not func1 then
            return { data = var3 }
        end

        local success, result = pcall(function()
            return func1(var3)
        end)
        if success then
            return { data = result }
        end

        local tbl4 = {
            value = var3,
            message = `Parser in formatString for str {str}`,
            name = arg2.debugName,
            componentType = currentComponentType,
            parserName = currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl4, arg2.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl4, arg2.appPage)

        return var1
    end, tutils.shallowEqual)
end

local function validateNumbers(op: string, arg1, arg2)
    if typeof(arg1) ~= "number" then
        arg1 = tonumber(arg1)
    end
    if typeof(arg2) ~= "number" then
        arg2 = tonumber(arg2)
    end
    if typeof(arg1) ~= "number" or typeof(arg2) ~= "number" then
        error(`{op} without numbers, {arg1}: {typeof(arg1)}, {arg2}: {typeof(arg2)}`)
    end
    return arg1, arg2
end

local function isEmpty(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 == nil or (if type(arg1) == "string" then arg1 == "" else type(arg1) == "table" and next(arg1) == nil)
end

local function isSame(arg1, arg2): boolean
    if arg1 == arg2 then
        return true
    end
    if arg1 == nil then
        return false
    end

    local str1 = typeof(arg2)
    if typeof(arg1) ~= str1 then
        if str1 == "string" then
            arg1 = tostring(arg1)
        elseif str1 == "number" then
            arg1 = tonumber(arg1)
        elseif str1 == "boolean" then
            arg1 = SduiParsers.parseBooleanProp_(arg1, nil, nil)
        end
    end
    return arg1 == arg2
end

local var3 = nil
if FFlagSduiDismissPromptPageScope then
    local function contains(arg1, arg2)
        if typeof(arg1) ~= "table" or typeof(arg2) ~= "string" then
            return false
        end

        if arg1[arg2] ~= nil then
            return true
        end

        for value, value2 in arg1 do
            if typeof(value) == "number" and isSame(value2, arg2) then
                return true
            end
        end

        return false
    end

    var3 = function(arg1, func1: (...any) -> (...any))
        local var4, var5 = func1(arg1.field)
        if var5 and var5 ~= DataStatus.Ready then
            return nil, var5
        end

        local kind = arg1.kind
        if kind == nil or kind.type == nil then
            error("nil target kind in ContainsCondition")
        end

        local value = nil
        if kind.type == "string_value" then
            value = kind.value
        elseif kind.type == "binding_path_value" then
            local var6
            value, var6 = func1(kind.value)
            if var6 and var6 ~= DataStatus.Ready then
                return nil, var6
            end
            if value == nil then
                return nil
            end
        else
            error(`Unknown ContainsCondition target kind {kind.type}`)
        end

        return (contains(var4, value))
    end
end

local function evaluateCondition(arg1, tbl1, arg2, arg3, arg4)
    if tbl1 == nil then
        return true
    end

    local type2 = tbl1 and tbl1.kind and tbl1.kind.type
    local value = tbl1 and tbl1.kind and tbl1.kind.value
    if type2 == nil then
        error("nil conditionType in condition")
    end
    if value == nil then
        error("nil conditionValue in condition")
    end

    local function getFieldObject(str1: string)
        local var4 = splitDottedPath(str1)

        local success, result, result2 = pcall(function()
            return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
        end)

        if success then
            return result, result2
        end

        return nil, result2
    end

    if type2 == "comparison" then
        local field = value.field
        local var4 = splitDottedPath(field)

        local success, result, result2 = pcall(function()
            return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
        end)

        if not success then
            result = nil
        end

        if result == nil or result2 and result2 ~= DataStatus.Ready then
            return nil, result2
        end
        local value2 = value.kind.value
        local op = value.op
        if op == "OP_LT" then
            local var5, var6 = validateNumbers(op, result, value2)
            return var5 < var6
        elseif op == "OP_LTE" then
            local var5, var6 = validateNumbers(op, result, value2)
            return var5 <= var6
        elseif op == "OP_GT" then
            local var5, var6 = validateNumbers(op, result, value2)
            return var6 < var5
        elseif op == "OP_GTE" then
            local var5, var6 = validateNumbers(op, result, value2)
            return var6 <= var5
        elseif op == "OP_E" then
            return (isSame(result, value2))
        elseif op == "OP_NE" then
            return not isSame(result, value2)
        end
        error(`Unknown operator for comparison {op}`)
    else
        if type2 == "is_null" then
            local field = value.field
            local var4 = splitDottedPath(field)

            local success, result, result2 = pcall(function()
                return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
            end)

            if not success then
                result = nil
            end

            if result2 and result2 ~= DataStatus.Ready then
                return nil, result2
            end
            return result == nil
        elseif type2 == "is_not_null" then
            local field = value.field
            local var4 = splitDottedPath(field)

            local success, result, result2 = pcall(function()
                return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
            end)

            if not success then
                result = nil
            end

            if result2 and result2 ~= DataStatus.Ready then
                return nil, result2
            end
            return result ~= nil
        elseif type2 == "is_empty" then
            local field = value.field
            local var4 = splitDottedPath(field)

            local success, result, result2 = pcall(function()
                return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
            end)

            if not success then
                result = nil
            end

            if result2 and result2 ~= DataStatus.Ready then
                return nil, result2
            elseif result == nil then
                return isEmpty(nil)
            elseif type(result) == "string" then
                return result == ""
            elseif type(result) == "table" then
                return next(result) == nil
            end

            return false
        elseif type2 == "is_not_empty" then
            local field = value.field
            local var4 = splitDottedPath(field)

            local success, result, result2 = pcall(function()
                return resolveBindingPathValue(arg1, var4, arg2, arg4, nil, true, arg3)
            end)

            if not success then
                result = nil
            end

            if result2 and result2 ~= DataStatus.Ready then
                return nil, result2
            end

            return not isEmpty(result)
        end

        if FFlagSduiDismissPromptPageScope and type2 == "contains" then
            return var3(value, getFieldObject)
        end

        if type2 == "and_condition" then
            for _, condition in value.conditions do
                local var4, var5 = evaluateCondition(arg1, condition, arg2, arg3, arg4)
                if var5 and var5 ~= DataStatus.Ready then
                    return var4, var5
                end

                if not var4 then
                    return var4
                end
            end
            return true
        elseif type2 == "or_condition" then
            for _, condition in value.conditions do
                local var4, var5 = evaluateCondition(arg1, condition, arg2, arg3, arg4)
                if var5 and var5 ~= DataStatus.Ready then
                    return var4, var5
                end
                if var4 or var4 == nil then
                    return var4, var5
                end
            end
            return false
        end
    end
    return nil
end

local function selectConditionalOption(arg1, tbl1, arg2, arg3, arg4)
    for _, value in tbl1 do
        local var4, var5 = evaluateCondition(arg1, value.condition, arg2, arg3, arg4)
        if var4 then
            return value, var5
        end

        if var5 and var5 ~= DataStatus.Ready then
            return var4, var5
        end
    end
    return nil
end

local function resolveTablePropValue(arg1, tbl1, tbl2, tbl3, _, _, _, _, _: ((...any) -> (...any))?)
    local var4 = Cryo.Dictionary.join(tbl3 or var2, tbl1 or var2)
    local var5 = nil
    if tbl2 then
        for value, value2 in tbl2 do
            var4[value] = value2(arg1).data

            local status = value2(arg1).status
            if status and status ~= DataStatus.Ready then
                var5 = status
            end
        end
    end

    return var4, var5
end

local function resolveFieldMap(tbl1, arg1, arg2, arg3, arg4, arg5, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var4, var5 = func1(tbl1, arg1, arg2, arg3, arg4)
    return resolveTablePropValue(arg5, var4, var5, nil, arg1, arg3, arg4, arg2, nil)
end

local function resolveTemplate(str1: string?, arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= nil then
        return arg1
    end
    if str1 == nil or str1 == "" then
        error("Missing roblox_component")
    end
    local templateForRobloxComponent = arg2.getTemplateForRobloxComponent(str1)
    if templateForRobloxComponent == nil then
        error(`Could not find template for roblox_component {str1}`)
    end
    return templateForRobloxComponent
end

return {
    generateStaticPropValue = generateStaticPropValue,
    generateDynamicBindingPropValue = generateDynamicBindingPropValue,
    generateTokenBindingPropValue = generateTokenBindingPropValue,
    generateFormatStringPropValue = generateFormatStringPropValue,
    generateConditionalPropValue = function(tbl1, arg1, arg2, arg3, arg4, func1: (...any) -> (...any), func2: ((...any) -> (...any))?, isNestedComponentConfig: boolean?)
        local currentComponentType = arg2.currentComponentType
        local currentParserName = arg2.currentParserName

        local options = tbl1.options

        return Signals.createComputed(function(arg5)
            local success, result, result2 = pcall(function()
                local var4, status = selectConditionalOption(arg5, options, arg1, arg2, arg4)
                if var4 == nil then
                    return nil, status
                end

                local type = var4 and var4.kind and var4.kind.type
                local value = var4 and var4.kind and var4.kind.value
                local var5, var6 = func1(type, value, arg1, arg4, arg2, arg3, func2)

                if var6 == PropResultCategory.PropSignal then
                    local var7 = var5(arg5)
                    var5 = var7.data
                    if var7.status and var7.status ~= DataStatus.Ready then
                        status = var7.status
                    end
                end

                return var5, status
            end)

            if success then
                return {
                    data = result,
                    status = result2,
                    isNestedComponentConfig = isNestedComponentConfig
                }
            end
            local tbl2 = {
                message = SduiParseHelpers.stringifyValue(result),
                name = arg2.debugName,
                componentType = currentComponentType,
                parserName = currentParserName
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg2.errorContext)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToEvaluateConditionalProp, tbl2, arg2.appPage)

            return var1
        end, tutils.shallowEqual)
    end,
    generateTablePropSignalValue = function(tbl1, arg1, arg2, arg3, arg4, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
        local currentComponentType = arg2.currentComponentType
        local currentParserName = arg2.currentParserName

        local var4, var5, var6 = func1(tbl1, arg1, arg4, arg2, arg3)

        return Signals.createComputed(function(arg5)
            local success, result, result2 = pcall(function()
                local var7, var8 = resolveTablePropValue(arg5, var4, var5, var6, arg1, arg2, arg3, arg4, func1)

                return var7, var8
            end)

            if not success then
                local tbl2 = {
                    message = SduiParseHelpers.stringifyValue(result),
                    name = arg2.debugName,
                    componentType = currentComponentType,
                    parserName = currentParserName
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl2, arg2.errorContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg2.appPage)
                return var1
            end

            if func2 and result ~= nil then
                local success2, result3 = pcall(function()
                    return func2(result)
                end)
                if not success2 then
                    local var7 = SduiParseHelpers.stringifyValue(result3)
                    local tbl2 = {
                        value = SduiParseHelpers.stringifyValue(result),
                        message = `Failed to apply propParser to table prop {var7}`,
                        name = arg2.debugName,
                        componentType = currentComponentType,
                        parserName = currentParserName
                    }
                    if FFlagSduiErrorPaths then
                        addSduiErrorContextFields(tbl2, arg2.errorContext)
                    end
                    SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg2.appPage)

                    return var1
                end
                result = result3
            end
            return { data = result, status = result2 }
        end, tutils.shallowEqual)
    end,
    selectConditionalOption = selectConditionalOption,
    evaluateCondition = evaluateCondition,
    resolveHydrationBinding = resolveHydrationBinding,
    resolveBindingPathValue = resolveBindingPathValue,
    resolveTablePropValue = resolveTablePropValue,
    resolveSourceArray = function(str1: string?, arg1, arg2, arg3, arg4, arg5)
        if str1 ~= "binding_path" then
            return if str1 == "literal" then arg1 and arg1.items else nil
        end

        local var4 = splitDottedPath(arg1)
        return resolveBindingPathValue(arg2, var4, arg3, arg4, nil, nil, arg5)
    end,
    resolveFieldMap = resolveFieldMap,
    mapArrayWithFieldMap = function(tbl1, tbl2, tbl3, arg1, arg2, arg3, func1: (...any) -> (...any))
        local result = {}
        for _, value in tbl1 do
            local dataBindingSourcesForTemplate = buildDataBindingSourcesForTemplate(value, tbl2)
            table.insert(result, (resolveFieldMap(tbl3, function()
                return dataBindingSourcesForTemplate
            end, function()
                return value
            end, arg1, arg2, arg3, func1)))
        end
        return result
    end,
    isComponentVisible = function(arg1, arg2): boolean
        return arg1.isComponentFilteredSignal == nil or arg1.isComponentFilteredSignal(arg2).data ~= true
    end,
    resolveTemplate = resolveTemplate,
    resolveTemplateFromData = function(arg1, arg2)
        local inlineComponent = arg1.inline_component
        return resolveTemplate(arg1.roblox_component, inlineComponent, arg2)
    end
}
