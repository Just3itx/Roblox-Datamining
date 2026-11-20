-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Flags = require(Foundation.Utility.Flags)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)

return {
    adjustForOnScreenKeyboard = function(rect: Rect, vector2: Vector2, vector2_2: Vector2): Rect
        local var1 = vector2 - vector2_2

        local y = math.min(rect.Max.Y, var1.Y)
        return Rect.new(rect.Min, Vector2.new(rect.Max.X, y))
    end,
    isOnScreen = function(rect: Rect, rect2: Rect): boolean
        return not (rect.Min.X > rect2.Max.X or rect.Max.X < rect2.Min.X or rect.Min.Y > rect2.Max.Y or rect.Max.Y < rect2.Min.Y)
    end,
    calculateSide = function(arg1, rect: Rect, rect2: Rect, vector2: Vector2)
        if arg1 == PopoverSide.Top then
            if rect.Min.Y - vector2.Y < rect2.Min.Y and rect.Max.Y + vector2.Y < rect2.Max.Y then
                return PopoverSide.Bottom
            end
        elseif arg1 == PopoverSide.Bottom then
            if rect.Max.Y + vector2.Y > rect2.Max.Y and rect.Min.Y - vector2.Y > rect2.Min.Y then
                return PopoverSide.Top
            end
        elseif arg1 == PopoverSide.Left then
            if rect.Min.X - vector2.X < rect2.Min.X and rect.Max.X + vector2.X < rect2.Max.X then
                return PopoverSide.Right
            end
        elseif arg1 == PopoverSide.Right and rect.Max.X + vector2.X > rect2.Max.X and rect.Min.X - vector2.X > rect2.Min.X then
            return PopoverSide.Left
        end

        return arg1
    end,
    calculatePositions = function(arg1, num1: number, arg2, num2: number, rect: Rect, rect2: Rect, num3: number, vector2: Vector2): (Vector2, Vector2, Vector2)
        local tbl1 = { X = 0, Y = 0 }
        local tbl2 = { X = 0, Y = 0 }
        local tbl3 = { X = 0, Y = 0 }

        local bool1 = arg1 == PopoverSide.Top or arg1 == PopoverSide.Bottom

        local bool2 = arg1 == PopoverSide.Top or arg1 == PopoverSide.Left

        local height = rect.Height
        local minX = rect.Min.X
        local minY = rect.Min.Y
        local vector2Y = vector2.Y
        local vector2X = vector2.X
        local maxX = rect.Max.X
        local maxY = rect.Max.Y
        local minY2 = rect2.Min.Y
        local maxY2 = rect2.Max.Y
        local minX2 = rect2.Min.X
        local maxX2 = rect2.Max.X
        local str1, str2

        if bool1 then
            height = rect.Width
            minX = rect.Min.Y
            minY = rect.Min.X
            vector2Y = vector2.X
            vector2X = vector2.Y
            maxX = rect.Max.Y
            maxY = rect.Max.X
            minY2 = rect2.Min.X
            maxY2 = rect2.Max.X
            minX2 = rect2.Min.Y
            maxX2 = rect2.Max.Y
            str1 = "Y"
            str2 = "X"
        else
            str1 = "X"
            str2 = "Y"
        end

        local num4 = num1 + num3
        if bool2 then
            tbl1[str1] = minX - num4 - vector2X
            tbl2[str1] = vector2X
        else
            tbl1[str1] = maxX + num4
            tbl2[str1] = 0
        end

        if arg2 == PopoverAlign.Start then
            tbl1[str2] = minY + num2
        elseif arg2 == PopoverAlign.Center then
            tbl1[str2] = minY + height / 2 - vector2Y / 2 + num2
        else
            tbl1[str2] = maxY + -num2
            tbl3[str2] = 1
        end

        local var1 = tbl1[str2] - tbl3[str2] * vector2Y

        local var2 = var1 + vector2Y
        if var1 < minY2 then
            tbl3[str2] = 0
            tbl1[str2] = minY2
        elseif maxY2 < var2 then
            tbl3[str2] = 1
            tbl1[str2] = maxY2
        end

        local var3 = tbl1[str2] - tbl3[str2] * vector2Y
        local var4 = var3 + vector2Y

        local num5 = math.max(minY, var3)
        local num6 = math.min(maxY, var4)
        local var5 = if num5 <= num6 then (num5 + num6) / 2 elseif var4 < minY then var4 - num3 else var3 + num3
        tbl2[str2] = var5 - tbl1[str2]

        local var6 = tbl1[str1]

        local num7 = math.max(maxX2 - vector2X - num4, if Flags.FoundationPopoverClampMinBound then minX2 else 0)
        tbl1[str1] = math.clamp(var6, minX2, num7)

        tbl1.X -= rect2.Min.X
        tbl1.Y -= rect2.Min.Y

        return Vector2.new(tbl1.X, tbl1.Y), Vector2.new(tbl2.X, tbl2.Y), Vector2.new(tbl3.X, tbl3.Y)
    end,
    calculatePopoverBounds = function(arg1, num1: number, num2: number, num3: number, vector2: Vector2)
        if arg1 == PopoverSide.Top or arg1 == PopoverSide.Bottom then
            return vector2 + Vector2.new(num2, num1 + num3)
        end

        return vector2 + Vector2.new(num1 + num3, num2)
    end,
    calculateAlign = function(arg1, arg2, rect: Rect, rect2: Rect, vector2: Vector2)
        if arg1 == PopoverSide.Top or arg1 == PopoverSide.Bottom then
            if arg2 == PopoverAlign.Start then
                if rect.Min.X + vector2.X > rect2.Max.X then
                    return PopoverAlign.End
                end
            elseif arg2 == PopoverAlign.End and rect.Max.X - vector2.X < rect2.Min.X then
                return PopoverAlign.Start
            end
        elseif arg2 == PopoverAlign.Start then
            if rect.Min.Y + vector2.Y > rect2.Max.Y then
                return PopoverAlign.End
            end
        elseif arg2 == PopoverAlign.End and rect.Max.Y - vector2.Y < rect2.Min.Y then
            return PopoverAlign.Start
        end

        return arg2
    end
}
