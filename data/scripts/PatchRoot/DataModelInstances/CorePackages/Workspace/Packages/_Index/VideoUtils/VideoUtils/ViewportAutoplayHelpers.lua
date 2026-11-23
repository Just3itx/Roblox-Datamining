-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local ViewportAutoplayRowSpanAttribute = require(VideoUtils.ViewportAutoplayRowSpanAttribute)
local ViewportAutoplayCellVerticalPaddingAttribute = require(VideoUtils.ViewportAutoplayCellVerticalPaddingAttribute)
local ViewportAutoplayAlignmentTypeAttribute = require(VideoUtils.ViewportAutoplayAlignmentTypeAttribute)
local AlignmentType = require(VideoUtilsParent.DiscoveryTypes).GameCollectionItemTypes.AlignmentType

local module = {}

function module.getTileRowSpan(arg1): number
    local var1 = arg1:GetAttribute(ViewportAutoplayRowSpanAttribute)
    if typeof(var1) == "number" and var1 > 0 then
        return math.floor(var1)
    end
    return 1
end

function module.resolveOneByOneHeight(arg1, num1: number)
    local var1 = arg1:GetAttribute(ViewportAutoplayCellVerticalPaddingAttribute)

    if typeof(var1) == "number" and not (num1 < 2) then
        return (arg1.AbsoluteSize.Y - var1 * (num1 - 1)) / num1
    end

    return nil
end

function module.isTilePinnedLeft(arg1): boolean?
    local var1 = arg1:GetAttribute(ViewportAutoplayAlignmentTypeAttribute)
    return var1 == AlignmentType.LeftPin or not (var1 == AlignmentType.RightPin) and nil
end

function module.getReadingOrderPositions(arg1, num1: number, num2: number, num3: number, num4: number?)
    local absolutePositionY = arg1.AbsolutePosition.Y
    local absoluteSizeY = arg1.AbsoluteSize.Y

    if num3 <= 1 or num4 == nil then
        return { absolutePositionY + num1 / num2 * absoluteSizeY }
    end

    local var1 = (absoluteSizeY - num4) / (num3 - 1)
    local num5 = num1 / num2 * num4
    local var2 = table.create(num3)
    for i = 0, num3 - 1 do
        var2[i + 1] = absolutePositionY + i * var1 + num5
    end
    return var2
end

function module.computeRowAnchorOverrides(tbl1, num1: number)
    local result = {}
    for _, instance in tbl1 do
        if module.getTileRowSpan(instance) ~= 2 then
            continue
        end

        local var1 = module.isTilePinnedLeft(instance)
        if var1 == nil then
            continue
        end

        local var2 = module.resolveOneByOneHeight(instance, 2)
        if var2 == nil then
            continue
        end

        local var3 = instance.AbsoluteSize.Y - var2
        local absolutePositionY = instance.AbsolutePosition.Y
        local var4 = absolutePositionY + instance.AbsoluteSize.Y
        local var5 = (absolutePositionY + var4) / 2
        local var6 = if var1 then absolutePositionY else var5

        if var1 then
            var4 = var5
        end

        if not var1 then
            absolutePositionY += var3
        end
        local tbl2 = {{
            instance = instance,
            absoluteX = instance.AbsolutePosition.X,
            rowTop = absolutePositionY,
            naturalOffset = instance.AbsolutePosition.X / num1 * var2
        }}

        for _, value in tbl1 do
            if value == instance or module.getTileRowSpan(value) ~= 1 then
                continue
            end

            local var7 = value.AbsolutePosition.Y + value.AbsoluteSize.Y / 2
            if not (var6 <= var7 and var7 <= var4) then
                continue
            end

            table.insert(tbl2, {
                instance = value,
                absoluteX = value.AbsolutePosition.X,
                rowTop = value.AbsolutePosition.Y,
                naturalOffset = value.AbsolutePosition.X / num1 * value.AbsoluteSize.Y
            })
        end

        table.sort(tbl2, function(arg1, arg2): boolean
            return arg1.absoluteX < arg2.absoluteX
        end)
        local num2 = #tbl2
        for value2, value3 in tbl2 do
            local var7 = if var1 then (value2 - 2) % num2 + 1 else value2 % num2 + 1
            result[value3.instance] = value3.rowTop + tbl2[var7].naturalOffset
        end
    end
    return result
end

return module
