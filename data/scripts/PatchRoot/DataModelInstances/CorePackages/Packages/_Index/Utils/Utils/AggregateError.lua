-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local Error = LuauPolyfill.Error

local module = {}

local var1 = (setmetatable({}, { __index = Error }))

var1.__index = var1
function var1.new(errors, str1: string?)
    local self = setmetatable(Error.new(if str1 == nil then "" else str1), var1)

    self.errors = errors

    self.name = "AggregateError"

    Error.captureStackTrace(self, var1.new)

    return self
end

module.AggregateError = setmetatable(var1, {
    __call = function(_, arg1, str1: string?)
        return var1.new(arg1, str1)
    end
})

function module.isAggregateError(arg1)
    return not (Array.indexOf(Object.keys(arg1), "errors") == -1) and Array.isArray(arg1.errors)
end

return module
