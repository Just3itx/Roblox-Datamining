-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local tbl2 = ({})

local tbl3 = {
    ID = 0,
    Type = "Model",
    Properties = { Name = "Safety Bubble Dummy", PrimaryPart = "_R:1_" },
    Children = {
        {
            ID = 1,
            Type = "Part",
            Properties = {
                Transparency = 0.5,
                Name = "HumanoidRootPart",
                Size = Vector3.new(2, 2, 1),
                Anchored = true,
                BottomSurface = Enum.SurfaceType.Smooth,
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {{
                ID = 2,
                Type = "Motor6D",
                Properties = {
                    Part1 = "_R:3_",
                    Name = "Root Hip",
                    C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                    C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                    Part0 = "_R:1_",
                    MaxVelocity = 0.10000000149011612
                },
                Children = {}
            }}
        },
        {
            ID = 3,
            Type = "Part",
            Properties = {
                Size = Vector3.new(2, 2, 1),
                BottomSurface = Enum.SurfaceType.Smooth,
                Name = "Torso",
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {
                {
                    ID = 4,
                    Type = "Motor6D",
                    Properties = {
                        Part1 = "_R:9_",
                        Name = "Left Hip",
                        C1 = CFrame.new(-0.5, 1, 0, -4.371138828673793e-8, 0, -1, 0, 0.9999999403953552, 0, 1, 0, -4.371138828673793e-8),
                        C0 = CFrame.new(-1, -1, 0, -4.371138828673793e-8, 0, -1, 0, 0.9999999403953552, 0, 1, 0, -4.371138828673793e-8),
                        Part0 = "_R:3_",
                        MaxVelocity = 0.10000000149011612
                    },
                    Children = {}
                },
                {
                    ID = 5,
                    Type = "Motor6D",
                    Properties = {
                        Part1 = "_R:10_",
                        Name = "Right Hip",
                        C1 = CFrame.new(0.5, 1, 0, -4.371138828673793e-8, 0, 1, 0, 0.9999999403953552, 0, -1, 0, -4.371138828673793e-8),
                        C0 = CFrame.new(1, -1, 0, -4.371138828673793e-8, 0, 1, -0, 0.9999999403953552, 0, -1, 0, -4.371138828673793e-8),
                        Part0 = "_R:3_",
                        MaxVelocity = 0.10000000149011612
                    },
                    Children = {}
                },
                {
                    ID = 6,
                    Type = "Motor6D",
                    Properties = {
                        Part1 = "_R:11_",
                        Name = "Left Shoulder",
                        C1 = CFrame.new(0.5, 0.5, 0, -4.371138828673793e-8, 0, -1, 0, 0.9999999403953552, 0, 1, 0, -4.371138828673793e-8),
                        C0 = CFrame.new(-1, 0.5, 0, -4.371138828673793e-8, 0, -1, 0, 0.9999999403953552, 0, 1, 0, -4.371138828673793e-8),
                        Part0 = "_R:3_",
                        MaxVelocity = 0.10000000149011612
                    },
                    Children = {}
                },
                {
                    ID = 7,
                    Type = "Motor6D",
                    Properties = {
                        Part1 = "_R:12_",
                        Name = "Right Shoulder",
                        C1 = CFrame.new(-0.5, 0.5, 0, -4.371138828673793e-8, 0, 1, 0, 0.9999999403953552, 0, -1, 0, -4.371138828673793e-8),
                        C0 = CFrame.new(1, 0.5, 0, -4.371138828673793e-8, 0, 1, -0, 0.9999999403953552, 0, -1, 0, -4.371138828673793e-8),
                        Part0 = "_R:3_",
                        MaxVelocity = 0.10000000149011612
                    },
                    Children = {}
                },
                {
                    ID = 8,
                    Type = "Motor6D",
                    Properties = {
                        Part1 = "_R:13_",
                        Name = "Neck",
                        C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                        C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                        Part0 = "_R:3_",
                        MaxVelocity = 0.10000000149011612
                    },
                    Children = {}
                }
            }
        },
        {
            ID = 9,
            Type = "Part",
            Properties = {
                Size = Vector3.new(1, 2, 1),
                Name = "Left Leg",
                CanCollide = false,
                BottomSurface = Enum.SurfaceType.Smooth,
                CFrame = CFrame.new(-0.5, -1.9999998807907104, 0, 1, 0, 0, 0, 0.9999998807907104, 0, 0, 0, 1),
                Position = Vector3.new(-0.5, -1.9999999, 0),
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {}
        },
        {
            ID = 10,
            Type = "Part",
            Properties = {
                Size = Vector3.new(1, 2, 1),
                Name = "Right Leg",
                CanCollide = false,
                BottomSurface = Enum.SurfaceType.Smooth,
                CFrame = CFrame.new(0.5, -1.9999998807907104, 0, 1, 0, 0, 0, 0.9999998807907104, 0, 0, 0, 1),
                Position = Vector3.new(0.5, -1.9999999, 0),
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {}
        },
        {
            ID = 11,
            Type = "Part",
            Properties = {
                Size = Vector3.new(1, 2, 1),
                Name = "Left Arm",
                CanCollide = false,
                BottomSurface = Enum.SurfaceType.Smooth,
                CFrame = CFrame.new(-1.5, 5.960464477539063e-8, 0, 1, 0, 0, 0, 0.9999998807907104, 0, 0, 0, 1),
                Position = Vector3.new(-1.5, 5.9604645e-8, 0),
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {}
        },
        {
            ID = 12,
            Type = "Part",
            Properties = {
                Size = Vector3.new(1, 2, 1),
                Name = "Right Arm",
                CanCollide = false,
                BottomSurface = Enum.SurfaceType.Smooth,
                CFrame = CFrame.new(1.5, 5.960464477539063e-8, 0, 1, 0, 0, 0, 0.9999998807907104, 0, 0, 0, 1),
                Position = Vector3.new(1.5, 5.9604645e-8, 0),
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {}
        },
        {
            ID = 13,
            Type = "Part",
            Properties = {
                Name = "Head",
                Position = Vector3.new(0, 1.5, 0),
                Size = Vector3.new(2, 1, 1),
                CFrame = CFrame.new(0, 1.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                BottomSurface = Enum.SurfaceType.Smooth,
                TopSurface = Enum.SurfaceType.Smooth
            },
            Children = {
                {
                    ID = 14,
                    Type = "Decal",
                    Properties = { Name = "Face", Texture = "rbxasset://textures/face.png" },
                    Children = {}
                },
                {
                    ID = 15,
                    Type = "SpecialMesh",
                    Properties = { Scale = Vector3.new(1.25, 1.25, 1.25) },
                    Children = {}
                }
            }
        },
        {
            ID = 16,
            Type = "Humanoid",
            Properties = {},
            Children = {}
        }
    }
}

local function Scan(arg1, parent, arg2, arg3): Instance
    local instance = Instance.new(arg1.Type)

    if arg1.ID then
        local var1 = tbl2[arg1.ID]
        if var1 then
            var1[1][var1[2]] = instance
            tbl2[arg1.ID] = nil
        else
            tbl1[arg1.ID] = instance
        end
    end
    for k, value in pairs(arg1.Properties) do
        if type(value) == "string" then
            local var1 = tonumber(value:match("^_R:(%w+)_$"))
            if var1 then
                if tbl1[var1] then
                    value = tbl1[var1]
                else
                    tbl2[var1] = { instance, k }
                    value = nil
                end
            end
        end

        instance[k] = value
    end
    for _, child in pairs(arg1.Children) do
        Scan(child, instance, arg2, arg3)
    end
    instance.Parent = parent
    if instance:IsA("Part") then
        instance.Position += arg2
        instance.Orientation += arg3
        instance.Anchored = true
    end
    return instance
end

return function(arg1, arg2): Instance
    return (Scan(tbl3, nil, arg1, arg2))
end
