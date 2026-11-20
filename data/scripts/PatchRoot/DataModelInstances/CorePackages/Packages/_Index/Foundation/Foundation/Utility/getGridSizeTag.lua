-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local _Types = require(Foundation.Components.Types)

local function getGridSizeTag(arg1): string
    if typeof(arg1) == "number" then
        return `col-{arg1}`
    end
    local tbl1 = {}

    for value, value2 in arg1 do
        if typeof(value2) == "number" then
            table.insert(tbl1, `{value}-col-{value2}`)
        end
    end
    return table.concat(tbl1, " ")
end

return getGridSizeTag
