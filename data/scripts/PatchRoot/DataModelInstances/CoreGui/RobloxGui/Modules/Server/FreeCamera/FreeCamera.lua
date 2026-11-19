-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local abs = math.abs
local clamp = math.clamp
local exp = math.exp
local rad = math.rad
local sign = math.sign
local sqrt = math.sqrt
local tan = math.tan

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local GameSettings = UserSettings().GameSettings
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local PlayerGui = nil
local Freecam = nil

local CurrentCamera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    local currentCamera = Workspace.CurrentCamera
    if currentCamera then
        CurrentCamera = currentCamera
    end
end)

local depthOfFieldEffect = nil
local textLabel = nil
local var1 = nil

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock")
end)
local var2 = success and result

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserShowGuiHideToggles")
end)
local var3 = success2 and result2

local success3, result3 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFixFreecamDeltaTimeCalculation")
end)
local var4 = success3 and result3

local success4, result4 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFixFreecamGuiChangeVisibility2")
end)
local var5 = success4 and result4

local success5, result5 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamControlSpeed")
end)
local var6 = success5 and result5

local success6, result6 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamTiltControl")
end)
local var7 = success6 and result6

local success7, result7 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamSmoothnessControl")
end)
local var8 = success7 and result7

local success8, result8 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamGuiDestabilization")
end)
local var9 = success8 and result8

local success9, result9 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamDepthOfFieldEffect3")
end)
local var10 = success9 and result9

local success10, result10 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamPlayerLock2")
end)
local var11 = success10 and result10

local success11, result11 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamPlayerLockResetHeight")
end)
local var12 = success11 and result11

local success12, result12 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamCustomGui")
end)
local var13 = success12 and result12

local LowValue = Enum.ContextActionPriority.Low.Value
local HighValue = Enum.ContextActionPriority.High.Value
local tbl1 = { Enum.KeyCode.LeftShift, Enum.KeyCode.P }
local tbl2 = {
    [Enum.KeyCode.Z] = true,
    [Enum.KeyCode.C] = true
}
local tbl3 = {
    [Enum.KeyCode.ButtonL1] = true,
    [Enum.KeyCode.ButtonR1] = true
}
local tbl4 = {
    [Enum.KeyCode.BackSlash] = true
}
local tbl5 = {
    [Enum.KeyCode.Slash] = true
}
local tbl6 = {
    [Enum.KeyCode.R] = true,
    [Enum.KeyCode.T] = true
}
local tbl7 = {
    [Enum.KeyCode.G] = true
}

local tbl8 = {
    [Enum.KeyCode.X] = true
}

local tbl9 = {
    [Enum.KeyCode.L] = true
}

local var14 = Vector2.new(0.75, 1) * 8

local num1 = 1.5
local num2 = 1
local num3 = 4
local num4 = 1

local tbl10 = ({})
local num5 = 0

local tbl11 = {}

local connection = nil
local connection2 = nil
local connection3 = nil
local connection4 = nil
local connection5 = nil

local bool1 = false
local z = 20
local y = 0
local tbl12 = {}
local num6 = 1
local var15 = nil

local bool2 = false
local enabled = false

local tbl13 = {}
tbl13.__index = tbl13

function tbl13.new(f, p)
    local self = setmetatable({}, tbl13)
    self.f = f
    self.p = p
    self.v = p * 0
    return self
end

function tbl13:Update(arg1, arg2)
    local var16 = self.f * 2 * math.pi
    local p = self.p
    local v = self.v

    local var17 = arg2 - p
    local var18 = exp(-var16 * arg1)

    local var19 = arg2 + (v * arg1 - var17 * (var16 * arg1 + 1)) * var18
    local var20 = (var16 * arg1 * (var17 * var16 - v) + v) * var18

    self.p = var19
    self.v = var20

    return var19
end

function tbl13:SetFreq(f)
    self.f = f
end

function tbl13:Reset(p)
    self.p = p
    self.v = p * 0
end

local vec3 = Vector3.new()
local var16 = if var7 then Vector3.new() else Vector2.new()
local num7 = 0

local var17 = tbl13.new(num1, Vector3.new())
local var18 = tbl13.new(num2, Vector2.new())
local var19 = tbl13.new(num3, 0)
local var20 = tbl13.new(num4, 0)

local tbl14 = {}

