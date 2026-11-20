-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Shared = require(scriptParentParent.Shared)

local invariant = require(scriptParentParent.Shared).invariant

local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE

local Array = require(scriptParentParent.LuauPolyfill).Array

local ReactElement = require(script.Parent.ReactElement)
local isValidElement = ReactElement.isValidElement
local cloneAndReplaceKey = ReactElement.cloneAndReplaceKey

local function escape(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = string.gsub(str1, "=", "=0")
    return "$" .. string.gsub(var1, ":", "=2")
end

local function escapeUserProvidedKey(str1: string): string -- Luacid: unused: defined but never referenced
    return str1
end

local function getElementKey(arg1, num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(arg1) ~= "table" or arg1 == nil or arg1.key == nil then
        return tostring(num1)
    end

    local key = arg1.key
    return escape(tostring(key))
end

local function mapIntoArray(arg1, tbl1: {any}, str1: string, str2: string, func1: (...any) -> (...any))
    local str3 = typeof(arg1)

    if str3 == "nil" or str3 == "boolean" or str3 == "userdata" then
        arg1 = nil
    end

    local bool1 = false

    if arg1 == nil or str3 == "string" or str3 == "number" then
        bool1 = true
    elseif str3 == "table" then
        local typeof = arg1["$$typeof"]

        if typeof == REACT_ELEMENT_TYPE or typeof == REACT_PORTAL_TYPE then
            bool1 = true
        end
    end

    if bool1 then
        local var1 = func1(arg1)

        if str2 == "" then
            str2 = "." .. getElementKey(arg1, 1)
        end
        if Array.isArray(var1) then
            local var2 = if str2 == nil then "" else str2 .. "/"

            mapIntoArray(var1, tbl1, var2, "", function<T>(arg2: T): T
                return arg2
            end)
        elseif var1 ~= nil then
            if isValidElement(var1) then
                local key = var1.key
                var1 = cloneAndReplaceKey(var1, str1 .. (if not key or arg1 and arg1.key == key then "" else tostring(key) .. "/") .. str2)
            end

            table.insert(tbl1, var1)
        end
        return 1
    end

    local num1 = 0
    local str4 = if str2 == "" then "." else str2 .. ":"

    if Array.isArray(arg1) then
        for i = 1, #arg1 do
            local var1 = arg1[i]
            local var2 = str4 .. getElementKey(var1, i)

            num1 += mapIntoArray(var1, tbl1, str1, var2, func1)
        end

        return num1
    end

    local iteratorFn = getIteratorFn(arg1)
    if typeof(iteratorFn) == "function" then
        local var1 = iteratorFn(arg1)

        local var2 = var1.next()
        local num2 = 1

        while not var2.done do
            local value = var2.value
            local var3 = str4 .. getElementKey(value, num2)

            num2 += 1
            num1 += mapIntoArray(value, tbl1, str1, var3, func1)

            var2 = var1.next()
        end
    end

    return num1
end

local function mapChildren(arg1, func1: (...any) -> (...any), _)
    if arg1 == nil then
        return nil
    end
    local result = {}
    local num1 = 1
    mapIntoArray(arg1, result, "", "", function(arg2)
        local var1 = func1(arg2, num1)
        num1 += 1
        return var1
    end)
    return result
end

return {
    forEach = function(arg1, callback: (...any) -> (...any), arg2) -- name: forEachChildren
        mapChildren(arg1, function(...)
            callback(...)
        end, arg2)
    end,
    map = mapChildren,
    count = function(arg1): number -- name: countChildren
        local num1 = 0
        mapChildren(arg1, function()
            num1 += 1
        end)

        return num1
    end,
    only = function<T>(arg1: T): T -- name: onlyChild
        invariant(isValidElement(arg1), "React.Children.only expected to receive a single React element child.")

        return arg1
    end,
    toArray = function(arg1)
        return mapChildren(arg1, function<T>(arg2: T): T
            return arg2
        end) or {}
    end
}
