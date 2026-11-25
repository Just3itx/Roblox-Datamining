-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local Create = require(VrCommonParent.AppCommonLib).Create

local Granite = Enum.Material.Granite

local module = {}
module.__index = module

function module.new(userCFrame)
    local self = setmetatable({}, module)
    self.userCFrame = userCFrame

    self.model = Create("Model")({ Name = "RiftController", Archivable = false })

    self.origin = Create("Part")({
        Parent = self.model,
        Name = "Origin",
        Anchored = true,
        Transparency = 1,
        Size = Vector3.new(0.05, 0.05, 0.05),
        CanCollide = false,
        CanQuery = false,
        CanTouch = false
    })

    self.parts = {}

    local var1 = Create("Part")({
        Parent = self.model,
        Name = "body",
        Anchored = true,
        Material = Granite,
        Size = Vector3.new(0.05, 0.05, 0.05),
        Transparency = 0.25,
        CFrame = self.origin.CFrame,
        CanCollide = false,
        CanQuery = false,
        CanTouch = false
    })

    self.mesh = Create("SpecialMesh")({
        Parent = var1,
        Name = "Mesh",
        MeshId = if userCFrame == Enum.UserCFrame.LeftHand then "rbxassetid://9597097835" else "rbxassetid://9597101144",
        TextureId = "rbxassetid://9597123835",
        Scale = Vector3.new(0.032, 0.032, 0.032)
    })
    Create("Weld")({ Parent = var1, Name = "Weld", Part0 = self.origin, Part1 = var1 })

    self.parts.body = var1

    self.model.PrimaryPart = self.origin

    return self
end

function module:setCFrame(arg1)
    self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), 0, 0) * CFrame.new(0, -0.03, 0.06))
end

function module:setCFrameAndScale(arg1, arg2)
    self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), 0, 0) * CFrame.new(0, -0.03 * arg2, 0.06 * arg2))

    self.mesh.Scale = Vector3.new(0.032, 0.032, 0.032) * arg2
end

function module.onButtonInputChanged(_, _, _) end

function module.onInputBegan(arg1, arg2)
    arg1:onButtonInputChanged(arg2, true)
end

function module.onInputChanged(_, _) end

function module.onInputEnded(arg1, arg2)
    arg1:onButtonInputChanged(arg2, false)
end

function module.onTouchpadModeChanged(_, _, _) end

return module
