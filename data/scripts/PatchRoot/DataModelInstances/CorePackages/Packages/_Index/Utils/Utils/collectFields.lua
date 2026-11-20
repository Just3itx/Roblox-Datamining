-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set

local tbl1 = {}

local memoize5 = require(script.Parent.memoize).memoize5

local GraphQL = require(scriptParentParent.GraphQL)

local Kind = GraphQL.Kind

local getDirectiveValues = GraphQL.getDirectiveValues
local GraphQLSkipDirective = GraphQL.GraphQLSkipDirective
local GraphQLIncludeDirective = GraphQL.GraphQLIncludeDirective
local isAbstractType = GraphQL.isAbstractType
local typeFromAST = GraphQL.typeFromAST

local shouldIncludeNode = nil
local getFieldEntryKey = nil
local doesFragmentConditionMatch = nil

local function collectFields<T>(arg1, tbl2, tbl3, arg2, arg3, arg4: T, arg5): T
    for _, selection in arg3.selections do
        local kind = selection.kind
        if kind == Kind.FIELD then
            if Boolean.toJSBoolean(shouldIncludeNode(tbl3, selection)) then
                local fieldEntryKey = getFieldEntryKey(selection)

                local var1 = arg4:get(fieldEntryKey)
                if var1 ~= nil then
                    table.insert(var1, selection)
                else
                    arg4:set(fieldEntryKey, { selection })
                end
            end
        elseif kind == Kind.INLINE_FRAGMENT then
            if shouldIncludeNode(tbl3, selection) and doesFragmentConditionMatch(arg1, selection, arg2) then
                collectFields(arg1, tbl2, tbl3, arg2, selection.selectionSet, arg4, arg5)
            end
        elseif kind == Kind.FRAGMENT_SPREAD then
            local value = selection.name.value
            if not arg5:has(value) and shouldIncludeNode(tbl3, selection) then
                arg5:add(value)
                local var1 = tbl2[tostring(value)]

                if Boolean.toJSBoolean(var1) and Boolean.toJSBoolean(doesFragmentConditionMatch(arg1, var1, arg2)) then
                    collectFields(arg1, tbl2, tbl3, arg2, var1.selectionSet, arg4, arg5)
                end
            end
        end
    end

    return arg4
end
tbl1.collectFields = collectFields

shouldIncludeNode = function(tbl2, arg1): boolean
    local directiveValues = getDirectiveValues(GraphQLSkipDirective, arg1, tbl2)
    if (if typeof(directiveValues) == "table" then directiveValues["if"] else nil) == true then
        return false
    end
    local directiveValues2 = getDirectiveValues(GraphQLIncludeDirective, arg1, tbl2)
    return (if typeof(directiveValues2) == "table" then directiveValues2["if"] else nil) ~= false
end

doesFragmentConditionMatch = function(arg1, arg2, arg3)
    local typeCondition = arg2.typeCondition
    if not Boolean.toJSBoolean(typeCondition) then
        return true
    end

    local var1 = typeFromAST(arg1, typeCondition)

    if var1 == arg3 then
        return true
    end
    if not Boolean.toJSBoolean(isAbstractType(var1)) then
        return false
    end

    local possibleTypes = arg1:getPossibleTypes(var1)

    return Array.includes(possibleTypes, arg3)
end

getFieldEntryKey = function(arg1)
    return if arg1.alias then arg1.alias.value else arg1.name.value
end

tbl1.collectSubFields = memoize5(function(arg1, tbl2, tbl3, arg2, arg3)
    local map = Map.new()
    local set = Set.new()
    for _, value in arg3 do
        if value.selectionSet then
            collectFields(arg1, tbl2, tbl3, arg2, value.selectionSet, map, set)
        end
    end

    return map
end)

return tbl1
