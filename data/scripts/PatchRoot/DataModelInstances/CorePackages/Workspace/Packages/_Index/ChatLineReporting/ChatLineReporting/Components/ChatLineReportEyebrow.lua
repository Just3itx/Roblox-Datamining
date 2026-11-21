-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local Constants = require(ChatLineReporting.Common.Constants)
local React = require(ChatLineReportingParent.React)
local Foundation = require(ChatLineReportingParent.Foundation)
local View = Foundation.View
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize
local FFlagEnableGlobalChatAbuseReporting = require(ChatLineReportingParent.SharedFlags).FFlagEnableGlobalChatAbuseReporting

local function getEyebrowText(name: string, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if string.match(name, Constants.ChannelTypes.Whisper) then tbl1.localizedText.ChatEyebrowSentPrivately else tbl1.localizedText.ChatEyebrowSentInAnotherChat
end

local function ChatLineReportEyebrow(tbl1)
    if FFlagEnableGlobalChatAbuseReporting and not tbl1.message.textChannel
        or tbl1.message.textChannel.Name == Constants.ChannelTypes.General
    then
        return nil
    end

    return (React.createElement(
        View,
        {
            tag = "auto-xy bg-shift-200 padding-left-xsmall padding-right-xsmall radius-small",
            LayoutOrder = 1
        },
        {
            eyebrowLabel = React.createElement(
                InputLabel,
                {
                    Text = getEyebrowText(tbl1.message.textChannel.Name, tbl1),
                    RichText = true,
                    size = InputLabelSize.Small
                }
            )
        }
    ))
end

return ChatLineReportEyebrow
