-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local _types = require(script.Parent.Parent.core.types)

local getOperationName = require(script.Parent.Parent.Parent.utilities).getOperationName

function module.transformOperation(arg1)
    local tbl1 = {
        variables = not Boolean.toJSBoolean(arg1.variables) and {} or arg1.variables or {},
        extensions = not Boolean.toJSBoolean(arg1.extensions) and {} or arg1.extensions or {},
        operationName = arg1.operationName,
        query = arg1.query
    }

    if not Boolean.toJSBoolean(tbl1.operationName) then
        if typeof(tbl1.query) ~= "string" then
            tbl1.operationName = if Boolean.toJSBoolean(getOperationName(tbl1.query)) then getOperationName(tbl1.query) or nil else nil
            return tbl1
        end

        tbl1.operationName = ""
    end

    return tbl1
end

return module
