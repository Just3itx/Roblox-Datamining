-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommon = script:FindFirstAncestor("VrCommon")
local VrCommonParent = VrCommon.Parent

local Create = require(VrCommonParent.AppCommonLib).Create

local FIntVRTouchControllerTransparency = require(VrCommon.Flags.FIntVRTouchControllerTransparency)

local tbl1 = {
    [Enum.UserCFrame.RightHand] = {
        Body = {
            meshId = "rbxassetid://12954883737",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0)
        },
        Grip = {
            meshId = "rbxassetid://12954884971",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0.015, -0.078, 0.005) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(-0.01, 0.005, 0) * CFrame.Angles(0, 0, -math.rad(7))
        },
        Stick = {
            meshId = "rbxassetid://12954884012",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0.056, 0.027, -0.074) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.001, 0)
        },
        Trigger = {
            meshId = "rbxassetid://12954885295",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0.014, -0.049, -0.131) * CFrame.Angles(0, math.pi, 0)
        },
        MenuButton = {
            meshId = "rbxassetid://12954884231",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0.07, 0.017, -0.017) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.001, 0)
        },
        ButtonA = {
            meshId = "rbxassetid://12954884749",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(0.011, 0.014, -0.026) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.005, 0)
        },
        ButtonB = {
            meshId = "rbxassetid://12954884464",
            textureId = "rbxassetid://12954905146",
            offset = CFrame.new(-0.013, 0.015, -0.07) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.005, 0)
        }
    },
    [Enum.UserCFrame.LeftHand] = {
        Body = {
            meshId = "rbxassetid://12954878407",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0)
        },
        Grip = {
            meshId = "rbxassetid://12954878772",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(-0.015, -0.078, 0.005) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0.0125, 0.005, 0.001)
        },
        Stick = {
            meshId = "rbxassetid://12954879211",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(-0.056, 0.027, -0.074) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.001, 0)
        },
        Trigger = {
            meshId = "rbxassetid://12954878599",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(-0.014, -0.049, -0.131) * CFrame.Angles(0, math.pi, 0)
        },
        MenuButton = {
            meshId = "rbxassetid://12954879390",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(-0.07, 0.017, -0.017) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.001, 0)
        },
        ButtonX = {
            meshId = "rbxassetid://12954879064",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(-0.011, 0.013, -0.026) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.005, 0)
        },
        ButtonY = {
            meshId = "rbxassetid://12954878913",
            textureId = "rbxassetid://12954905425",
            offset = CFrame.new(0.013, 0.015, -0.07) * CFrame.Angles(0, math.pi, 0),
            moveOffset = CFrame.new(0, -0.005, 0)
        }
    }
}

local tbl2 = {
    [Enum.KeyCode.ButtonL1] = "Grip",
    [Enum.KeyCode.ButtonL2] = "Trigger",
    [Enum.KeyCode.ButtonL3] = "Stick",
    [Enum.KeyCode.ButtonR1] = "Grip",
    [Enum.KeyCode.ButtonR2] = "Trigger",
    [Enum.KeyCode.ButtonR3] = "Stick",
    [Enum.KeyCode.Thumbstick1] = "Stick",
    [Enum.KeyCode.Thumbstick2] = "Stick",
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

function module.new(userCFrame)
    local self = setmetatable({}, module)
    self.userCFrame = userCFrame

    self.model = Create("Model")({ Name = "TouchController", Archivable = false })

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

    for k, value in pairs(tbl1[userCFrame]) do
        local vec3 = Vector3.new(0.032, 0.032, 0.032)
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
            CanTouch = false,
            Transparency = FIntVRTouchControllerTransparency / 100
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

    self.model.PrimaryPart = self.origin

    return self
end

function module:setCFrame(arg1)
    if self.userCFrame == Enum.UserCFrame.RightHand then
        self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), 0, 0) * CFrame.new(-0.03, 0.08, -0.06))
        return
    end
    self.model:SetPrimaryPartCFrame(arg1 * CFrame.Angles(math.rad(20), 0, 0) * CFrame.new(0.03, 0.08, -0.06))
end

