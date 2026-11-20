-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Number = LuauPolyfill.Number
local String = LuauPolyfill.String
local isNaN = Number.isNaN
local var1 = nil
local var2 = nil

local function naturalCompare(str1: string, str2: string)
    local num1 = 1
    local num2 = 1

    while num1 <= #str1 and num2 <= #str2 do
        local var3 = String.charCodeAt(str1, num1)
        local var4 = String.charCodeAt(str2, num2)

        if var1(var3) and var1(var4) then
            local num3 = 0

            repeat
                num1 += 1
                num3 = num3 * 10 + var3 - var2
                var3 = String.charCodeAt(str1, num1)
            until not (var1(var3) and num3 > 0)

            local num4 = 0

            repeat
                num2 += 1
                num4 = num4 * 10 + var4 - var2
                var4 = String.charCodeAt(str2, num2)
            until not (var1(var4) and num4 > 0)

            if num3 < num4 then
                return -1
            end

            if num4 < num3 then
                return 1
            end
        else
            if var3 < var4 then
                return -1
            end
            if var4 < var3 then
                return 1
            end
            num1 += 1
            num2 += 1
        end
    end

    return #str1 - #str2
end

var2 = 48
local num1 = 57

var1 = function(num2: number): boolean
    local bool1 = not isNaN(num2)
    return bool1 and var2 <= num2 and num2 <= num1
end

return { naturalCompare = naturalCompare }
