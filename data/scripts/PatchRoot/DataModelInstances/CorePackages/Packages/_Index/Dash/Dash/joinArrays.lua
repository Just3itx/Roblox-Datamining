-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function joinArrays(...)
    local result = {}

    for _, value in { ... } do
        if value then
            table.move(value, 1, #value, #result + 1, result)
        end
    end
    return result
end

return joinArrays
