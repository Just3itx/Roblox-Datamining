-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)

local CallParticipantCard = require(FriendsCalling.Components.CallParticipant.CallParticipantCard)

local HeaderBar = Foundation.HeaderBar
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function useElapsedText(connectedAt: number?)
    local var1, var2 = React.useState(nil)
    React.useEffect(function()
        if connectedAt == nil then
            var2(nil)
            return
        end

        local bool1 = true
        local function tick()
            if not bool1 then
                return
            end
            local num1 = math.max(0, math.floor(os.clock() - connectedAt))
            var2(string.format("%02d:%02d", math.floor(num1 / 60), num1 % 60))
            task.delay(1, tick)
        end
        tick()
        return function()
            bool1 = false
        end
    end, { connectedAt })
    return var1
end

local function ExpandedCallOverlay(tbl1)
    local var1 = useTokens()
    local var2 = useElapsedText(tbl1.connectedAt)
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        padding = {
            top = UDim.new(0, tbl1.topPadding)
        },
        tag = {
            ["col size-full bg-surface-100"] = true,
            ["stroke-standard stroke-default radius-large clip"] = tbl1.hasRoundedCorners
        }
    }
    local tbl3 = { Header = 0, Body = 0, Actions = 0 }

    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = {
        LayoutOrder = 1,
        ref = tbl1.onDragInputTarget,
        tag = "size-full-0 auto-y",
        testId = "friends-calling-pip-drag-target"
    }

    local tbl5 = { Bar = 0 }

    local createElement3 = React.createElement
    local root = HeaderBar.Root
    local tbl6 = { hasBackground = false }

    local tbl7 = {
        Leading = React.createElement(HeaderBar.Leading, nil, {
            Actions = React.createElement(
                HeaderBar.Actions,
                {
                    actions = {{
                        id = "collapse",
                        icon = IconName.TwoArrowsToCenter,
                        onActivated = tbl1.onCollapse
                    }}
                }
            )
        }),
        Content = 0,
        Trailing = 0
    }

    local createElement4 = React.createElement
    local content = HeaderBar.Content
    local var5 = nil
    local tbl8 = {
        Titles = React.createElement(View, { tag = "col align-x-center auto-xy" }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.participant.name,
                tag = "auto-xy text-title-large content-emphasis",
                testId = "friends-calling-pip-title"
            }),
            Timer = if var2 == nil then nil else React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var2,
                    tag = "auto-xy text-body-medium content-default",
                    testId = "friends-calling-pip-timer"
                }
            )
        })
    }
    tbl7.Content = createElement4(content, var5, tbl8)

    tbl7.Trailing = React.createElement(HeaderBar.Trailing, nil, { Spacer = React.createElement(View, { tag = "size-1000-1000" }) })
    tbl5.Bar = createElement3(root, tbl6, tbl7)
    tbl3.Header = createElement2(var4, tbl4, tbl5)

    tbl3.Body = React.createElement(
        View,
        { LayoutOrder = 2, tag = "fill size-full-0 padding-x-xlarge padding-bottom-xxlarge" },
        {
            PlayerCard = React.createElement(CallParticipantCard, {
                userId = tbl1.participant.userId,
                name = tbl1.participant.name,
                statusText = tbl1.participant.statusText,
                isMuted = tbl1.participant.isMuted,
                isSpeaking = tbl1.participant.isSpeaking,
                isDimmed = tbl1.participant.isDimmed,
                showStatusAnimation = tbl1.participant.showStatusAnimation,
                testId = "friends-calling-pip-player-card"
            })
        }
    )
    local createElement5 = React.createElement
    local var6 = View
    local tbl9 = {
        LayoutOrder = 3,
        tag = "align-x-center size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge"
    }

    local tbl10 = { Pill = 0 }
    local createElement6 = React.createElement
    local var7 = View
    local tbl11 = {
        tag = "row align-y-center gap-medium auto-xy padding-medium radius-circle bg-over-media-0"
    }
    local tbl12 = {
        Message = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = IconName.SpeechBubbleAlignCenter,
            isCircular = true,
            onActivated = tbl1.onOpenChat,
            size = InputSize.Large,
            testId = "friends-calling-pip-message"
        }),
        Headphones = React.createElement(IconButton, {
            LayoutOrder = 2,
            icon = IconName.Headphones,
            isCircular = true,
            onActivated = tbl1.onToggleConversationAudio,
            size = InputSize.Large,
            testId = "friends-calling-pip-headphones"
        }),
        Microphone = React.createElement(IconButton, {
            LayoutOrder = 3,
            icon = if tbl1.isMicrophoneMuted then IconName.MicrophoneSlash else IconName.Microphone,
            isCircular = true,
            onActivated = tbl1.onToggleMicrophone,
            size = InputSize.Large,
            testId = "friends-calling-pip-microphone"
        }),
        EndCall = React.createElement(View, {
            LayoutOrder = 4,
            onActivated = tbl1.onEndCall,
            tag = "align-x-center align-y-center size-1200-1200 radius-circle bg-system-alert",
            testId = "friends-calling-pip-end-call"
        }, {
            Icon = React.createElement(Icon, { name = IconName.X, size = IconSize.Medium, style = var1.Color.Extended.White.White_100 })
        })
    }
    tbl10.Pill = createElement6(var7, tbl11, tbl12)
    tbl3.Actions = createElement5(var6, tbl9, tbl10)
    return createElement(var3, tbl2, tbl3)
end

return ExpandedCallOverlay
