-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set

local module = {}

local getOperationASTFromRequest = require(script.Parent.getOperationASTFromRequest).getOperationASTFromRequest

local GraphQL = require(scriptParentParent.GraphQL)

local Kind = GraphQL.Kind

local isListType = GraphQL.isListType
local getNullableType = GraphQL.getNullableType
local isAbstractType = GraphQL.isAbstractType
local isObjectType = GraphQL.isObjectType

local TypeNameMetaFieldDef = GraphQL.TypeNameMetaFieldDef

local SchemaMetaFieldDef = GraphQL.SchemaMetaFieldDef

local collectFields = require(script.Parent.collectFields)

local collectFields2 = collectFields.collectFields
local collectSubFields = collectFields.collectSubFields

local _Interfaces = require(script.Parent.Interfaces)

local _types = require(script.Parent.types)

local NULL = GraphQL.NULL

local visitRoot = nil
local visitErrorsByType = nil
local visitObjectValue = nil
local sortErrorsByPathSegment = nil
local updateObject = nil
local addPathSegmentInfo = nil
local visitFieldValue = nil

local function visitData(arg1, func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?)
    if Boolean.toJSBoolean(Array.isArray(arg1)) then
        return Array.map(arg1, function(arg2)
            return visitData(arg2, func1, func2)
        end)
    elseif typeof(arg1) == "table" then
        if func1 ~= nil then
            arg1 = func1(arg1)
        end
        if arg1 ~= nil then
            for value in arg1 do
                local var1 = arg1[tostring(value)]

                arg1[value] = visitData(var1, func1, func2)
            end
        end

        if func2 ~= nil then
            return (func2(arg1))
        end

        return arg1
    else
        return arg1
    end
end

module.visitData = visitData
function module.visitErrors(arg1, func1: (...any) -> (...any))
    return Array.map(arg1, function(arg2)
        return func1(arg2)
    end)
end

function module.visitResult(arg1, arg2, arg3, tbl1, arg4)
    local var1 = Array.reduce(arg2.document.definitions, function(arg5, arg6)
        if arg6.kind == Kind.FRAGMENT_DEFINITION then
            local value = arg6.name.value
            arg5[tostring(value)] = arg6
        end
        return arg5
    end, {})

    local var2 = not Boolean.toJSBoolean(arg2.variables) and {} or arg2.variables

    local tbl2 = {
        segmentInfoMap = Map.new(),
        unpathedErrors = Set.new()
    }
    local data = arg1.data
    local errors = arg1.errors
    local bool1 = not (errors == nil) and arg4 ~= nil
    local operationAstFromRequest = getOperationASTFromRequest(arg2)
    if data ~= nil and operationAstFromRequest ~= nil then
        arg1.data = visitRoot(
            data,
            operationAstFromRequest,
            arg3,
            var1,
            var2,
            tbl1,
            if Boolean.toJSBoolean(bool1) then errors else nil,
            tbl2
        )
    end

    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(not (errors == nil) and arg4) then
        arg1.errors = visitErrorsByType(errors, arg4, tbl2)
    end

    return arg1
end

visitErrorsByType = function(arg1, arg2, tbl1)
    local segmentInfoMap = tbl1.segmentInfoMap
    local unpathedErrors = tbl1.unpathedErrors

    local __unpathed = arg2.__unpathed

    return Array.map(arg1, function(arg3)
        local var1 = segmentInfoMap:get(arg3)

        local var2 = if var1 == nil then arg3 else Array.reduce(Array.reverse(Array.concat({}, var1)), function(arg4, arg5)
            local name = arg5.type.name

            local var2 = arg2[name]
            if var2 == nil then
                return arg4
            end
            local var3 = var2[tostring(arg5.fieldName)]
            if var3 == nil then
                return arg4
            end

            return (var3(arg4, arg5.pathIndex))
        end, arg3)

        local toJsBoolean = Boolean.toJSBoolean

        if toJsBoolean(if Boolean.toJSBoolean(__unpathed) then unpathedErrors:has(arg3) else __unpathed) then
            return __unpathed(var2)
        end
        return var2
    end)
end

