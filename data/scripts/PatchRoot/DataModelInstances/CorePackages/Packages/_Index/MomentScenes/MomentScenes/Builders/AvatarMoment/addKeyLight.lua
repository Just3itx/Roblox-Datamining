-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function addKeyLight(parent)
    local keyLight = Instance.new("Part")
    keyLight.Name = "KeyLight"
    keyLight.Anchored = true
    keyLight.Transparency = 1
    keyLight.CanCollide = false
    keyLight.Size = Vector3.new(1, 1, 1)
    keyLight.Position = Vector3.new(-4, 8, 6)
    keyLight.Parent = parent
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 0.7
    pointLight.Range = 16
    pointLight.Color = Color3.fromRGB(255, 244, 220)
    pointLight.Parent = keyLight
end

return addKeyLight
