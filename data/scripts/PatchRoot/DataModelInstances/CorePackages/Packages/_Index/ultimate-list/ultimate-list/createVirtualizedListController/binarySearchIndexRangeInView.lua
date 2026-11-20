-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local DataSourceMethods = require(ultimateList.DataSources.DataSourceMethods)
local _DataSources = require(ultimateList.DataSources)
local _Dimensions = require(ultimateList.Dimensions)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local function binarySearchIndexRangeInView(arg1, func1: (...any) -> (...any), num1: number, num2: number, str1: string)
    local function compareInView(arg2): string
        local var1 = if str1 == "x" then arg2.position.X.Offset elseif str1 == "y" then arg2.position.Y.Offset else exhaustiveMatch(str1)
        return if var1 + (if str1 == "x" then arg2.size.X.Offset elseif str1 == "y" then arg2.size.Y.Offset else exhaustiveMatch(str1)) < num1 then "before" elseif num1 + num2 < var1 then "after" else "inside"
    end

    local var1 = DataSourceMethods.length(arg1)
    local var2 = var1
    local num3 = 1
    local x, var3

    while true do
        if not (num3 <= var1) then
            return Vector3.new(0, 0, 0)
        end

        x = (num3 + var1) // 2

        var3 = DataSourceMethods.get(arg1, x)
        assert(var3 ~= nil, "get() returned nil, meaning the length is inaccurate")

        local str2 = compareInView((func1(var3.value, x)))

        if str2 == "after" then
            var1 = x - 1
        elseif str2 == "before" then
            num3 = x + 1
        else
            if str2 == "inside" then
                break
            end

            exhaustiveMatch(str2)
        end
    end

    local var4 = var3
    local y = x

    while x > 1 do
        var3 = var3.before()
        if var3 == nil or compareInView(func1(var3.value, x - 1)) ~= "inside" then
            break
        end

        x -= 1
    end

    while y < var2 do
        var4 = var4.after()
        if var4 == nil or compareInView(func1(var4.value, y + 1)) ~= "inside" then
            break
        end

        y += 1
    end

    return Vector3.new(x, y)
end

return binarySearchIndexRangeInView
