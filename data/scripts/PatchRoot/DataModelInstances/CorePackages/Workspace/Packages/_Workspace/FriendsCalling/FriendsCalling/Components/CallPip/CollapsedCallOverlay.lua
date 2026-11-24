-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)

local _CallParticipantCard = require(FriendsCalling.Components.CallParticipant.CallParticipantCard)
local ParticipantAvatar = require(FriendsCalling.Components.CallParticipant.ParticipantAvatar)

local AvatarSize = Foundation.Enums.AvatarSize
local IconName = Foundation.Enums.IconName
local IconButton = Foundation.IconButton
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local function CollapsedCallOverlay(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col align-x-center align-y-center gap-small size-full padding-medium stroke-standard stroke-default radius-large clip bg-surface-200"
    }

    local tbl3 = { Avatar = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl4 = {
        LayoutOrder = 1,
        ref = tbl1.onDragInputTarget,
        Size = UDim2.fromOffset(70, 70),
        testId = "friends-calling-pip-drag-target"
    }
    local tbl5 = { Content = 0 }
    local element

    if tbl1.participant.showStatusAnimation then
        element = React.createElement(FoundationText, {
            Text = tbl1.participant.statusText or "",
            tag = "auto-xy text-body-medium text-align-x-center content-default",
            testId = "friends-calling-pip-ringing"
        })
    elseif tbl1.participant.userId == 0 then
        element = nil
    else
        element = React.createElement(ParticipantAvatar, {
            avatarSize = AvatarSize.XLarge,
            isDimmed = tbl1.participant.isDimmed,
            isSpeaking = tbl1.participant.isSpeaking,
            ringSize = 70,
            userId = tbl1.participant.userId
        })
    end

    tbl5.Content = element
    tbl3.Avatar = createElement2(var2, tbl4, tbl5)
    local var3

    if tbl1.participant.showStatusAnimation then
        var3 = nil
    else
        local createElement3 = React.createElement
        local var4 = View
        local tbl6 = {
            LayoutOrder = 2,
            tag = "row align-x-center align-y-center gap-xsmall auto-xy padding-xsmall radius-circle bg-over-media-300"
        }

        local tbl7 = {
            Headphones = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.Headphones,
                isCircular = true,
                onActivated = tbl1.onToggleConversationAudio,
                size = InputSize.Medium,
                testId = "friends-calling-pip-headphones"
            }),
            Microphone = React.createElement(IconButton, {
                LayoutOrder = 2,
                icon = if tbl1.isMicrophoneMuted then IconName.MicrophoneSlash else IconName.Microphone,
                isCircular = true,
                onActivated = tbl1.onToggleMicrophone,
                size = InputSize.Medium,
                testId = "friends-calling-pip-microphone"
            })
        }
        var3 = createElement3(var4, tbl6, tbl7)
    end

    tbl3.Actions = var3
    return createElement(var1, tbl2, tbl3)
end

return CollapsedCallOverlay
