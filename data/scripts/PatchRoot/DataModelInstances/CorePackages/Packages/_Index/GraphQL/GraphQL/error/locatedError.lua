-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local instanceof = LuauPolyfill.instanceof

local inspect = require(scriptParentParent.jsutils.inspect).inspect

local _ast = require(scriptParentParent.language.ast)

local GraphQLError = require(scriptParent.GraphQLError).GraphQLError

return {
    locatedError = function(arg1, arg2, arg3)
        if not instanceof(arg1, Error) then
            if typeof(arg1) == "table" and typeof(arg1.message) == "string" and arg1.stack ~= nil then
                arg1 = Error.new(arg1.message)
            elseif typeof(arg1) == "table" and typeof(arg1.error) == "string" then
                arg1 = Error.new("Unexpected error value: " .. inspect(arg1.error))
            else
                arg1 = Error.new("Unexpected error value: " .. inspect(arg1))
            end
        end

        if Array.isArray(arg1.path) then
            return arg1
        end

        return (GraphQLError.new(arg1.message, arg1.nodes or arg2, arg1.source, arg1.positions, arg3, arg1))
    end
}
