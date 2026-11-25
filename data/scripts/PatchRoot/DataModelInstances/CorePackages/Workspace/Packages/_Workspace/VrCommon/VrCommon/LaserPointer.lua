-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommon = script:FindFirstAncestor("VrCommon")
local VrCommonParent = VrCommon.Parent

local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local Create = require(VrCommonParent.AppCommonLib).Create
local VRUtil = require(VrCommon.VRUtil)

require(VrCommon.Panel3D)

local bool1 = game:DefineFastFlag("EnableUserInputCFrameLogging", false)
local engineFeature = game:GetEngineFeature("RenderCaptureAlwaysOnTopGui")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.Changed:wait()
    LocalPlayer = Players.LocalPlayer
end

local function fromLinearRGB(color3: Color3): Color3 -- Luacid: Inlined by compiler; 3 call sites recovered
    return Color3.new(color3.r ^ 2.2, color3.g ^ 2.2, color3.b ^ 2.2)
end

local function addPartsToGame(...)
    local tbl1 = { ... }
    local coreEffectFolder = GuiService.CoreEffectFolder

    if coreEffectFolder then
        for _, value in pairs(tbl1) do
            value.Parent = coreEffectFolder
            value.CanTouch = false
            value.CanCollide = false
            value.CanQuery = false
        end

        return
    end

    coroutine.wrap(function()
        while GuiService.Changed:wait() ~= "CoreEffectFolder" and GuiService.CoreEffectFolder == nil do

        end

        for _, value in pairs(tbl1) do
            value.Parent = coreEffectFolder
            value.CanTouch = false
            value.CanCollide = false
            value.CanQuery = false
        end
    end)()
end

local function removePartsFromGame(...)
    for _, value in pairs({ ... }) do
        value.Parent = nil
    end
end

local function getLocalHumanoid()
    local character = LocalPlayer.Character
    if not character then
        return
    end

    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Humanoid") then
            return child
        end
    end
end

