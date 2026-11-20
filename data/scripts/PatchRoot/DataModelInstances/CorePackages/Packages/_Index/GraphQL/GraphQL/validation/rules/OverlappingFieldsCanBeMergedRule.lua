-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local null = require(scriptParentParentParent.luaUtils.null)
local jsutils = scriptParentParentParent.jsutils
local language = scriptParentParentParent.language
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local inspect = require(jsutils.inspect).inspect
local Kind = require(language.kinds).Kind
local print = require(language.printer).print
local definition = require(scriptParentParentParent.type.definition)
local getNamedType = definition.getNamedType
local isNonNullType = definition.isNonNullType
local isLeafType = definition.isLeafType
local isObjectType = definition.isObjectType
local isListType = definition.isListType
local isInterfaceType = definition.isInterfaceType
local typeFromAST = require(scriptParentParentParent.utilities.typeFromAST).typeFromAST

local module = {}

local findConflictsWithinSelectionSet = nil
local collectConflictsBetweenFieldsAndFragment = nil
local collectConflictsBetween = nil
local collectConflictsWithin = nil
local collectConflictsBetweenFragments = nil
local getFieldsAndFragmentNames = nil
local getReferencedFieldsAndFragmentNames = nil
local findConflict = nil
local sameArguments = nil
local doTypesConflict = nil
local subfieldConflicts = nil
local var1 = nil

