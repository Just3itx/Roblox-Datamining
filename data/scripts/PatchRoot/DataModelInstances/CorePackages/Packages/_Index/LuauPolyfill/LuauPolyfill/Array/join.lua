-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:22Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

local map = require(script.Parent.map)

return function(arg1, str1: string?): string
    if #arg1 == 0 then
        return ""
    end

    local var1 = map(arg1, function(arg2): string
        return tostring(arg2)
    end)

    return table.concat(var1, str1 or ",")
end