local function applyExpCurve(arg1, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = arg1 ^ num1
    if var1 ~= var1 then
        var1 = math.abs(arg1) ^ num1
    end
    return var1
end

local Mode = { Disabled = 0, Pointer = 1, Navigation = 2, Hidden = 3, DualPointer = 4 }
local tbl2 = {
    MODE_ENABLED = true,
    ARC_COLOR_GOOD = fromLinearRGB(Color3.fromRGB(0, 162, 255)),
    ARC_COLOR_BAD = fromLinearRGB(Color3.fromRGB(253, 68, 72)),
    ARC_THICKNESS = 0.0125,
    PLOP_GOOD = "rbxasset://textures/ui/VR/VRPointerDiscBlue.png",
    PLOP_BAD = "rbxasset://textures/ui/VR/VRPointerDiscRed.png",
    PLOP_BALL_COLOR_GOOD = BrickColor.new("Bright green"),
    PLOP_BALL_COLOR_BAD = BrickColor.new("Bright red"),
    PLOP_BALL_SIZE = 0.5,
    PLOP_SIZE = 2,
    PLOP_PULSE_MIN_SIZE = 0,
    PLOP_PULSE_MAX_SIZE = 2,
    MAX_VALID_DISTANCE = 100,
    BUTTON_DOWN_THRESHOLD = 0.95,
    BUTTON_UP_THRESHOLD = 0.5,
    MIN_VELOCITY = 10,
    RANGE_T_EXP = 2,
    G = 10,
    PULSE_DURATION = 0.8,
    PULSE_PERIOD = 1,
    PULSE_EXP = 2,
    PULSE_SIZE_0 = 0.25,
    PULSE_SIZE_1 = 2,
    BALL_WAVE_PERIOD = 2,
    BALL_WAVE_AMPLITUDE = 0.5,
    BALL_WAVE_START = 0.25,
    BALL_WAVE_EXP = 0.8,
    FLOOR_OFFSET = 4.5,
    FADE_OUT_DURATION = 0.125,
    FADE_IN_DURATION = 0.125,
    TRANSITION_DURATION = 0.25
}
local tbl3 = {
    MODE_ENABLED = true,
    ARC_COLOR_GOOD = tbl2.ARC_COLOR_GOOD,
    ARC_COLOR_BAD = tbl2.ARC_COLOR_BAD,
    ARC_COLOR_HIT = fromLinearRGB(Color3.fromRGB(0, 255, 162)),
    ARC_THICKNESS = 0.01,
    MAX_DISTANCE = 50,
    G = 0,
    SWITCH_AIM_THRESHOLD = math.rad(15),
    TRANSITION_DURATION = 0.075
}

local vector2 = Vector2.new(0, 0)
local vector2_2 = Vector2.new(1, 1)

local module = {}
module.__index = module
module.Mode = Mode

function module.new(_)
    local self = setmetatable({}, module)

    self.laserMaxDistance = VRService.LaserDistance
    self.laserHand = 0

    self.inputUserCFrame = Enum.UserCFrame.RightHand
    self.equippedTool = false

    self.lastLaserModeHit = tick()

    self.guiMenuIsOpen = false
    self.externalForcePointer = false
    self.forceDotActive = true

    self.navHitPoint = Vector3.new(0, 0, 0)
    self.navHitNormal = Vector3.new(0, 1, 0)
    self.navHitPart = nil

    self.navigationIsValid = false
    self.lastNavigationValidityChangeTime = tick()
    self.plopBallBounceStart = tick()

    self.buttonPressStart = 0
    self.showPlopBallOnPointer = false

    self.parabola = Create("ParabolaAdornment")({
        Name = "LaserPointerParabola",
        Parent = CoreGui,
        A = -1,
        B = 2,
        C = 0,
        Color3 = nil,
        Thickness = tbl2.ARC_THICKNESS,
        Visible = false
    })

    self.originPart = Create("Part")({
        Name = "LaserPointerOrigin",
        Anchored = true,
        CanCollide = false,
        TopSurface = Enum.SurfaceType.SmoothNoOutlines,
        BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
        Material = Enum.Material.SmoothPlastic,
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    })

    self.parabola.Adornee = self.originPart

    self.parabolaOffhand = Create("ParabolaAdornment")({
        Name = "LaserPointerparabolaOffhand",
        Parent = CoreGui,
        A = 0,
        B = 1e-6,
        C = 0,
        Color3 = Color3.new(1, 1, 1),
        Transparency = 0.5,
        Thickness = tbl2.ARC_THICKNESS,
        Visible = false
    })

    self.originPartOffhand = Create("Part")({
        Name = "LaserPointerOriginOffhand",
        Anchored = true,
        CanCollide = false,
        TopSurface = Enum.SurfaceType.SmoothNoOutlines,
        BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
        Material = Enum.Material.SmoothPlastic,
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    })

    self.parabolaOffhand.Adornee = self.originPartOffhand

    self.plopPart = Create("Part")({
        Name = "LaserPointerTeleportPlop",
        Anchored = true,
        CanCollide = false,
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    })

    self.plopBall = Create("Part")({
        Name = "LaserPointerTeleportPlopBall",
        Anchored = true,
        CanCollide = false,
        TopSurface = Enum.SurfaceType.SmoothNoOutlines,
        BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
        Material = Enum.Material.Neon,
        BrickColor = tbl2.PLOP_BALL_COLOR_GOOD,
        Shape = Enum.PartType.Ball,
        Size = Vector3.new(1, 1, 1) * tbl2.PLOP_BALL_SIZE
    })
    self.plopAdorn = Create("ImageHandleAdornment")({
        Name = "LaserPointerTeleportPlopAdorn",
        Parent = self.plopPart,
        Adornee = self.plopPart,
        Size = vector2_2 * tbl2.PLOP_SIZE,
        Image = tbl2.PLOP_GOOD
    })
    self.plopAdornPulse = Create("ImageHandleAdornment")({
        Name = "LaserPointerTeleportPlopAdornPulse",
        Parent = self.plopPart,
        Adornee = self.plopPart,
        Size = vector2,
        Image = tbl2.PLOP_GOOD,
        Transparency = 0.5
    })

    self.cursorPart = Create("Part")(
        {
            Name = "Cursor",
            CanCollide = false,
            CanQuery = false,
            CanTouch = false,
            Anchored = true,
            Transparency = 1
        }
    )

    local var1 = Create("SurfaceGui")
    local tbl4 = {
        Name = "CursorSurfaceGui",
        Active = false,
        AlwaysOnTop = true,
        Enabled = false,
        ZOffset = 10,
        Adornee = if engineFeature then self.cursorPart else nil,
        Parent = if engineFeature then CoreGui else self.cursorPart
    }
    self.cursorSurfaceGui = var1(tbl4)

    self.cursorImage = Create("ImageLabel")({
        Image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
        ImageColor3 = Color3.new(0, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.cursorSurfaceGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0)
    })

    self.connections = {}

    local connections = self.connections
    local laserPointerChanged = VRService:GetPropertyChangedSignal("LaserPointer")

    table.insert(connections, laserPointerChanged:Connect(function()
        self:onModeChanged()
    end))

    self:onModeChanged()

    GuiService.MenuOpened:connect(function()
        self.guiMenuIsOpen = true
    end)
    GuiService.MenuClosed:connect(function()
        self.guiMenuIsOpen = false
    end)

    self.inputUserCFrame = VRService.GuiInputUserCFrame
    VRService.Changed:connect(function(property: string)
        if property == "GuiInputUserCFrame" then
            self.inputUserCFrame = VRService.GuiInputUserCFrame
        elseif property == "PointerHitCFrame" or property == "DidPointerHit" then
            self:cursorInputsChanged()
        elseif property == "VRSessionState" and VRService.VRSessionState == Enum.VRSessionState.Focused then
            self:updateInputUserCFrame()
        end
    end)

    VRService.LaserPointerTriggered:connect(function(input: InputObject)
        if game:GetEngineFeature("ImprovedTriggerFire") and input.UserInputState ~= Enum.UserInputState.End then
            return
        end

        if (input.KeyCode == Enum.KeyCode.ButtonR1
            or input.KeyCode == Enum.KeyCode.ButtonR2
            or input.KeyCode == Enum.KeyCode.ButtonR3
            or input.KeyCode == Enum.KeyCode.ButtonA
            or input.KeyCode == Enum.KeyCode.ButtonB)
            and self.laserHand ~= 0
        then
            self.laserHand = 0
            self:updateInputUserCFrame()
        elseif (input.KeyCode == Enum.KeyCode.ButtonL1
            or input.KeyCode == Enum.KeyCode.ButtonL2
            or input.KeyCode == Enum.KeyCode.ButtonL3
            or input.KeyCode == Enum.KeyCode.ButtonX
            or input.KeyCode == Enum.KeyCode.ButtonY)
            and self.laserHand ~= 1
        then
            self.laserHand = 1
            self:updateInputUserCFrame()
        end
    end)

    VRService.UserCFrameEnabled:Connect(function(_userCFrame: Enum.UserCFrame, _: boolean)
        self:updateInputUserCFrame()
    end)

    self:updateInputUserCFrame()

    return self
end

function module.hasAnyHandController(): boolean
    return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
end

function module.getModeName(arg1)
    for k, value in pairs(Mode) do
        if arg1 == value then
            return k
        end
    end

    return "unknown"
end

function module:updateInputUserCFrame()
    local guiInputUserCFrame = if bool1 then VRService.GuiInputUserCFrame else nil

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and self.laserHand == 0 then
        VRService.GuiInputUserCFrame = Enum.UserCFrame.RightHand
    elseif VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) and self.laserHand == 1 then
        VRService.GuiInputUserCFrame = Enum.UserCFrame.LeftHand
    elseif VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        VRService.GuiInputUserCFrame = Enum.UserCFrame.RightHand
    elseif VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        VRService.GuiInputUserCFrame = Enum.UserCFrame.LeftHand
    else
        VRService.GuiInputUserCFrame = Enum.UserCFrame.Head
    end
    if bool1 and guiInputUserCFrame ~= VRService.GuiInputUserCFrame then
        print("Updated GuiInputUserCFrame is: " .. tostring(VRService.GuiInputUserCFrame))
    end
