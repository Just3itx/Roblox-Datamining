-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function calculateRowOnPage(num1: number, arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 and typeof(arg1) == "number" then arg1 + num1 - 1 else -1
end

local function calculateRowPositionFields(arg1, arg2, arg3)
    if not arg1 or typeof(arg1) ~= "number" or arg1 <= 0 or not arg2 or typeof(arg2) ~= "number" or arg2 <= 0 then
        return { positionInRow = -1, rowInSort = -1, rowOnPage = -1 }
    end

    local positionInRow = (arg1 - 1) % arg2 + 1

    local rowInSort = math.ceil(arg1 / arg2)

    return {
        positionInRow = positionInRow,
        rowInSort = rowInSort,
        rowOnPage = calculateRowOnPage(rowInSort, arg3)
    }
end

return calculateRowPositionFields
