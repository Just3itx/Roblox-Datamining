-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local HttpService = game:GetService("HttpService")

function sortedEncode(input)
    if Array.isArray(input) or typeof(input) ~= "table" then
        return HttpService:JSONEncode(input)
    end

    local var1 = Array.map(Array.sort(Object.keys(input)), function(input2)
        return HttpService:JSONEncode(input2) .. ":" .. sortedEncode(input[input2])
    end)
    return "{" .. Array.join(var1, ",") .. "}"
end

return {
    sortedEncode = sortedEncode
}
