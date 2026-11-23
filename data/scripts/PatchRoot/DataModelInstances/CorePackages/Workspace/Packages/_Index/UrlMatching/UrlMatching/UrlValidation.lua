-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Regex = require(script.Parent.Regex)
local RegExp = require(scriptParentParent.RegExp)

local StringUtilities = require(scriptParentParent.StringUtilities)
local StringSplit = StringUtilities.StringSplit
local StringTrim = StringUtilities.StringTrim
local ParseQuery = StringUtilities.ParseQuery

local FFlagAppChatEarlyTestingLinks = require(scriptParentParent.SharedFlags).FFlagAppChatEarlyTestingLinks

local _Types = require(script.Parent.Types)

local function filterParams(tbl1, optional: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    return Cryo.List.filter(tbl1, function(arg1): boolean
        return arg1.optional == optional or not optional and arg1.optional == nil
    end)
end

local function requiredParams(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return filterParams(tbl1, false)
end

local function optionalParams(tbl1) -- Luacid: unused: defined but never referenced
    return filterParams(tbl1, true)
end

local function mapValidToArgName(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local var1 = Regex.matchWhole(Regex.oneOrMore(arg1.pattern))
        local var2 = tbl1[arg1.name]

        if FFlagAppChatEarlyTestingLinks and type(var2) ~= "string" then
            return nil
        end

        if var2 == nil or not RegExp(var1):exec(var2) then
            return nil
        end

        return arg1.name
    end
end

local function validateParams(tbl1, tbl2)
    local tbl3 = tbl1 or {}
    local var1 = filterParams(tbl2, false)
    local func1 = mapValidToArgName(tbl3)
    local var2 = Cryo.List.filterMap(var1, func1)
    if #var2 ~= #var1 then
        return false, {}
    end

    local var3 = filterParams(tbl2, true)

    local var4 = Cryo.List.filterMap(var3, func1)
    local var5 = Cryo.List.join(var2, var4)
    local var6 = Cryo.List.toSet(var5)
    return true, (Cryo.Dictionary.filter(tbl3, function(_, arg1): boolean
        return var6[arg1] ~= nil
    end))
end

local function validatePathParams(tbl1, tbl2)
    if #tbl1 < #requiredParams(tbl2) then
        return false, {}
    end

    local var1 = Cryo.Dictionary.map(tbl2, function(arg1, arg2)
        return tbl1[arg2], arg1.name
    end)
    return validateParams(var1, tbl2)
end

local function validateUrlParams(arg1, arg2)
    local var1 = if arg1.path then StringTrim(arg1.path, "/") else ""
    local var2 = var1 == "" and {} or StringSplit(var1, "/")

    local var3 = ParseQuery(arg1.query)
    local var4 = Cryo.Dictionary.map(var3, function(arg3)
        return if #arg3 == 1 then arg3[1] else arg3
    end)

    local bool1, var5 = validatePathParams(var2, arg2.pathParams or {})
    if not bool1 then
        return false, {}
    end

    local bool2, var6 = validateParams(var4, arg2.queryParams or {})
    if not bool2 then
        return false, {}
    end

    return true, Cryo.Dictionary.union(var5, var6)
end

return {
    validateUrlMatch = function(arg1, arg2)
        for value, value2 in arg2 do
            if not RegExp(value, "i"):test(arg1.matchedPath) then
                continue
            end

            local bool1, var1 = validateUrlParams(arg1.url, value2)
            if bool1 then
                return bool1, value2.paramCallback(var1)
            end
        end

        return false, nil
    end,
    validateUrlParams = validateUrlParams
}
