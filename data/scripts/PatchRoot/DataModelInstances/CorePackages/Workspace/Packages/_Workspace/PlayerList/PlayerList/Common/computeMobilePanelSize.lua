-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Common.Constants)

local function lerpRange(num1: number, num2: number, num3: number, num4: number, num5: number): number -- Luacid: unused: defined but never referenced
    return (num1 - num2) * (num5 - num4) / (num3 - num2) + num4
end

local function computeMobilePanelSize(vector2: Vector2, y: number, num1: number, num2: number?): Vector2
    local num3 = math.min(vector2.X, vector2.Y)
    local num4 = math.max(vector2.X, vector2.Y)
    local panelBorder = Constants.PANEL_BORDER
    local num5 = (num3 - 320) * 60 / 55 + 270
    local num6 = (num4 - 480) * 46 / 190 + 434

    if not (Constants.PANEL_SIZE_MIN_CAP < num5) then
        y = math.clamp(num5, math.min(270, num3 - panelBorder), Constants.PANEL_SIZE_MIN_CAP)
    end
    if not (Constants.PANEL_SIZE_MAX_CAP < num6) then
        num1 = math.clamp(num6, math.min(434, num4 - panelBorder), Constants.PANEL_SIZE_MAX_CAP)
    end

    local x = if vector2.X > vector2.Y then num1 else y

    if vector2.Y > vector2.X then
        y = num1
    end

    if num2 ~= nil then
        y = math.min(y, math.max(0, vector2.Y - num2))
    end
    return Vector2.new(x, y)
end

return computeMobilePanelSize
