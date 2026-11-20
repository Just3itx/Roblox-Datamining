-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}

local print = require(scriptParentParentParentParent.GraphQL).print

local _types = require(script.Parent.Parent.core.types)

local headersToLowerCase = nil

module.fallbackHttpConfig = {
    http = { includeQuery = true, includeExtensions = false },
    headers = { accept = "*/*", ["content-type"] = "application/json" },
    options = { method = "POST" }
}
function module.selectHttpOptionsAndBody(arg1, tbl1, ...)
    local var1 = Object.assign({}, tbl1.options, { headers = tbl1.headers, credentials = tbl1.credentials })

    local var2 = tbl1.http == nil and {} or tbl1.http

    Array.forEach({ ... }, function(arg2)
        var1 = Object.assign({}, var1, arg2.options, { headers = Object.assign({}, var1.headers, headersToLowerCase(arg2.headers)) })

        if Boolean.toJSBoolean(arg2.credentials) then
            var1.credentials = arg2.credentials
        end

        var2 = Object.assign({}, var2, arg2.http)
    end)

    local operationName = arg1.operationName
    local extensions = arg1.extensions
    local variables = arg1.variables
    local query = arg1.query
    local body = { operationName = operationName, variables = variables }

    if var2.includeExtensions then
        body.extensions = extensions
    end

    if var2.includeQuery then
        body.query = print(query)
    end

    return { options = var1, body = body }
end

headersToLowerCase = function(tbl1)
    if tbl1 == nil then
        return tbl1
    end

    local result = {}
    Array.forEach(Object.keys(tbl1), function(str1: string)
        result[string.lower(str1)] = tbl1[str1]
    end)
    return result
end

return module
