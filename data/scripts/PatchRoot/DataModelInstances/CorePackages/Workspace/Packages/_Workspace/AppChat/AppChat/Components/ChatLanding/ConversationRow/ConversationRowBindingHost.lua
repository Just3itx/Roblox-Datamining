-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local _Signals = require(AppChatParent.Signals)

local ConversationRowView = require(script.Parent.ConversationRowView)
local useConversationRowBindingPresentation = require(script.Parent.useConversationRowBindingPresentation)

return React.memo(function(tbl1) -- name: ConversationRowBindingHost
    local var1 = useConversationRowBindingPresentation({ itemSignal = tbl1.itemSignal })

    if not var1.hasConversation then
        return nil
    end

    return React.createElement(ConversationRowView, {
        itemSignal = tbl1.itemSignal,
        entryHeight = var1.entryHeight,
        pagePaddingLeft = var1.pagePaddingLeft,
        pagePaddingRight = var1.pagePaddingRight,
        testId = var1.testId,
        locatorTitle = var1.locatorTitle,
        title = var1.title,
        subtitleText = var1.subtitleText,
        timestampText = var1.timestampText,
        showSubscriptionBadge = var1.showSubscriptionBadge,
        showUnread = var1.showUnread,
        showSquadButton = var1.showSquadButton,
        showTimestamp = var1.showTimestamp,
        squadLocation = var1.squadLocation,
        rowRef = var1.rowRef,
        onRowActivated = var1.onRowActivated,
        onSquadActivated = var1.onSquadActivated,
        showBackground = var1.showBackground,
        debugCellValue = var1.debugCellValue
    })
end)
