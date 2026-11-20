-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getDiffBetweenOrientations(cFrame: CFrame, cFrame2: CFrame): number
    local _, var1 = (cFrame * cFrame2:Inverse()):ToAxisAngle()
    return math.deg(var1)
end

return getDiffBetweenOrientations
