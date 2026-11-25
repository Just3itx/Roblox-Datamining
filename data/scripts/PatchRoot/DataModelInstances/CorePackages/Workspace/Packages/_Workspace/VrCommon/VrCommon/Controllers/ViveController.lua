-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local Create = require(VrCommonParent.AppCommonLib).Create

local tbl1 = {
    Body = {
        size = Vector3.new(0.391, 0.277, 0.731),
        meshId = "rbxassetid://433286977",
        textureId = "rbxassetid://433287000",
        offset = CFrame.new(0, -0.115, 0.213)
    },
    RightGrip = {
        meshId = "rbxassetid://433290663",
        textureId = "rbxassetid://433290688",
        offset = CFrame.new(0.057, -0.047, 0.29),
        moveOffset = CFrame.new(-0.005, 0, 0)
    },
    LeftGrip = {
        meshId = "rbxassetid://433289821",
        textureId = "rbxassetid://433289832",
        offset = CFrame.new(-0.057, -0.047, 0.29),
        moveOffset = CFrame.new(0.005, 0, 0)
    },
    SystemButton = {
        meshId = "rbxassetid://433291265",
        textureId = "rbxassetid://433291278",
        offset = CFrame.new(0, 0.005, 0.294),
        moveOffset = CFrame.new(vector.create(-0, -0.000997421, -0.00007177444, -0))
    },
    MenuButton = {
        meshId = "rbxassetid://433288124",
        textureId = "rbxassetid://433288134",
        offset = CFrame.new(0, 0.016, 0.068),
        moveOffset = CFrame.new(vector.create(-0, -0.0009998778, 0.00001563049, -0))
    },
    Trackpad = {
        meshId = "rbxassetid://433288821",
        textureId = "rbxassetid://433288836",
        offset = CFrame.new(0, 0, 0.163),
        moveOffset = CFrame.new(vector.create(-0, -0.0009935069, -0.00011377229, -0))
    },
    Trigger = {
        meshId = "rbxassetid://433288767",
        textureId = "rbxassetid://433288775",
        offset = CFrame.new(0, -0.093, 0.163)
    },
    LED = {
        meshId = "rbxassetid://433293218",
        textureId = "rbxassetid://433293231",
        offset = CFrame.new(0, 0.007, 0.32)
    },
    ButtonA = {
        meshId = "rbxassetid://922444331",
        textureId = "rbxasset://textures/ui/VR/ButtonA.png",
        offset = CFrame.new(-0, 0.0115499999, 0.197307006) * CFrame.Angles(0, math.pi, 0),
        moveOffset = CFrame.new(0, -0.005, 0)
    },
    ButtonB = {
        meshId = "rbxassetid://922454202",
        textureId = "rbxasset://textures/ui/VR/ButtonB.png",
        offset = CFrame.new(0.0391042456, 0.0154935224, 0.161779419) * CFrame.Angles(0, math.pi, 0),
        moveOffset = CFrame.new(0, -0.005, 0)
    },
    ButtonX = {
        meshId = "rbxassetid://922453111",
        textureId = "rbxasset://textures/ui/VR/ButtonX.png",
        offset = CFrame.new(-0.0390719995, 0.0154770007, 0.161733001) * CFrame.Angles(0, math.pi, 0),
        moveOffset = CFrame.new(0, -0.005, 0)
    },
    ButtonY = {
        meshId = "rbxassetid://922455502",
        textureId = "rbxasset://textures/ui/VR/ButtonY.png",
        offset = CFrame.new(0, 0.0197229274, 0.126810834) * CFrame.Angles(0, math.pi, 0),
        moveOffset = CFrame.new(0, -0.005, 0)
    }
}

local tbl2 = {
    [Enum.KeyCode.ButtonL1] = "LeftGrip",
    [Enum.KeyCode.ButtonL2] = "Trigger",
    [Enum.KeyCode.ButtonL3] = "Trackpad",
    [Enum.KeyCode.ButtonR1] = "RightGrip",
    [Enum.KeyCode.ButtonR2] = "Trigger",
    [Enum.KeyCode.ButtonR3] = "Trackpad",
    [Enum.KeyCode.Thumbstick1] = "Trackpad",
    [Enum.KeyCode.Thumbstick2] = "Trackpad",
    [Enum.KeyCode.ButtonSelect] = "MenuButton",
    [Enum.KeyCode.ButtonStart] = "MenuButton",
    [Enum.KeyCode.ButtonA] = "ButtonA",
    [Enum.KeyCode.ButtonB] = "ButtonB",
    [Enum.KeyCode.ButtonX] = "ButtonX",
    [Enum.KeyCode.ButtonY] = "ButtonY"
}

