-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1)
    if typeof(arg1) ~= "table" then
        return false
    end
    if next(arg1) == nil then
        return true
    end

    if #arg1 == 0 then
        return false
    end

    local num1 = 0
    local num2 = 0
    for k in pairs(arg1) do
        if typeof(k) ~= "number" then
            return false
        end
        if k % 1 ~= 0 or k < 1 then
            return false
        end
        num1 += 1
        num2 += k
    end

    return num2 == num1 * (num1 + 1) / 2
end
