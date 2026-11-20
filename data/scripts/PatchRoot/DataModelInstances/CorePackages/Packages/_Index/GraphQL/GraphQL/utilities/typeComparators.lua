-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local definition = require(scriptParentParent.type.definition)
local isInterfaceType = definition.isInterfaceType
local isObjectType = definition.isObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType
local isAbstractType = definition.isAbstractType

local function isEqualType(arg1, arg2)
    if arg1 == arg2 then
        return true
    elseif isNonNullType(arg1) and isNonNullType(arg2) or isListType(arg1) and isListType(arg2) then
        return isEqualType(arg1.ofType, arg2.ofType)
    end

    return false
end

local function isTypeSubTypeOf(arg1, arg2, arg3)
    if arg2 == arg3 then
        return true
    elseif isNonNullType(arg3) then
        if isNonNullType(arg2) then
            return isTypeSubTypeOf(arg1, arg2.ofType, arg3.ofType)
        end

        return false
    elseif isNonNullType(arg2) then
        return isTypeSubTypeOf(arg1, arg2.ofType, arg3)
    elseif isListType(arg3) then
        if isListType(arg2) then
            return isTypeSubTypeOf(arg1, arg2.ofType, arg3.ofType)
        end

        return false
    else
        return not isListType(arg2)
            and isAbstractType(arg3)
            and (isInterfaceType(arg2) or isObjectType(arg2))
            and arg1:isSubType(arg3, arg2)
    end
end

return {
    isEqualType = isEqualType,
    isTypeSubTypeOf = isTypeSubTypeOf,
    doTypesOverlap = function(arg1, arg2, arg3)
        if arg2 == arg3 then
            return true
        elseif isAbstractType(arg2) then
            if isAbstractType(arg3) then
                return Array.some(arg1:getPossibleTypes(arg2), function(arg4)
                    return arg1:isSubType(arg3, arg4)
                end)
            end

            return arg1:isSubType(arg2, arg3)
        elseif isAbstractType(arg3) then
            return arg1:isSubType(arg3, arg2)
        else
            return false
        end
    end
}
