-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local FFlagVoiceChatBanDurationUseServerTime = require(script.Parent.Parent.Parent.VoiceChat.Flags.FFlagVoiceChatBanDurationUseServerTime)
local InGameMenuPolicy = require(script.Parent.Parent.Parent.InGameMenu.InGameMenuPolicy)

local VoiceChatPromptFrame = require(script.Parent.VoiceChatPromptFrame)

local var1 = Roact.PureComponent:extend("VoiceChatPrompt")

var1.validateProps = t.strictInterface({
    promptSignal = t.optional(t.RBXScriptSignal),
    errorText = t.optional(t.string),
    bannedUntil = t.optional(
        if FFlagVoiceChatBanDurationUseServerTime then t.interface({ minutes = t.number, absoluteSeconds = t.number }) else t.string
    ),
    onContinueFunc = t.optional(t.callback),
    onPrimaryActivated = t.optional(t.callback),
    onSecondaryActivated = t.optional(t.callback),
    onReadyForSignal = t.optional(t.callback),
    Analytics = t.optional(t.table),
    VoiceChatServiceManager = t.optional(t.table),
    policyMapper = t.optional(t.callback),
    settingsAppAvailable = t.optional(t.boolean)
})

function var1.render(arg1)
    return Roact.createElement("ScreenGui", {
        AutoLocalize = false,
        DisplayOrder = 9,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        PolicyProvider = Roact.createElement(
            InGameMenuPolicy.Provider,
            {
                policy = { arg1.props.policyMapper or InGameMenuPolicy.Mapper }
            },
            {
                Content = Roact.createElement(VoiceChatPromptFrame, arg1.props)
            }
        )
    })
end

return var1
