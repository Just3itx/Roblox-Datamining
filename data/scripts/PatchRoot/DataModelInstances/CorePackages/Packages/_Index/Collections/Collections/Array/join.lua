-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

local map = require(scriptParent.map)

return function(arg1, str1: string?): string
    if #arg1 == 0 then
        return ""
    end

    local var1 = map(arg1, function(arg2): string
        return tostring(arg2)
    end)

    return table.concat(var1, str1 or ",")
end
