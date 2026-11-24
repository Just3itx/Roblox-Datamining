-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FaceAnimatorService = game:GetService("FaceAnimatorService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local Roact = require(ExpChatParent.Roact)
local RoactRodux = require(ExpChatParent.RoactRodux)
local ReactUtils = require(ExpChatParent.ReactUtils)
local Dictionary = require(ExpChatParent.llama).Dictionary
local SharedFlags = require(ExpChatParent.SharedFlags)

local EventConnection = ReactUtils.EventConnection

local Config = require(ExpChat.Config)
local AvatarChatUISettings = Config.AvatarChatUISettings
local Permissions = Config.Permissions
local GlobalFlags = require(ExpChat.GlobalFlags)
local FFlagExpChatUseProximityStore = SharedFlags.FFlagExpChatUseProximityStore
local ReactIs = if FFlagExpChatUseProximityStore then require(ExpChatParent.ReactIs) else nil
local ControlBubble = require(script.Parent.ControlBubble)
local GetFFlagExpChatEnableVoiceReverseNudge = require(ExpChat.Flags.GetFFlagExpChatEnableVoiceReverseNudge)

local GetFFlagExpChatUseVoiceParticipantsStore = SharedFlags.GetFFlagExpChatUseVoiceParticipantsStore

local bool1 = game:DefineFastFlag("PreventMicToggleIfGameConsumedEvent", false)

local var1 = Roact.PureComponent:extend("PlayerButtons")

var1.defaultProps = { LayoutOrder = 1 }

function var1.init(arg1)
    local tbl1 = {
        cameraEnabled = if FaceAnimatorService then FaceAnimatorService:IsStarted() and FaceAnimatorService.VideoAnimationEnabled else false
    }
    arg1:setState(tbl1)

    function arg1.toggleMic(arg2, arg3)
        if bool1 and arg2 then
            return
        end

        local onClickedVoiceIndicator = arg1.props.onClickedVoiceIndicator
        local userId = arg1.props.userId
        if not GetFFlagExpChatUseVoiceParticipantsStore() then
            arg3 = arg1.props.voiceState
        end

        onClickedVoiceIndicator(userId, arg3)
    end

    function arg1.onVideoButtonPressed()
        if arg1.props.hasCameraPermissions then
            arg1:toggleVideo()
            return
        end

        local function func1(arg2, _)
            if arg2 then
                arg1:toggleVideo()
                if arg1.props.setCameraPermissionStateFromControl then
                    arg1.props.setCameraPermissionStateFromControl(arg2)
                end
            elseif arg1.props.displayCameraDeniedToast then
                arg1.props.displayCameraDeniedToast()
            end
        end

        if arg1.props.getPermissions then
            arg1.props.getPermissions(func1, Permissions.CAMERA_ACCESS)
        end
    end

    function arg1.toggleVideo()
        arg1.props.onClickedCameraIndicator()
    end

    function arg1.updateVideo()
        arg1:setState({ cameraEnabled = FaceAnimatorService.VideoAnimationEnabled })
    end
end

function var1.shouldShowCameraIndicator(arg1)
    return arg1.props.isLocalPlayer and arg1:getCameraButtonVisibleAtMount()
end

function var1.shouldShowMicOffIndicator(arg1): boolean
    if not arg1.props.isLocalPlayer then
        return false
    end

    local bool2 = arg1.props.voiceState == "Muted" or arg1.props.voiceState == "LOCAL_MUTED"

    if GlobalFlags.JoinWithoutMicPermissions then
        return bool2
    end

    return bool2 or not arg1.props.hasMicPermissions
end

function var1.getCameraButtonVisibleAtMount(arg1)
    if arg1.props.isCameraOnlyUser and arg1.props.isCameraOnlyUser() then
        return false
    elseif arg1.props.isCamEnabledForUserAndPlace then
        return arg1.props.isCamEnabledForUserAndPlace()
    end

    return false
end

function var1.render(arg1)
    local var2 = arg1.props.hasMicPermissions or arg1.props.voiceEnabled
    if GlobalFlags.JoinWithoutMicPermissions then
        var2 = arg1.props.voiceEnabled
    end
    local var3 = arg1:shouldShowCameraIndicator()
    local var4 = not GetFFlagExpChatUseVoiceParticipantsStore() and arg1:shouldShowMicOffIndicator()
    local var5 = var3 and var2
    local chatSettings = arg1.props.chatSettings

    local cornerRadiusOffset = var5 and AvatarChatUISettings.DoubleIconCornerRadiusOffset or AvatarChatUISettings.SingleIconCornerRadiusOffset
    local controlBubbleSize = var5 and AvatarChatUISettings.DoubleIconButtonSize or AvatarChatUISettings.SingleIconButtonSize

    local iconStyle = if arg1.props.isLocalPlayer then "microphone" else "speaker"

    local iconAssetName = if arg1.state.cameraEnabled and arg1:getCameraButtonVisibleAtMount() then "icons/controls/voice/video_on_light" else "icons/controls/voice/video_off_light"

    local createElement = Roact.createElement
    local str3 = "Frame"

    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -8),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, AvatarChatUISettings.FrameHeight),
        LayoutOrder = arg1.props.LayoutOrder,
        BackgroundTransparency = chatSettings.BackgroundTransparency,
        BackgroundColor3 = chatSettings.BackgroundColor3,
        Visible = if FFlagExpChatUseProximityStore and ReactIs.isBinding(arg1.props.Visible) then arg1.props.Visible:map(function(arg2)
            return arg2 and var2 or var3
        end) else var2 or var3
    }

    local tbl2 = {
        Scale = Roact.createElement("UIScale", { Scale = if arg1.props.isInsideMaximizeDistance then 1 else 0.75 }),
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, cornerRadiusOffset) }),
        Container = 0,
        Carat = 0,
        BubbleGradient = 0,
        VideoEnabledChanged = 0
    }
    local createElement2 = Roact.createElement
    local str4 = "ImageLabel"
    local var7 = Dictionary.join({ Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, chatSettings.ImageLabel)
    local tbl3 = {
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, cornerRadiusOffset) }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        MicrophoneBubble = 0,
        Divider = 0,
        CameraBubble = 0
    }
    local var8 = var2

    if var8 then
        var8 = Roact.createElement(ControlBubble, {
            LayoutOrder = 1,
            onActivated = arg1.toggleMic,
            chatSettings = chatSettings,
            controlBubbleSize = controlBubbleSize,
            cornerRadiusOffset = cornerRadiusOffset,
            iconAssetName = if var4 then "icons/controls/voice/microphone_off_light" else nil,
            iconSize = AvatarChatUISettings.IconSize,
            iconTransparency = AvatarChatUISettings.IconTransparency,
            voiceState = if GetFFlagExpChatUseVoiceParticipantsStore() then nil else arg1.props.voiceState,
            iconStyle = iconStyle,
            isUserToxic = if GetFFlagExpChatUseVoiceParticipantsStore() then nil else arg1.props.isUserToxic,
            userId = if GetFFlagExpChatUseVoiceParticipantsStore() then arg1.props.userId else nil
        })
    end

    tbl3.MicrophoneBubble = var8

    tbl3.Divider = var2
        and var3
        and Roact.createElement("Frame", {
            Size = AvatarChatUISettings.DividerSize,
            AnchorPoint = Vector2.new(0.5, 1),
            BorderSizePixel = 0,
            LayoutOrder = 2,
            ZIndex = 1,
            BackgroundColor3 = AvatarChatUISettings.DividerColor
        })
    local element

    if var3 then
        element = Roact.createElement(ControlBubble, {
            LayoutOrder = 3,
            onActivated = arg1.onVideoButtonPressed or arg1.toggleVideo,
            chatSettings = chatSettings,
            cornerRadiusOffset = cornerRadiusOffset,
            controlBubbleSize = controlBubbleSize,
            iconAssetName = iconAssetName,
            iconSize = AvatarChatUISettings.IconSize,
            iconTransparency = AvatarChatUISettings.IconTransparency,
            iconStyle = iconStyle,
            isUserToxic = if GetFFlagExpChatUseVoiceParticipantsStore() then nil else arg1.props.isUserToxic
        })
    else
        element = var3
    end

    tbl3.CameraBubble = element
    tbl2.Container = createElement2(str4, var7, tbl3)

    tbl2.Carat = chatSettings.TailVisible
        and Roact.createElement(
            "ImageLabel",
            {
                LayoutOrder = 3,
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 1, -1),
                Size = UDim2.fromOffset(12, 8),
                Image = "rbxasset://textures/ui/InGameChat/Caret.png",
                ImageColor3 = chatSettings.BackgroundColor3,
                ImageTransparency = chatSettings.BackgroundTransparency
            },
            {
                CaratGradient = chatSettings.UIGradient and Roact.createElement("UIGradient", chatSettings.UIGradient)
            }
        )
    tbl2.BubbleGradient = chatSettings.UIGradient and Roact.createElement("UIGradient", chatSettings.UIGradient)
    tbl2.VideoEnabledChanged = if FaceAnimatorService then Roact.createElement(
        EventConnection,
        {
            event = FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"),
            callback = arg1.updateVideo
        }
    )
        or nil else nil
    return createElement(str3, tbl1, tbl2)
end

local function mapStateToProps(arg1, arg2)
    local reverseNudgeToxicUser

    if GetFFlagExpChatEnableVoiceReverseNudge() and arg1.ReverseNudgeToxicUsers then
        reverseNudgeToxicUser = arg1.ReverseNudgeToxicUsers[arg2.userId]
        if reverseNudgeToxicUser == nil then
            reverseNudgeToxicUser = false
        end
    else
        reverseNudgeToxicUser = false
    end

    return {
        voiceState = arg1.Voice.participants[arg2.userId],
        isUserToxic = reverseNudgeToxicUser
    }
end

if GetFFlagExpChatUseVoiceParticipantsStore() then
    return var1
end
return RoactRodux.connect(mapStateToProps)(var1)
