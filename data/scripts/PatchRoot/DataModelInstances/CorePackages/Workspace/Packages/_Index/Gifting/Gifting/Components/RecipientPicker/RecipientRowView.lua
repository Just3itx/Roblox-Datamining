-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local AvatarSize = Foundation.Enums.AvatarSize

return React.memo(function(tbl1) -- name: RecipientRowView
    local userId = tonumber(tbl1.userId)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y padding-y-xsmall",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { HoverSurface = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        onActivated = if tbl1.isAvailable then tbl1.onActivated else nil,
        tag = "size-full-0 auto-y padding-x-small radius-medium"
    }
    local tbl5 = { Row = 0 }
    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        tag = "row align-y-center gap-large size-full-0 auto-y padding-y-small",
        testId = `recipient-row-{tbl1.userId}`
    }
    local tbl7 = {
        Avatar = if userId then React.createElement(
            Foundation.Avatar,
            {
                userId = userId,
                backgroundStyle = tbl1.avatarBackgroundStyle,
                size = AvatarSize.Large,
                LayoutOrder = 1
            }
        ) else nil,
        Names = React.createElement(Foundation.View, {
            tag = "col fill auto-y padding-y-xsmall",
            LayoutOrder = 2
        }, {
            DisplayName = React.createElement(Foundation.Text, {
                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis",
                Text = tbl1.displayName,
                LayoutOrder = 1
            }),
            Username = if tbl1.username == "" then nil else React.createElement(Foundation.Text, {
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
                Text = `@{tbl1.username}`,
                LayoutOrder = 2
            })
        }),
        Unavailable = if tbl1.isAvailable then nil else React.createElement(Foundation.Text, {
            tag = "auto-xy text-body-small content-default",
            Text = tbl1.unavailableLabel,
            testId = `recipient-row-unavailable-{tbl1.userId}`,
            LayoutOrder = 3
        })
    }
    tbl5.Row = createElement3(view3, tbl6, tbl7)
    tbl3.HoverSurface = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end)
