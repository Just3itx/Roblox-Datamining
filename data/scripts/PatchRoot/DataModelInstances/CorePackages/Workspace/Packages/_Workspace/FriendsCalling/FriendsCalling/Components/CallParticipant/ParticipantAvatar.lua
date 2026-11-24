-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)

local Avatar = Foundation.Avatar
local _AvatarSize = Foundation.Enums.AvatarSize
local View = Foundation.View

local function ParticipantAvatar(tbl1)
    return React.createElement(
        View,
        {
            Size = UDim2.fromOffset(tbl1.ringSize, tbl1.ringSize),
            tag = "position-center-center anchor-center-center"
        },
        {
            SpeakingRing = if tbl1.isSpeaking then React.createElement(View, {
                Size = UDim2.fromOffset(tbl1.ringSize, tbl1.ringSize),
                tag = "position-center-center anchor-center-center stroke-thick stroke-system-success radius-circle",
                testId = "friends-calling-participant-speaking"
            }) else nil,
            Avatar = React.createElement(
                View,
                {
                    GroupTransparency = if tbl1.isDimmed then 0.7 else nil,
                    tag = "position-center-center anchor-center-center auto-xy",
                    testId = "friends-calling-participant-avatar"
                },
                {
                    Headshot = React.createElement(Avatar, { size = tbl1.avatarSize, userId = tbl1.userId })
                }
            )
        }
    )
end
return ParticipantAvatar
