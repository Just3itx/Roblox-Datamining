-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatNumberWithShortUnits(num1: number)
    local num2 = math.abs(num1)
    local var1

    if num2 >= 1000000000 then
        local num3 = num1 / 1000000000
        var1 = ("%.0fB"):format(math.floor(num3))
    elseif num2 >= 1000000 then
        if num2 >= 100000000 then
            local num3 = num1 / 1000000
            var1 = ("%.0fM"):format(math.floor(num3))
        else
            var1 = ("%.1fM"):format(num1 / 1000000)
        end
    elseif num2 >= 1000 then
        if num2 >= 100000 then
            local num3 = num1 / 1000
            var1 = ("%.0fK"):format(math.floor(num3))
        else
            var1 = ("%.1fK"):format(num1 / 1000)
        end
    else
        var1 = tostring(num1)
    end

    local var2, var3 = var1:match("(%d+)%.0(%w+)")
    if var2 and var3 then
        var1 = var2 .. var3
    end

    return var1
end

return formatNumberWithShortUnits
