-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local selectAvatarPreviewColors = require(script.Parent.selectAvatarPreviewColors)

local function selectColorAdjustmentButtonColor(arg1)
    local var1 = selectAvatarPreviewColors(arg1)
    if not var1 then
        return Color3.new()
    end

    local headColor3 = var1.headColor3
    local torsoColor3 = var1.torsoColor3
    return headColor3 or torsoColor3 or Color3.new()
end

return selectColorAdjustmentButtonColor