end

function module:onModeChanged(_)
    self:updateInputUserCFrame()

    if VRService.LaserPointer == Enum.VRLaserPointerMode.Disabled then
        addPartsToGame(self.originPart, self.cursorPart)
        removePartsFromGame(self.plopPart, self.plopBall, self.originPartOffhand)
        self.forceDotActive = true
        self.parabola.Visible = false
        self.parabolaOffhand.Visible = false
        self:setNavigationActionEnabled(false)
        return
    end
    if VRService.LaserPointer == Enum.VRLaserPointerMode.Pointer then
        addPartsToGame(self.originPart, self.cursorPart)
        removePartsFromGame(self.plopPart, self.plopBall, self.originPartOffhand)
        self.parabola.Visible = true
        self.parabolaOffhand.Visible = false
        self:setNavigationActionEnabled(false)
        self.forceDotActive = false
    elseif VRService.LaserPointer == Enum.VRLaserPointerMode.DualPointer then
        addPartsToGame(self.originPart, self.originPartOffhand, self.cursorPart)
        removePartsFromGame(self.plopPart, self.plopBall)
        self.parabola.Visible = true
        self.parabolaOffhand.Visible = true
        self:setNavigationActionEnabled(false)
        self.forceDotActive = false
    end
end

function module.setMode(_, arg1)
    if arg1 == Mode.Disabled or arg1 == Mode.Hidden then
        VRService.LaserPointer = Enum.VRLaserPointerMode.Disabled
    elseif arg1 == Mode.Pointer or arg1 == Mode.Navigation then
        VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
    elseif arg1 == Mode.DualPointer then
        VRService.LaserPointer = Enum.VRLaserPointerMode.DualPointer
    end
