-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local VideoCaptureService = game:GetService("VideoCaptureService")
local FaceAnimatorService = game:GetService("FaceAnimatorService")

local Roact = require(CorePackages.Packages.Roact)
local ReactUtils = require(CorePackages.Packages.ReactUtils)
local t = require(CorePackages.Packages.t)

local EventConnection = ReactUtils.EventConnection

local Modules = CoreGui.RobloxGui.Modules
local default = require(Modules.VoiceChat.VoiceChatServiceManager).default
local getCamMicPermissions = require(Modules.Settings.getCamMicPermissions)

local var1 = Roact.PureComponent:extend("FlashingDot")

local function lerpNum(num1: number, num2: number, num3: number): number -- Luacid: unused: defined but never referenced
    return num1 + (num2 - num1) * num3
end

var1.validateProps = t.strictInterface({})

function var1.init(arg1)
    arg1:setState({ Visible = false, isUsingMic = false, hasMicPermissions = false, hasCameraPermissions = false })

    arg1.prevTime = math.pi / 2
    arg1.prevSinTime = 1
    local transparencyBinding, updateTransparencyBinding = Roact.createBinding(0)
    arg1.transparencyBinding = transparencyBinding
    arg1.updateTransparencyBinding = updateTransparencyBinding

    function arg1.checkNewVisibility()
        local hasMicPermissions = arg1.state.hasMicPermissions

        if hasMicPermissions then
            if default.localMuted == nil then
                hasMicPermissions = false
            else
                hasMicPermissions = not default.localMuted
            end
        end
        local active = arg1.state.hasCameraPermissions and FaceAnimatorService.VideoAnimationEnabled and VideoCaptureService.Active
        local var4 = hasMicPermissions or active

        if arg1.state.Visible ~= var4 then
            arg1:setState({ Visible = var4, isUsingMic = hasMicPermissions })
        end
    end

    function arg1.animationConnection(arg2)
        local prevTime = arg1.prevTime + arg2
        local prevSinTime = math.sin(prevTime * 3)

        local num2 = math.abs(arg1.prevSinTime)
        arg1.updateTransparencyBinding(num2 * -0.5 + 0.5)
        arg1.prevTime = prevTime
        arg1.prevSinTime = prevSinTime
    end
end

function var1.didMount(arg1)
    arg1.isMounted = true
    getCamMicPermissions(function(arg2)
        if not arg1.isMounted then
            return
        end

        arg1:setState({ hasCameraPermissions = arg2.hasCameraPermissions, hasMicPermissions = arg2.hasMicPermissions })
    end, nil, nil, "FlashingDot.didMount")
    arg1.checkNewVisibility()
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.state.hasMicPermissions ~= arg2.hasMicPermissions or arg1.state.hasCameraPermissions ~= arg2.hasCameraPermissions then
        arg1.checkNewVisibility()
    end
end

function var1.render(arg1)
    local uDim2 = UDim2.fromOffset(4, 4)

    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -4, 0, 3),
        Size = UDim2.fromOffset(4, 4),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Visible = arg1.state.Visible
    }, {
        FlashingDot = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = uDim2,
            Image = "rbxasset://textures/AnimationEditor/FaceCaptureUI/FlashingDot.png",
            ImageTransparency = arg1.transparencyBinding,
            LayoutOrder = 2
        }),
        MuteChangedEvent = Roact.createElement(EventConnection, { event = default.muteChanged.Event, callback = arg1.checkNewVisibility }),
        CameraChangedEvent = Roact.createElement(
            EventConnection,
            {
                event = FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"),
                callback = arg1.checkNewVisibility
            }
        ),
        AnimationConnection = if arg1.state.Visible then Roact.createElement(EventConnection, { event = RunService.RenderStepped, callback = arg1.animationConnection }) else nil
    })
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return var1
