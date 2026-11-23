-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local function ConversationRelativeTimestamp(tbl1)
    local hasUnreadMessages = tbl1.hasUnreadMessages

    return React.createElement(Foundation.View, { tag = "row auto-xy align-y-center gap-xsmall" }, {
        timestamp = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-body-small content-default",
                LayoutOrder = 1,
                Text = tbl1.timestampText
            }
        ),
        unreadDot = if hasUnreadMessages then React.createElement(Foundation.View, { tag = "size-200-200 radius-circle bg-action-emphasis", LayoutOrder = 2 }) else nil
    })
end

return ConversationRelativeTimestamp