end

function module.setEnableAmbidexterousPointer(_, _) end

function module.calculateLaunchVelocity(_, arg1, arg2, arg3)
    return -(math.sqrt(arg1 / (math.sqrt(2) / 2)) * arg2) / math.sqrt(2 * arg3 * (math.sqrt(2) / 2) + 2 * arg2 * 0.7071067811865475)
end

function module:isHeadMounted(): boolean
    return VRService.GuiInputUserCFrame == Enum.UserCFrame.Head
end

function module:shouldForcePointer()
    return self.externalForcePointer or self.guiMenuIsOpen
end

function module:setForcePointer(externalForcePointer)
    self.externalForcePointer = externalForcePointer
end

function module.getNavigationOrigin(_)
    local localHumanoid = getLocalHumanoid()
    if not localHumanoid then
        return
    end

    local torso = localHumanoid.Torso
    if torso then
        local hipHeight = localHumanoid.HipHeight
        local var1 = if localHumanoid.RigType == Enum.HumanoidRigType.R6 then 2 else hipHeight

        local var2 = torso.Size.Y / 2
        return torso.Position + Vector3.new(0, -var2 - var1, 0)
    end
end

function module.horzDistanceFromCharacter(_, arg1)
    local character = LocalPlayer.Character
    if not character then
        return math.huge
    end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        return ((humanoidRootPart:GetRenderCFrame().p - arg1) * Vector3.new(1, 0, 1)).magnitude
    end

    return math.huge
end

function module:onNavigateAction(_, userInputState, _)
    if userInputState == Enum.UserInputState.Begin then
        VRService:RequestNavigation(
            CFrame.new(self.navHitPoint, self.navHitPoint + self.navHitNormal) * CFrame.Angles(math.pi / 2, 0, 0),
            self.inputUserCFrame
        )
    end
end

function module:setNavigationActionEnabled(arg1)
    if arg1 then
        ContextActionService:BindCoreAction("LaserPointerNavigate", function(...)
            self:onNavigateAction(...)
        end, false, Enum.KeyCode.ButtonA)

        return
    end
    ContextActionService:UnbindCoreAction("LaserPointerNavigate")
end

function module:setArcLaunchParams(arg1, arg2, arg3, arg4)
    local var1 = math.cos(arg1) * arg2
    local var2 = math.sin(arg1) * arg2

    local var3 = if var1 == 0 then 1e-6 else var1

    self.parabola.A = -(0.5 * arg3) * (1 / var3 ^ 2)
    self.parabola.B = var2 / var3
    self.parabola.C = 0
    self.parabola.Range = arg4 * 1.5
end

function module:renderAsParabola(pos: Vector3, arg1)
    local var1 = arg1 * Vector3.new(1, 0, 1)
    self.originPart.CFrame = CFrame.new(pos, pos + var1) * CFrame.Angles(0, math.pi / 2, 0)
end

function module:renderAsLaser(pos: Vector3, lookAt: Vector3)
    self.originPart.CFrame = CFrame.new(pos, lookAt) * CFrame.Angles(0, math.pi / 2, 0)
    self.parabola.A = 0
    self.parabola.B = 1e-6
    self.parabola.C = 0
    self.parabola.Range = (lookAt - pos).magnitude
end

