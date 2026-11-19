-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local encodeURIComponent = require(scriptParentParentParent.luaUtils.encodeURIComponent)

local module = {}

local serializeFetchParameter = require(script.Parent.serializeFetchParameter).serializeFetchParameter
local _selectHttpOptionsAndBody = require(script.Parent.selectHttpOptionsAndBody)

function module.rewriteURIForGET(str1: string, arg1)
    local tbl1 = {}
    local function addQueryParam(str2: string, str3: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        table.insert(tbl1, ("%s=%s"):format(str2, encodeURIComponent(str3)))
    end

    if Array.indexOf(Object.keys(arg1), "query") ~= -1 then
        addQueryParam("query", arg1.query)
    end
    if Boolean.toJSBoolean(arg1.operationName) then
        addQueryParam("operationName", arg1.operationName)
    end
    if Boolean.toJSBoolean(arg1.variables) then
        local var1 = nil
        local success, result = pcall(function()
            var1 = serializeFetchParameter(arg1.variables, "Variables map", true)
        end)
        if not success then
            return { parseError = result }
        end

        addQueryParam("variables", var1)
    end
    if Boolean.toJSBoolean(arg1.extensions) then
        local var1 = nil
        local success, result = pcall(function()
            var1 = serializeFetchParameter(arg1.extensions, "Extensions map")
        end)
        if not success then
            return { parseError = result }
        end
        addQueryParam("extensions", var1)
    end

    local var1 = string.find(str1, "#")
    local var2

    if var1 == nil then
        var2 = ""
    else
        var2 = string.sub(str1, var1)
        str1 = string.sub(str1, 1, var1 - 1)
    end

    return {
        newURI = str1 .. (if string.find(str1, "?") == nil then "?" else "&") .. Array.join(tbl1, "&") .. var2
    }
end

return module
