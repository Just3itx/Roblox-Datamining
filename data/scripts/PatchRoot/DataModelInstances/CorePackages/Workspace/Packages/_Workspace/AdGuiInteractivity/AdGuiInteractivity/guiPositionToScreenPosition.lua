-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local tbl1 = {
    [Enum.NormalId.Front] = CFrame.identity,
    [Enum.NormalId.Left] = CFrame.fromEulerAngles(0, math.pi / 2, 0),
    [Enum.NormalId.Back] = CFrame.fromEulerAngles(0, math.pi, 0),
    [Enum.NormalId.Right] = CFrame.fromEulerAngles(0, -(math.pi / 2), 0),
    [Enum.NormalId.Top] = CFrame.fromEulerAnglesYXZ(math.pi / 2, -(math.pi / 2), 0),
    [Enum.NormalId.Bottom] = CFrame.fromEulerAnglesYXZ(-(math.pi / 2), -(math.pi / 2), 0)
}

local function guiPositionToScreenPosition(arg1, vector2: Vector2, arg2)
    local var1 = vector2 / arg1.AbsoluteSize
    if arg1:IsA("ScreenGui") then
        return vector2
    elseif arg1:IsA("BillboardGui") then
        local screenSpaceBounds = arg1:GetScreenSpaceBounds()

        if screenSpaceBounds then
            return screenSpaceBounds.Min + var1 * Vector2.new(screenSpaceBounds.Width, screenSpaceBounds.Height) + GuiService:GetInsetArea(Enum.ScreenInsets.None).Min
        end

        return nil
    elseif arg1:IsA("SurfaceGui") then
        local var2 = arg1.Adornee or arg1.Parent
        if not (var2 and var2:IsA("BasePart")) then
            return nil
        end

        local var3 = tbl1[arg1.Face]

        local var4 = var2.CFrame * var3

        local var5 = (var3:Inverse() * var2.Size):Abs()

        local x = 0.5 - var1.X
        local y = 0.5 - var1.Y
        local var6, var7 = arg2:WorldToScreenPoint(var4 * (var5 * Vector3.new(x, y, -0.5)))
        if not var7 then
            return nil
        end

        return Vector2.new(var6.X, var6.Y)
    else
        return nil
    end
end
return guiPositionToScreenPosition
