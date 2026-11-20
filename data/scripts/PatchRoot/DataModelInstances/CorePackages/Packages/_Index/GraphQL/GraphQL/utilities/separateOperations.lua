-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Set = LuauPolyfill.Set

local _ObjMap = require(scriptParentParent.jsutils.ObjMap)

local _ast = require(scriptParentParent.language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind
local visit = require(scriptParentParent.language.visitor).visit

local collectDependencies = nil
local collectTransitiveDependencies = nil

local function separateOperations(arg1)
    local tbl1 = {}
    local tbl2 = {}

    for _, definition in pairs(arg1.definitions) do
        local kind = definition.kind
        if kind == Kind.OPERATION_DEFINITION then
            table.insert(tbl1, definition)
        elseif kind == Kind.FRAGMENT_DEFINITION then
            tbl2[definition.name.value] = collectDependencies(definition.selectionSet)
        end
    end

    local result = ({})
    for _, value in pairs(tbl1) do
        local set = Set.new()

        for _, value2 in pairs(collectDependencies(value.selectionSet)) do
            collectTransitiveDependencies(set, tbl2, value2)
        end

        local value2 = value.name and value.name.value or ""

        result[value2] = {
            kind = Kind.DOCUMENT,
            definitions = Array.filter(arg1.definitions, function(arg2)
                return arg2 == value or arg2.kind == Kind.FRAGMENT_DEFINITION and set:has(arg2.name.value)
            end)
        }
    end

    return result
end

collectTransitiveDependencies = function(arg1, arg2, str1: string)
    if arg1:has(str1) then
        return
    end

    arg1:add(str1)

    local var1 = arg2[str1]
    if var1 == nil then
        return
    end

    for _, value in pairs(var1) do
        collectTransitiveDependencies(arg1, arg2, value)
    end
end

collectDependencies = function(arg1)
    local result = {}

    visit(arg1, {
        FragmentSpread = function(_, arg2)
            table.insert(result, arg2.name.value)
        end
    })

    return result
end

return { separateOperations = separateOperations }
