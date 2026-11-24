-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function tokenize(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    for value in string.gmatch(str1, "%S+") do
        table.insert(result, value)
    end
    return result
end

local function trim(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(str1, "^%s*(.-)%s*$") or ""
end

local function startsWith(str1: string, str2: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if #str2 > #str1 then
        return false
    end
    return string.sub(str1, 1, #str2) == str2
end

local function anyWordEquals(tbl1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl1 do
        if value == str1 then
            return true
        end
    end
    return false
end

local function anyWordStartsWith(tbl1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl1 do
        if startsWith(value, str1) then
            return true
        end
    end
    return false
end

local function anyWordIncludes(tbl1, str1: string)
    for _, value in tbl1 do
        if string.find(value, str1, 1, true) ~= nil then
            return true
        end
    end
    return false
end

local function maxEditsFor(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 >= 8 then 2 else 1
end

local function editDistanceWithin(str1: string, str2: string, num1: number)
    if str1 == str2 then
        return true
    end
    local num2 = #str1
    local num3 = #str2
    if num1 < math.abs(num2 - num3) then
        return false
    end
    if not (num2 < num3) then
        local str3 = str1
        str1 = str2
        str2 = str3
        str3 = num3
        num3 = num2
        num2 = str3
    end

    if num2 == 0 then
        return num3 <= num1
    end

    local var1 = table.create(num2 + 1)
    local var2 = table.create(num2 + 1)
    local var3 = table.create(num2 + 1)
    for i = 0, num2 do
        var2[i + 1] = i
    end
    for i = 1, num3 do
        var3[1] = i

        local var4 = string.byte(str2, i)
        local var5 = if i >= 2 then string.byte(str2, i - 1) else 0
        local num4 = i

        for j = 1, num2 do
            local var6 = string.byte(str1, j)
            local num5 = if var4 == var6 then 0 else 1
            local var7 = var2[j + 1] + 1
            local var8 = var3[j] + 1
            local var9 = var2[j] + num5

            if var8 < var7 then
                var7 = var8
            end

            if not (var9 < var7) then
                var9 = var7
            end

            if i >= 2 and j >= 2 then
                local num6 = j - 1

                if var4 == string.byte(str1, num6) and var5 == var6 then
                    local var10 = var1[j - 1] + 1
                    if var10 < var9 then
                        var9 = var10
                    end
                end
            end
            var3[j + 1] = var9
            if var9 < num4 then
                num4 = var9
            end
        end

        if num1 < num4 then
            return false
        end

        local var6 = var1
        var1 = var2
        var2 = var3
        var3 = var6
    end

    return var2[num2 + 1] <= num1
end

local function anyWordWithinEditDistance(tbl1, str1: string, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl1 do
        if editDistanceWithin(str1, value, num1) then
            return true
        end
    end
    return false
end

local function anyWordHasFuzzyPrefix(tbl1, str1: string, num1: number)
    local num2 = #str1
    for _, value in tbl1 do
        if num2 <= #value and editDistanceWithin(str1, string.sub(value, 1, num2), num1) then
            return true
        end
    end
    return false
end

local function scoreToken(str1: string, tbl1, str2: string, num1: number): number
    if str1 == str2 then
        return 100
    end

    if anyWordEquals(tbl1, str2) then
        return 50
    end

    if anyWordStartsWith(tbl1, str2) then
        return 20
    end

    if #str2 >= 5 and anyWordHasFuzzyPrefix(tbl1, str2, (maxEditsFor(#str2))) then
        return 8
    end

    if #str2 > 1 and string.find(str1, str2, 1, true) ~= nil then
        return 5
    end

    if #str2 == 1 and num1 > 1 and anyWordIncludes(tbl1, str2) then
        return 5
    end

    if #str2 >= 4 and anyWordWithinEditDistance(tbl1, str2, (maxEditsFor(#str2))) then
        return 12
    end

    return 0
end

return {
    substringMatch = function(tbl1, str1: string, num1: number)
        if num1 <= 0 then
            return {}
        end
        if str1 == "" then
            return {}
        end
        local str2 = string.lower(str1)
        local result = {}
        for _, value in tbl1 do
            if string.find(string.lower(value.name), str2, 1, true) == nil then
                continue
            end

            table.insert(result, value)
            if num1 <= #result then
                break
            end
        end

        return result
    end,
    fuzzyMatch = function(tbl1, str1: string, num1: number)
        if num1 <= 0 then
            return {}
        end

        local str2 = string.lower((trim(str1)))
        if str2 == "" then
            return tbl1
        end

        local tbl2 = tokenize(str2)
        local num2 = #tbl2

        local tbl3 = {}
        for index, value2 in tbl1 do
            local str3 = string.lower(value2.name)
            local tbl4 = tokenize(str3)
            local num3 = 0
            local bool1 = false
            for _, value3 in tbl2 do
                local num4 = scoreToken(str3, tbl4, value3, num2)
                if num4 == 0 then
                    bool1 = true
                    break
                end

                num3 += num4
            end
            if bool1 then
                continue
            end

            table.insert(tbl3, { item = value2, score = num3, index = index })
        end

        table.sort(tbl3, function(arg1, arg2): boolean
            if arg1.score == arg2.score then
                return arg1.index < arg2.index
            end

            return arg1.score > arg2.score
        end)

        local num3 = math.min(num1, #tbl3)
        local var1 = table.create(num3)
        for i = 1, num3 do
            var1[i] = tbl3[i].item
        end
        return var1
    end
}
