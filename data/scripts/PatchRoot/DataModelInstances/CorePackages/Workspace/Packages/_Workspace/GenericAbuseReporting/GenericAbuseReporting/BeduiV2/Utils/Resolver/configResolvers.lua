-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _ResolverTypes = require(script.Parent.ResolverTypes)
local transformJsonLeafFirst = require(script.Parent.transformJsonLeafFirst)
local _Types = require(GenericAbuseReporting.BeduiV2.Types)

local function getByPath(arg1, str1: string)
    local tbl1 = string.split(str1, ".")

    for _, value in ipairs(tbl1) do
        if type(arg1) ~= "table" or arg1 == nil then
            return nil
        end

        arg1 = arg1[value]
        if arg1 == nil then
            return nil
        end
    end
    return arg1
end

local function isTruthy(condition): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (condition == nil or condition == false) and condition ~= ""
end

local tbl1 = {
    ["$attribute"] = {
        is = function(arg1): boolean
            return type(arg1) == "table" and arg1["$attribute"] ~= nil and type(arg1["$attribute"]) == "string"
        end,
        resolve = function(arg1, tbl1)
            return (getByPath(tbl1.attribute, arg1["$attribute"]))
        end
    },
    ["$resource"] = {
        is = function(arg1): boolean
            return type(arg1) == "table" and arg1["$resource"] ~= nil and type(arg1["$resource"]) == "string"
        end,
        resolve = function(arg1, tbl1)
            local var1 = tbl1.resources[arg1["$resource"]]
            return if var1 then var1.value else nil
        end
    },
    ["$switch"] = {
        is = function(arg1): boolean
            return type(arg1) == "table" and arg1["$switch"] ~= nil and type(arg1["$switch"]) == "table"
        end,
        resolve = function(arg1, _)
            for _, value in ipairs(arg1["$switch"]) do
                if type(value) == "string" then
                    return value
                end

                if type(value) == "table" and value.condition and isTruthy(value.condition) then
                    return value.value
                end
            end

            return nil
        end
    },
    ["$store"] = {
        is = function(arg1): boolean
            return type(arg1) == "table" and arg1["$store"] ~= nil and type(arg1["$store"]) == "string"
        end,
        resolve = function(arg1, tbl1)
            return (getByPath(tbl1.store, arg1["$store"]))
        end
    }
}

local function resolveConfig(arg1, tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (transformJsonLeafFirst(arg1, function(arg2) -- name: replacerFn
        if type(arg2) == "table" then
            if tbl1["$attribute"].is(arg2) then
                return tbl1["$attribute"].resolve(arg2, tbl2)
            end

            if tbl1["$resource"].is(arg2) then
                return tbl1["$resource"].resolve(arg2, tbl2)
            end

            if tbl1["$switch"].is(arg2) then
                return tbl1["$switch"].resolve(arg2, tbl2)
            end

            if tbl1["$store"].is(arg2) then
                return tbl1["$store"].resolve(arg2, tbl2)
            end
        end
        return arg2
    end))
end

return {
    resolveArConfig = function(arg1, tbl2)
        local resources = resolveConfig(arg1.resources, { attribute = arg1.attributes, resources = {}, store = tbl2.store })
        return (resolveConfig(arg1, { attribute = arg1.attributes, resources = resources, store = tbl2.store }))
    end,
    resolveConfig = resolveConfig
}