function module:renderOffhandLaser(pos: Vector3, lookAt: Vector3)
    self.originPartOffhand.CFrame = CFrame.new(pos, lookAt) * CFrame.Angles(0, math.pi / 2, 0)
    self.parabolaOffhand.Range = (lookAt - pos).magnitude
end

function module:canNavigateTo(arg1, _, arg2): boolean
    local character = LocalPlayer.Character
    return if character then if character:FindFirstChild("HumanoidRootPart") then if arg1 then not (arg2.Y < -1e-6) else false else false else false
end

function module.checkHeadMountedMode(arg1, arg2)
    if arg1:shouldForcePointer() then
        arg1:setMode(Mode.Pointer)
        return
    end

    local coreGuiFolder = GuiService.CoreGuiFolder
    if arg2 and arg2:IsDescendantOf(coreGuiFolder) then
        arg1:setMode(Mode.Pointer)
        return
    end
    arg1:setMode(Mode.Navigation)
end

function module:setNavigationValidState(navigationIsValid)
    if navigationIsValid == self.navigationIsValid then
        return
    end
    self.navigationIsValid = navigationIsValid
    self.lastNavigationValidityChangeTime = tick()

    if navigationIsValid then
        self.plopBallBounceStart = tick()
        self.parabola.Color3 = tbl2.ARC_COLOR_GOOD
        self.plopAdorn.Visible = true
        self.plopAdorn.Image = tbl2.PLOP_GOOD
        self.plopAdornPulse.Visible = true
        self.plopAdornPulse.Image = tbl2.PLOP_GOOD
        self.plopBall.BrickColor = tbl2.PLOP_BALL_COLOR_GOOD
        return
    end
    self.parabola.Color3 = tbl2.ARC_COLOR_BAD
    self.plopAdorn.Visible = false
    self.plopAdorn.Image = tbl2.PLOP_BAD
    self.plopAdornPulse.Visible = false
    self.plopAdornPulse.Image = tbl2.PLOP_BAD
    self.plopBall.BrickColor = tbl2.PLOP_BALL_COLOR_BAD
end

function module:updateNavPlop(pos: Vector3, arg1)
    local var1 = tick() - self.plopBallBounceStart

    local cFrame = CFrame.new(pos, pos + arg1)
    local var2

    if self.navigationIsValid then
        local var3 = var1 * 2 * math.pi / tbl2.BALL_WAVE_PERIOD
        local var4 = applyExpCurve(math.sin(var3), tbl2.BALL_WAVE_EXP)
        var2 = tbl2.BALL_WAVE_START + var4 * tbl2.BALL_WAVE_AMPLITUDE
    else
        var2 = 0
    end

    self.plopPart.CFrame = cFrame
    self.plopBall.CFrame = cFrame * CFrame.new(0, 0, -var2)

    local var3 = var1 % tbl2.PULSE_PERIOD
    if not (var3 > 0) then
        return
    end

    local var4 = var3 / tbl2.PULSE_DURATION
    if var4 < 1 then
        self.plopAdornPulse.Visible = true
        self.plopAdornPulse.Size = vector2_2 * (tbl2.PULSE_SIZE_0 + applyExpCurve(var4, tbl2.PULSE_EXP) * (tbl2.PULSE_SIZE_1 - tbl2.PULSE_SIZE_0))

        self.plopAdornPulse.Transparency = 0.5 + var4 * 0.5
        return
    end
    self.plopAdornPulse.Visible = false
    self.plopAdornPulse.Size = vector2
    self.pulseStartTime = tick() + tbl2.PULSE_PERIOD
end

function module:updateNavigationMode(navHitPoint, navHitNormal, navHitPart)
    self.navHitPoint = navHitPoint
    self.navHitNormal = navHitNormal
    self.navHitPart = navHitPart

    self:updateNavPlop(navHitPoint, navHitNormal)
    self:setNavigationValidState(self:canNavigateTo(self.navHitPart, self.navHitPoint, self.navHitNormal))
end

function module:showHitBallOnLaserPointer(arg1)
    if arg1 then
        if not self.showPlopBallOnPointer then
            self.showPlopBallOnPointer = true
            addPartsToGame(self.plopBall)
        end
    elseif self.showPlopBallOnPointer then
        removePartsFromGame(self.plopBall)
        self.showPlopBallOnPointer = false
    end
end

