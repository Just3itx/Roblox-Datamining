-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _LeaderboardStore = require(scriptParentParentParent.LeaderboardStore)

local function computeStatColumns(arg1, num1: number)
    if not arg1 then
        return {}
    end

    local tbl1 = {}
    arg1.iterateData(function(name, arg3)
        table.insert(tbl1, { name = name, order = arg3.order(false) })
    end, false)

    table.sort(tbl1, function(arg2, arg3): boolean
        return arg2.order < arg3.order
    end)

    local result = {}
    for i, value in ipairs(tbl1) do
        if num1 < i then
            break
        end

        table.insert(result, { name = value.name, order = value.order })
    end

    return result
end

return computeStatColumns
