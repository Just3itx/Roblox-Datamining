-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Error = require(scriptParentParentParent.LuauPolyfill).Error

local HttpService = game:GetService("HttpService")

local module = {}
local invariant = require(scriptParentParent.jsUtils.invariant)

local function elementsThatOverlapOffsets(input, num1: number, func1: (...any) -> (...any))
    local result = ({})
    local num2 = 0
    for i = 1, num1 do
        local var1 = func1(i)
        local var2 = var1.offset + var1.length
        for j = 1, #input do
            if result[j] ~= nil or not (input[j] <= var2) then
                continue
            end

            result[j] = i
            num2 += 1
            if j ~= #input then
                continue
            end
            if num2 ~= #input then
                invariant(num2 == #input, "bad offsets input, should be in increasing order: %s", HttpService:JSONEncode(input))
            end

            return result
        end
    end

    return result
end
module.elementsThatOverlapOffsets = elementsThatOverlapOffsets

function module.newRangeCount(arg1, arg2): number
    return arg2.last - arg2.first + 1 - math.max(0, math.min(arg2.last, arg1.last) + 1 - math.max(arg2.first, arg1.first))
end

function module.computeWindowedRenderLimits(arg1, func1: (...any) -> (...any), num1: number, num2: number, tbl1, func2: (...any) -> (...any), arg2)
    local var1 = func1(arg1)
    if var1 == 0 then
        return tbl1
    end
    local offset = arg2.offset
    local velocity = arg2.velocity
    local visibleLength = arg2.visibleLength

    local num3 = math.max(0, offset)
    local var2 = num3 + visibleLength
    local var3 = (num2 - 1) * visibleLength

    local str1 = if velocity > 1 then "after" elseif velocity < -1 then "before" else "none"
    local num4 = math.max(0, num3 - 0.5 * var3)
    local num5 = math.max(0, var2 + 0.5 * var3)
    if func2(var1).offset < num4 then
        return {
            first = math.max(1, var1 - num1),
            last = var1
        }
    end

    local var4, var5, var6, var7 = table.unpack(elementsThatOverlapOffsets({ num4, num3, var2, num5 }, var1, func2), 1, 4)

    local overscanFirst = if var4 == nil then 1 else var4
    if var5 == nil then
        var5 = math.max(1, overscanFirst)
    end
    if var7 == nil then
        var7 = var1
    end

    if var6 == nil then
        var6 = math.min(var7, var5 + num1 - 1)
    end
    local visible = { first = var5, last = var6 }
    local var9 = visible.last - visible.first + 1

    local last = tbl1.last
    local num6 = math.min(visible.last, last) + 1
    local first = tbl1.first
    local var10 = var9 - math.max(0, num6 - math.max(visible.first, first))

    while not (var5 <= overscanFirst and var7 <= var6) do
        local bool1 = num1 <= var10
        local bool2 = var5 <= tbl1.first or tbl1.last < var5
        local bool3 = overscanFirst < var5 and not (bool1 and bool2)
        local bool4 = tbl1.last <= var6 or var6 < tbl1.first
        local bool5 = var6 < var7 and not (bool1 and bool4)

        if bool1 and not (bool3 or bool5) then
            break
        end

        if bool3 and (str1 ~= "after" or not (bool5 and bool4)) then
            if bool2 then
                var10 += 1
            end
            var5 -= 1
        end
        if not bool5 or str1 == "before" and bool3 and bool2 then
            continue
        end

        if bool4 then
            var10 += 1
        end
        var6 += 1
    end

    if not (var5 <= var6
        and var5 >= 1
        and var6 <= var1
        and overscanFirst <= var5
        and var6 <= var7
        and var5 <= visible.first
        and visible.last <= var6) then
        error(
            Error.new(
                "Bad window calculation " .. HttpService:JSONEncode(
                    {
                        first = var5,
                        last = var6,
                        itemCount = var1,
                        overscanFirst = overscanFirst,
                        overscanLast = var7,
                        visible = visible
                    }
                )
            )
        )
    end

    return { first = var5, last = var6 }
end

function module.keyExtractor(arg1, num1: number)
    if typeof(arg1) == "table" and arg1.key ~= nil then
        return arg1.key
    elseif typeof(arg1) == "table" and arg1.id ~= nil then
        return arg1.id
    end
    return tostring(num1)
end

return module
