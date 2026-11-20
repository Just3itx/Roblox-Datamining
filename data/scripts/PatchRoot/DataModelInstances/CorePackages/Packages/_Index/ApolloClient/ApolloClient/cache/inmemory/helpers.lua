-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local LuauRegExp = require(scriptParentParentParentParent.LuauRegExp)

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local _types = require(script.Parent.types)

local utilities = require(scriptParentParentParent.utilities)

local isReference = utilities.isReference

local isField = utilities.isField
local DeepMerger = utilities.DeepMerger
local resultKeyNameFromFieldf = utilities.resultKeyNameFromFieldf
local shouldInclude = utilities.shouldInclude
local isNonNullObject = utilities.isNonNullObject

local module = {}

local hasOwnProperty = require(scriptParentParentParent.luaUtils.hasOwnProperty)
module.hasOwn = hasOwnProperty

function module.getTypenameFromStoreObject(arg1, arg2)
    if isReference(arg2) then
        return (arg1:get(arg2.__ref, "__typename"))
    end

    return if arg2 then arg2.__typename else nil
end

module.TypeOrFieldNameRegExp = LuauRegExp("^[_a-zA-Z][_0-9a-zA-Z]*", "i")

local tbl1 = ({})

function module.fieldNameFromStoreName(str1: string)
    if tbl1[str1] then
        return tbl1[str1]
    end
    local var1 = string.match(str1, "^[_a-zA-Z][_0-9a-zA-Z]*") or str1
    tbl1[str1] = var1
    return var1
end

local function selectionSetMatchesResult(arg1, tbl2, tbl3)
    if not isNonNullObject(tbl2) then
        return false
    end

    if Array.isArray(tbl2) then
        return Array.every(tbl2, function(arg2)
            return selectionSetMatchesResult(arg1, arg2, tbl3)
        end)
    end
    return Array.every(arg1.selections, function(arg2)
        if not (isField(arg2) and shouldInclude(arg2, tbl3)) then
            return true
        end

        local var1 = resultKeyNameFromFieldf(arg2)

        return hasOwnProperty(tbl2, var1) and (not arg2.selectionSet or selectionSetMatchesResult(arg2.selectionSet, tbl2[var1], tbl3))
    end)
end

module.selectionSetMatchesResult = selectionSetMatchesResult

function module.storeValueIsStoreObject(arg1)
    return isNonNullObject(arg1) and not (isReference(arg1) or Array.isArray(arg1))
end

function module.makeProcessedFieldsMerger()
    return DeepMerger.new()
end
return module