local Granite = Enum.Material.Granite

local module = {}
module.__index = module

local tbl3 = {
    [Enum.UserCFrame.LeftHand] = Enum.VRTouchpad.Left,
    [Enum.UserCFrame.RightHand] = Enum.VRTouchpad.Right
}

function module.new(userCFrame)
    local self = setmetatable({}, module)
    self.userCFrame = userCFrame
    self.touchpad = tbl3[self.userCFrame]
    self.touchpadMode = VRService:GetTouchpadMode(self.touchpad)
    self.onTouchpadModeChangedConn = VRService.TouchpadModeChanged:connect(function(...)
        self:onTouchpadModeChanged(...)
    end)

    self.model = Create("Model")({ Name = "ViveController", Archivable = false })

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

    self.scale = 1
    self.parts = {}

    for k, value in pairs(tbl1) do
        local vec3 = Vector3.new(0.033, 0.033, 0.033)
        if value.scale then
            vec3 *= value.scale
        end

        local part1 = Create("Part")({
            Parent = self.model,
            Name = k,
            Anchored = true,
            Material = Granite,
            Size = value.size or Vector3.new(0.05, 0.05, 0.05),
            CFrame = self.origin.CFrame * value.offset,
            CanCollide = false,
            CanQuery = false,
            CanTouch = false
        })

        Create("SpecialMesh")(
            {
                Parent = part1,
                Name = "Mesh",
                MeshId = value.meshId,
                TextureId = value.textureId,
                Scale = vec3
            }
        )

        Create("Weld")({ Parent = part1, Name = "Weld", Part0 = self.origin, Part1 = part1, C0 = value.offset })

        self.parts[k] = part1
    end

    local var1 = Create("Part")({
        Parent = self.model,
        Name = "TrackpadIndicator",
        Material = Enum.Material.Neon,
        BrickColor = BrickColor.new("Institutional white"),
        Shape = Enum.PartType.Ball,
        Anchored = true,
        Transparency = 1,
        Size = Vector3.new(0.05, 0.05, 0.05),
        CanCollide = false,
        CanQuery = false,
        CanTouch = false
    })

    Create("Weld")({ Parent = var1, Name = "Weld", Part0 = self.origin, Part1 = var1, C0 = tbl1.Trackpad.offset })

    self.parts.TrackpadIndicator = var1
    self.model.PrimaryPart = self.origin

    self:onTouchpadModeChanged(self.touchpad, VRService:GetTouchpadMode(self.touchpad))

    return self
end

function module:setPartVisible(arg1, arg2)
    local part = self.parts[arg1]
    if part then
        part.Transparency = if arg2 then 0 else 1
    end
end

function module:setABXYEnabled(arg1)
    self:setPartVisible("ButtonA", arg1)
    self:setPartVisible("ButtonB", arg1)
    self:setPartVisible("ButtonX", arg1)
    self:setPartVisible("ButtonY", arg1)
end

function module:setCFrame(arg1)
    self.model:SetPrimaryPartCFrame(arg1)
end

function module:setCFrameAndScale(arg1, scale)
    self.model:SetPrimaryPartCFrame(arg1)
    if self.scale == scale then
        return
    end

    self.scale = scale
    for k, value in pairs(tbl1) do
        local part = self.parts[k]
        if not part then
            continue
        end

        local vec3 = Vector3.new(0.033, 0.033, 0.033)
        if value.scale then
            vec3 *= value.scale
        end

        local mesh = part:FindFirstChild("Mesh")
        local weld = part:FindFirstChild("Weld")

        local c0 = CFrame.new(value.offset.p * self.scale) * (value.offset - value.offset.p)
        part.CFrame = arg1 * c0

        if mesh then
            mesh.Scale = vec3 * self.scale
        end
        if weld then
            weld.C0 = c0
        end
    end
end

