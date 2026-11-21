-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local ExpChatShared = require(ChatLineReportingParent.ExpChatShared)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local getPresetIconRichText = ExpChatShared.getPresetIconRichText
local isPresetMessage = ExpChatShared.isPresetMessage

local getMessageText = require(ChatLineReporting.Common.getMessageText)
local React = require(ChatLineReportingParent.React)
local Foundation = require(ChatLineReportingParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Constants = require(ChatLineReporting.Common.Constants)
local ChatLineReportEyebrow = require(ChatLineReporting.Components.ChatLineReportEyebrow)

local function ChatLineReportSelectableLine(tbl1)
    local var1, var2 = React.useState(nil)
    local messageText = getMessageText(tbl1.message.useTranslation, tbl1.message.translation, tbl1.message.text)
    local prefixText = tbl1.message.prefixText or ""
    local var3 = var1 or prefixText
    local userId = tbl1.message.userId

    if userId and userId.data then
        local names = userId.data.userProfiles[1].names
        var2((string.gsub(var3, names.displayName, names.combinedName)))
    end

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        Size = UDim2.new(0, tbl1.scrollViewSizeX - Constants.SelectableLineScrollbarOffset, 1, 0),
        LayoutOrder = 2,
        tag = "col"
    }

    local tbl3 = {
        eyebrow = React.createElement(ChatLineReportEyebrow, { message = tbl1.message, localizedText = tbl1.localizedText }),
        chatText = React.createElement(FoundationText, {
            Text = if FFlagExpChatPresetChatEnabled and isPresetMessage(tbl1.message) then `{var3} {messageText} {getPresetIconRichText(18)}` else `{var3} {messageText}`,
            RichText = true,
            tag = "auto-xy text-wrap text-align-x-left",
            LayoutOrder = 2
        })
    }
    return createElement(var4, tbl2, tbl3)
end

return ChatLineReportSelectableLine