function module:setCFrameAndScale(arg1, scale)
    local num1 = if self.userCFrame == Enum.UserCFrame.RightHand then 1 else -1
    self.model:SetPrimaryPartCFrame(
        arg1 * CFrame.Angles(math.rad(20), 0, 0) * CFrame.new(-0.03 * scale * num1, 0.08 * scale, -0.06 * scale)
    )
    if self.scale == scale then
        return
    end

    self.scale = scale
    for k, value in pairs(tbl1[self.userCFrame]) do
        local part = self.parts[k]
        if not part then
            continue
        end

        local vec3 = Vector3.new(0.032, 0.032, 0.032)
        if value.scale then
            vec3 *= value.scale
        end

        local mesh = part:FindFirstChild("Mesh")
        local weld = part:FindFirstChild("Weld")

        local offset = value.offset
        local c0 = CFrame.new(offset.p * self.scale) * (offset - offset.p)
        part.CFrame = self.origin.CFrame * c0

        if mesh then
            mesh.Scale = vec3 * self.scale
        end
        if weld then
            weld.C0 = c0
        end
    end
end

function module:setButtonState(arg1, arg2)
    local var1 = tbl1[self.userCFrame][arg1]
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
    local offset = tbl1[self.userCFrame].Trigger.offset
    local var1 = CFrame.new(offset.p * self.scale) * (offset - offset.p)

    local trigger = self.parts.Trigger
    local weld = trigger:FindFirstChild("Weld")
    if not weld then
        return
    end

    local pos = Vector3.new(0, 0.05, 0.025) * self.scale

    local rx = arg1 * math.rad(20) + 0
    local c0 = var1 * CFrame.new(pos) * CFrame.Angles(rx, 0, 0) * CFrame.new(-pos)
    trigger.CFrame = self.origin.CFrame * c0
    weld.C0 = c0
end

function module:setStickState(arg1)
    local offset = tbl1[self.userCFrame].Stick.offset
    local var1 = CFrame.new(offset.p * self.scale) * (offset - offset.p)

    local stick = self.parts.Stick
    local weld = stick:FindFirstChild("Weld")
    if not weld then
        return
    end

    local pos = Vector3.new(-0.0008, -0.0269, 0.0013) * self.scale

    local rz = arg1.X * math.rad(20) + 0
    local rx = arg1.Y * math.rad(20) + 0
    local c0 = var1 * CFrame.new(pos) * CFrame.Angles(rx, 0, rz) * CFrame.new(-pos)
    stick.CFrame = self.origin.CFrame * c0
    weld.C0 = c0
end

function module:onInputPositionChanged(arg1)
    if self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL2
    then
        self:setTriggerState(arg1.Position.Z)
    elseif self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.Thumbstick2
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.Thumbstick1
    then
        self:setStickState(arg1.Position)
    end
end

function module:onButtonInputChanged(arg1, arg2)
    if self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL1
        or self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR1
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonL3
        or self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonR3
        or self.userCFrame == Enum.UserCFrame.LeftHand and arg1.KeyCode == Enum.KeyCode.ButtonSelect
        or self.userCFrame == Enum.UserCFrame.RightHand and arg1.KeyCode == Enum.KeyCode.ButtonStart
        or arg1.KeyCode == Enum.KeyCode.ButtonA
        or arg1.KeyCode == Enum.KeyCode.ButtonB
        or arg1.KeyCode == Enum.KeyCode.ButtonX
        or arg1.KeyCode == Enum.KeyCode.ButtonY
    then
        self:setButtonState(tbl2[arg1.KeyCode], arg2)
    end
end

function module.onInputBegan(arg1, arg2)
    arg1:onButtonInputChanged(arg2, true)
end

function module.onInputChanged(arg1, arg2)
    arg1:onInputPositionChanged(arg2)
end

function module.onInputEnded(arg1, arg2)
    arg1:onInputPositionChanged(arg2)
    arg1:onButtonInputChanged(arg2, false)
end

function module.onTouchpadModeChanged(_, _, _) end

function module:destroy()
    self.model:Destroy()
end

function module:getButtonPart(arg1)
    local var1 = tbl2[arg1]
    return if var1 then self.parts[var1] else nil
end

return module
