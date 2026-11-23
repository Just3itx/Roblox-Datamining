-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text

local tbl1 = { layoutOrder = 2, userText = "", contentText = "" }

function ReplyComposeBarText(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    return React.createElement(View, {
        tag = "col fill auto-y align-x-left clip",
        LayoutOrder = var1.layoutOrder
    }, {
        UserReplyingTo = React.createElement(FoundationText, {
            tag = "text-caption-medium content-muted text-truncate-end text-align-x-left auto-xy",
            Text = var1.userText,
            LayoutOrder = 1
        }),
        ContentReplyingTo = React.createElement(FoundationText, {
            tag = "text-body-medium content-emphasis text-truncate-end text-align-x-left auto-xy",
            Text = var1.contentText,
            LayoutOrder = 2
        })
    })
end

return React.memo(ReplyComposeBarText)
