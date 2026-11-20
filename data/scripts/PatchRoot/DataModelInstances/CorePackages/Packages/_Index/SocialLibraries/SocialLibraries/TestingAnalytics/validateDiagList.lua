-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local llama = dependencies.llama
local isEnum = require(script.Parent.Parent.Utils.isEnum)
local t = dependencies.t
local formatKeyValidationError = require(script.Parent.formatKeyValidationError)
local var1 = require(script.Parent.formatErrorForIncorrectKey)(t.strictInterface({ name = t.any, counter = t.optional(t.any) }))

return function(arg1): boolean
    llama.Dictionary.map(arg1, function(arg2, arg3)
        if isEnum(arg3) then
            arg3 = arg3.rawValue()
        end
        assert(type(arg2.name) == "string", formatKeyValidationError("name", "a string", arg3))
        assert(
            type(arg2.counter) == "number" or arg2.counter == nil,
            formatKeyValidationError("counter", "nil or a number", arg3)
        )
        assert(var1(arg2, arg3))
    end)

    return true
end
