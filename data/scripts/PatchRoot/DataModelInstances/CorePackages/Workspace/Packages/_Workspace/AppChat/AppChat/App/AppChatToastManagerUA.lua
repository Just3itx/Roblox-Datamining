-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatToastEventReceiver = require(AppChat.Components.EventReceivers.AppChatToastEventReceiver)
local EnteredChatFromEntryPoint = require(AppChat.Actions.EnteredChatFromEntryPoint)
local NavigateIntoChat = require(AppChat.Conversations.Thunks.NavigateIntoChat)

local React = require(AppChatParent.React)
local RoactUtils = require(AppChatParent.RoactUtils)
local SocialCommon = require(AppChatParent.SocialCommon)

local OverlayHost = require(AppChat.Components.OSA.OverlayHost)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

function AppChatToastManagerUA()
    local var1 = useDispatch()

    local navigateToChat = React.useCallback(function(conversationId: string)
        var1(NavigateIntoChat({ conversationId = conversationId }, true))
        var1(EnteredChatFromEntryPoint(SocialCommon.Enums.ChatEntryPointNames.ToastUniversalApp))
    end, { var1 })

    return React.createElement(React.Fragment, nil, {
        ToastEventReceiver = React.createElement(AppChatToastEventReceiver, { navigateToChat = navigateToChat }),
        OverlayHost = React.createElement(OverlayHost)
    })
end

return AppChatToastManagerUA
