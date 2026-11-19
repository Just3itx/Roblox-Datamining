-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1)
    assert(arg1 ~= nil, "cannot get entries from a nil value")
    local str1 = typeof(arg1)

    local result = ({})
    if str1 == "table" then
        for k, value in pairs(arg1) do
            table.insert(result, { k, value })
        end

        return result
    end
    if str1 == "string" then
        for i = 1, string.len(arg1) do
            result[i] = { tostring(i), string.sub(arg1, i, i) }
        end
    end

    return result
end
