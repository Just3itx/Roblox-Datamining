-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local _Players = game:GetService("Players")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Cryo = require(CorePackages.Packages.Cryo)

local Constants = require(script.Parent.Parent.Constants)
local var1 = require(script.Parent.Parent.Logger)(script.Name)

local BubbleChatBillboard = require(script.Parent.BubbleChatBillboard)

local GetFFlagBubbleVoiceIndicatorSetting = require(RobloxGui.Modules.Flags.GetFFlagBubbleVoiceIndicatorSetting)

local var2 = Roact.Component:extend("ChatBillboards")

var2.validateProps = t.strictInterface({
    userMessages = t.map(t.string, t.array(t.string)),
    bubbleChatEnabled = t.boolean,
    voiceEnabled = t.boolean,
    participants = t.map(t.string, t.string)
})

function var2.getDerivedStateFromProps(arg1, arg2)
    return {
        userMessages = Cryo.Dictionary.join(arg2.userMessages or {}, arg1.userMessages)
    }
end

function var2.init(arg1)
    var1:debug("Initializing")
    arg1:setState({ userMessages = {} })

    function arg1.onBillboardFadeOut(arg2)
        arg1:setState({ userMessages = Cryo.Dictionary.join(arg1.state.userMessages, { [arg2] = Cryo.None }) })
    end
end

function var2.render(arg1)
    if not arg1.props.voiceEnabled and not arg1.props.bubbleChatEnabled then
        return
    end

    local tbl1 = ({})
    for k, _ in pairs(arg1.state.userMessages) do
        tbl1[k] = false
    end
    for k, participant in pairs(arg1.props.participants) do
        if participant ~= Constants.VOICE_STATE.HIDDEN then
            tbl1[k] = true
        end
    end

    local tbl2 = ({})
    for userId, value in pairs(tbl1) do
        var1:trace("Rendering billboard for ...{}", string.sub(tostring(userId), -4))
        local var3 = "BubbleChat_" .. userId
        tbl2[var3] = Roact.createElement(BubbleChatBillboard, {
            userId = userId,
            onFadeOut = arg1.onBillboardFadeOut,
            voiceEnabled = arg1.props.voiceEnabled and value,
            bubbleChatEnabled = arg1.props.bubbleChatEnabled
        })
    end

    return Roact.createElement("ScreenGui", { ResetOnSpawn = false }, tbl2)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    local voiceEnabled = arg1.components.voiceEnabled
    if GetFFlagBubbleVoiceIndicatorSetting() then
        voiceEnabled = arg1.components.voiceEnabled and arg1.chatSettings.Voice.ShowIndicator
    end

    return {
        userMessages = arg1.userMessages,
        voiceEnabled = voiceEnabled,
        bubbleChatEnabled = arg1.components.bubbleChatEnabled,
        participants = arg1.voiceState
    }
end)(var2)
