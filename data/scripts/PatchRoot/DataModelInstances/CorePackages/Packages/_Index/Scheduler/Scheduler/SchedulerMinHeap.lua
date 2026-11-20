-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local var1 = nil
local var2 = nil
local var3 = nil

function module.push<T>(tbl1, tbl2)
    local num1 = #tbl1 + 1
    tbl1[num1] = tbl2

    var2(tbl1, tbl2, num1)
end

function module.peek<T>(tbl1): T
    return tbl1[1]
end

function module.pop(tbl1)
    local var4 = tbl1[1]
    if var4 == nil then
        return nil
    end

    local var5 = tbl1[#tbl1]
    tbl1[#tbl1] = nil

    if var5 ~= var4 then
        tbl1[1] = var5
        var3(tbl1, var5, 1)
    end
    return var4
end

var2 = function(tbl1, tbl2, num1: number)
    while true do
        local num2 = math.floor(num1 / 2)
        local var4 = tbl1[num2]
        if var4 == nil or not (var1(var4, tbl2) > 0) then
            break
        end
        tbl1[num2] = tbl2
        tbl1[num1] = var4
        num1 = num2
    end
end

var3 = function(tbl1, tbl2, num1: number)
    local num2 = #tbl1
    while num1 < num2 do
        local num3 = num1 * 2
        local var4 = tbl1[num3]
        local num4 = num3 + 1
        local var5 = tbl1[num4]

        if var4 ~= nil and var1(var4, tbl2) < 0 then
            if var5 ~= nil and var1(var5, var4) < 0 then
                tbl1[num1] = var5
                tbl1[num4] = tbl2
            else
                tbl1[num1] = var4
                tbl1[num3] = tbl2
                num4 = num3
            end
        else
            if var5 == nil or not (var1(var5, tbl2) < 0) then
                return
            end

            tbl1[num1] = var5
            tbl1[num4] = tbl2
        end

        num1 = num4
    end
end

var1 = function(tbl1, tbl2)
    local var4 = tbl1.sortIndex - tbl2.sortIndex

    if var4 == 0 then
        return tbl1.id - tbl2.id
    end

    return var4
end

return module
