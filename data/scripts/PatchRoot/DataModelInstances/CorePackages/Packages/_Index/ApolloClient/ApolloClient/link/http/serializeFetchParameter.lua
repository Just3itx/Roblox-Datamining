-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Error = LuauPolyfill.Error
local Array = LuauPolyfill.Array

local HttpService = game:GetService("HttpService")

local module = {}

local InvariantError = require(scriptParentParentParent.jsutils.invariant).InvariantError

function module.serializeFetchParameter(input, str1: string, bool1: boolean?)
    local var1 = nil
    local success, result = pcall(function()
        if Array.isArray(input) and #input == 0 and bool1 then
            var1 = "{}"
            return
        end

        var1 = HttpService:JSONEncode(input)
    end)

    if not success then
        local invariantError = InvariantError.new(("Network request failed. %s is not serializable: %s"):format(str1, result))

        invariantError.parseError = Error.new(result)
        error(invariantError)
    end
    return var1
end
return module
