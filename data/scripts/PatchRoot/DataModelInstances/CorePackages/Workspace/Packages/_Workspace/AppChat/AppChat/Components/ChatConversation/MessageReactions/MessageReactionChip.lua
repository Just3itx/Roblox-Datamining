-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local Reactions = require(AppChatParent.Reactions)

local useMessageReactionCounts = require(script.Parent.useMessageReactionCounts)

return React.memo(function(tbl1) -- name: MessageReactionChip
    local reactionCounts = useMessageReactionCounts(tbl1.messageId)

    if reactionCounts == nil then
        return nil
    end

    return React.createElement(
        Foundation.View,
        {
            tag = {
                ["col align-y-bottom size-full-600"] = true,
                ["align-x-left"] = tbl1.isIncoming,
                ["align-x-right"] = not tbl1.isIncoming
            },
            ZIndex = 2,
            LayoutOrder = tbl1.layoutOrder,
            testId = "MessageReactionChip"
        },
        {
            ReactionChip = React.createElement(Reactions.ReactionChip, { reactionCounts = reactionCounts })
        }
    )
end)
