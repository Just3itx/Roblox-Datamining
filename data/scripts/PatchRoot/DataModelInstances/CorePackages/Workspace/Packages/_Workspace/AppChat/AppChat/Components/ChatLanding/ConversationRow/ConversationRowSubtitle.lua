-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local function isNonEmpty(arg1)
    if typeof(arg1) == "string" then
        return arg1 ~= ""
    end
    return arg1:map(function(str1: string): boolean
        return str1 ~= ""
    end)
end

return React.memo(function(tbl1) -- name: ConversationRowSubtitle
    local var1 = React.useMemo(function()
        return isNonEmpty(tbl1.subtitleText)
    end, { tbl1.subtitleText })
    local var2 = React.useMemo(function()
        return isNonEmpty(tbl1.timestampText)
    end, { tbl1.timestampText })

    return React.createElement(
        Foundation.View,
        {
            tag = "row align-y-center gap-xsmall size-full-0 auto-y padding-right-medium clip",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            subtitle = React.createElement(Foundation.Text, {
                tag = "shrink auto-xy text-body-small text-align-x-left text-truncate-split content-default",
                Text = tbl1.subtitleText,
                Visible = var1,
                LayoutOrder = 1
            }),
            inlineTimestamp = React.createElement(Foundation.View, {
                tag = "row align-y-center gap-xsmall auto-xy",
                Visible = var2,
                LayoutOrder = 2,
                testId = "conversation-row-inline-timestamp"
            }, {
                separator = React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-body-small content-default",
                        Text = "·",
                        Visible = var1,
                        LayoutOrder = 1
                    }
                ),
                timestamp = React.createElement(Foundation.Text, {
                    tag = "auto-xy text-body-small content-default",
                    Text = tbl1.timestampText,
                    LayoutOrder = 2,
                    testId = "conversation-row-timestamp"
                })
            })
        }
    )
end)
