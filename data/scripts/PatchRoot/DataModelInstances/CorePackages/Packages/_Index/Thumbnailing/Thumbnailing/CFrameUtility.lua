-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.CalculateTargetCFrame(cFrame: CFrame): CFrame
    local var1 = if math.abs(cFrame.LookVector.Y) > 0.9 then cFrame.UpVector else cFrame.LookVector

    local unit = Vector3.new(var1.X, 0, var1.Z).Unit

    return CFrame.lookAt(cFrame.Position, cFrame.Position + unit)
end

function module.AdjustTargetCFrameWithExtents(cFrame: CFrame, vec1: vector, vec2: vector)
    local var1 = (vec1 + vec2) / 2
    return cFrame + (cFrame - cFrame.Position) * var1
end

function module.CalculateTargetCFrameWithExtents(cFrame: CFrame, vec1: vector, vec2: vector)
    local targetCFrame = module.CalculateTargetCFrame(cFrame)
    return module.AdjustTargetCFrameWithExtents(targetCFrame, vec1, vec2)
end

return module
