-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Avatar = Foundation.Avatar
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local AvatarSize = Foundation.Enums.AvatarSize
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local useTokens = Foundation.Hooks.useTokens

local function renderDetail(text: string, name: string, style, testId: string, layoutOrder: number)
    return React.createElement(
        View,
        {
            tag = "row align-y-center gap-xsmall auto-xy",
            testId = testId,
            LayoutOrder = layoutOrder
        },
        {
            Icon = React.createElement(Icon, {
                name = name,
                variant = IconVariant.Filled,
                size = IconSize.XSmall,
                style = style,
                testId = `{testId}-icon`,
                LayoutOrder = 1
            }),
            Label = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium content-default text-no-wrap",
                    Text = text,
                    LayoutOrder = 2
                }
            )
        }
    )
end
return React.memo(function(tbl1) -- name: UserInfoPanelView
    local var1 = useTokens()
    local userId = tonumber(tbl1.userId)
    local bool1 = tbl1.friendDurationText ~= nil or tbl1.mutualFriendsText ~= nil or tbl1.joinedText ~= nil

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "col align-x-center gap-large size-full-0 auto-y padding-large radius-large bg-shift-100",
        testId = "UserInfoPanelView",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Identity = 0, Details = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = { tag = "col align-x-center gap-small size-full-0 auto-y", LayoutOrder = 1 }

    local tbl5 = {
        Avatar = if userId then React.createElement(
            Avatar,
            {
                userId = userId,
                size = AvatarSize.Large,
                backgroundStyle = var1.Color.Shift.Shift_300,
                LayoutOrder = 1
            }
        ) else nil,
        Names = React.createElement(View, {
            tag = "col align-x-center size-full-0 auto-y",
            LayoutOrder = 2
        }, {
            DisplayName = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-title-medium text-align-x-center content-emphasis",
                Text = tbl1.displayName,
                testId = "user-info-panel-display-name",
                LayoutOrder = 1
            }),
            Username = if tbl1.username then React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-body-small text-align-x-center content-default",
                Text = `@{tbl1.username}`,
                testId = "user-info-panel-username",
                LayoutOrder = 2
            }) else nil
        })
    }
    tbl3.Identity = createElement2(var4, tbl4, tbl5)
    local element

    if bool1 then
        element = React.createElement(View, {
            tag = "row wrap align-x-center align-y-center gap-medium size-full-0 auto-y",
            testId = "user-info-panel-details",
            LayoutOrder = 2
        }, {
            FriendDuration = if tbl1.friendDurationText then renderDetail(
                tbl1.friendDurationText,
                IconName.Calendar,
                var1.Color.Content.Default,
                "user-info-panel-friend-duration",
                1
            ) else nil,
            MutualFriends = if tbl1.mutualFriendsText then renderDetail(
                tbl1.mutualFriendsText,
                IconName.TwoPeople,
                var1.Color.Content.Default,
                "user-info-panel-mutual-friends",
                2
            ) else nil,
            Joined = if tbl1.joinedText then renderDetail(tbl1.joinedText, IconName.CircleI, var1.Color.Content.Default, "user-info-panel-joined", 3) else nil
        })
    else
        element = nil
    end

    tbl3.Details = element
    return createElement(var3, tbl2, tbl3)
end)
