-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function addFallbackBackdrop(parent)
    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Anchored = true
    floor.Size = Vector3.new(40, 1, 40)
    floor.Position = Vector3.new(0, -0.5, 0)
    floor.Color = Color3.fromRGB(40, 40, 48)
    floor.Material = Enum.Material.SmoothPlastic
    floor.Parent = parent

    local skyDome = Instance.new("Part")
    skyDome.Name = "SkyDome"
    skyDome.Anchored = true
    skyDome.Shape = Enum.PartType.Ball
    skyDome.Size = Vector3.new(80, 80, 80)
    skyDome.Position = Vector3.new(0, 10, 0)
    skyDome.Color = Color3.fromRGB(18, 22, 40)
    skyDome.Material = Enum.Material.SmoothPlastic
    skyDome.CastShadow = false
    local specialMesh = Instance.new("SpecialMesh")
    specialMesh.MeshType = Enum.MeshType.Sphere
    specialMesh.Scale = Vector3.new(-1, -1, -1)
    specialMesh.Parent = skyDome
    skyDome.Parent = parent
end

return addFallbackBackdrop
