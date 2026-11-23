-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function deduplicateBodyColor3s(tbl1)
    local result = {}
    local tbl2 = ({})

    for _, value in tbl1 do
        local str1 = tostring(value)
        if not tbl2[str1] then
            table.insert(result, value)
            tbl2[str1] = true
        end
    end

    return result
end

local function generateColorSequence(tbl1): ColorSequence
    local tbl2 = deduplicateBodyColor3s(tbl1)
    local num1 = #tbl2

    if num1 == 1 then
        local var1 = tbl2[1]
        return ColorSequence.new(var1, var1)
    end

    local keypoints = {}

    local num2 = 1 / (num1 - 1 + 1.6)

    for value, value2 in tbl2 do
        local var1 = if value == 1 then 0 elseif value == num1 then 1 else (value - 1 + 0.8) * num2

        table.insert(keypoints, ColorSequenceKeypoint.new(var1, value2))
    end
    return ColorSequence.new(keypoints)
end

return generateColorSequence
