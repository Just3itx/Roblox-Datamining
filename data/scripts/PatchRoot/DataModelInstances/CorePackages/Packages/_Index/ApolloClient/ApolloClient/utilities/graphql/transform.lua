-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local Boolean = LuauPolyfill.Boolean
local String = LuauPolyfill.String

local module = {}

local GraphQL = require(scriptParentParentParentParent.GraphQL)

local visit = GraphQL.visit

local REMOVE = GraphQL.REMOVE
local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local getFromAST = require(script.Parent.getFromAST)
local checkDocument = getFromAST.checkDocument
local getOperationDefinition = getFromAST.getOperationDefinition
local getFragmentDefinition = getFromAST.getFragmentDefinition
local getFragmentDefinitions = getFromAST.getFragmentDefinitions
local getMainDefinition = getFromAST.getMainDefinition
local filterInPlace = require(script.Parent.Parent.common.filterInPlace).filterInPlace
local storeUtils = require(script.Parent.storeUtils)
local isField = storeUtils.isField
local isInlineFragment = storeUtils.isInlineFragment

local function createFragmentMap(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local fragmentMap = {}
    Array.forEach(arg1, function(arg2)
        fragmentMap[arg2.name.value] = arg2
    end)
    return fragmentMap
end

local hasDirectivesInSelection = nil
local removeArgumentsFromDocument = nil
local removeFragmentSpreadFromDocument = nil
local getAllFragmentSpreadsFromSelectionSet = nil

local tbl1 = {
    kind = "Field",
    name = { kind = "Name", value = "__typename" }
}
local function isEmpty(arg1, tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    return Array.every(arg1.selectionSet.selections, function(arg2)
        return arg2.kind == "FragmentSpread" and isEmpty(tbl2[arg2.name.value], tbl2)
    end, nil)
end

local function nullIfDocIsEmpty(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if isEmpty(
        getOperationDefinition(arg1) or getFragmentDefinition(arg1),
        (createFragmentMap((getFragmentDefinitions(arg1))))
    ) then nil else arg1
end

local function getDirectiveMatcher(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return function(arg2)
        return Array.some(arg1, function(arg3)
            return if Boolean.toJSBoolean(arg3.name) and arg3.name == arg2.name.value then true else Boolean.toJSBoolean(arg3.test) and arg3:test(arg2)
        end)
    end
end

local function removeDirectivesFromDocument(arg1, arg2)
    local tbl2 = {}
    local tbl3 = {}

    local tbl4 = {}
    local tbl5 = {}

    local var1 = nullIfDocIsEmpty((visit(arg2, {
        Variable = {
            enter = function(_, arg3, _, arg4)
                if arg4.kind ~= "VariableDefinition" then
                    tbl2[arg3.name.value] = true
                end
                return nil
            end
        },
        Field = {
            enter = function(_, arg3)
                if not (Boolean.toJSBoolean(arg1) and Boolean.toJSBoolean(arg3.directives) and Array.some(arg1, function(arg4)
                    return arg4.remove
                end) and arg3.directives and Array.some(arg3.directives, (getDirectiveMatcher(arg1)))) then
                    return nil
                end

                if arg3.arguments then
                    Array.forEach(arg3.arguments, function(arg4)
                        if arg4.value.kind == "Variable" then
                            table.insert(tbl3, { name = arg4.value.name.value })
                        end
                    end)
                end

                if arg3.selectionSet then
                    Array.forEach(getAllFragmentSpreadsFromSelectionSet(arg3.selectionSet), function(arg4)
                        table.insert(tbl5, { name = arg4.name.value })
                    end)
                end

                return REMOVE
            end
        },
        FragmentSpread = {
            enter = function(_, arg3)
                tbl4[arg3.name.value] = true
            end
        },
        Directive = {
            enter = function(_, arg3)
                return if Boolean.toJSBoolean(getDirectiveMatcher(arg1)(arg3)) then REMOVE else nil
            end
        }
    })))

    if Boolean.toJSBoolean(var1) and Boolean.toJSBoolean(#filterInPlace(tbl3, function(arg3): boolean
        return not not (Boolean.toJSBoolean(arg3.name) and not tbl2[arg3.name])
    end)) then
        var1 = removeArgumentsFromDocument(tbl3, var1)
    end

    if Boolean.toJSBoolean(var1) and Boolean.toJSBoolean(#filterInPlace(tbl5, function(arg3): boolean
        return not not (Boolean.toJSBoolean(arg3.name) and not tbl4[arg3.name])
    end)) then
        var1 = removeFragmentSpreadFromDocument(tbl5, var1)
    end

    return var1
end
module.removeDirectivesFromDocument = removeDirectivesFromDocument

module.addTypenameToDocument = Object.assign(setmetatable({}, {
    __call = function(_, arg1)
        return visit(checkDocument(arg1), {
            SelectionSet = {
                enter = function(_, arg2, _, arg3)
                    if Boolean.toJSBoolean(arg3) and arg3.kind == "OperationDefinition" then
                        return
                    end

                    local selections = arg2.selections
                    if not Boolean.toJSBoolean(selections) or Array.some(selections, function(arg4)
                        return isField(arg4) and (arg4.name.value == "__typename" or String.lastIndexOf(arg4.name.value, "__", 1) == 1)
                    end) or isField(arg3) and Boolean.toJSBoolean(arg3.directives) and Boolean.toJSBoolean(Array.some(arg3.directives, function(arg4): boolean
                        return arg4.name.value == "export"
                    end)) then
                        return
                    end

                    return Object.assign({}, arg2, { selections = Array.concat({}, selections, { tbl1 }) })
                end
            }
        })
    end
}), {
    added = function(_, arg1): boolean
        return arg1 == tbl1
    end
})

local tbl2 = {
    test = function(_, arg1): boolean
        local bool1 = arg1.name.value == "connection"
        if bool1 and (not Boolean.toJSBoolean(arg1.arguments) or Array.some(arg1.arguments, function(arg2): boolean
            return arg2.name.value == "key"
        end)) then
            invariant.warn(
                "Removing an @connection directive even though it does not have a key. You may want to use the key parameter to specify a store key."
            )
        end

        return bool1
    end
}

function module.removeConnectionDirectiveFromDocument(arg1)
    return (removeDirectivesFromDocument({ tbl2 }, checkDocument(arg1)))
end

local function hasDirectivesInSelectionSet(arg1, arg2, bool1: boolean?) -- Luacid: unused: defined but never referenced
    if bool1 == nil then
        bool1 = true
    end

    return if arg2 and arg2.selections then Array.some(arg2.selections, function(arg3)
        return hasDirectivesInSelection(arg1, arg3, bool1)
    end) or false else false
end

hasDirectivesInSelection = function(arg1, arg2, bool1: boolean?)
    if bool1 == nil then
        bool1 = true
    end

    if not isField(arg2) then
        return true
    end

    if not arg2.directives then
        return false
    end

    local var1 = Array.some(arg2.directives, (getDirectiveMatcher(arg1)))

    if not var1 then
        if bool1 then
            local selectionSet = arg2.selectionSet
            local bool2 = bool1

            if bool2 == nil then
                bool2 = true
            end

            var1 = (if selectionSet and selectionSet.selections then Array.some(selectionSet.selections, function(arg3)
                return hasDirectivesInSelection(arg1, arg3, bool2)
            end) or false else false) or false
        else
            var1 = false
        end
    end

    return var1
end

local function getArgumentMatcher(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        return Array.some(arg1, function(tbl3)
            return if arg2.value and arg2.value.kind == "Variable" and arg2.value.name then tbl3.name == arg2.value.name.value or tbl3.test and tbl3.test(tbl3, arg2) or false else false
        end)
    end
end

removeArgumentsFromDocument = function(arg1, arg2)
    local argumentMatcher = getArgumentMatcher(arg1)

    return nullIfDocIsEmpty((visit(arg2, {
        OperationDefinition = {
            enter = function(_, arg3)
                return Object.assign({}, arg3, {
                    variableDefinitions = arg3.variableDefinitions and Array.filter(arg3.variableDefinitions, function(arg4): boolean
                        return not Array.some(arg1, function(arg5): boolean
                            return arg5.name == arg4.variable.name.value
                        end)
                    end) or {}
                })
            end
        },
        Field = {
            enter = function(_, arg3)
                if Array.some(arg1, function(arg4)
                    return arg4.remove
                end) then
                    local num1 = 0
                    if arg3.arguments then
                        Array.forEach(arg3.arguments, function(arg4)
                            if argumentMatcher(arg4) then
                                num1 += 1
                            end
                        end)
                    end

                    if num1 == 1 then
                        return REMOVE
                    end
                end
                return nil
            end
        },
        Argument = {
            enter = function(_, arg3)
                return if Boolean.toJSBoolean(argumentMatcher(arg3)) then REMOVE else nil
            end
        }
    })))
end
module.removeArgumentsFromDocument = removeArgumentsFromDocument

removeFragmentSpreadFromDocument = function(arg1, arg2)
    local function enter(_, arg3)
        return if Array.some(arg1, function(arg4): boolean
            return arg4.name == arg3.name.value
        end) then REMOVE else nil
    end

    return nullIfDocIsEmpty((visit(arg2, { FragmentSpread = { enter = enter }, FragmentDefinition = { enter = enter } })))
end
module.removeFragmentSpreadFromDocument = removeFragmentSpreadFromDocument

getAllFragmentSpreadsFromSelectionSet = function(arg1)
    local allFragmentSpreadsFromSelectionSet = {}
    Array.forEach(arg1.selections, function(arg2)
        if (isField(arg2) or isInlineFragment(arg2)) and arg2.selectionSet then
            Array.forEach(getAllFragmentSpreadsFromSelectionSet(arg2.selectionSet), function(arg3)
                table.insert(allFragmentSpreadsFromSelectionSet, arg3)
            end)
        elseif arg2.kind == "FragmentSpread" then
            table.insert(allFragmentSpreadsFromSelectionSet, arg2)
        end
    end)
    return allFragmentSpreadsFromSelectionSet
end

function module.buildQueryFromSelectionSet(arg1)
    if getMainDefinition(arg1).operation == "query" then
        return arg1
    end

    return (visit(arg1, {
        OperationDefinition = {
            enter = function(_, arg2)
                return Object.assign({}, arg2, { operation = "query" })
            end
        }
    }))
end

function module.removeClientSetsFromDocument(arg1)
    checkDocument(arg1)

    local var1 = removeDirectivesFromDocument({{
        test = function(_, arg2): boolean
            return arg2.name.value == "client"
        end,
        remove = true
    }}, arg1)

    if Boolean.toJSBoolean(var1) then
        var1 = visit(var1, {
            FragmentDefinition = {
                enter = function(_, arg2)
                    if arg2.selectionSet then
                        local var2 = Array.every(arg2.selectionSet.selections, function(arg3)
                            return isField(arg3) and arg3.name.value == "__typename"
                        end)
                        if Boolean.toJSBoolean(var2) then
                            return REMOVE
                        end
                    end
                    return nil
                end
            }
        })
    end

    return var1
end
return module
