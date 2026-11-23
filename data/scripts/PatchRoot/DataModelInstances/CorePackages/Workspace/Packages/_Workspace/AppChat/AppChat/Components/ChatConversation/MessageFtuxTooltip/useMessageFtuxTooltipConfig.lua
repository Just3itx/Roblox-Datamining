-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local tbl1 = {}

tbl1[require(script.Parent.MessageFtuxTooltipVariant).Replies] = function() -- name: useRepliesTooltipConfig
    return {
        textKey = if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then "Feature.Chat.Label.SwipeToReplyTooltip" else "Feature.Chat.Label.HoverToReplyTooltip",
        storageKey = "AppChatEnableRepliesUIFtuxTooltip"
    }
end
return function(arg1)
    return tbl1[arg1]()
end
