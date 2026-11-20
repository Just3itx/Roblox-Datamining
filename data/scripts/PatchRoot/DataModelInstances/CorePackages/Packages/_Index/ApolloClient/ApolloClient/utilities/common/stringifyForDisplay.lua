-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local String = LuauPolyfill.String

local HttpService = game:GetService("HttpService")

local makeUniqueId = require(script.Parent.makeUniqueId).makeUniqueId

function replaceUndefined(arg1, arg2)
    if not Array.isArray(arg1) then
        return arg1
    end
    local result = {}
    for i = 1, #arg1 do
        if arg1[i] == nil then
            table.insert(result, arg2)
        else
            table.insert(result, arg1[i])
        end
    end
    return result
end

function module.stringifyForDisplay(arg1)
    local uniqueId = makeUniqueId("stringifyForDisplay")

    return Array.join(
        String.split(HttpService:JSONEncode(replaceUndefined(arg1, uniqueId)), HttpService:JSONEncode(uniqueId)),
        "<undefined>"
    )
end

return module
