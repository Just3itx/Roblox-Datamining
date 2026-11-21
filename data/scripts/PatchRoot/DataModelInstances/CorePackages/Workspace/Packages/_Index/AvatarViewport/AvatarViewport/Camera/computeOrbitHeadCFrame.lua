-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)

local function computeOrbitHeadCFrame(tbl1)
    local var1 = tbl1.focusPartName or Constants.DefaultFocusPartName
    local var2 = tbl1.character:FindFirstChild(var1)
    if not (var2 and var2:IsA("BasePart")) then
        return nil
    end

    local var3 = tbl1.baseDistance or Constants.DefaultOrbitBaseDistance
    local var4 = tbl1.fieldOfViewDeg or Constants.DefaultOrbitFieldOfViewDeg
    local layout = tbl1.layout

    local position = var2.Position

    local var5 = tbl1.fieldOfViewForDistanceScaleDeg or var4
    local var6 = if var5 > 0 and var4 > 0 and var5 ~= var4 then math.tan(math.rad(var5 * 0.5)) / math.tan(math.rad(var4 * 0.5)) else 1
    local var7 = var3 * tbl1.distanceScale * var6

    local target = position + Vector3.new(
        0,
        -((0.5 - (layout.cutoutTopOffset + layout.cutoutDiameter * 0.5) / math.max(layout.viewportHeight, 1)) * var7 * math.tan(math.rad(var4 * 0.5)) * 2),
        0
    )
    local position2 = (CFrame.new(position) * CFrame.Angles(0, math.rad(tbl1.yRotDeg), 0) * CFrame.new(0, 0.05, -var7)).Position
    return CFrame.lookAt(position2, target)
end

return computeOrbitHeadCFrame
