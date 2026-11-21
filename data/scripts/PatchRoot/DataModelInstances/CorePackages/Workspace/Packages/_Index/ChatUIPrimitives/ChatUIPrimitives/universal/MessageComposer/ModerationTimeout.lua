-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Countdown = require(script.Parent.Countdown)

local function ModerationTimeout(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local untilTimestamp = tbl1.state.untilTimestamp

    if tbl1.state.status == "loading" then
        return React.createElement(
            Foundation.View,
            {
                tag = "row align-x-center align-y-center size-full",
                GroupTransparency = tbl1.transparency,
                testId = "moderationTimeoutLoading"
            },
            {
                Spinner = React.createElement(Foundation.Loading, { size = Foundation.Enums.IconSize.Medium })
            }
        )
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "row align-y-center gap-small size-full padding-left-large padding-right-medium",
        GroupTransparency = tbl1.transparency,
        testId = "moderationTimeout"
    }
    local tbl3 = {
        Copy = React.createElement(Foundation.Text, {
            tag = "fill auto-y text-body-medium text-no-wrap text-align-x-left text-truncate-end content-system-alert",
            Text = tbl1.state.text or "",
            LayoutOrder = 1
        }),
        Trailing = React.createElement(Foundation.View, {
            tag = "row align-y-center gap-small auto-xy",
            LayoutOrder = 2
        }, {
            Countdown = if untilTimestamp == nil then nil else React.createElement(Countdown, { untilTimestamp = untilTimestamp, LayoutOrder = 1 }),
            AlertIcon = React.createElement(Foundation.Icon, {
                name = Foundation.Enums.IconName.TriangleExclamation,
                size = Foundation.Enums.IconSize.Medium,
                style = var1.Color.System.Alert,
                LayoutOrder = 2
            })
        })
    }
    return createElement(view, tbl2, tbl3)
end

return ModerationTimeout