local function fCurve(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (exp(2 * arg1) - 1) / 6.38905609893065
end

local function fDeadzone(arg1) -- Luacid: unused: defined but never referenced
    return fCurve((arg1 - 0.15) / 0.85)
end

local function thumbstickCurve(arg1)
    return sign(arg1) * clamp(fCurve((abs(arg1) - 0.15) / 0.85), 0, 1)
end

local tbl15 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    DPadLeft = 0,
    DPadRight = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    ButtonL1 = 0,
    ButtonR1 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
}

local tbl16 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    U = 0,
    H = 0,
    J = 0,
    K = 0,
    I = 0,
    Y = 0,
    Up = 0,
    Down = 0,
    Left = 0,
    Right = 0,
    LeftShift = 0,
    RightShift = 0,
    Z = 0,
    C = 0,
    Comma = 0,
    Period = 0,
    LeftBracket = 0,
    RightBracket = 0,
    Semicolon = 0,
    Quote = 0,
    V = 0,
    B = 0,
    N = 0,
    M = 0,
    BackSlash = 0,
    Minus = 0,
    Equals = 0,
    Slash = 0,
    R = 0,
    T = 0,
    G = 0,
    X = 0,
    L = 0
}

local tbl17 = {
    Delta = Vector2.new(),
    MouseWheel = 0
}

local var21 = Vector2.new(1, 1) * (math.pi / 64)
local var22 = var21 / 60
local var23 = Vector2.new(1, 1) * (math.pi / 8)

local tbl18 = {
    FarIntensity = { ADJ = 0.1, MIN = 0, MAX = 1 },
    NearIntensity = { ADJ = 0.1, MIN = 0, MAX = 1 },
    FocusDistance = { ADJ = 20, MIN = 0, MAX = 200 },
    FocusRadius = { ADJ = 5, MIN = 0, MAX = 50 }
}

local getNavSpeed = 1
local getRollSpeed = 1
local getFovSpeed = 1

function tbl14.Vel(num11: number)
    if var6 then
        getNavSpeed = clamp(getNavSpeed + num11 * (tbl16.Up - tbl16.Down + tbl15.DPadUp - tbl15.DPadDown) * 0.75, 0.01, 4)
    else
        getNavSpeed = clamp(getNavSpeed + num11 * (tbl16.Up - tbl16.Down) * 0.75, 0.01, 4)
    end
    local var24 = Vector3.new(
        thumbstickCurve(tbl15.Thumbstick1.X),
        thumbstickCurve(tbl15.ButtonR2) - thumbstickCurve(tbl15.ButtonL2),
        thumbstickCurve(-tbl15.Thumbstick1.Y)
    ) * Vector3.new(1, 1, 1)

    local var25 = Vector3.new(
        tbl16.D - tbl16.A + tbl16.K - tbl16.H,
        tbl16.E - tbl16.Q + tbl16.I - tbl16.Y,
        tbl16.S - tbl16.W + tbl16.J - tbl16.U
    ) * Vector3.new(1, 1, 1)

    local isKeyDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)

    return (var24 + var25) * (getNavSpeed * (if isKeyDown then 0.25 else 1))
end

function tbl14.Pan(num11: number)
    local var24 = Vector2.new(thumbstickCurve(tbl15.Thumbstick2.Y), thumbstickCurve(-tbl15.Thumbstick2.X)) * var23
    local var25 = tbl17.Delta * var21
    if var4 and num11 > 0 then
        var25 = tbl17.Delta / num11 * var22
    end

    tbl17.Delta = Vector2.new()
    return var24 + var25
end

function tbl14.Fov(num11: number)
    if var6 then
        getFovSpeed = clamp(getFovSpeed + num11 * (tbl16.Right - tbl16.Left + tbl15.DPadRight - tbl15.DPadLeft) * 0.75, 0.01, 4)
    end
    local num12 = (tbl15.ButtonX - tbl15.ButtonY) * 0.25
    local num13 = tbl17.MouseWheel * 1
    if var4 and num11 > 0 then
        num13 = tbl17.MouseWheel / num11 * (1 / 60)
    end

    tbl17.MouseWheel = 0
    return if var6 then (num12 + num13) * getFovSpeed else num12 + num13
end

function tbl14.Roll(num11: number)
    getRollSpeed = clamp(getRollSpeed + num11 * (tbl16.Period - tbl16.Comma) * 0.75, 0.01, 4)

    return ((tbl15.ButtonR1 - tbl15.ButtonL1) * 1 + (tbl16.C - tbl16.Z) * 1) * getRollSpeed
end

