-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local UIBlox = require(CorePackages.Packages.UIBlox)
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local var1 = require(RobloxGui.Modules.VoiceChat.Logger)(script.Name)

local Roact = require(CorePackages.Packages.Roact)
local ReactIs = require(CorePackages.Packages.ReactIs)

local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local var2 = Roact.PureComponent:extend("VoiceIndicator")

var2.validateProps = t.strictInterface({
    onClicked = t.optional(t.callback),
    userId = t.string,
    hideOnError = t.optional(t.boolean),
    size = t.optional(t.UDim2),
    iconStyle = t.optional(t.union(t.literal("MicDark"), t.literal("MicLight"), t.literal("SpeakerDark"), t.literal("SpeakerLight"))),
    iconTransparency = t.optional(t.union(t.number, t.table)),
    voiceState = t.string
})

var2.defaultProps = {}

function var2.getIcon(_, arg1)
    return "rbxasset://textures/ui/VoiceChat/" .. arg1 .. ".png"
end

function var2.init(arg1)
    local level, updateLevel = Roact.createBinding(0)
    arg1.level = level
    arg1.updateLevel = updateLevel
    local voiceState, updateVoiceState = Roact.createBinding(arg1.props.voiceState)
    arg1.voiceState = voiceState
    arg1.updateVoiceState = updateVoiceState

    arg1.renderStepName = HttpService:GenerateGUID()
    RunService:BindToRenderStep(arg1.renderStepName, 1, function()
        arg1.updateLevel(math.random())
    end)

    arg1.levelIcon = Roact.joinBindings({ arg1.voiceState, arg1.level }):map(function(arg2)
        local var7 = arg2[1]
        local var8 = arg2[2]

        if var7 == Constants.VOICE_STATE.MUTED or var7 == Constants.VOICE_STATE.LOCAL_MUTED then
            return default:GetIcon("Muted", arg1.props.iconStyle)
        end

        if var7 == Constants.VOICE_STATE.CONNECTING then
            return default:GetIcon("Connecting", arg1.props.iconStyle)
        end

        if var7 == Constants.VOICE_STATE.INACTIVE then
            return default:GetIcon("Unmuted0", arg1.props.iconStyle)
        end

        if var7 ~= Constants.VOICE_STATE.TALKING then
            return default:GetIcon("Error", arg1.props.iconStyle)
        end

        local num1 = math.floor(var8 * 5 + 0.5) * 20
        return default:GetIcon("Unmuted" .. tostring(num1), arg1.props.iconStyle)
    end)
end

function var2.renderWithSelectionCursor(arg1, arg2)
    local bool1 = arg1.props.voiceState == Constants.VOICE_STATE.ERROR or arg1.props.voiceState == Constants.VOICE_STATE.HIDDEN
    if arg1.props.hideOnError and (not arg1.props.voiceState or bool1) then
        return nil
    end

    local num1 = if arg1.props.voiceState == Constants.VOICE_STATE.LOCAL_MUTED then 0.5 else 0

    local imageTransparency = if arg1.props.iconTransparency then if ReactIs.isBinding(arg1.props.iconTransparency) then arg1.props.iconTransparency:map(function(arg3): number
        return 1 - (1 - arg3) * (1 - num1)
    end) else 1 - (1 - arg1.props.iconTransparency) * (1 - num1) else num1

    return Roact.createElement("ImageButton", {
        Size = arg1.props.size or UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = arg1.levelIcon,
        ImageTransparency = imageTransparency,
        SelectionImageObject = arg2(CursorKind.RoundedRectNoInset),
        [Roact.Event.Activated] = arg1.props.onClicked
    })
end

function var2.render(arg1)
    return withSelectionCursorProvider(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var2.didUpdate(arg1, arg2, _)
    var1:trace("Voice state updated to {} for ...{}", arg1.props.voiceState, string.sub(tostring(arg1.props.userId), -4))
    if arg2.voiceState ~= arg1.props.voiceState then
        arg1.updateVoiceState(arg1.props.voiceState)
    end
end

function var2.willUnmount(arg1)
    pcall(function()
        RunService:UnbindFromRenderStep(arg1.renderStepName)
    end)
end

return RoactRodux.connect(function(arg1, arg2) -- name: mapStateToProps
    return {
        voiceState = arg1.voiceState[arg2.userId]
    }
end)(var2)
