-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local Constants = require(ChatLineReporting.Common.Constants)
local getMessageText = require(ChatLineReporting.Common.getMessageText)
local React = require(ChatLineReportingParent.React)
local Foundation = require(ChatLineReportingParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local function ChatLineReportVerbatim(tbl1)
    local var1, var2 = React.useState(nil)
    local messageText = getMessageText(tbl1.selectedMessage.useTranslation, tbl1.selectedMessage.translation, tbl1.selectedMessage.text)

    local prefixText = tbl1.selectedMessage.prefixText or ""
    local var3 = var1 or prefixText
    local userId = tbl1.selectedMessage.userId
    if userId and userId.data then
        local names = userId.data.userProfiles[1].names
        var2((string.gsub(var3, names.displayName, names.combinedName)))
    end

    return React.createElement(View, {
        Size = UDim2.new(1, 0, 0, Constants.SelectableChatLineHeight),
        tag = "radius-medium padding-left-medium padding-right-medium stroke-neutral stroke-standard"
    }, {
        messageFrame = React.createElement(View, {
            tag = "auto-xy position-center-left anchor-center-left"
        }, {
            messageText = React.createElement(FoundationText, {
                Text = `{var3} {messageText}`,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextScaled = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = true,
                tag = "auto-xy content-muted"
            })
        })
    })
end

return ChatLineReportVerbatim