function tbl14.SpringControl(num11: number)
    if var10 then
        local isKeyDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
        local isKeyDown2 = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)

        if isKeyDown or isKeyDown2 then
            return
        end
    end

    num1 = clamp(num1 + num11 * (tbl16.RightBracket - tbl16.LeftBracket) * 0.75, 0.01, 10)
    var17:SetFreq(num1)

    num2 = clamp(num2 + num11 * (tbl16.Quote - tbl16.Semicolon) * 0.75, 0.01, 10)
    var18:SetFreq(num2)

    num3 = clamp(num3 + num11 * (tbl16.B - tbl16.V) * 0.75, 0.01, 10)
    var19:SetFreq(num3)

    num4 = clamp(num4 + num11 * (tbl16.M - tbl16.N) * 0.75, 0.01, 10)
    var20:SetFreq(num4)
end

function tbl14.DoF(num11: number)
    local isKeyDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    local isKeyDown2 = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)

    if isKeyDown then
        local var24 = depthOfFieldEffect
        var24.FarIntensity = clamp(
            depthOfFieldEffect.FarIntensity + num11 * (tbl16.RightBracket - tbl16.LeftBracket) * tbl18.FarIntensity.ADJ,
            tbl18.FarIntensity.MIN,
            tbl18.FarIntensity.MAX
        )
        local var25 = depthOfFieldEffect
        var25.InFocusRadius = clamp(
            depthOfFieldEffect.InFocusRadius + num11 * (tbl16.Equals - tbl16.Minus) * tbl18.FocusRadius.ADJ,
            tbl18.FocusRadius.MIN,
            tbl18.FocusRadius.MAX
        )
    elseif isKeyDown2 then
        local var24 = depthOfFieldEffect
        var24.NearIntensity = clamp(
            depthOfFieldEffect.NearIntensity + num11 * (tbl16.RightBracket - tbl16.LeftBracket) * tbl18.NearIntensity.ADJ,
            tbl18.NearIntensity.MIN,
            tbl18.NearIntensity.MAX
        )
    else
        local var24 = depthOfFieldEffect
        var24.FocusDistance = clamp(
            depthOfFieldEffect.FocusDistance + num11 * (tbl16.Equals - tbl16.Minus) * tbl18.FocusDistance.ADJ,
            tbl18.FocusDistance.MIN,
            tbl18.FocusDistance.MAX
        )
    end
end

local function resetKeys(arg1, arg2) -- Luacid: Inlined by compiler; 8 call sites recovered
    for k, _ in pairs(arg1) do
        if arg2[k.Name] then
            arg2[k.Name] = 0
        end
    end
end

local function handleDoubleTapReset(keyCode)
    local now = os.clock()

    local var24 = tbl10[keyCode]
    local var25 = var24 and now - var24 or -1

    if var24 and var25 <= 0.25 and now - num5 >= 0.1 then
        var16 = Vector3.new(var16.x, var16.y, 0)
        var20:Reset(0)
        if var10 then
            resetKeys(tbl3, tbl15)
            resetKeys(tbl2, tbl16)
        else
            tbl15.ButtonL1 = 0
            tbl15.ButtonR1 = 0
            tbl16.C = 0
            tbl16.Z = 0
        end
        num5 = now
    end

    tbl10[keyCode] = now
end

local function findPlayerLockRootPart(arg1)
    if not tbl12 or #tbl12 < 1 then
        return nil
    end

    for _ = 1, #tbl12 do
        num6 = (num6 - 1 + arg1) % #tbl12 + 1

        local var24 = tbl12[num6]
        local character = var24 and var24.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.RootPart then
                return humanoid.RootPart
            end
        end

        if arg1 == 0 then
            arg1 = 1
        end
    end

    bool1 = false
    return nil
end

