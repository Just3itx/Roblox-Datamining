-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local byte = string.byte

local module = { INVALID = -1 }

local function isContinuation(num1: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (num1 == nil or not (num1 >= 128)) and num1 <= 191
end

local function decode(str1: string, num1: number)
    local var1 = byte(str1, num1 + 1)
    if var1 < 128 then
        return var1, 1
    end

    local var2, num2, num3

    if var1 >= 194 and var1 <= 223 then
        var2 = var1 - 192
        num2 = 2
        num3 = 128
    elseif var1 >= 224 and var1 <= 239 then
        var2 = var1 - 224
        num2 = 3
        num3 = 2048
    else
        if not (var1 >= 240 and var1 <= 244) then
            return -1, 1
        end

        var2 = var1 - 240
        num2 = 4
        num3 = 65536
    end

    for i = 1, num2 - 1 do
        local var3 = byte(str1, num1 + 1 + i)

        if not isContinuation(var3) then
            return -1, 1
        end
        var2 = var2 * 64 + (var3 - 128)
    end

    if var2 < num3 or var2 > 1114111 or var2 >= 55296 and var2 <= 57343 then
        return -1, 1
    end
    return var2, num2
end

function module.codePointAt(str1: string, num1: number)
    return (decode(str1, num1))
end

function module.codePointBefore(str1: string, num1: number)
    local num2 = num1 - 1

    while num2 > 0 and num1 - 4 < num2 do
        local num3 = num2 + 1

        if not isContinuation((byte(str1, num3))) then
            break
        end

        num2 -= 1
    end
    local var1, num3 = decode(str1, num2)
    return if num2 + num3 == num1 then var1 else -1
end

return module