local function reasonMessage(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not Array.isArray(arg1) then
        return arg1
    end

    return table.concat(Array.map(arg1, function(arg2)
        local var2 = arg2[1]
        local var3 = arg2[2]
        return ("subfields \"%s\" conflict because "):format(var2) .. reasonMessage(var3)
    end), " and ")
end

function module.OverlappingFieldsCanBeMergedRule(arg1)
    local var2 = var1.new()

    local tbl1 = {}

    return {
        SelectionSet = function(_, arg2)
            local conflictsWithinSelectionSet = findConflictsWithinSelectionSet(arg1, tbl1, var2, arg1:getParentType(), arg2)

            for _, value in ipairs(conflictsWithinSelectionSet) do
                local var3 = value[1]
                local var4 = var3[1]
                local var5 = var3[2]
                local var6 = value[2]
                local var7 = value[3]
                local var8 = reasonMessage(var5)
                arg1:reportError(
                    GraphQLError.new(
                        ("Fields \"%s\" conflict because %s. Use different aliases on the fields to fetch both if this was intentional."):format(
                            var4,
                            var8
                        ),
                        Array.concat(var6, var7)
                    )
                )
            end
        end
    }
end

findConflictsWithinSelectionSet = function(arg1, arg2, arg3, arg4, arg5)
    local conflictsWithinSelectionSet = {}

    local fieldsAndFragmentNames = getFieldsAndFragmentNames(arg1, arg2, arg4, arg5)

    local var2 = fieldsAndFragmentNames[1]
    local var3 = fieldsAndFragmentNames[2]

    collectConflictsWithin(arg1, conflictsWithinSelectionSet, arg2, arg3, var2)

    if #var3 ~= 0 then
        for i = 1, #var3 do
            collectConflictsBetweenFieldsAndFragment(arg1, conflictsWithinSelectionSet, arg2, arg3, false, var2, var3[i])

            for j = i + 1, #var3 do
                collectConflictsBetweenFragments(arg1, conflictsWithinSelectionSet, arg2, arg3, false, var3[i], var3[j])
            end
        end
    end

    return conflictsWithinSelectionSet
end

collectConflictsBetweenFieldsAndFragment = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    local fragment = arg1:getFragment(arg7)
    if not fragment then
        return
    end

    local referencedFieldsAndFragmentNames = getReferencedFieldsAndFragmentNames(arg1, arg3, fragment)

    local var2 = referencedFieldsAndFragmentNames[1]
    local var3 = referencedFieldsAndFragmentNames[2]

    if arg6 == var2 then
        return
    end

    collectConflictsBetween(arg1, arg2, arg3, arg4, arg5, arg6, var2)

    for i = 1, #var3 do
        collectConflictsBetweenFieldsAndFragment(arg1, arg2, arg3, arg4, arg5, arg6, var3[i])
    end
end

collectConflictsBetweenFragments = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    if arg6 == arg7 or arg4:has(arg6, arg7, arg5) then
        return
    end

    arg4:add(arg6, arg7, arg5)

    local fragment = arg1:getFragment(arg6)
    local fragment2 = arg1:getFragment(arg7)
    if not (fragment and fragment2) then
        return
    end

    local referencedFieldsAndFragmentNames = getReferencedFieldsAndFragmentNames(arg1, arg3, fragment)

    local var2 = referencedFieldsAndFragmentNames[1]
    local var3 = referencedFieldsAndFragmentNames[2]

    local referencedFieldsAndFragmentNames2 = getReferencedFieldsAndFragmentNames(arg1, arg3, fragment2)

    local var4 = referencedFieldsAndFragmentNames2[1]
    local var5 = referencedFieldsAndFragmentNames2[2]

    collectConflictsBetween(arg1, arg2, arg3, arg4, arg5, var2, var4)

    for i = 1, #var5 do
        collectConflictsBetweenFragments(arg1, arg2, arg3, arg4, arg5, arg6, var5[i])
    end

    for i = 1, #var3 do
        collectConflictsBetweenFragments(arg1, arg2, arg3, arg4, arg5, var3[i], arg7)
    end
end

local function findConflictsBetweenSubSelectionSets(arg1, arg2, arg3, arg4, arg5, selectionSet, arg6, selectionSet2)
    local conflictsBetweenSubSelectionSets = {}

    local fieldsAndFragmentNames = getFieldsAndFragmentNames(arg1, arg2, arg5, selectionSet)

    local var2 = fieldsAndFragmentNames[1]
    local var3 = fieldsAndFragmentNames[2]

    local fieldsAndFragmentNames2 = getFieldsAndFragmentNames(arg1, arg2, arg6, selectionSet2)

    local var4 = fieldsAndFragmentNames2[1]
    local var5 = fieldsAndFragmentNames2[2]

    collectConflictsBetween(arg1, conflictsBetweenSubSelectionSets, arg2, arg3, arg4, var2, var4)

    if #var5 ~= 0 then
        for i = 1, #var5 do
            collectConflictsBetweenFieldsAndFragment(arg1, conflictsBetweenSubSelectionSets, arg2, arg3, arg4, var2, var5[i])
        end
    end

    if #var3 ~= 0 then
        for i = 1, #var3 do
            collectConflictsBetweenFieldsAndFragment(arg1, conflictsBetweenSubSelectionSets, arg2, arg3, arg4, var4, var3[i])
        end
    end

    for i = 1, #var3 do
        for j = 1, #var5 do
            collectConflictsBetweenFragments(arg1, conflictsBetweenSubSelectionSets, arg2, arg3, arg4, var3[i], var5[j])
        end
    end

    return conflictsBetweenSubSelectionSets
end

collectConflictsWithin = function(arg1, tbl1: {any}, arg2, arg3, arg4)
    for _, value in arg4 do
        local var2 = value[1]
        local var3 = value[2]

        if not (#var3 > 1) then
            continue
        end

        for i = 1, #var3 do
            for j = i + 1, #var3 do
                local conflict = findConflict(arg1, arg2, arg3, false, var2, var3[i], var3[j])

                if conflict then
                    table.insert(tbl1, conflict)
                end
            end
        end
    end
end

collectConflictsBetween = function(arg1, tbl1: {any}, arg2, arg3, arg4, arg5, arg6)
    for _, value in ipairs(arg5:keys()) do
        local var2 = arg6[value]
        if not var2 then
            continue
        end

        local var3 = arg5[value]
        for i = 1, #var3 do
            for j = 1, #var2 do
                local conflict = findConflict(arg1, arg2, arg3, arg4, value, var3[i], var2[j])

                if conflict then
                    table.insert(tbl1, conflict)
                end
            end
        end
    end
end

findConflict = function(arg1, arg2, arg3, bool1: boolean, str1: string, arg4, arg5)
    local var2 = arg4[1]
    local var3 = arg4[2]
    local var4 = arg4[3]
    local var5 = arg5[1]
    local var6 = arg5[2]
    local var7 = arg5[3]

    if not bool1 then
        if var2 == var5 then
            bool1 = false
        else
            bool1 = isObjectType(var2) and isObjectType(var5)
        end
    end

    if not bool1 then
        local value = var3.name.value
        local value2 = var6.name.value
        if value ~= value2 then
            return {
                { str1, ("\"%s\" and \"%s\" are different fields"):format(value, value2) },
                { var3 },
                { var6 }
            }
        end

        local var8 = var3.arguments or {}

        local var9 = var6.arguments or {}

        if not sameArguments(var8, var9) then
            return {
                { str1, "they have differing arguments" },
                { var3 },
                { var6 }
            }
        end
    end

    local type = var4 and var4.type
    local type2 = var7 and var7.type

    if not (type and type2 and doTypesConflict(type, type2)) then
        local selectionSet = var3.selectionSet
        local selectionSet2 = var6.selectionSet
        if not (selectionSet and selectionSet2) then
            return nil
        end

        local conflictsBetweenSubSelectionSets = findConflictsBetweenSubSelectionSets(
            arg1,
            arg2,
            arg3,
            bool1,
            getNamedType(type),
            selectionSet,
            getNamedType(type2),
            selectionSet2
        )

        return subfieldConflicts(conflictsBetweenSubSelectionSets, str1, var3, var6)
    end

    return {
        { str1, ("they return conflicting types \"%s\" and \"%s\""):format(inspect(type), inspect(type2)) },
        { var3 },
        { var6 }
    }
end

local sameValue = nil
local _collectFieldsAndFragmentNames = nil

sameArguments = function(arg1, arg2)
    if #arg1 ~= #arg2 then
        return false
    end
    return Array.every(arg1, function(arg3)
        local var2 = Array.find(arg2, function(arg4): boolean
            return arg4.name.value == arg3.name.value
        end)
        if not var2 then
            return false
        end
        return sameValue(arg3.value, var2.value)
    end)
end

sameValue = function(arg1, arg2): boolean
    return print(arg1) == print(arg2)
end

doTypesConflict = function(arg1, arg2)
    if isListType(arg1) then
        if isListType(arg2) then
            return doTypesConflict(arg1.ofType, arg2.ofType)
        end
        return true
    elseif isListType(arg2) then
        return true
    elseif isNonNullType(arg1) then
        if isNonNullType(arg2) then
            return doTypesConflict(arg1.ofType, arg2.ofType)
        end
        return true
    else
        return if isNonNullType(arg2) then true elseif isLeafType(arg1) or isLeafType(arg2) then arg1 ~= arg2 else false
    end
end

getFieldsAndFragmentNames = function(arg1, arg2, arg3, arg4)
    local tbl1 = arg2[arg4]
    if not tbl1 then
        local map = Map.new()
        local tbl2 = {}
        _collectFieldsAndFragmentNames(arg1, arg3, arg4, map, tbl2)

        tbl1 = { map, Object.keys(tbl2) }
        arg2[arg4] = tbl1
    end

    return tbl1
end

getReferencedFieldsAndFragmentNames = function(arg1, arg2, arg3)
    local var2 = arg2[arg3.selectionSet]
    if var2 then
        return var2
    end

    local var3 = typeFromAST(arg1:getSchema(), arg3.typeCondition)
    return getFieldsAndFragmentNames(arg1, arg2, var3, arg3.selectionSet)
end

_collectFieldsAndFragmentNames = function(arg1, arg2, arg3, arg4, arg5)
    for _, selection in ipairs(arg3.selections) do
        local kind = selection.kind
        if kind == Kind.FIELD then
            local value = selection.name.value
            local var2 = if isObjectType(arg2) or isInterfaceType(arg2) then arg2:getFields():get(value) else nil

            if selection.alias then
                value = selection.alias.value
            end

            if not arg4[value] then
                arg4[value] = {}
            end

            table.insert(arg4[value], { arg2 or null, selection or null, var2 or null })
        elseif kind == Kind.FRAGMENT_SPREAD then
            arg5[selection.name.value] = true
        elseif kind == Kind.INLINE_FRAGMENT then
            local typeCondition = selection.typeCondition
            local var2 = if typeCondition then typeFromAST(arg1:getSchema(), typeCondition) else arg2
            _collectFieldsAndFragmentNames(arg1, var2, selection.selectionSet, arg4, arg5)
        end
    end
end

subfieldConflicts = function(arg1, str1: string, arg2, arg3)
    if not (#arg1 > 0) then
        return nil
    end

    return {
        {
            str1,
            Array.map(arg1, function<T>(tbl1: {T}): T
                return tbl1[1]
            end)
        },
        Array.reduce(arg1, function(arg4, arg5)
            local var2 = arg5[2]
            return Array.concat(arg4, var2)
        end, { arg2 }),
        Array.reduce(arg1, function(arg4, arg5)
            local var2 = arg5[3]
            return Array.concat(arg4, var2)
        end, { arg3 })
    }
end

var1 = {}
local tbl1 = { __index = var1 }

function var1.new()
    local self = (setmetatable({}, tbl1))
    self._data = {}
    return self
end

function var1:has(str1: string, str2: string, bool1: boolean): boolean
    local var2 = self._data[str1]
    local var3 = var2 and var2[str2]
    return not (var3 == nil) and (not (bool1 == false) or var3 == false)
end

function var1.add(tbl2, str1: string, str2: string, bool1: boolean)
    tbl2:_pairSetAdd(str1, str2, bool1)
    tbl2:_pairSetAdd(str2, str1, bool1)
end

function var1:_pairSetAdd(str1: string, str2: string, bool1: boolean)
    local tbl2 = self._data[str1]

    if not tbl2 then
        tbl2 = {}
        self._data[str1] = tbl2
    end

    tbl2[str2] = bool1
end

return module
