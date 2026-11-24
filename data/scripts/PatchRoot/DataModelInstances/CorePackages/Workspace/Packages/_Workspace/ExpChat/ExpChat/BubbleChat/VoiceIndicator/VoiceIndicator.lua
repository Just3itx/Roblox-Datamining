-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/" .. script.Name)

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local UIBlox = require(ExpChatParent.UIBlox)
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local BubbleChat = script:FindFirstAncestor("BubbleChat")
local getVoiceIndicatorIcon = require(BubbleChat.Helpers.getVoiceIndicatorIcon)

local Roact = require(ExpChatParent.Roact)
local RoactRodux = require(ExpChatParent.RoactRodux)

local GetFFlagExpChatUseVoiceParticipantsStore = require(ExpChatParent.SharedFlags).GetFFlagExpChatUseVoiceParticipantsStore

local var2 = Roact.PureComponent:extend("VoiceIndicator")

var2.defaultProps = {}

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

    arg1.levelIcon = Roact.joinBindings({ arg1.voiceState, arg1.level }):map(function(tbl1)
        local var7 = tbl1[1]
        local var8 = tbl1[2]

        return getVoiceIndicatorIcon(arg1.props.getIcon, var7, var8, arg1.props.iconStyle)
    end)

    function arg1.onClicked()
        if arg1.props.onClicked and arg1.props.userId then
            arg1.props.onClicked(arg1.props.userId)
        end
    end
end

function var2.renderWithSelectionCursor(arg1, arg2)
    local bool1 = arg1.props.voiceState == "Error" or arg1.props.voiceState == "Hidden"
    if arg1.props.hideOnError and (not arg1.props.voiceState or bool1) then
        return nil
    end

    local num1 = if arg1.props.voiceState == "LOCAL_MUTED" then 0.5 else 0

    local var3 = if arg1.props.iconTransparency then if type(arg1.props.iconTransparency) ~= "number" then arg1.props.iconTransparency:map(function(arg3): number
        return 1 - (1 - arg3) * (1 - num1)
    end) else 1 - (1 - arg1.props.iconTransparency) * (1 - num1) else num1

    return Roact.createElement("ImageButton", {
        Size = arg1.props.size or UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = arg1.levelIcon,
        ImageTransparency = var3,
        SelectionImageObject = arg2(CursorKind.RoundedRectNoInset),
        [Roact.Event.Activated] = arg1.onClicked
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

local function mapStateToProps(arg1, arg2)
    return {
        voiceState = arg1.Voice.participants[arg2.userId]
    }
end

if GetFFlagExpChatUseVoiceParticipantsStore() then
    return var2
end
return RoactRodux.connect(mapStateToProps)(var2)
