-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local clamp = math.clamp
local exp = math.exp
local rad = math.rad
local sqrt = math.sqrt
local tan = math.tan

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local StarterPlayer = game:GetService("StarterPlayer")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamIASRefactor1")
end)
local var1 = success and result

local tbl1 = {
    AttributeName = "FreecamEnabled",
    Thumbstick = { Curvature = 2 },
    DoubleTap = { Threshold = 0.25, Debounce = 0.1 },
    PlayerLock = {
        DefaultZoom = 20,
        MinZoom = 5,
        MaxZoom = 50,
        DefaultHeight = 0,
        HeightRange = 10
    },
    Movement = {
        Gain = Vector3.new(64, 64, 64),
        AdjSpeed = 0.75,
        MinSpeed = 0.01,
        MaxSpeed = 4,
        ShiftMul = 0.25,
        Stiffness = 1.5,
        AdjStiffness = 0.75,
        MinStiffness = 0.01,
        MaxStiffness = 10
    },
    Pan = {
        Gain = Vector2.new(0.75, 1) * 8,
        MouseScale = Vector2.new(0.0008181230868723419, -0.0008181230868723419),
        TrackpadScale = Vector2.new(0.011453723216212788, -0.011453723216212788),
        GamepadScale = Vector2.new(math.pi / 8, math.pi / 8),
        AdjSpeed = 0.75,
        MinSpeed = 0.01,
        MaxSpeed = 4,
        Stiffness = 1,
        AdjStiffness = 0.75,
        MinStiffness = 0.01,
        MaxStiffness = 10
    },
    Fov = {
        Gain = 300,
        WheelScale = -0.01667,
        PinchScale = -0.008,
        GamepadScale = 0.25,
        AdjSpeed = 0.75,
        MinSpeed = 0.01,
        MaxSpeed = 4,
        Stiffness = 4,
        AdjStiffness = 0.75,
        MinStiffness = 0.01,
        MaxStiffness = 10
    },
    Roll = {
        Gain = -(math.pi / 2),
        AdjSpeed = 0.75,
        MinSpeed = 0.01,
        MaxSpeed = 4,
        Stiffness = 1,
        AdjStiffness = 0.75,
        MinStiffness = 0.01,
        MaxStiffness = 10
    },
    DoF = {
        FarIntensity = { Adj = 0.1, Min = 0, Max = 1 },
        NearIntensity = { Adj = 0.1, Min = 0, Max = 1 },
        FocusDistance = { Adj = 20, Min = 0, Max = 200 },
        FocusRadius = { Adj = 5, Min = 0, Max = 50 }
    },
    Bloom = {
        Intensity = { Adj = 0.05, Min = 0, Max = 1 },
        Size = { Adj = 2, Min = 0, Max = 56 },
        Threshold = {
            Adj = 0.05,
            Min = if var1 then 0.8 else 0,
            Max = if var1 then 4 else 1
        }
    },
    Blur = {
        Size = { Adj = 2, Min = 0, Max = 56 }
    },
    ColorCorrection = {
        Brightness = { Adj = 0.05, Min = -1, Max = 1 },
        Contrast = { Adj = 0.05, Min = -1, Max = 1 },
        Saturation = { Adj = 0.05, Min = -1, Max = 1 }
    },
    SunRays = {
        Intensity = { Adj = 0.05, Min = 0, Max = 1 },
        Spread = { Adj = 0.05, Min = 0, Max = 1 }
    },
    Keys = {
        Toggle = {
            Keyboard = Enum.KeyCode.P,
            Modifier = Enum.KeyCode.LeftShift
        },
        Pan = {
            Mouse = Enum.KeyCode.MouseDelta,
            Trackpad = Enum.KeyCode.TrackpadPan,
            Gamepad = Enum.KeyCode.Thumbstick2
        },
        MovementMove = {
            Keyboard = {
                Up = Enum.KeyCode.W,
                Down = Enum.KeyCode.S,
                Left = Enum.KeyCode.A,
                Right = Enum.KeyCode.D
            },
            Gamepad = Enum.KeyCode.Thumbstick1
        },
        MovementElevate = {
            Keyboard = {
                Up = Enum.KeyCode.E,
                Down = Enum.KeyCode.Q
            },
            Gamepad = {
                Up = Enum.KeyCode.ButtonR2,
                Down = Enum.KeyCode.ButtonL2
            }
        },
        ModeSelect = {
            Toggle = {
                Keyboard = Enum.KeyCode.Up,
                Gamepad = Enum.KeyCode.DPadUp
            },
            Next = {
                Keyboard = Enum.KeyCode.Down,
                Gamepad = Enum.KeyCode.DPadDown
            },
            Axis = {
                Up = {
                    Keyboard = Enum.KeyCode.Right,
                    Gamepad = Enum.KeyCode.DPadRight
                },
                Down = {
                    Keyboard = Enum.KeyCode.Left,
                    Gamepad = Enum.KeyCode.DPadLeft
                }
            }
        },
        Fov = {
            Mouse = Enum.KeyCode.MouseWheel,
            TrackpadPinch = Enum.KeyCode.TrackpadPinch,
            Gamepad = {
                Up = Enum.KeyCode.ButtonX,
                Down = Enum.KeyCode.ButtonY
            }
        },
        Tilt = {
            Keyboard = {
                Up = Enum.KeyCode.C,
                Down = Enum.KeyCode.Z
            },
            Gamepad = {
                Up = Enum.KeyCode.ButtonR1,
                Down = Enum.KeyCode.ButtonL1
            }
        },
        Shift = {
            KeyboardPrimary = Enum.KeyCode.LeftShift,
            KeyboardSecondary = Enum.KeyCode.RightShift
        }
    }
}

tbl1.Actions = {
    Toggle = {
        name = "FreecamToggleAction",
        type = Enum.InputActionType.Bool,
        bindings = {{
            keyCode = tbl1.Keys.Toggle.Keyboard,
            primaryModifier = tbl1.Keys.Toggle.Modifier
        }}
    },
    Pan = {
        name = "PanAction",
        type = Enum.InputActionType.Direction2D,
        bindings = {
            {
                keyCode = tbl1.Keys.Pan.Mouse,
                vector2Scale = tbl1.Pan.MouseScale
            },
            {
                keyCode = tbl1.Keys.Pan.Trackpad,
                vector2Scale = tbl1.Pan.TrackpadScale
            },
            {
                keyCode = tbl1.Keys.Pan.Gamepad,
                responseCurve = tbl1.Thumbstick.Curvature,
                vector2Scale = tbl1.Pan.GamepadScale
            }
        }
    },
    MovementMove = {
        name = "MovementMoveAction",
        type = Enum.InputActionType.Direction2D,
        bindings = {
            {
                up = tbl1.Keys.MovementMove.Keyboard.Up,
                down = tbl1.Keys.MovementMove.Keyboard.Down,
                left = tbl1.Keys.MovementMove.Keyboard.Left,
                right = tbl1.Keys.MovementMove.Keyboard.Right
            },
            {
                keyCode = tbl1.Keys.MovementMove.Gamepad,
                responseCurve = tbl1.Thumbstick.Curvature
            }
        }
    },
    MovementElevate = {
        name = "MovementElevateAction",
        type = Enum.InputActionType.Direction1D,
        bindings = {
            {
                up = tbl1.Keys.MovementElevate.Keyboard.Up,
                down = tbl1.Keys.MovementElevate.Keyboard.Down
            },
            {
                up = tbl1.Keys.MovementElevate.Gamepad.Up,
                down = tbl1.Keys.MovementElevate.Gamepad.Down
            }
        }
    },
    Fov = {
        name = "FovAction",
        type = Enum.InputActionType.Direction1D,
        bindings = {
            {
                keyCode = tbl1.Keys.Fov.Mouse,
                scale = tbl1.Fov.WheelScale
            },
            {
                keyCode = tbl1.Keys.Fov.TrackpadPinch,
                scale = tbl1.Fov.PinchScale
            },
            {
                up = tbl1.Keys.Fov.Gamepad.Up,
                down = tbl1.Keys.Fov.Gamepad.Down,
                scale = tbl1.Fov.GamepadScale
            }
        }
    },
    Tilt = {
        name = "TiltAction",
        type = Enum.InputActionType.Direction1D,
        bindings = {
            {
                up = tbl1.Keys.Tilt.Keyboard.Up,
                down = tbl1.Keys.Tilt.Keyboard.Down
            },
            {
                up = tbl1.Keys.Tilt.Gamepad.Up,
                down = tbl1.Keys.Tilt.Gamepad.Down
            }
        }
    },
    Shift = {
        name = "ShiftAction",
        type = Enum.InputActionType.Bool,
        bindings = {
            {
                keyCode = tbl1.Keys.Shift.KeyboardPrimary
            },
            {
                keyCode = tbl1.Keys.Shift.KeyboardSecondary
            }
        }
    },
    ModeToggle = {
        name = "ModeToggleAction",
        type = Enum.InputActionType.Bool,
        bindings = {
            {
                keyCode = tbl1.Keys.ModeSelect.Toggle.Keyboard
            },
            {
                keyCode = tbl1.Keys.ModeSelect.Toggle.Gamepad
            }
        }
    },
    ModeNext = {
        name = "ModeNextAction",
        type = Enum.InputActionType.Bool,
        bindings = {
            {
                keyCode = tbl1.Keys.ModeSelect.Next.Keyboard
            },
            {
                keyCode = tbl1.Keys.ModeSelect.Next.Gamepad
            }
        }
    },
    ModeAxis = {
        name = "ModeAxisAction",
        type = Enum.InputActionType.Direction1D,
        bindings = {
            {
                up = tbl1.Keys.ModeSelect.Axis.Up.Keyboard,
                down = tbl1.Keys.ModeSelect.Axis.Down.Keyboard
            },
            {
                up = tbl1.Keys.ModeSelect.Axis.Up.Gamepad,
                down = tbl1.Keys.ModeSelect.Axis.Down.Gamepad
            }
        }
    }
}

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local Freecam = nil

