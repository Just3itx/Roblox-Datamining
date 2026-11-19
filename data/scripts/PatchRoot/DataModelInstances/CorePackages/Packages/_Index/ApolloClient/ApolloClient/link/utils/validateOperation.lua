-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local InvariantError = require(scriptParentParentParent.jsutils.invariant).InvariantError

local _types = require(script.Parent.Parent.core.types)

function module.validateOperation<T>(arg1: T): T
    local tbl1 = {
        "query",
        "operationName",
        "variables",
        "extensions",
        "context"
    }

    for _, value in ipairs(Object.keys(arg1)) do
        if Array.indexOf(tbl1, value) < 0 then
            error(InvariantError.new(("illegal argument: %s"):format(value)))
        end
    end

    return arg1
end

return module
