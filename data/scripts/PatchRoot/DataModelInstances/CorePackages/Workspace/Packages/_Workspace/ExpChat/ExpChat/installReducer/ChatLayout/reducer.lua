-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
return require(ExpChatParent.Rodux).combineReducers({
    Alignment = require(script.Parent.alignment),
    ChatWindowSettings = require(script.Parent.windowSettings),
    ChatInputBarSettings = require(script.Parent.inputBarSettings),
    ChannelTabsSettings = require(script.Parent.channelTabsSettings)
})