function module:cursorInputsChanged()
    local didPointerHit = VRService.DidPointerHit
    self.cursorSurfaceGui.Enabled = didPointerHit
    if not didPointerHit then
        return
    end

    local pointerHitCFrame = VRService.PointerHitCFrame

    local var1 = (VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head).Position - pointerHitCFrame.Position).magnitude * 0.01
    local var2

    if var1 < 0.05 then
        var2 = var1 / 0.05
        var1 = 0.05
    else
        var2 = 1
    end

    self.cursorPart.Size = Vector3.new(var1, var1, var1)
    local cFrame = CFrame.new(0, 0, var1 * 0.5)
    self.cursorPart.CFrame = pointerHitCFrame * cFrame
    self.cursorImage.Size = UDim2.new(var2, 0, var2, 0)
end

function module:updateCursor_DEPRECATED()
    if VRService.DidPointerHit then
        local pointerHitCFrame = VRService.PointerHitCFrame
        local userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(self.inputUserCFrame)

        if self:isHeadMounted() then
            userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head)
        end

        local p = userCFrameWorldSpace.p
        local lookVector = userCFrameWorldSpace.lookVector

        local pointerHitCFramePosition = pointerHitCFrame.Position
        local lookVector2 = pointerHitCFrame.lookVector
        local num1 = lookVector2:Dot(lookVector)
        if math.abs(num1) > 0.001 then
            local var1 = p + (pointerHitCFramePosition - p):Dot(lookVector2) / num1 * lookVector
            pointerHitCFrame = pointerHitCFrame.Rotation + var1
        end

        local var1 = (workspace.CurrentCamera.CFrame.Position - pointerHitCFrame.Position).magnitude * 0.01
        local var2

        if var1 < 0.05 then
            var2 = var1 / 0.05
            var1 = 0.05
        else
            var2 = 1
        end

        self.cursorPart.Size = Vector3.new(var1, var1, var1)
        local cFrame = CFrame.new(0, 0, var1 * 0.5)
        self.cursorPart.CFrame = pointerHitCFrame * cFrame
        self.cursorImage.Size = UDim2.new(var2, 0, var2, 0)
    end
    self.cursorSurfaceGui.Enabled = VRService.DidPointerHit
end

function module:disableComponent()
    removePartsFromGame(
        self.parabola,
        self.parabolaOffhand,
        self.originPart,
        self.originPartOffhand,
        self.plopPart,
        self.plopBall,
        self.cursorPart
    )
    if engineFeature then
        removePartsFromGame(self.cursorSurfaceGui)
    end
    self:setNavigationActionEnabled(false)
    for _, connection in pairs(self.connections) do
        connection:Disconnect()
    end
    self.connections = {}
end

function module:update(_)
    if VRService.LaserPointer == Enum.VRLaserPointerMode.Disabled then
        return
    end

    self.parabola.Thickness = tbl3.ARC_THICKNESS * workspace.CurrentCamera.HeadScale
    self.parabolaOffhand.Thickness = tbl3.ARC_THICKNESS * workspace.CurrentCamera.HeadScale

    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        self.parabola.Color3 = tbl3.ARC_COLOR_BAD
    else
        self.parabola.Color3 = VRService.DidPointerHit and tbl3.ARC_COLOR_HIT or tbl3.ARC_COLOR_GOOD
    end

    local userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(self.inputUserCFrame)
    local p = userCFrameWorldSpace.p
    local lookVector = userCFrameWorldSpace.lookVector
    local var1 = if VRService.DidPointerHit then p + lookVector * (VRService.PointerHitCFrame.Position - p).magnitude else p + lookVector * self.laserMaxDistance

    if self:isHeadMounted() then
        self.parabola.Visible = false
    else
        self.parabola.Visible = true
        self:renderAsLaser(p, var1)
    end

    if VRService.LaserPointer ~= Enum.VRLaserPointerMode.DualPointer then
        return
    end

    if self:isHeadMounted() then
        self.parabolaOffhand.Visible = false
        return
    end
    self.parabolaOffhand.Visible = true
    local userCFrame = if self.inputUserCFrame == Enum.UserCFrame.RightHand then Enum.UserCFrame.LeftHand else Enum.UserCFrame.RightHand
    local userCFrameWorldSpace2 = VRUtil.GetUserCFrameWorldSpace(userCFrame)
    local p2 = userCFrameWorldSpace2.p
    self:renderOffhandLaser(p2, p2 + userCFrameWorldSpace2.lookVector * 3)
end

return module