local CurrentCamera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    local currentCamera = Workspace.CurrentCamera
    if currentCamera then
        CurrentCamera = currentCamera
    end
end)

local get = nil
local var2 = nil
local var3 = nil
local var4 = nil
local var5 = nil
local var6 = nil

local tbl2 = {
    DepthOfField = {
        Enabled = false,
        FarIntensity = 0.75,
        NearIntensity = 0.75,
        FocusDistance = 0.05,
        InFocusRadius = 10
    },
    Bloom = { Enabled = false, Intensity = 0.4, Size = 24, Threshold = 0.95 },
    Blur = { Enabled = false, Size = 24 },
    ColorCorrection = {
        Enabled = false,
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    },
    SunRays = { Enabled = false, Intensity = 0.25, Spread = 1 },
    ColorGrading = {
        Enabled = false,
        TonemapperPreset = Enum.TonemapperPreset.Default
    }
}
local var8 = nil
local var9 = nil
local var10 = nil

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserShowGuiHideToggles")
end)
local var11 = success2 and result2

local success3, result3 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserPlayerScriptsRefactor4")
end)
local var12 = success3 and result3

local success4, result4 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserPlayerScriptsRefactor5")
end)
local var13 = success4 and result4

local success5, result5 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamIASRefactor2")
end)
local var14 = success5 and result5

local success6, result6 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamIASRefactor3")
end)
local var15 = success6 and result6

local success7, result7 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFreecamIASRefactor4")
end)
local var16 = success7 and result7

local function makeEffectOverride(str1: string, arg1)
    local tbl3 = {}
    local connection = nil
    local connection2 = nil

    local function disable()
        for _, value in ipairs(tbl3) do
            if value.Parent then
                value.Enabled = true
            end
        end

        if connection then
            connection:Disconnect()
            connection = nil
        end

        if connection2 then
            connection2:Disconnect()
            connection2 = nil
        end

        tbl3 = {}
    end

    local function trySuppress(arg2: Instance) -- Luacid: Inlined by compiler; 4 call sites recovered
        if arg2:IsA(str1) and arg2.Enabled and not (arg1 and arg1(arg2)) then
            tbl3[#tbl3 + 1] = arg2
            arg2.Enabled = false
        end
    end

    local function enable()
        tbl3 = {}
        for _, child in ipairs(CurrentCamera:GetChildren()) do
            trySuppress(child)
        end

        for _, child in ipairs(Lighting:GetChildren()) do
            trySuppress(child)
        end

        connection = CurrentCamera.ChildAdded:Connect(function(child: Instance)
            trySuppress(child)
        end)

        connection2 = Lighting.ChildAdded:Connect(function(child: Instance)
            trySuppress(child)
        end)
    end
    return enable, disable
end

local isEnabled = false
local func1, func2 = makeEffectOverride("PostEffect", function(arg1: Instance): boolean
    return arg1.Name:sub(1, 7) == "Freecam"
end)

local var17 = nil

local function doToggleMasterEffects()
    isEnabled = not isEnabled
    if isEnabled then
        func1()
        return
    end
    func2()
    for _, value in ipairs(var17) do
        local var18 = value.get()
        if var18 then
            var18.Enabled = false
        end
    end
end

local function doToggleDoF()
    if var12 and not isEnabled then
        return
    end

    local var18 = get

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end

local function doToggleBloom()
    if var12 and not isEnabled then
        return
    end

    local var18 = var2

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end

local function doToggleBlur()
    if var12 and not isEnabled then
        return
    end

    local var18 = var3

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end

local function doToggleColorCorrection()
    if var12 and not isEnabled then
        return
    end

    local var18 = var4

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end

local function doToggleSunRays()
    if var12 and not isEnabled then
        return
    end

    local var18 = var5

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end

local function doToggleColorGrading()
    if var12 and not isEnabled then
        return
    end

    local var18 = var6

    if var18 then
        var18.Enabled = not var18.Enabled
    end
end
local tbl3 = {
    key = "DepthOfField",
    class = "DepthOfFieldEffect",
    get = function()
        return get
    end,
    set = function(arg1)
        get = arg1
    end,
    props = {
        "FarIntensity",
        "NearIntensity",
        "FocusDistance",
        "InFocusRadius"
    }
}

local tbl4 = {
    key = "Bloom",
    class = "BloomEffect",
    get = function()
        return var2
    end,
    set = function(arg1)
        var2 = arg1
    end,
    props = { "Intensity", "Size", "Threshold" }
}

local tbl5 = {
    key = "Blur",
    class = "BlurEffect",
    get = function()
        return var3
    end,
    set = function(arg1)
        var3 = arg1
    end,
    props = { "Size" }
}

local tbl6 = {
    key = "ColorCorrection",
    class = "ColorCorrectionEffect",
    get = function()
        return var4
    end,
    set = function(arg1)
        var4 = arg1
    end,
    props = {
        "Brightness",
        "Contrast",
        "Saturation",
        "TintColor"
    }
}

local tbl7 = {
    key = "SunRays",
    class = "SunRaysEffect",
    get = function()
        return var5
    end,
    set = function(arg1)
        var5 = arg1
    end,
    props = { "Intensity", "Spread" }
}

local tbl8 = {
    key = "ColorGrading",
    class = "ColorGradingEffect",
    parent = if var13 then Lighting or nil else nil,
    get = 0,
    set = 0,
    props = 0
}

function tbl8.get()
    return var6
end

function tbl8.set(arg1)
    var6 = arg1
end

tbl8.props = { "TonemapperPreset" }
var17 = {
    tbl3,
    tbl4,
    tbl5,
    tbl6,
    tbl7,
    tbl8
}

local connection = nil
local connection2 = nil
local connection3 = nil

local bool1 = false
local DefaultZoom = tbl1.PlayerLock.DefaultZoom
local DefaultHeight = tbl1.PlayerLock.DefaultHeight
local items = {}
local getIndex = 1
local var18 = nil

local bool3 = false
local enabled = false

local huge = -math.huge
local huge2 = -math.huge

local tbl10 = {
    movement = tbl1.Movement.Stiffness,
    pan = tbl1.Pan.Stiffness,
    fov = tbl1.Fov.Stiffness,
    roll = tbl1.Roll.Stiffness
}

local var19 = nil

local tbl11 = {}
tbl11.__index = tbl11

function tbl11.new(f, p)
    local self = setmetatable({}, tbl11)
    self.f = f
    self.p = p
    self.v = p * 0
    return self
end

function tbl11:Update(arg1, arg2)
    local var20 = self.f * 2 * math.pi
    local p = self.p
    local v = self.v
    local var21 = arg2 - p
    local var22 = exp(-var20 * arg1)
    local var7 = arg2 + (v * arg1 - var21 * (var20 * arg1 + 1)) * var22
    local var23 = (var20 * arg1 * (var21 * var20 - v) + v) * var22
    self.p = var7
    self.v = var23
    return var7
end

function tbl11:SetFreq(f)
    self.f = f
end

function tbl11:Reset(p)
    self.p = p
    self.v = p * 0
end

local vec3 = Vector3.new()
local vec3_2 = Vector3.new()
local num2 = 0

local var20 = tbl11.new(tbl10.movement, Vector3.new())
local var21 = tbl11.new(tbl10.pan, Vector2.new())
local var22 = tbl11.new(tbl10.fov, 0)
local var23 = tbl11.new(tbl10.roll, 0)

local tbl12 = {}
local tbl13 = {}

local tbl14 = { movement = 1, pan = 1, fov = 1, roll = 1 }

local bool4 = false
local var24 = nil

local getModeActive = false
local _getModeIndex = 1
local tbl15 = {}
local bool6 = false
local _isMonitorItemSelected = false

local function findPlayerLockRootPart(arg1)
    if not items or #items < 1 then
        return nil
    end

    for _ = 1, #items do
        getIndex = (getIndex - 1 + arg1) % #items + 1
        local var25 = items[getIndex]
        local character = var25 and var25.Character
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

local tbl9 = {
    { name = "Custom", color = nil },
    {
        name = "White",
        color = Color3.new(1, 1, 1)
    },
    {
        name = "Warm",
        color = Color3.fromRGB(255, 230, 200)
    },
    {
        name = "Cool",
        color = Color3.fromRGB(200, 220, 255)
    },
    {
        name = "Red",
        color = Color3.new(1, 0, 0)
    },
    {
        name = "Green",
        color = Color3.new(0, 1, 0)
    },
    {
        name = "Blue",
        color = Color3.new(0, 0, 1)
    },
    {
        name = "Yellow",
        color = Color3.new(1, 1, 0)
    },
    {
        name = "Cyan",
        color = Color3.new(0, 1, 1)
    },
    {
        name = "Magenta",
        color = Color3.new(1, 0, 1)
    },
    {
        name = "Orange",
        color = Color3.fromRGB(255, 140, 0)
    },
    {
        name = "Purple",
        color = Color3.fromRGB(128, 0, 255)
    }
}

local num1 = 1
local white = Color3.new(1, 1, 1)

local function doTogglePlayerLock()
    bool1 = not bool1
    if bool1 then
        DefaultZoom = tbl1.PlayerLock.DefaultZoom
        DefaultHeight = tbl1.PlayerLock.DefaultHeight
        var18 = findPlayerLockRootPart(0)
    end
end

local function doToggleScreenGuis()
    bool3 = not bool3
    if not var10 then
        return
    end

    for _, value in pairs(var10.getScreenGuis()) do
        if value.Parent and value ~= Freecam then
            value.Enabled = bool3
        end
    end
end

local function doToggleLeaderboard()
    enabled = not enabled
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, enabled)
end

