-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent
local Constants = require(ChatLineReporting.Common.Constants)
local SharedFlags = require(ChatLineReportingParent.SharedFlags)
local FFlagEnableGlobalChatAbuseReporting = SharedFlags.FFlagEnableGlobalChatAbuseReporting
local FFlagAbuseReportAttributedRBXSystemMessages = SharedFlags.FFlagAbuseReportAttributedRBXSystemMessages

function isSystemMessage(tbl1): boolean
    return not (FFlagAbuseReportAttributedRBXSystemMessages
        or FFlagEnableGlobalChatAbuseReporting and not tbl1.textChannel
        or tbl1.textChannel.Name ~= Constants.ChannelTypes.System)
        or not tbl1.userId
        or tbl1.userId == "0"
        or false
end

return isSystemMessage
