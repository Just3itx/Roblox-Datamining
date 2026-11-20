-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)

local _Types = require(Foundation.Providers.StudioPanels.Types)

local function getPanelPosition(arg1, arg2, vector2: Vector2?, num1: number?, num2: number?)
    local num3 = 0
    local offset

    if type(arg1) == "table" then
        offset = arg1.offset
        arg1 = arg1.position
    else
        offset = 0
    end
    if type(arg2) == "table" then
        num3 = arg2.offset
        arg2 = arg2.position
    end

    local var1 = offset + (num2 or 0)
    local num4 = 0
    local var2

    if arg2 == PopoverAlign.Center then
        var2 = 0
        num4 = 0.5
    elseif arg2 == PopoverAlign.End then
        var2 = -num3
        num4 = 1
    else
        var2 = num3
    end

    local var3 = nil
    local zero = nil
    local var4 = nil
    if arg1 == PopoverSide.Top then
        var3 = Vector2.new(var2, -var1)
        zero = Vector2.new(num4, 0)
        var4 = Vector2.new(num4, 1)
    elseif arg1 == PopoverSide.Bottom then
        var3 = Vector2.new(var2, var1)
        zero = Vector2.new(num4, 1)
        var4 = Vector2.new(num4, 0)
    elseif arg1 == PopoverSide.Left then
        var3 = Vector2.new(-var1, var2)
        zero = Vector2.new(0, num4)
        var4 = Vector2.new(1, num4)
    elseif arg1 == PopoverSide.Right then
        var3 = Vector2.new(var1, var2)
        zero = Vector2.new(1, num4)
        var4 = Vector2.new(0, num4)
    end

    local num5 = num1 or 0
    if num5 > 0 then
        local bool1 = arg1 == PopoverSide.Top or arg1 == PopoverSide.Bottom
        local num6 = num5 * 2
        local num7 = num5 * 2
        local var5, var6

        if bool1 then
            var5 = num6 + num3
            var6 = num7 + var1
        else
            var5 = num6 + var1
            var6 = num7 + num3
        end

        var3 += Vector2.new(var4.X * var5 - num5, var4.Y * var6 - num5)
    end

    if vector2 then
        zero = Vector2.zero
    else
        vector2 = var3
    end

    return { targetAnchorPoint = zero, subjectAnchorPoint = var4, offset = vector2 }
end

return getPanelPosition
