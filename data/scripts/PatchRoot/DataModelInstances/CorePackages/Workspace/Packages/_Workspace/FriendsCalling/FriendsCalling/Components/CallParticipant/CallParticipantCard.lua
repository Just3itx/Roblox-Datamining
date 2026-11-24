-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)

local ParticipantAvatar = require(script.Parent.ParticipantAvatar)
local RingingIndicator = require(script.Parent.RingingIndicator)

local AvatarSize = Foundation.Enums.AvatarSize
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function useAbsoluteSize()
    local var1 = React.useRef(nil)
    local var2, var3 = React.useState(Vector2.zero)

    React.useEffect(function()
        local current = var1.current
        if current == nil then
            return
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var3(current.AbsoluteSize)
        end

        update()
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
        return function()
            connection:Disconnect()
        end
    end, {})

    return var1, var2
end

local function CallParticipantCard(arg1)
    local var1 = useTokens()
    local ref, var3 = useAbsoluteSize()
    local var2, var5 = useAbsoluteSize()
    local size2600 = var1.Size.Size_2600
    local medium = var1.Padding.Medium

    local uDim2 = UDim2.fromScale(0.5, 0.5)
    local var6

    if var3.X > 0 and var3.Y > 0 then
        local var7 = var3.Y - var5.Y
        local num1 = math.min(size2600, var3.X - 2 * medium, var7 - medium)
        var6 = math.max(num1, 0) / size2600
        uDim2 = UDim2.new(0.5, 0, 0, math.min(var3.Y / 2, var7 - num1 / 2))
    else
        var6 = 1
    end

    local createElement = React.createElement
    local var7 = View
    local tbl1 = {
        ref = ref,
        tag = "size-full stroke-standard stroke-default radius-large clip bg-surface-200",
        testId = arg1.testId
    }
    local tbl2 = {
        Avatar = React.createElement(
            View,
            {
                Position = uDim2,
                Size = UDim2.fromOffset(size2600, size2600),
                scale = var6,
                tag = "anchor-center-center"
            },
            {
                Avatar = React.createElement(ParticipantAvatar, {
                    avatarSize = AvatarSize.Pictogram,
                    isDimmed = arg1.isDimmed,
                    isSpeaking = arg1.isSpeaking,
                    ringSize = size2600,
                    userId = arg1.userId
                })
            }
        ),
        Footer = 0
    }

    local createElement2 = React.createElement
    local var8 = View
    local tbl3 = {
        ref = var2,
        tag = "col gap-xsmall position-bottom-left anchor-bottom-left size-full-0 auto-y padding-medium"
    }
    local tbl4 = {
        NameRow = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            Muted = if arg1.isMuted then React.createElement(Icon, {
                LayoutOrder = 1,
                name = IconName.MicrophoneSlash,
                size = IconSize.Small,
                testId = "friends-calling-participant-muted"
            }) else nil,
            Name = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = arg1.name,
                tag = "shrink auto-xy text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis",
                testId = "friends-calling-participant-name"
            })
        }),
        StatusRow = 0
    }
    local element

    if arg1.statusText == nil then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            Status = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.statusText,
                tag = "shrink auto-xy text-body-medium text-no-wrap text-align-x-left text-truncate-end content-default",
                testId = "friends-calling-participant-status"
            }),
            Animation = if arg1.showStatusAnimation then React.createElement(RingingIndicator, { LayoutOrder = 2, testId = "friends-calling-participant-activity" }) else nil
        })
    end

    tbl4.StatusRow = element
    tbl2.Footer = createElement2(var8, tbl3, tbl4)
    return createElement(var7, tbl1, tbl2)
end

return CallParticipantCard