local function makeEffectGroup(name: string, toggle, arg1, arg2, arg3)
    local modes = {{
        type = "toggle",
        name = "Enable",
        toggle = toggle,
        isEnabled = function()
            local var25 = arg1()
            return var25 and var25.Enabled
        end
    }}

    for _, value in ipairs(arg2 or {}) do
        local num5 = #modes + 1
        local tbl18 = {
            type = "axis",
            name = value.name,
            adj = value.adjCfg.Adj,
            min = value.adjCfg.Min,
            max = value.adjCfg.Max,
            get = 0,
            set = 0
        }

        function tbl18.get()
            local var25 = arg1()
            return var25 and var25[value.prop] or 0
        end

        function tbl18.set(arg4)
            local var25 = arg1()

            if var25 then
                var25[value.prop] = arg4
            end
        end

        modes[num5] = tbl18
    end

    for _, value in ipairs(arg3 or {}) do
        modes[#modes + 1] = value
    end
    return { type = "group", name = name, modes = modes }
end

local function makeTintChannel(str1: string): {adj: number, format: string, get: () -> any, max: number, min: number, name: any, set: (any) -> (), type: string} | {adj: number, get: () -> any, max: number, min: number, name: any, set: (any) -> (), type: string}
    return if var14 then {
        type = "axis",
        name = "Tint " .. str1,
        adj = 64,
        min = 0,
        max = 255,
        format = "%.0f",
        get = function()
            return (var4 and var4.TintColor or white)[str1] * 255
        end,
        set = function(arg1)
            local var25 = var4 and var4.TintColor or white
            local r = var25.R
            local g = var25.G
            local b = var25.B
            if str1 == "R" then
                r = arg1 / 255
            elseif str1 == "G" then
                g = arg1 / 255
            else
                b = arg1 / 255
            end

            white = Color3.new(r, g, b)
            num1 = 1
            if var4 then
                var4.TintColor = white
            end
        end
    } else {
        type = "axis",
        name = "Tint " .. str1,
        adj = 0.02,
        min = 0,
        max = 1,
        get = function()
            return white[str1]
        end,
        set = function(arg1)
            local r = white.R
            local g = white.G
            local b = white.B
            if str1 == "R" then
                r = arg1
            elseif str1 == "G" then
                g = arg1
            else
                b = arg1
            end

            white = Color3.new(r, g, b)
            num1 = 1
            if var4 then
                var4.TintColor = white
            end
        end
    }
end

local function makeSpeedStiffnessGroup(name, arg2, str1: string, str2: string, arg3)
    return {
        type = "group",
        name = name,
        modes = {
            {
                type = "axis",
                name = "Speed",
                adj = arg2.AdjSpeed,
                min = arg2.MinSpeed,
                max = arg2.MaxSpeed,
                get = function()
                    return tbl14[str1]
                end,
                set = function(arg4)
                    tbl14[str1] = arg4
                end
            },
            {
                type = "axis",
                name = "Stiffness",
                adj = arg2.AdjStiffness,
                min = arg2.MinStiffness,
                max = arg2.MaxStiffness,
                get = function()
                    return tbl10[str2]
                end,
                set = function(arg4)
                    tbl10[str2] = arg4
                    arg3:SetFreq(arg4)
                end
            }
        }
    }
end

local tbl17 = {
    (function() -- name: buildCustomEffectsGroup
        local tbl17 = {
            type = "group",
            name = "Custom Post Processing",
            modes = {
                {
                    type = "toggle",
                    name = "Enable",
                    toggle = doToggleMasterEffects,
                    isEnabled = function()
                        return isEnabled
                    end
                },
                makeEffectGroup("Depth of Field", doToggleDoF, function()
                    return get
                end, {
                    {
                        name = "Far",
                        adjCfg = tbl1.DoF.FarIntensity,
                        prop = "FarIntensity"
                    },
                    {
                        name = "Near",
                        adjCfg = tbl1.DoF.NearIntensity,
                        prop = "NearIntensity"
                    },
                    {
                        name = "Focus Distance",
                        adjCfg = tbl1.DoF.FocusDistance,
                        prop = "FocusDistance"
                    },
                    {
                        name = "Focus Radius",
                        adjCfg = tbl1.DoF.FocusRadius,
                        prop = "InFocusRadius"
                    }
                }),
                makeEffectGroup("Bloom", doToggleBloom, function()
                    return var2
                end, {
                    {
                        name = "Intensity",
                        adjCfg = tbl1.Bloom.Intensity,
                        prop = "Intensity"
                    },
                    {
                        name = "Size",
                        adjCfg = tbl1.Bloom.Size,
                        prop = "Size"
                    },
                    {
                        name = "Threshold",
                        adjCfg = tbl1.Bloom.Threshold,
                        prop = "Threshold"
                    }
                }),
                makeEffectGroup("Blur", doToggleBlur, function()
                    return var3
                end, {{
                    name = "Size",
                    adjCfg = tbl1.Blur.Size,
                    prop = "Size"
                }}),
                makeEffectGroup("Color Correction", doToggleColorCorrection, function()
                    return var4
                end, {
                    {
                        name = "Brightness",
                        adjCfg = tbl1.ColorCorrection.Brightness,
                        prop = "Brightness"
                    },
                    {
                        name = "Contrast",
                        adjCfg = tbl1.ColorCorrection.Contrast,
                        prop = "Contrast"
                    },
                    {
                        name = "Saturation",
                        adjCfg = tbl1.ColorCorrection.Saturation,
                        prop = "Saturation"
                    }
                }, {
                    {
                        type = "cycle",
                        name = "Tint",
                        items = function()
                            return tbl9
                        end,
                        getIndex = function()
                            return num1
                        end,
                        setIndex = function(arg1)
                            num1 = arg1
                            if not var4 then
                                return
                            end

                            if arg1 == 1 then
                                var4.TintColor = white
                                return
                            end
                            local color = tbl9[arg1].color
                            var4.TintColor = color
                            if not var14 then
                                white = color
                            end
                        end,
                        displayItem = function(arg1)
                            return arg1.name
                        end
                    },
                    makeTintChannel("R"),
                    makeTintChannel("G"),
                    (makeTintChannel("B"))
                }),
                makeEffectGroup("Sun Rays", doToggleSunRays, function()
                    return var5
                end, {
                    {
                        name = "Intensity",
                        adjCfg = tbl1.SunRays.Intensity,
                        prop = "Intensity"
                    },
                    {
                        name = "Spread",
                        adjCfg = tbl1.SunRays.Spread,
                        prop = "Spread"
                    }
                }),
                (makeEffectGroup("Color Grading", doToggleColorGrading, function()
                    return var6
                end, nil, {{
                    type = "cycle",
                    name = "Tonemap",
                    items = function()
                        return { Enum.TonemapperPreset.Default, Enum.TonemapperPreset.Retro }
                    end,
                    getIndex = function(): number
                        return if var6 and var6.TonemapperPreset == Enum.TonemapperPreset.Retro then 2 else 1
                    end,
                    setIndex = function(arg1)
                        if not var6 then
                            return
                        end

                        local tbl17 = { Enum.TonemapperPreset.Default, Enum.TonemapperPreset.Retro }
                        var6.TonemapperPreset = tbl17[arg1]
                    end,
                    displayItem = function(arg1)
                        return arg1.Name
                    end
                }}))
            }
        }
        if var12 then
            for i = 2, #tbl17.modes do
                tbl17.modes[i].disabled = function(): boolean
                    return not isEnabled
                end
            end
        end

        return tbl17
    end)(),
    {
        type = "group",
        name = "Player Lock",
        modes = {
            {
                type = "toggle",
                name = "Enable",
                toggle = doTogglePlayerLock,
                isEnabled = function()
                    return bool1
                end
            },
            {
                type = "cycle",
                name = "Target",
                items = function()
                    return items
                end,
                getIndex = function()
                    return getIndex
                end,
                setIndex = function(arg1)
                    getIndex = arg1
                    local var25 = items[arg1]
                    local character = var25 and var25.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        var18 = humanoid and humanoid.RootPart or nil
                        return
                    end
                    var18 = nil
                end,
                displayItem = function(arg1)
                    return arg1.Name
                end
            }
        }
    },
    {
        type = "group",
        name = if var15 then "UI Visibility" else "UI",
        modes = {
            {
                type = "toggle",
                name = "Screen GUIs",
                toggle = doToggleScreenGuis,
                isEnabled = function()
                    return bool3
                end
            },
            {
                type = "toggle",
                name = "Leaderboard",
                toggle = doToggleLeaderboard,
                isEnabled = function()
                    return enabled
                end
            }
        }
    },
    makeSpeedStiffnessGroup("Movement", tbl1.Movement, "movement", "movement", var20),
    makeSpeedStiffnessGroup("Field of View", tbl1.Fov, "fov", "fov", var22),
    makeSpeedStiffnessGroup(if var15 then "Roll" else "Tilt", tbl1.Roll, "roll", "roll", var23),
    (makeSpeedStiffnessGroup(if var15 then "Rotation" else "Pan", tbl1.Pan, "pan", "pan", var21))
}

tbl17 = var15 and {
    tbl17[4],
    tbl17[7],
    tbl17[6],
    tbl17[5],
    tbl17[1],
    tbl17[2],
    tbl17[3]
} or tbl17

local isDisabled = nil
local nextEnabledIndex = nil
if var12 then
    isDisabled = function(arg1)
        return arg1.disabled and arg1.disabled()
    end

    nextEnabledIndex = function(arg1, arg2, arg3)
        local num5 = #arg1
        for _ = 1, num5 do
            arg2 = (arg2 - 1 + arg3) % num5 + 1
            if not isDisabled(arg1[arg2]) then
                return arg2
            end
        end

        return arg2
    end
end

local function currentMode() -- Luacid: Inlined by compiler; 6 call sites recovered
    if not (#tbl15 > 0) then
        return tbl17[_getModeIndex]
    end

    local var25 = tbl15[#tbl15]
    return var25.modes[var25.index]
end

local function createBinding(inputAction: InputAction, arg1): InputBinding
    local inputBinding = Instance.new("InputBinding")
    if arg1.keyCode then
        inputBinding.KeyCode = arg1.keyCode
    end

    if arg1.up then
        inputBinding.Up = arg1.up
    end

    if arg1.down then
        inputBinding.Down = arg1.down
    end

    if arg1.left then
        inputBinding.Left = arg1.left
    end

    if arg1.right then
        inputBinding.Right = arg1.right
    end

    if arg1.scale then
        inputBinding.Scale = arg1.scale
    end

    if arg1.vector2Scale then
        inputBinding.Vector2Scale = arg1.vector2Scale
    end

    if arg1.responseCurve then
        inputBinding.ResponseCurve = arg1.responseCurve
    end

    if arg1.primaryModifier then
        inputBinding.PrimaryModifier = arg1.primaryModifier
    end

    inputBinding.Parent = inputAction
    return inputBinding
end

local function createAction(inputContext: InputContext, arg1): InputAction
    local inputAction = Instance.new("InputAction")
    inputAction.Name = arg1.name
    inputAction.Type = arg1.type
    inputAction.Parent = inputContext
    for _, binding in ipairs(arg1.bindings) do
        createBinding(inputAction, binding)
    end
    return inputAction
end

local function makeDoubleTapHandler(threshold, debounce, callback) -- Luacid: Inlined by compiler; 1 call site recovered
    local var25 = nil
    local num5 = 0
    local function detect(arg1)
        if not (math.abs(arg1) > 0.01) then
            return
        end

        local now = os.clock()
        if var25 == nil or not (now - var25 <= threshold) then
            var25 = now
            return
        end

        if now - num5 >= debounce then
            callback()
            num5 = now
        end
        var25 = nil
    end

    local function reset()
        var25 = nil
    end

    return detect, reset
end

local function createIASContexts()
    local actions = tbl1.Actions
    local script2

    if var16 then
        local freecamInput = Instance.new("Folder")
        freecamInput.Name = "FreecamInput"
        freecamInput.Parent = StarterPlayer
        script.Destroying:Connect(function()
            freecamInput:Destroy()
        end)

        script2 = freecamInput
    else
        script2 = script
    end

    local freecamToggleContext = Instance.new("InputContext")
    freecamToggleContext.Name = "FreecamToggleContext"
    freecamToggleContext.Priority = 3000
    freecamToggleContext.Sink = false
    freecamToggleContext.Enabled = true
    freecamToggleContext.Parent = script2
    var19 = createAction(freecamToggleContext, actions.Toggle)

    local freecamInputContext = Instance.new("InputContext")
    freecamInputContext.Name = "FreecamInputContext"
    freecamInputContext.Priority = 2000
    freecamInputContext.Sink = true
    freecamInputContext.Enabled = false
    freecamInputContext.Parent = script2
    tbl12._sinkContext = freecamInputContext

    tbl13.Pan = createAction(freecamInputContext, actions.Pan)
    tbl13.MovementMove = createAction(freecamInputContext, actions.MovementMove)
    tbl13.MovementElevate = createAction(freecamInputContext, actions.MovementElevate)
    tbl13.Fov = createAction(freecamInputContext, actions.Fov)
    tbl13.Shift = createAction(freecamInputContext, actions.Shift)

    local inputAction = createAction(freecamInputContext, actions.Tilt)
    tbl13.Tilt = inputAction

    local func3, func4 = makeDoubleTapHandler(tbl1.DoubleTap.Threshold, tbl1.DoubleTap.Debounce, function()
        vec3_2 = Vector3.new(vec3_2.x, vec3_2.y, 0)
        var23:Reset(0)
        bool4 = true
    end)

    var24 = func4
    local func5 = func3

    inputAction.StateChanged:Connect(function(value: number)
        if bool4 then
            if math.abs(value) < 0.01 then
                bool4 = false
            end

            return
        end
        func5(value)
    end)

    createAction(freecamInputContext, actions.ModeToggle).StateChanged:Connect(function(value: boolean)
        if not value then
            return
        end

        if not var12 then
            if getModeActive then
                if bool6 then
                    bool6 = false
                elseif #tbl15 > 0 then
                    tbl15[#tbl15] = nil
                else
                    getModeActive = false
                end
            else
                getModeActive = true
            end

            return
        end

        if not getModeActive then
            getModeActive = true
            return
        end

        if _isMonitorItemSelected then
            _isMonitorItemSelected = false
            return
        end

        if #tbl15 > 0 then
            local var25 = tbl15[#tbl15]
            local index = nextEnabledIndex(var25.modes, var25.index, -1)
            if index < var25.index then
                var25.index = index
                return
            end
            tbl15[#tbl15] = nil
        else
            local var25 = nextEnabledIndex(tbl17, _getModeIndex, -1)
            if var25 < _getModeIndex then
                _getModeIndex = var25
                return
            end
            getModeActive = false
        end
    end)

    createAction(freecamInputContext, actions.ModeNext).StateChanged:Connect(function(value: boolean)
        if not value then
            return
        end

        if var12 then
            if not getModeActive then
                getModeActive = true
            elseif _isMonitorItemSelected then
                _isMonitorItemSelected = false
            elseif #tbl15 > 0 then
                local var25 = tbl15[#tbl15]
                var25.index = nextEnabledIndex(var25.modes, var25.index, 1)
            else
                _getModeIndex = nextEnabledIndex(tbl17, _getModeIndex, 1)
            end

            return
        end

        if not getModeActive then
            return
        end

        if bool6 then
            return
        end
        if #tbl15 > 0 then
            local var25 = tbl15[#tbl15]
            var25.index = var25.index % #var25.modes + 1
            return
        end
        local var25 = tbl17[_getModeIndex]
        if var25.type == "group" then
            table.insert(tbl15, { modes = var25.modes, index = 1, groupName = var25.name })
            return
        elseif var25.type == "toggle" then
            var25.toggle()
            return
        elseif var25.type == "cycle" then
            local var26 = var25.items()
            if #var26 > 0 then
                var25.setIndex(var25.getIndex() % #var26 + 1)
            end

            return
        elseif var25.type == "action" then
            var25.action()
            return
        end

        if var25.type == "axis" then
            bool6 = true
        end
    end)

    local inputAction2 = createAction(freecamInputContext, actions.ModeAxis)
    inputAction2.StateChanged:Connect(function(value: number)
        if not getModeActive or value == 0 then
            return
        end

        if not var12 then
            if bool6 then
                return
            end
            if #tbl15 > 0 then
                local var25 = currentMode()

                if var25.type == "group" then
                    table.insert(tbl15, { modes = var25.modes, index = 1, groupName = var25.name })
                    return
                elseif var25.type == "toggle" then
                    var25.toggle()
                    return
                end

                if var25.type == "cycle" then
                    local var26 = var25.items()
                    if #var26 == 0 then
                        return
                    end

                    if value > 0 then
                        var25.setIndex(var25.getIndex() % #var26 + 1)
                        return
                    end

                    if value < 0 then
                        var25.setIndex((var25.getIndex() - 2) % #var26 + 1)
                    end
                elseif var25.type == "action" then
                    var25.action()
                end
            else
                if value > 0 then
                    _getModeIndex = _getModeIndex % #tbl17 + 1
                    return
                end

                if value < 0 then
                    _getModeIndex = (_getModeIndex - 2) % #tbl17 + 1
                end
            end

            return
        end

        local var25 = currentMode()

        if _isMonitorItemSelected then
            if var25.type == "toggle" then
                var25.toggle()
                return
            end

            if var25.type == "cycle" then
                local var26 = var25.items()
                if #var26 > 0 then
                    if value > 0 then
                        var25.setIndex(var25.getIndex() % #var26 + 1)
                        return
                    end
                    var25.setIndex((var25.getIndex() - 2) % #var26 + 1)
                end
            else
                if var25.type == "action" then
                    var25.action()
                    return
                end

                if var25.type == "axis" then
                end
            end

            return
        end

        if value > 0 then
            if isDisabled(var25) then
                return
            elseif var25.type == "group" then
                table.insert(tbl15, { modes = var25.modes, index = 1, groupName = var25.name })
                return
            elseif var25.type == "action" then
                var25.action()
                return
            else
                _isMonitorItemSelected = true
                return
            end
        end

        if not (value < 0) then
            return
        end

        _isMonitorItemSelected = false
        if #tbl15 > 0 then
            tbl15[#tbl15] = nil
            return
        end
        getModeActive = false
    end)

    tbl13.ModeAxis = inputAction2
end

createIASContexts()

function tbl12.Movement()
    local state = tbl13.MovementMove:GetState()
    return Vector3.new(state.X, tbl13.MovementElevate:GetState(), state.Y) * (tbl14.movement * (tbl13.Shift:GetState() and tbl1.Movement.ShiftMul or 1))
end

function tbl12.Pan()
    local state = tbl13.Pan:GetState()
    return Vector2.new(state.Y, -state.X) * tbl14.pan
end

function tbl12.Fov()
    return tbl13.Fov:GetState() * tbl14.fov
end

function tbl12.Roll()
    return (if bool4 then 0 else tbl13.Tilt:GetState()) * tbl14.roll
end

function tbl12.ModeControl(num5: number)
    if not getModeActive then
        return
    end

    if var12 then
        if not _isMonitorItemSelected then
            return
        end
    elseif #tbl15 == 0 and not bool6 then
        return
    end

    local var25 = currentMode()

    if var25.type ~= "axis" then
        return
    end

    local var26 = tbl13.ModeAxis:GetState() * var25.adj * num5
    if var26 ~= 0 then
        var25.set((clamp(var25.get() + var26, var25.min, var25.max)))
    end
end

function tbl12.StartCapture()
    tbl12._sinkContext.Enabled = true
end

function tbl12.StopCapture()
    tbl12._sinkContext.Enabled = false
    bool4 = false
    if var24 then
        var24()
    end

    getModeActive = false
    if var12 then
        table.clear(tbl15)
        _isMonitorItemSelected = false
    else
        tbl15 = {}
    end
    bool6 = false
end

function tbl12.getModeActive()
    return getModeActive
end

function tbl12.getModeName()
    return currentMode().name
end

function tbl12.getModeBreadcrumb(): string
    if #tbl15 == 0 then
        return ""
    end

    local tbl18 = {}
    for _, value in ipairs(tbl15) do
        table.insert(tbl18, value.groupName)
    end
    return table.concat(tbl18, " › ")
end

function tbl12.getModeDisplay()
    local var25 = currentMode()

    if var25.type == "group" then
        return ""
    elseif var25.type == "axis" then
        return string.format(var14 and var25.format or "%.2f", var25.get())
    elseif var25.type == "toggle" then
        return if var25.isEnabled() then "ON" else "OFF"
    end

    if var25.type ~= "cycle" then
        return if var25.type == "action" then "(fire)" else ""
    end

    local var26 = var25.items()
    if #var26 == 0 then
        return "None"
    end

    local var27 = var26[var25.getIndex()]
    return var27 and var25.displayItem(var27) or "None"
end

function tbl12.getModeHint()
    local var25 = tbl17[_getModeIndex]

    local function lrVerb(type) -- Luacid: Inlined by compiler; 2 call sites recovered
        if type == "axis" then
            return "Hold to adjust"
        elseif type == "toggle" then
            return "Tap to flip"
        elseif type == "cycle" then
            return "Tap to cycle"
        elseif type == "action" then
            return "Tap to fire"
        elseif type == "group" then
            return "Enter"
        end

        return nil
    end

    if #tbl15 > 0 then
        local var26 = tbl15[#tbl15]
        local var27 = var26.index % #var26.modes + 1
        local nav = "[↑] Back  [↓] " .. var26.modes[var27].name
        local var29 = lrVerb(currentMode().type)
        return {
            nav = nav,
            action = var29 and "[←][→] " .. var29 or ""
        }
    end

    if bool6 then
        local var26 = lrVerb(var25.type)
        return {
            nav = "[↑] Back",
            action = var26 and "[←][→] " .. var26 or ""
        }
    end
    local type = var25.type

    local name = tbl17[(_getModeIndex - 2) % #tbl17 + 1].name
    local name2 = tbl17[_getModeIndex % #tbl17 + 1].name
    return {
        nav = "[↑] Close  [↓] " .. (type == "group" and "Enter"
            or (if type == "toggle" then "Flip" elseif type == "cycle" then "Cycle" elseif type == "action" then "Fire" elseif type == "axis" then "Adjust" else "Select")),
        action = "[←] " .. name .. "  [→] " .. name2
    }
end

function tbl12.getTintColorName()
    return if num1 >= 1 and num1 <= #tbl9 then tbl9[num1].name else "Custom"
end

function tbl12.getActiveGroupName()
    return if getModeActive and #tbl15 ~= 0 then tbl15[1].groupName else nil
end

if var12 then
    tbl12._navigationStack = tbl15
    tbl12._modes = tbl17
    function tbl12._getModeIndex()
        return _getModeIndex
    end

    function tbl12._isMonitorItemSelected()
        return _isMonitorItemSelected
    end
end

local tbl18 = {
    {
        get = function()
            return var2
        end,
        key = "bloom",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format("Intensity: %.2f  Size: %.1f\nThreshold: %.2f", arg1.Intensity, arg1.Size, arg1.Threshold)
        end
    },
    {
        get = function()
            return var3
        end,
        key = "blur",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format("Size: %.1f", arg1.Size)
        end
    },
    {
        get = function()
            return var4
        end,
        key = "cc",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format(
                "Brightness: %.2f  Contrast: %.2f\nSaturation: %.2f  Tint: %s",
                arg1.Brightness,
                arg1.Contrast,
                arg1.Saturation,
                tbl12.getTintColorName()
            )
        end
    },
    {
        get = function()
            return var5
        end,
        key = "sunrays",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format("Intensity: %.2f  Spread: %.2f", arg1.Intensity, arg1.Spread)
        end
    },
    {
        get = function()
            return var6
        end,
        key = "colorgrading",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format("Color Grading: %s", arg1.TonemapperPreset.Name)
        end
    },
    {
        get = function()
            return get
        end,
        key = "dof",
        group = "Custom Post Processing",
        fmt = function(arg1): string
            return string.format(
                "Far: %.2f  Near: %.2f\nDistance: %.1f  Radius: %.1f",
                arg1.FarIntensity,
                arg1.NearIntensity,
                arg1.FocusDistance,
                arg1.InFocusRadius
            )
        end
    }
}

local function setBubble(arg1, text) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.bubble.Visible = text ~= ""
    if text ~= "" then
        arg1.label.Text = text
    end
end
local var25 = nil
local tbl19 = nil
local var26 = nil
local var27 = nil
local var28 = nil
local var29 = nil
local var30 = nil
if var12 then
    tbl19 = {}
    var26 = 12

    var27 = function(parent)
        local freecamMonitorPanel = Instance.new("Frame")
        freecamMonitorPanel.Name = "FreecamMonitorPanel"
        freecamMonitorPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        freecamMonitorPanel.BackgroundTransparency = 0.2
        freecamMonitorPanel.BorderSizePixel = 0
        freecamMonitorPanel.Size = UDim2.new(0, 240, 0, 0)
        freecamMonitorPanel.AutomaticSize = Enum.AutomaticSize.Y
        freecamMonitorPanel.AnchorPoint = Vector2.new(1, 1)
        freecamMonitorPanel.Position = UDim2.new(1, -16, 1, -16)
        freecamMonitorPanel.Visible = false

        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = freecamMonitorPanel

        local uiPadding = Instance.new("UIPadding")
        uiPadding.PaddingTop = UDim.new(0, 8)
        uiPadding.PaddingBottom = UDim.new(0, 8)
        uiPadding.PaddingLeft = UDim.new(0, 12)
        uiPadding.PaddingRight = UDim.new(0, 12)
        uiPadding.Parent = freecamMonitorPanel

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.Padding = UDim.new(0, 1)
        uiListLayout.Parent = freecamMonitorPanel

        local breadcrumb = Instance.new("TextLabel")
        breadcrumb.Name = "Breadcrumb"
        breadcrumb.BackgroundTransparency = 1
        breadcrumb.TextColor3 = Color3.fromRGB(150, 150, 150)
        breadcrumb.Font = Enum.Font.GothamMedium
        breadcrumb.TextSize = 11
        breadcrumb.TextXAlignment = Enum.TextXAlignment.Left
        breadcrumb.Size = UDim2.new(1, 0, 0, 16)
        breadcrumb.LayoutOrder = 0
        breadcrumb.Visible = false
        breadcrumb.Parent = freecamMonitorPanel

        tbl19 = {}
        for layoutOrder = 1, var26 do
            local frame = Instance.new("Frame")
            frame.Name = "Row" .. layoutOrder
            frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            frame.BackgroundTransparency = 1
            frame.BorderSizePixel = 0
            frame.Size = UDim2.new(1, 0, 0, 22)
            frame.LayoutOrder = layoutOrder
            frame.Visible = false

            local uiCorner2 = Instance.new("UICorner")
            uiCorner2.CornerRadius = UDim.new(0, 4)
            uiCorner2.Parent = frame

            local uiPadding2 = Instance.new("UIPadding")
            uiPadding2.PaddingLeft = UDim.new(0, 6)
            uiPadding2.PaddingRight = UDim.new(0, 6)
            uiPadding2.Parent = frame

            local name = Instance.new("TextLabel")
            name.Name = "Name"
            name.BackgroundTransparency = 1
            name.TextColor3 = Color3.new(1, 1, 1)
            name.Font = Enum.Font.GothamMedium
            name.TextSize = 14
            name.TextXAlignment = Enum.TextXAlignment.Left
            name.Size = UDim2.new(0.55, 0, 1, 0)
            name.Position = UDim2.new(0, 0, 0, 0)
            name.Parent = frame

            local value = Instance.new("TextLabel")
            value.Name = "Value"
            value.BackgroundTransparency = 1
            value.TextColor3 = Color3.fromRGB(180, 180, 180)
            value.Font = Enum.Font.GothamMedium
            value.TextSize = 14
            value.TextXAlignment = Enum.TextXAlignment.Right
            value.Size = UDim2.new(0.45, 0, 1, 0)
            value.Position = UDim2.new(0.55, 0, 0, 0)
            value.Parent = frame

            frame.Parent = freecamMonitorPanel
            tbl19[layoutOrder] = { frame = frame, nameLabel = name, valueLabel = value }
        end

        local hint = Instance.new("TextLabel")
        hint.Name = "Hint"
        hint.BackgroundTransparency = 1
        hint.TextColor3 = Color3.fromRGB(120, 120, 120)
        hint.Font = Enum.Font.Gotham
        hint.TextSize = 12
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.Size = UDim2.new(1, 0, 0, 20)
        hint.LayoutOrder = var26 + 1
        hint.Parent = freecamMonitorPanel

        freecamMonitorPanel.Parent = parent
        var25 = { panel = freecamMonitorPanel, breadcrumb = breadcrumb, hint = hint }
    end

    var28 = function(arg1)
        if arg1.type == "group" then
            return "›"
        elseif arg1.type == "toggle" then
            return if arg1.isEnabled() then "On" else "Off"
        elseif arg1.type == "axis" then
            return string.format(var14 and arg1.format or "%.2f", arg1.get())
        end

        if arg1.type ~= "cycle" then
            return if arg1.type == "action" then "" else ""
        end

        local var31 = arg1.items()
        if #var31 == 0 then
            return "--"
        end

        local var32 = var31[arg1.getIndex()]
        return var32 and arg1.displayItem(var32) or "--"
    end

    var29 = function(arg1, arg2, arg3): Color3
        if arg1.type == "toggle" then
            if arg1.isEnabled() then
                return Color3.fromRGB(0, 176, 111)
            end
            return Color3.fromRGB(150, 150, 150)
        elseif arg2 and arg3 then
            return Color3.new(1, 1, 1)
        else
            return Color3.fromRGB(180, 180, 180)
        end
    end
    var30 = function()
        if not var25 then
            return
        end

        local panel = var25.panel
        if not tbl12.getModeActive() then
            panel.Visible = false
            return
        end
        panel.Visible = true
        local var31, index

        if #tbl12._navigationStack > 0 then
            local var32 = tbl12._navigationStack[#tbl12._navigationStack]
            var31 = var32.modes
            index = var32.index
        else
            var31 = tbl12._modes
            index = tbl12._getModeIndex()
        end

        local modeBreadcrumb = tbl12.getModeBreadcrumb()
        var25.breadcrumb.Text = modeBreadcrumb
        var25.breadcrumb.Visible = modeBreadcrumb ~= ""

        local var32 = tbl12._isMonitorItemSelected()
        local num5 = math.min(#var31, var26)
        for i = 1, var26 do
            local var33 = tbl19[i]
            if i <= num5 then
                local var34 = var31[i]
                local bool8 = i == index
                local var35 = var34.disabled and var34.disabled()
                var33.frame.Visible = true

                if bool8 and not var35 then
                    var33.nameLabel.Text = "> " .. var34.name
                    var33.nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    var33.nameLabel.Font = Enum.Font.GothamMedium
                    var33.frame.BackgroundTransparency = if var32 then 0.88 else 1
                elseif var35 then
                    var33.nameLabel.Text = "  " .. var34.name
                    var33.nameLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
                    var33.nameLabel.Font = Enum.Font.GothamMedium
                    var33.frame.BackgroundTransparency = 1
                else
                    var33.nameLabel.Text = "  " .. var34.name
                    var33.nameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    var33.nameLabel.Font = Enum.Font.GothamMedium
                    var33.frame.BackgroundTransparency = 1
                end

                var33.valueLabel.Text = var28(var34)
                var33.valueLabel.TextColor3 = var35 and Color3.fromRGB(60, 60, 60) or var29(var34, bool8, var32)
            else
                var33.frame.Visible = false
            end
        end

        if not var32 then
            var25.hint.Text = "↑↓ Navigate   → Select   ← Back"

            return
        end

        if var15 then
            var25.hint.Text = "↑↓ Exit selection   ←→ Adjust"
            return
        end
        var25.hint.Text = "←→ Adjust   ↑↓ Exit selection"
    end
end

local function StepFreecam(num5: number)
    tbl12.ModeControl(num5)

    local var31 = var20:Update(num5, tbl12.Movement())
    local var32 = var21:Update(num5, tbl12.Pan())
    local var33 = var22:Update(num5, tbl12.Fov())
    local var34 = var23:Update(num5, tbl12.Roll())

    local var35 = sqrt(0.7002075382097097 / tan((rad(num2 / 2))))

    local num6 = num2
    num2 = clamp(num2 + var33 * tbl1.Fov.Gain * (num5 / var35), 1, 120)
    if math.abs(num2 - num6) > 0.01 then
        huge = os.clock()
    end

    if var31.Magnitude > 0.05 or var32.Magnitude > 0.0005 or math.abs(var34) > 0.0005 or math.abs(var33) > 0.0005 then
        huge2 = os.clock()
    end
    local var36 = var32 * tbl1.Pan.Gain * (num5 / var35)
    vec3_2 += Vector3.new(var36.X, var36.Y, var34 * tbl1.Roll.Gain * (num5 / var35))
    local function wrapAngle(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        arg1 %= math.pi * 2
        if arg1 > math.pi then
            arg1 = arg1 - math.pi * 2 or arg1
        end

        return arg1
    end
    vec3_2 = Vector3.new(wrapAngle(vec3_2.x), wrapAngle(vec3_2.y), (wrapAngle(vec3_2.z)))
    local vec3_3 = Vector3.new(var31.X, var31.Y, -var31.Z)
    local var37 = CFrame.new(vec3) * CFrame.fromOrientation(vec3_2.x, vec3_2.y, vec3_2.z) * CFrame.new(vec3_3 * tbl1.Movement.Gain * num5)

    if bool1 and var18 and var18.Parent then
        local playerLock = tbl1.PlayerLock
        local var38 = -var31.Z * tbl1.Movement.Gain.Z * num5
        local var39 = var31.Y * tbl1.Movement.Gain.Y * num5
        DefaultZoom = clamp(DefaultZoom + var38, playerLock.MinZoom, playerLock.MaxZoom)
        DefaultHeight = clamp(DefaultHeight + var39, -playerLock.HeightRange, playerLock.HeightRange)
        var37 = CFrame.new(var18.Position + Vector3.new(0, DefaultHeight, 0)) * CFrame.fromOrientation(vec3_2.x, vec3_2.y, vec3_2.z) * CFrame.new(0, 0, DefaultZoom)
    end

    if var12 then
        var30()
    elseif var8 and var8.Parent and var9 and Freecam and Freecam.Parent then
        local mode = var9.mode
        if tbl12.getModeActive() then
            if os.clock() - huge2 < 2 then
                local tbl20 = ({})
                tbl20[#tbl20 + 1] = string.format("X: %.0f  Y: %.0f  Z: %.0f", vec3.X, vec3.Y, vec3.Z)
                local num7 = #tbl20 + 1
                tbl20[num7] = string.format("Pitch: %.1f°  Yaw: %.1f°  Roll: %.1f°", math.deg(vec3_2.X), math.deg(vec3_2.Y), math.deg(vec3_2.Z))
                if os.clock() - huge < 2 then
                    tbl20[#tbl20 + 1] = string.format("Field of View: %.1f", num2)
                end
                if num5 > 0 then
                    local var38 = (var37.p - vec3).Magnitude / num5
                    if var38 > 0.5 then
                        tbl20[#tbl20 + 1] = string.format("Speed: %.1f", var38)
                    end
                end
                setBubble(var9.status, table.concat(tbl20, "\n"))
            else
                var9.status.bubble.Visible = false
            end

            if bool1 and #items > 0 and tbl12.getActiveGroupName() ~= "Player Lock" then
                setBubble(var9.lock, string.format("Lock: %s", items[getIndex].Name))
            else
                var9.lock.bubble.Visible = false
            end

            local activeGroupName = tbl12.getActiveGroupName()
            for _, value in ipairs(tbl18) do
                local var38 = value.get()
                if var38 and var38.Enabled and activeGroupName ~= value.group then
                    setBubble(var9[value.key], (value.fmt(var38)))
                else
                    var9[value.key].bubble.Visible = false
                end
            end

            mode.bubble.Visible = true
            local modeBreadcrumb = tbl12.getModeBreadcrumb()
            mode.breadcrumb.Text = modeBreadcrumb
            mode.breadcrumb.Visible = modeBreadcrumb ~= ""
            local modeName = tbl12.getModeName()
            local modeDisplay = tbl12.getModeDisplay()
            local title = mode.title

            if modeDisplay ~= "" then
                modeName = modeName .. ": " .. modeDisplay or modeName
            end

            title.Text = modeName
            local modeHint = tbl12.getModeHint()
            mode.nav.Text = modeHint.nav
            mode.nav.Visible = modeHint.nav ~= ""
            mode.action.Text = modeHint.action
            mode.action.Visible = modeHint.action ~= ""

            var8.Visible = true
        else
            var8.Visible = false
        end
    end

    vec3 = var37.p
    CurrentCamera.CFrame = var37
    CurrentCamera.Focus = var37
    CurrentCamera.FieldOfView = num2
end

var10 = {}

local Default = nil
local MouseIconEnabled = nil
local CameraType = nil
local Focus = nil
local CFrame = nil
local FieldOfView = nil
local getScreenGuis = {}
local tbl21 = { Backpack = true, Chat = true, Health = true, PlayerList = true }

local tbl22 = { BadgesNotificationsActive = true, PointsNotificationsActive = true }

function var10.Push()
    for k in pairs(tbl21) do
        tbl21[k] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[k])
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], false)
    end
    for k in pairs(tbl22) do
        tbl22[k] = StarterGui:GetCore(k)
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
        connection = playerGui.ChildAdded:Connect(function(child: Instance)
            if child:IsA("ScreenGui") and child.Enabled then
                getScreenGuis[#getScreenGuis + 1] = child
                child.Enabled = bool3
            end
        end)
    end

    FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = 70

    CameraType = CurrentCamera.CameraType
    CurrentCamera.CameraType = Enum.CameraType.Custom

    CFrame = CurrentCamera.CFrame
    Focus = CurrentCamera.Focus

    MouseIconEnabled = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = false

    Default = Enum.MouseBehavior.Default
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

function var10.Pop()
    for k, value in pairs(tbl21) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], value)
    end
    for k, value in pairs(tbl22) do
        StarterGui:SetCore(k, value)
    end
    for _, value in pairs(getScreenGuis) do
        if value.Parent and value ~= Freecam then
            value.Enabled = true
        end
    end

    if connection then
        connection:Disconnect()
        connection = nil
    end
    getScreenGuis = {}

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
    UserInputService.MouseBehavior = Default
    Default = nil
end

function var10.getScreenGuis()
    return getScreenGuis
end

local function removePlayerFromList(player: Player)
    for i, player2 in ipairs(items) do
        if player2 ~= player then
            continue
        end

        table.remove(items, i)
        if getIndex == i and bool1 then
            bool1 = false
            getIndex = 1
        end
        if i < getIndex then
            getIndex -= 1
        end

        if getIndex > #items or getIndex < 1 then
            getIndex = 1
            return
        end

        break
    end
end

local function initializePlayerList()
    items = Players:GetPlayers()
    for i, player in ipairs(items) do
        if player == LocalPlayer then
            getIndex = i
            break
        end
    end

    connection2 = Players.PlayerAdded:Connect(function(player: Player)
        table.insert(items, player)
    end)

    connection3 = Players.PlayerRemoving:Connect(removePlayerFromList)
end

local function StartFreecam()
    initializePlayerList()

    local currentCameraCFrame = CurrentCamera.CFrame
    vec3_2 = Vector3.new(currentCameraCFrame:toEulerAnglesYXZ())
    vec3 = currentCameraCFrame.p
    num2 = CurrentCamera.FieldOfView

    var20:Reset(Vector3.new())
    var21:Reset(Vector2.new())
    var22:Reset(0)
    var23:Reset(0)

    Freecam = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Freecam")
    if var12 then
        if not var25 then
            var27(Freecam)
        end
    elseif not (var8 and var8.Parent) then
        local freecamCustomGui = Instance.new("Frame")
        freecamCustomGui.Name = "FreecamCustomGui"
        freecamCustomGui.BackgroundTransparency = 1
        freecamCustomGui.AutomaticSize = Enum.AutomaticSize.XY
        freecamCustomGui.AnchorPoint = Vector2.new(1, 1)
        freecamCustomGui.Position = UDim2.new(1, -16, 1, -16)
        freecamCustomGui.Size = UDim2.new(0, 0, 0, 0)
        freecamCustomGui.Visible = false

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        uiListLayout.Padding = UDim.new(0, 6)
        uiListLayout.Parent = freecamCustomGui

        local function makeBubble(frameName: string, layoutOrder: number): (Frame, TextLabel)
            local frame = Instance.new("Frame")
            frame.Name = frameName
            frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            frame.BackgroundTransparency = 0.4
            frame.BorderSizePixel = 0
            frame.AutomaticSize = Enum.AutomaticSize.XY
            frame.Size = UDim2.new(0, 0, 0, 0)
            frame.LayoutOrder = layoutOrder
            frame.Visible = false
            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 8)
            uiCorner.Parent = frame
            local uiPadding = Instance.new("UIPadding")
            uiPadding.PaddingTop = UDim.new(0, 8)
            uiPadding.PaddingBottom = UDim.new(0, 8)
            uiPadding.PaddingLeft = UDim.new(0, 12)
            uiPadding.PaddingRight = UDim.new(0, 12)
            uiPadding.Parent = frame
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.GothamMedium
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.AutomaticSize = Enum.AutomaticSize.XY
            label.Size = UDim2.new(0, 0, 0, 0)
            label.Parent = frame
            frame.Parent = freecamCustomGui
            return frame, label
        end

        local frame, textLabel = makeBubble("BloomBubble", 1)
        local frame2, textLabel2 = makeBubble("BlurBubble", 2)
        local frame3, textLabel3 = makeBubble("CCBubble", 3)
        local frame4, textLabel4 = makeBubble("SunRaysBubble", 4)
        local frame5, textLabel5 = makeBubble("ColorGradingBubble", 5)
        local frame6, textLabel6 = makeBubble("DofBubble", 6)
        local frame7, textLabel7 = makeBubble("LockBubble", 7)
        local frame8, textLabel8 = makeBubble("StatusBubble", 8)

        local modeBubble = Instance.new("Frame")
        modeBubble.Name = "ModeBubble"
        modeBubble.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        modeBubble.BackgroundTransparency = 0.4
        modeBubble.BorderSizePixel = 0
        modeBubble.AutomaticSize = Enum.AutomaticSize.XY
        modeBubble.Size = UDim2.new(0, 0, 0, 0)
        modeBubble.LayoutOrder = 9
        modeBubble.Visible = false
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = modeBubble
        local uiPadding = Instance.new("UIPadding")
        uiPadding.PaddingTop = UDim.new(0, 8)
        uiPadding.PaddingBottom = UDim.new(0, 8)
        uiPadding.PaddingLeft = UDim.new(0, 12)
        uiPadding.PaddingRight = UDim.new(0, 12)
        uiPadding.Parent = modeBubble
        local uiListLayout2 = Instance.new("UIListLayout")
        uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout2.FillDirection = Enum.FillDirection.Vertical
        uiListLayout2.Padding = UDim.new(0, 2)
        uiListLayout2.Parent = modeBubble
        local function makeModeLabel(textLabel9Name: string, layoutOrder: number, font: Enum.Font, textSize: number, textColor3: Color3): TextLabel
            local textLabel9 = Instance.new("TextLabel")
            textLabel9.Name = textLabel9Name
            textLabel9.BackgroundTransparency = 1
            textLabel9.TextColor3 = textColor3
            textLabel9.Font = font
            textLabel9.TextSize = textSize
            textLabel9.TextXAlignment = Enum.TextXAlignment.Left
            textLabel9.AutomaticSize = Enum.AutomaticSize.XY
            textLabel9.Size = UDim2.new(0, 0, 0, 0)
            textLabel9.LayoutOrder = layoutOrder
            textLabel9.Parent = modeBubble
            return textLabel9
        end
        local textLabel9 = makeModeLabel("Breadcrumb", 1, Enum.Font.Gotham, 11, Color3.fromRGB(100, 100, 100))
        local textLabel10 = makeModeLabel("Title", 2, Enum.Font.GothamBold, 14, Color3.new(1, 1, 1))
        local textLabel11 = makeModeLabel("NavHint", 3, Enum.Font.Gotham, 12, Color3.fromRGB(120, 120, 120))
        local textLabel12 = makeModeLabel("ActionHint", 4, Enum.Font.GothamMedium, 12, Color3.fromRGB(200, 200, 200))
        modeBubble.Parent = freecamCustomGui

        var8 = freecamCustomGui
        var9 = {
            bloom = { bubble = frame, label = textLabel },
            blur = { bubble = frame2, label = textLabel2 },
            cc = { bubble = frame3, label = textLabel3 },
            sunrays = { bubble = frame4, label = textLabel4 },
            colorgrading = { bubble = frame5, label = textLabel5 },
            dof = { bubble = frame6, label = textLabel6 },
            lock = { bubble = frame7, label = textLabel7 },
            status = { bubble = frame8, label = textLabel8 },
            mode = {
                bubble = modeBubble,
                breadcrumb = textLabel9,
                title = textLabel10,
                nav = textLabel11,
                action = textLabel12
            }
        }
        freecamCustomGui.Parent = Freecam
    end

    var10.Push()
    Freecam.Enabled = true

    local function makeEffect(className: string, instanceName): Instance -- Luacid: Inlined by compiler; 1 call site recovered
        local instance = Instance.new(className)
        instance.Name = instanceName
        instance.Parent = CurrentCamera
        return instance
    end
    for _, value in ipairs(var17) do
        local var31 = tbl2[value.key]
        local effect = makeEffect(value.class, "Freecam" .. value.key)
        if var13 and value.parent then
            effect.Parent = value.parent
        end
        for _, prop in ipairs(value.props) do
            effect[prop] = var31[prop]
        end

        effect.Enabled = var31.Enabled
        value.set(effect)
    end

    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
    tbl12.StartCapture()
end

local function StopFreecam()
    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end

    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end

    bool1 = false
    getIndex = 1
    items = {}

    func2()
    isEnabled = false
    for _, value in ipairs(var17) do
        local var31 = value.get()
        if not var31 then
            continue
        end

        local var32 = tbl2[value.key]
        var32.Enabled = var31.Enabled
        for _, prop in ipairs(value.props) do
            var32[prop] = var31[prop]
        end

        var31:Destroy()
        value.set(nil)
    end

    if var12 and var25 then
        var25.panel.Visible = false
    end

    if Freecam and Freecam.Parent then
        Freecam.Enabled = false
    end

    bool3 = false
    enabled = false

    tbl12.StopCapture()
    RunService:UnbindFromRenderStep("Freecam")
    var10.Pop()
end

local bool8 = false

local function ToggleFreecam() -- Luacid: Inlined by compiler; 1 call site recovered
    if bool8 then
        StopFreecam()
    else
        StartFreecam()
    end

    bool8 = not bool8
    if var11 then
        script:SetAttribute(tbl1.AttributeName, bool8)
    end
end

var19.StateChanged:Connect(function(bool9: boolean)
    if bool9 then
        ToggleFreecam()
    end
end)
if var11 then
    script:SetAttribute(tbl1.AttributeName, bool8)
    script:GetAttributeChangedSignal(tbl1.AttributeName):Connect(function()
        local var31 = script:GetAttribute(tbl1.AttributeName)
        if typeof(var31) ~= "boolean" then
            script:SetAttribute(tbl1.AttributeName, bool8)
            return
        end
        if var31 == bool8 then
            return
        end

        if var31 then
            StartFreecam()
            bool8 = true
            return
        end

        StopFreecam()
        bool8 = false
    end)
end

return {}
