-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local engineFeature = game:GetEngineFeature("OpenXrForWin32")

local Create = require(VrCommonParent.AppCommonLib).Create

local Granite = Enum.Material.Granite
local vec3 = if engineFeature then Vector3.new(3.4, 3.4, 3.4) else Vector3.new(3.6, 3.6, 3.6)

local module = {}
module.__index = module

function module.new(userCFrame)
    local self = setmetatable({}, module)
    self.userCFrame = userCFrame

    self.model = Create("Model")({ Name = "IndexController", Archivable = false })

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
        MeshId = if userCFrame == Enum.UserCFrame.LeftHand then "rbxassetid://9605099531" else "rbxassetid://9605114549",
        TextureId = if userCFrame == Enum.UserCFrame.LeftHand then "rbxassetid://9605099774" else "rbxassetid://9605114771",
        Scale = vec3
    })
    Create("Weld")({ Parent = var1, Name = "Weld", Part0 = self.origin, Part1 = var1 })

    self.parts.body = var1

    self.model.PrimaryPart = self.origin

    return self
end

function module:setCFrame(arg1)
    if engineFeature then
        if self.userCFrame == Enum.UserCFrame.RightHand then
            self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(40), math.pi, 0) * CFrame.new(-0.1, 0.08, -0.01))
            return
        end

        self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(40), math.pi, 0) * CFrame.new(0.1, 0.08, -0.01))
    elseif self.userCFrame == Enum.UserCFrame.RightHand then
        self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), math.pi, 0) * CFrame.new(-0.1, -0.03, -0.4))
    else
        self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), math.pi, 0) * CFrame.new(0.1, -0.03, -0.4))
    end
end

function module:setCFrameAndScale(arg1, arg2)
    local num1 = if self.userCFrame == Enum.UserCFrame.RightHand then 1 else -1
    if engineFeature then
        self.model:SetPrimaryPartCFrame(
            arg1 * CFrame.Angles(math.rad(40), math.pi, 0) * CFrame.new(-0.1 * arg2 * num1, 0.08 * arg2, -0.01 * arg2)
        )
    else
        self.model:SetPrimaryPartCFrame(
            arg1 * CFrame.Angles(math.rad(20), math.pi, 0) * CFrame.new(-0.1 * arg2 * num1, -0.03 * arg2, -0.4 * arg2)
        )
    end
    self.mesh.Scale = vec3 * arg2
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