local function getOperationRootType(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local operation = arg2.operation
    if operation == "query" then
        return arg1:getQueryType()
    elseif operation == "mutation" then
        return arg1:getMutationType()
    elseif operation == "subscription" then
        return arg1:getSubscriptionType()
    end

    return nil
end

visitRoot = function(arg1, arg2, arg3, tbl1, tbl2, arg4, arg5, tbl3)
    local operationRootType = getOperationRootType(arg3, arg2)
    local var1 = collectFields2(arg3, tbl1, tbl2, operationRootType, arg2.selectionSet, Map.new(), Set.new())

    return visitObjectValue(arg1, operationRootType, var1, arg3, tbl1, tbl2, arg4, 1, arg5, tbl3)
end

visitObjectValue = function(tbl1, arg1, arg2, arg3, tbl2, tbl3, arg4, num1: number, arg5, tbl4)
    local fields = arg1:getFields()
    local var1 = if typeof(arg4) == "table" then arg4[arg1.name] else nil
    local __enter = if typeof(var1) == "table" then var1.__enter else nil
    local var2 = if __enter == nil then tbl1 else __enter(tbl1)
    local errorMap

    if arg5 == nil then
        errorMap = nil
    else
        local var3 = sortErrorsByPathSegment(arg5, num1)
        errorMap = var3.errorMap
        for _, unpathedError in var3.unpathedErrors do
            tbl4.unpathedErrors:add(unpathedError)
        end
    end
    for _, value in arg2 do
        local var3, var4 = table.unpack(value, 1, 2)

        local value2 = var4[1].name.value
        local type = if typeof(fields:get(value2)) == "table" then fields:get(value2).type else nil

        if type == nil then
            if value2 == "__typename" then
                type = TypeNameMetaFieldDef.type
            elseif value2 == "__schema" then
                type = SchemaMetaFieldDef.type
            end
        end
        local num2 = num1 + 1
        local var5

        if errorMap then
            var5 = errorMap[tostring(var3)]
            if var5 ~= nil then
                errorMap[tostring(var3)] = nil
            end
            addPathSegmentInfo(arg1, value2, num2, var5, tbl4)
        else
            var5 = nil
        end
        local var6 = visitFieldValue(tbl1[tostring(var3)], type, var4, arg3, tbl2, tbl3, arg4, num2, var5, tbl4)

        updateObject(var2, var3, var6, var1, value2)
    end

    local __typename = var2.__typename
    if __typename ~= nil then
        updateObject(var2, "__typename", __typename, var1, "__typename")
    end

    if errorMap then
        for value in errorMap do
            for _, value2 in errorMap[value] do
                tbl4.unpathedErrors:add(value2)
            end
        end
    end

    local __leave = if typeof(var1) == "table" then var1.__leave else nil

    if __leave ~= nil then
        return (__leave(var2))
    end

    return var2
end

updateObject = function(tbl1, str1: string, arg1, arg2, str2: string)
    if arg2 == nil then
        tbl1[tostring(str1)] = arg1
        return
    end

    local var1 = arg2[str2]

    if var1 == nil then
        tbl1[tostring(str1)] = arg1
        return
    end
    local var2 = var1(arg1)
    if var2 == nil then
        tbl1[tostring(str1)] = nil
        return
    end
    tbl1[tostring(str1)] = var2
end

local function visitListValue(arg1, ofType, arg2, arg3, tbl1, tbl2, arg4, num1: number, arg5, tbl3)
    return Array.map(arg1, function(arg6)
        return visitFieldValue(arg6, ofType, arg2, arg3, tbl1, tbl2, arg4, num1 + 1, arg5, tbl3)
    end)
end

visitFieldValue = function(arg1, arg2, arg3, arg4, tbl1, tbl2, arg5, num1: number, arg6, tbl3)
    local var1 = arg6 == nil and {} or arg6

    if arg1 == nil or arg1 == NULL then
        return arg1
    end
    local nullableType = getNullableType(arg2)
    if Boolean.toJSBoolean(isListType(nullableType)) then
        return visitListValue(arg1, nullableType.ofType, arg3, arg4, tbl1, tbl2, arg5, num1, var1, tbl3)
    end

    if Boolean.toJSBoolean(isAbstractType(nullableType)) then
        local type = arg4:getType(arg1.__typename)
        local var2 = collectSubFields(arg4, tbl1, tbl2, type, arg3)
        return visitObjectValue(arg1, type, var2, arg4, tbl1, tbl2, arg5, num1, var1, tbl3)
    end

    if Boolean.toJSBoolean(isObjectType(nullableType)) then
        local var2 = collectSubFields(arg4, tbl1, tbl2, nullableType, arg3)
        return visitObjectValue(arg1, nullableType, var2, arg4, tbl1, tbl2, arg5, num1, var1, tbl3)
    end

    local var2 = if typeof(arg5) == "table" then arg5[nullableType.name] else nil

    if var2 == nil then
        return arg1
    end

    local var3 = var2(arg1)

    return if var3 == nil then arg1 else var3
end

sortErrorsByPathSegment = function(arg1, num1: number)
    local errorMap = {}

    local set = Set.new()
    for _, value in arg1 do
        local var1 = if typeof(value.path) == "table" then value.path[num1] else nil
        if var1 == nil then
            set:add(value)
        elseif Array.indexOf(Object.keys(errorMap), tostring(var1)) ~= -1 then
            table.insert(errorMap[tostring(var1)], value)
        else
            errorMap[tostring(var1)] = { value }
        end
    end
    return { errorMap = errorMap, unpathedErrors = set }
end

addPathSegmentInfo = function(type, fieldName: string, pathIndex: number, arg1, tbl1)
    for _, value in arg1 == nil and {} or arg1 do
        local tbl2 = { type = type, fieldName = fieldName, pathIndex = pathIndex }
        local var1 = tbl1.segmentInfoMap:get(value)
        if var1 == nil then
            tbl1.segmentInfoMap:set(value, { tbl2 })
        else
            table.insert(var1, tbl2)
        end
    end
end
return module
