-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local t = require(scriptParentParentParentParent.Parent.t)

return t.strictInterface({
    Color = t.Color3,
    AnimatedColor = t.Color3,
    Transparency = t.numberConstrained(0, 1),
    GradientRotationSpeed = t.number,
    GradientColorSequence = t.ColorSequence,
    GradientTransparencySequence = t.NumberSequence,
    Rotation = t.number
})
