-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.get(arg1)
    local success, result = pcall(function()
        return arg1:GetUIScaleOptions()
    end)
    return if success then result else nil
end

function module.optionId(num1: number, num2: number): string
    return `{num1}:{num2}`
end

function module.valueFromOption(str1: string, tbl1): number?
    local var1, var2 = string.match(str1, "^(%d+):(%d+)$")
    local var3 = tonumber(var1)
    local var4 = tonumber(var2)
    return if var3 and tbl1.enabled[var3] and tbl1.values[var3] == var4 then var4 else nil
end

function module.equal(tbl1, tbl2)
    if tbl1.savedHundredths ~= tbl2.savedHundredths
        or tbl1.autoHundredths ~= tbl2.autoHundredths
        or tbl1.selectedIndex ~= tbl2.selectedIndex
        or tbl1.defaultIndex ~= tbl2.defaultIndex
        or #tbl1.values ~= #tbl2.values
    then
        return false
    end
    for value, value2 in tbl1.values do
        if value2 ~= tbl2.values[value] or tbl1.enabled[value] ~= tbl2.enabled[value] then
            return false
        end
    end
    return true
end

function module.valueForMode(tbl1, bool1: boolean)
    if bool1 == (tbl1.savedHundredths ~= 0) then
        return nil
    end
    if not bool1 then
        return 0
    end
    local var1 = tbl1.values[tbl1.defaultIndex]
    return if var1 and var1 > 0 then var1 else nil
end

function module.valueFromSlider(selectedIndex: number, num1: number, tbl1, tbl2)
    return if tbl2.savedHundredths == 0
        or selectedIndex ~= num1
        or not tbl2.enabled[selectedIndex]
        or not module.equal(tbl1, tbl2)
        or selectedIndex == tbl2.selectedIndex then nil else tbl2.values[selectedIndex]
end

return module