local function Keypress(_: string, userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    tbl16[inputObject.KeyCode.Name] = if userInputState == Enum.UserInputState.Begin then 1 else 0

    if var7 and tbl2[inputObject.KeyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
        handleDoubleTapReset(inputObject.KeyCode)
    end

    if var10 and tbl4[inputObject.KeyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
        if not depthOfFieldEffect.Enabled then
            tbl11 = {}

            for _, child in ipairs(CurrentCamera:GetChildren()) do
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    tbl11[#tbl11 + 1] = child
                    child.Enabled = false
                end
            end
            for _, child in ipairs(Lighting:GetChildren()) do
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    tbl11[#tbl11 + 1] = child
                    child.Enabled = false
                end
            end
            connection2 = CurrentCamera.ChildAdded:Connect(function(child: Instance)
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    tbl11[#tbl11 + 1] = child
                    child.Enabled = false
                end
            end)
            connection3 = Lighting.ChildAdded:Connect(function(child: Instance)
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    tbl11[#tbl11 + 1] = child
                    child.Enabled = false
                end
            end)
        else
            for _, value in ipairs(tbl11) do
                if value.Parent then
                    value.Enabled = true
                end
            end
            if connection2 then
                connection2:Disconnect()
                connection2 = nil
            end
            if connection3 then
                connection3:Disconnect()
                connection3 = nil
            end
            tbl11 = {}
        end
        depthOfFieldEffect.Enabled = not depthOfFieldEffect.Enabled
        resetKeys(tbl4, tbl16)
    end

    if var11 then
        if tbl5[inputObject.KeyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
            bool1 = not bool1
            if bool1 then
                z = 20
                if var12 then
                    y = 0
                end
                var15 = findPlayerLockRootPart(0)
            end
            resetKeys(tbl5, tbl16)
        end
        if tbl6[inputObject.KeyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
            if bool1 and #tbl12 > 0 then
                local num11 = tbl16.T - tbl16.R
                var15 = findPlayerLockRootPart(num11)
            end
            resetKeys(tbl6, tbl16)
        end
    end

    if var13 then
        if tbl7[inputObject.keyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
            if Freecam and Freecam.Parent then
                Freecam.Enabled = not Freecam.Enabled
            end
            resetKeys(tbl7, tbl16)
        end

        if tbl8[inputObject.keyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
            bool2 = not bool2
            if var1 then
                local screenGuis = var1.getScreenGuis()
                for _, value in pairs(screenGuis) do
                    if value.Parent and value ~= Freecam then
                        value.Enabled = bool2
                    end
                end
            end
            resetKeys(tbl8, tbl16)
        end

        if tbl9[inputObject.keyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
            enabled = not enabled
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, enabled)
            resetKeys(tbl9, tbl16)
        end
    end

    return Enum.ContextActionResult.Sink
end

local function GpButton(_: string, userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    tbl15[inputObject.KeyCode.Name] = if userInputState == Enum.UserInputState.Begin then 1 else 0

    if var7 and tbl3[inputObject.KeyCode] and inputObject.UserInputState == Enum.UserInputState.Begin then
        handleDoubleTapReset(inputObject.KeyCode)
    end

    return Enum.ContextActionResult.Sink
end

local function MousePan(_: string, _userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    local delta = inputObject.Delta
    tbl17.Delta = Vector2.new(-delta.y, -delta.x)
    return Enum.ContextActionResult.Sink
end

local function Thumb(_: string, _userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    tbl15[inputObject.KeyCode.Name] = inputObject.Position
    return Enum.ContextActionResult.Sink
end

local function Trigger(_: string, _userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    tbl15[inputObject.KeyCode.Name] = inputObject.Position.z
    return Enum.ContextActionResult.Sink
end

local function MouseWheel(_: string, _userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult
    tbl17[inputObject.UserInputType.Name] = -inputObject.Position.z
    return Enum.ContextActionResult.Sink
end

local function Zero(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    for k, value in pairs(arg1) do
        arg1[k] = value * 0
    end
end

function tbl14.StartCapture()
    if var6 then
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboard",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.W,
            Enum.KeyCode.U,
            Enum.KeyCode.A,
            Enum.KeyCode.H,
            Enum.KeyCode.S,
            Enum.KeyCode.J,
            Enum.KeyCode.D,
            Enum.KeyCode.K,
            Enum.KeyCode.E,
            Enum.KeyCode.I,
            Enum.KeyCode.Q,
            Enum.KeyCode.Y
        )
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardControlSpeed",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.Up,
            Enum.KeyCode.Down,
            Enum.KeyCode.Left,
            Enum.KeyCode.Right
        )
        ContextActionService:BindActionAtPriority(
            "FreecamGamepadControlSpeed",
            GpButton,
            false,
            HighValue,
            Enum.KeyCode.DPadUp,
            Enum.KeyCode.DPadDown,
            Enum.KeyCode.DPadLeft,
            Enum.KeyCode.DPadRight
        )
    else
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboard",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.W,
            Enum.KeyCode.U,
            Enum.KeyCode.A,
            Enum.KeyCode.H,
            Enum.KeyCode.S,
            Enum.KeyCode.J,
            Enum.KeyCode.D,
            Enum.KeyCode.K,
            Enum.KeyCode.E,
            Enum.KeyCode.I,
            Enum.KeyCode.Q,
            Enum.KeyCode.Y,
            Enum.KeyCode.Up,
            Enum.KeyCode.Down
        )
    end
    if var7 then
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardTiltControl",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.Z,
            Enum.KeyCode.C
        )
        ContextActionService:BindActionAtPriority(
            "FreecamGamepadTiltControl",
            GpButton,
            false,
            HighValue,
            Enum.KeyCode.ButtonL1,
            Enum.KeyCode.ButtonR1
        )
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardTiltControlSpeed",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.Comma,
            Enum.KeyCode.Period
        )
        if var8 then
            ContextActionService:BindActionAtPriority(
                "FreecamKeyboardSmoothnessControl",
                Keypress,
                false,
                HighValue,
                Enum.KeyCode.LeftBracket,
                Enum.KeyCode.RightBracket,
                Enum.KeyCode.Semicolon,
                Enum.KeyCode.Quote,
                Enum.KeyCode.V,
                Enum.KeyCode.B,
                Enum.KeyCode.N,
                Enum.KeyCode.M
            )
        end
    end
    if var10 then
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardDoFToggle",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.BackSlash
        )
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardDoFControls",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.Minus,
            Enum.KeyCode.Equals
        )
    end
    if var11 then
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardPlayerLockToggle",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.Slash
        )
        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardPlayerLockSwitch",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.R,
            Enum.KeyCode.T
        )
    end
    if var13 then
        ContextActionService:BindActionAtPriority("FreecamKeyboardCustomGuiToggle", Keypress, false, HighValue, Enum.KeyCode.G)

        ContextActionService:BindActionAtPriority("FreecamKeyboardPlayerGuiToggle", Keypress, false, HighValue, Enum.KeyCode.X)

        ContextActionService:BindActionAtPriority(
            "FreecamKeyboardLeaderboardToggle",
            Keypress,
            false,
            HighValue,
            Enum.KeyCode.L
        )
    end
    ContextActionService:BindActionAtPriority(
        "FreecamMousePan",
        MousePan,
        false,
        HighValue,
        Enum.UserInputType.MouseMovement
    )
    ContextActionService:BindActionAtPriority(
        "FreecamMouseWheel",
        MouseWheel,
        false,
        HighValue,
        Enum.UserInputType.MouseWheel
    )
    ContextActionService:BindActionAtPriority(
        "FreecamGamepadButton",
        GpButton,
        false,
        HighValue,
        Enum.KeyCode.ButtonX,
        Enum.KeyCode.ButtonY
    )
    ContextActionService:BindActionAtPriority(
        "FreecamGamepadTrigger",
        Trigger,
        false,
        HighValue,
        Enum.KeyCode.ButtonR2,
        Enum.KeyCode.ButtonL2
    )
    ContextActionService:BindActionAtPriority(
        "FreecamGamepadThumbstick",
        Thumb,
        false,
        HighValue,
        Enum.KeyCode.Thumbstick1,
        Enum.KeyCode.Thumbstick2
    )
end

function tbl14.StopCapture()
    if not var13 then
        getNavSpeed = 1
        if var6 then
            getFovSpeed = 1
        end
        if var7 then
            getRollSpeed = 1
        end
    end
    Zero(tbl15)
    Zero(tbl16)
    Zero(tbl17)
    ContextActionService:UnbindAction("FreecamKeyboard")
    if var6 then
        ContextActionService:UnbindAction("FreecamKeyboardControlSpeed")
        ContextActionService:UnbindAction("FreecamGamepadControlSpeed")
    end
    if var7 then
        ContextActionService:UnbindAction("FreecamKeyboardTiltControl")
        ContextActionService:UnbindAction("FreecamGamepadTiltControl")
        ContextActionService:UnbindAction("FreecamKeyboardTiltControlSpeed")
        if var8 then
            ContextActionService:UnbindAction("FreecamKeyboardSmoothnessControl")
        end
    end
    if var10 then
        ContextActionService:UnbindAction("FreecamKeyboardDoFToggle")
        ContextActionService:UnbindAction("FreecamKeyboardDoFControls")
    end
    if var11 then
        ContextActionService:UnbindAction("FreecamKeyboardPlayerLockToggle")
        ContextActionService:UnbindAction("FreecamKeyboardPlayerLockSwitch")
    end
    if var13 then
        ContextActionService:UnbindAction("FreecamKeyboardCustomGuiToggle")
        ContextActionService:UnbindAction("FreecamKeyboardPlayerGuiToggle")
        ContextActionService:UnbindAction("FreecamKeyboardLeaderboardToggle")
    end
    ContextActionService:UnbindAction("FreecamMousePan")
    ContextActionService:UnbindAction("FreecamMouseWheel")
    ContextActionService:UnbindAction("FreecamGamepadButton")
    ContextActionService:UnbindAction("FreecamGamepadTrigger")
    ContextActionService:UnbindAction("FreecamGamepadThumbstick")
end

function tbl14.getNavSpeed()
    return getNavSpeed
end

function tbl14.getFovSpeed()
    return getFovSpeed
end

function tbl14.getRollSpeed()
    return getRollSpeed
end

local function StepFreecam(num11: number)
    if var8 then
        tbl14.SpringControl(num11)
    end

    if var10 and depthOfFieldEffect and depthOfFieldEffect.Parent then
        tbl14.DoF(num11)
    end

    local var24 = var17:Update(num11, tbl14.Vel(num11))
    local var25 = var18:Update(num11, tbl14.Pan(num11))
    local var26 = var19:Update(num11, tbl14.Fov(num11))
    local var27 = if var7 then var20:Update(num11, tbl14.Roll(num11)) else nil
    local var28 = sqrt(0.7002075382097097 / tan((rad(num7 / 2))))

    num7 = clamp(num7 + var26 * 300 * (num11 / var28), 1, 120)
    local var29

    if var7 then
        local var30 = var25 * var14 * (num11 / var28)
        var16 += Vector3.new(var30.X, var30.Y, var27 * -(math.pi / 2) * (num11 / var28))
        if var8 then
            var16 = Vector3.new(var16.x % (math.pi * 2), var16.y % (math.pi * 2), var16.z % (math.pi * 2))
        else
            var16 = Vector3.new(clamp(var16.x, -(math.pi / 2), math.pi / 2), var16.y % (math.pi * 2), var16.z)
        end

        var29 = CFrame.new(vec3) * CFrame.fromOrientation(var16.x, var16.y, var16.z) * CFrame.new(var24 * Vector3.new(64, 64, 64) * num11)
    else
        var16 += var25 * var14 * (num11 / var28)
        var16 = Vector2.new(clamp(var16.x, -(math.pi / 2), math.pi / 2), var16.y % (math.pi * 2))

        var29 = CFrame.new(vec3) * CFrame.fromOrientation(var16.x, var16.y, 0) * CFrame.new(var24 * Vector3.new(64, 64, 64) * num11)
    end

    if var11 and bool1 and var15 then
        local var30 = var24.Z * 64 * num11
        local var31 = var24.Y * 64 * num11
        z = clamp(z + var30, 5, 50)
        y = clamp(y + var31, -10, 10)
        var29 = CFrame.new(var15.Position + Vector3.new(0, y, 0)) * (if var7 then CFrame.fromOrientation(var16.x, var16.y, var16.z) else CFrame.fromOrientation(var16.x, var16.y, 0)) * CFrame.new(0, 0, z)
    end

    if var13 and textLabel and textLabel.Parent and Freecam and Freecam.Parent and Freecam.Enabled then
        local str1 = ""

        if num11 > 0 then
            local var30 = (var29.p - vec3) / num11
            str1 ..= string.format("Velocity: (%.1f, %.1f, %.1f)\n", var30.X, var30.Y, var30.Z)
        end

        local str2 = str1 .. string.format("FOV: %.1f\n", num7)

        if var7 then
            str2 ..= string.format("Tilt: %.1f°\n", math.deg(var16.z))
        end

        if var8 then
            str2 = (((str2 .. string.format("Stiffness (Vel): %.1f\n", num1)) .. string.format("Stiffness (Pan): %.1f\n", num2)) .. string.format("Stiffness (FOV): %.1f\n", num3)) .. string.format("Stiffness (Roll): %.1f\n", num4)
        end

        if var6 then
            str2 = ((str2 .. string.format("Movement Speed: %.1f\n", tbl14.getNavSpeed())) .. string.format("Zoom Speed: %.1f\n", tbl14.getFovSpeed())) .. string.format("Tilt Speed: %.1f\n", tbl14.getRollSpeed())
        end

        if var10 then
            if depthOfFieldEffect and depthOfFieldEffect.Parent and depthOfFieldEffect.Enabled then
                str2 = ((((str2 .. string.format("Custom Depth Of Field: On\n")) .. string.format("Custom Depth Of Field Near Intensity: %.1f\n", depthOfFieldEffect.NearIntensity))
                    .. string.format("Custom Depth Of Field Far Intensity: %.1f\n", depthOfFieldEffect.FarIntensity))
                    .. string.format("Custom Depth Of Field Focus Distance: %.1f\n", depthOfFieldEffect.FocusDistance))
                    .. string.format("Custom Depth Of Field Focus Radius: %.1f\n", depthOfFieldEffect.InFocusRadius)
            else
                str2 ..= string.format("Custom Depth Of Field: Off\n")
            end
        end

        if var11 then
            if bool1 and #tbl12 > 0 then
                str2 ..= string.format("Player Lock: %s\n", tbl12[num6].Name)
            else
                str2 ..= string.format("Player Lock: Off\n")
            end
        end

        textLabel.Text = str2
    end

    vec3 = var29.p

    CurrentCamera.CFrame = var29
    CurrentCamera.Focus = var29
    CurrentCamera.FieldOfView = num7
end

local function CheckMouseLockAvailability(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local devEnableMouseLock = Players.LocalPlayer.DevEnableMouseLock
    local bool3 = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local bool4 = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
    local bool5 = GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    return devEnableMouseLock and bool4 and not bool5 and not bool3
end

var1 = {}

local var24 = nil
local MouseIconEnabled = nil
local CameraType = nil
local Focus = nil
local CFrame = nil
local FieldOfView = nil
local getScreenGuis = {}
local tbl20 = { Backpack = true, Chat = true, Health = true, PlayerList = true }

local tbl21 = { BadgesNotificationsActive = true, PointsNotificationsActive = true }

function var1.Push()
    for k in pairs(tbl20) do
        tbl20[k] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[k])
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], false)
    end
    for k in pairs(tbl21) do
        tbl21[k] = StarterGui:GetCore(k)
        StarterGui:SetCore(k, false)
    end
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if playerGui then
        for _, child in pairs(playerGui:GetChildren()) do
            if child:IsA("ScreenGui") and child.Enabled then
                getScreenGuis[#getScreenGuis + 1] = child
                child.Enabled = false
            end
        end
        if var5 then
            connection = playerGui.ChildAdded:Connect(function(child: Instance)
                if not child:IsA("ScreenGui") or not child.Enabled then
                    return
                end

                getScreenGuis[#getScreenGuis + 1] = child
                if var13 then
                    child.Enabled = bool2
                    return
                end
                child.Enabled = false
            end)
        end
    end

    FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = 70

    CameraType = CurrentCamera.CameraType
    CurrentCamera.CameraType = Enum.CameraType.Custom

    CFrame = CurrentCamera.CFrame
    Focus = CurrentCamera.Focus

    MouseIconEnabled = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = false

    if var2 and CheckMouseLockAvailability() then
        var24 = Enum.MouseBehavior.Default

        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        return
    end

    var24 = UserInputService.MouseBehavior

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

function var1.Pop()
    for k, value in pairs(tbl20) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], value)
    end
    for k, value in pairs(tbl21) do
        StarterGui:SetCore(k, value)
    end
    for _, value in pairs(getScreenGuis) do
        if var13 then
            if value.Parent and value ~= Freecam then
                value.Enabled = true
            end
        elseif value.Parent then
            value.Enabled = true
        end
    end

    if var5 then
        if connection then
            connection:Disconnect()
            connection = nil
        end

        getScreenGuis = {}
    end

    CurrentCamera.FieldOfView = FieldOfView
    FieldOfView = nil

    CurrentCamera.CameraType = CameraType
    CameraType = nil

    CurrentCamera.CFrame = CFrame
    CFrame = nil

    CurrentCamera.Focus = Focus
    Focus = nil

    UserInputService.MouseIconEnabled = MouseIconEnabled
    MouseIconEnabled = nil

    UserInputService.MouseBehavior = var24
    var24 = nil
end

function var1.getScreenGuis()
    return getScreenGuis
end

local function removePlayerFromList(player: Player)
    for i, player2 in ipairs(tbl12) do
        if player2 ~= player then
            continue
        end

        table.remove(tbl12, i)

        if num6 == i and bool1 then
            bool1 = false
            num6 = 1
        end

        if i < num6 then
            num6 -= 1
        end

        if num6 > #tbl12 or num6 < 1 then
            num6 = 1

            return
        end

        break
    end
end

local function initializePlayerList()
    tbl12 = Players:GetPlayers()

    for i, player in ipairs(tbl12) do
        if player == LocalPlayer then
            num6 = i
            break
        end
    end

    connection4 = Players.PlayerAdded:Connect(function(player: Player)
        table.insert(tbl12, player)
    end)

    connection5 = Players.PlayerRemoving:Connect(removePlayerFromList)
end

local function StartFreecam()
    if var11 then
        initializePlayerList()
    end

    if not var9 and var3 then
        script:SetAttribute("FreecamEnabled", true)
    end

    local currentCameraCFrame = CurrentCamera.CFrame
    if var7 then
        var16 = Vector3.new(currentCameraCFrame:toEulerAnglesYXZ())
    else
        var16 = Vector2.new(currentCameraCFrame:toEulerAnglesYXZ())
    end
    vec3 = currentCameraCFrame.p
    num7 = CurrentCamera.FieldOfView

    var17:Reset(Vector3.new())
    var18:Reset(Vector2.new())
    var19:Reset(0)
    if var7 then
        var20:Reset(0)
    end

    if not var13 and var8 then
        num1 = 1.5
        num2 = 1
        num3 = 4
        num4 = 1
    end

    if var13 then
        PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        Freecam = PlayerGui:WaitForChild("Freecam")
        if not (textLabel and textLabel.Parent) then
            textLabel = Instance.new("TextLabel")
            textLabel.Name = "FreecamCustomGui"
            textLabel.TextColor3 = Color3.new(1, 1, 1)
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 20
            textLabel.TextStrokeTransparency = 0
            textLabel.BackgroundTransparency = 1
            textLabel.TextWrapped = true
            textLabel.TextXAlignment = Enum.TextXAlignment.Right
            textLabel.AutomaticSize = Enum.AutomaticSize.Y
            textLabel.AnchorPoint = Vector2.new(1, 1)
            textLabel.Position = UDim2.new(1, -10, 1, -10)
            textLabel.Size = UDim2.new(0, 400, 0, 0)
            textLabel.Parent = Freecam
        end
    end

    var1.Push()

    if var10 and not (depthOfFieldEffect and depthOfFieldEffect.Parent) then
        depthOfFieldEffect = Instance.new("DepthOfFieldEffect")
        depthOfFieldEffect.Enabled = false
        depthOfFieldEffect.Name = "FreecamDepthOfField"
        depthOfFieldEffect.Parent = CurrentCamera
    end

    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
    tbl14.StartCapture()
end

local function StopFreecam()
    if not var9 and var3 then
        script:SetAttribute("FreecamEnabled", false)
    end

    if var11 then
        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end
        if connection5 then
            connection5:Disconnect()
            connection5 = nil
        end
        bool1 = false
        num6 = 1
        tbl12 = {}
    end

    if var10 and depthOfFieldEffect and depthOfFieldEffect.Parent then
        if depthOfFieldEffect.Enabled then
            for _, value in ipairs(tbl11) do
                if value.Parent then
                    value.Enabled = true
                end
            end
            if connection2 then
                connection2:Disconnect()
                connection2 = nil
            end
            if connection3 then
                connection3:Disconnect()
                connection3 = nil
            end
            tbl11 = {}
        end
        depthOfFieldEffect.Enabled = false
    end

    if var13 then
        if Freecam and Freecam.Parent then
            Freecam.Enabled = false
        end
        bool2 = false
        enabled = false
    end

    tbl14.StopCapture()
    RunService:UnbindFromRenderStep("Freecam")
    var1.Pop()
end

local bool3 = false

local function ToggleFreecam() -- Luacid: Inlined by compiler; 1 call site recovered
    if bool3 then
        StopFreecam()
    else
        StartFreecam()
    end
    bool3 = not bool3
    if var9 then
        script:SetAttribute("FreecamEnabled", bool3)
    end
end

local function CheckMacro(arg1)
    for i = 1, #arg1 - 1 do
        if not UserInputService:IsKeyDown(arg1[i]) then
            return
        end
    end

    ToggleFreecam()
end

ContextActionService:BindActionAtPriority("FreecamToggle", function(_: string, userInputState: Enum.UserInputState, inputObject: InputObject): Enum.ContextActionResult -- name: HandleActivationInput
    if userInputState == Enum.UserInputState.Begin and inputObject.KeyCode == tbl1[#tbl1] then
        CheckMacro(tbl1)
    end

    return Enum.ContextActionResult.Pass
end, false, LowValue, tbl1[#tbl1])

if var9 or var3 then
    script:SetAttribute("FreecamEnabled", bool3)
    script:GetAttributeChangedSignal("FreecamEnabled"):Connect(function()
        local freecamEnabled = script:GetAttribute("FreecamEnabled")

        if typeof(freecamEnabled) ~= "boolean" then
            script:SetAttribute("FreecamEnabled", bool3)
            return
        end

        if freecamEnabled == bool3 then
            return
        end

        if freecamEnabled then
            StartFreecam()
            bool3 = true
            return
        end
        StopFreecam()
        bool3 = false
    end)
end

return {}