function module:setButtonState(arg1, arg2)
    local var1 = tbl1[arg1]
    if not var1 then
        return
    end

    local offset = var1.offset
    local moveOffset = var1.moveOffset

    if not offset or not moveOffset then
        return
    end

    local c0 = CFrame.new(offset.p * self.scale) * (offset - offset.p)
    local var3 = CFrame.new(moveOffset.p * self.scale) * (moveOffset - moveOffset.p)

    local part = self.parts[arg1]
    if not part then
        return
    end

    local mesh = part:FindFirstChild("Mesh")
    local weld = part:FindFirstChild("Weld")
    if weld then
        if arg2 then
            part.CFrame = self.origin.CFrame * c0 * var3
            weld.C0 = c0 * var3
        else
            part.CFrame = self.origin.CFrame * c0
            weld.C0 = c0
        end
    end
    if not mesh then
        return
    end

    if arg2 then
        mesh.VertexColor = Vector3.new(0.5, 0.5, 0.5)
        return
    end
    mesh.VertexColor = Vector3.new(1, 1, 1)
end

function module:setTriggerState(arg1)
    local offset = tbl1.Trigger.offset
    local var1 = CFrame.new(offset.p * self.scale) * (offset - offset.p)

    local trigger = self.parts.Trigger
    local weld = trigger:FindFirstChild("Weld")
    if not weld then
        return
    end

    local vec3 = Vector3.new(0, 0.05 * self.scale, -0.025 * self.scale)
    local rx = arg1 * -math.rad(20) + 0
    local c0 = var1 * CFrame.new(vec3) * CFrame.Angles(rx, 0, 0) * CFrame.new(-vec3)
    trigger.CFrame = self.origin.CFrame * c0
    weld.C0 = c0
end

function module:setTrackpadState(arg1)
    local trackpadIndicator = self.parts.TrackpadIndicator
    local weld = trackpadIndicator:FindFirstChild("Weld")
    local offset = tbl1.Trackpad.offset
    local var1 = CFrame.new(offset.p * self.scale) * (offset - offset.p)

    if not weld then
        return
    end

    local pos = Vector3.new(arg1.X, 0, -arg1.Y) * 0.055
    local var2 = CFrame.Angles(math.pi * 13 / 360, 0, 0) * CFrame.new(0, 0.002 * self.scale * arg1.magnitude ^ 3, 0)
    local c0 = var1 * CFrame.new(0, 0.01 * self.scale, 0) * var2:toWorldSpace(CFrame.new(pos))
    trackpadIndicator.CFrame = self.origin.CFrame * c0
    weld.C0 = c0
end

function module:onButtonInputChanged(arg1, arg2)
    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR3
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL3
    then
        self:setButtonState("Trackpad", arg2)
        return
    end

    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR1
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL1
    then
        self:setButtonState("LeftGrip", arg2)
        self:setButtonState("RightGrip", arg2)
        return
    end

    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonStart
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonSelect
    then
        self:setButtonState("MenuButton", arg2)
        return
    end

    if self.touchpadMode ~= Enum.VRTouchpadMode.ABXY then
        return
    end

    if arg1.KeyCode == Enum.KeyCode.ButtonA then
        self:setButtonState("ButtonA", arg2)
        return
    end
    if arg1.KeyCode == Enum.KeyCode.ButtonB then
        self:setButtonState("ButtonB", arg2)
        return
    end
    if arg1.KeyCode == Enum.KeyCode.ButtonX then
        self:setButtonState("ButtonX", arg2)
        return
    end
    if arg1.KeyCode == Enum.KeyCode.ButtonY then
        self:setButtonState("ButtonY", arg2)
    end
end

function module:onInputBegan(arg1)
    self:onButtonInputChanged(arg1, true)

    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.Thumbstick2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.Thumbstick1
    then
        self:setPartVisible("TrackpadIndicator", true)
    end
end

function module:onInputChanged(arg1)
    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL2
    then
        self:setTriggerState(arg1.Position.Z)
    end

    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.Thumbstick2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.Thumbstick1
    then
        self:setTrackpadState(arg1.Position)
    end
end

function module:onInputEnded(arg1)
    self:onButtonInputChanged(arg1, false)

    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.Thumbstick2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.Thumbstick1
    then
        self:setPartVisible("TrackpadIndicator", false)
    end
end

function module:onTouchpadModeChanged(touchpad, vrTouchpadMode)
    if touchpad ~= self.touchpad then
        return
    end

    self.touchpadMode = vrTouchpadMode

    if vrTouchpadMode == Enum.VRTouchpadMode.ABXY then
        self:setABXYEnabled(true)
        return
    end
    self:setABXYEnabled(false)
end

function module:destroy()
    if self.onTouchpadModeChangedConn then
        self.onTouchpadModeChangedConn:disconnect()
        self.onTouchpadModeChangedConn = nil
    end
    self.model:Destroy()
end

function module:getButtonPart(arg1)
    local var1 = tbl2[arg1]
    return if var1 then self.parts[var1] else nil
end

return module
