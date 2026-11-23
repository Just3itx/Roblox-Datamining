-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signals = require(AppChatParent.Signals)

local createEmojiSetsStore = require(script.createEmojiSetsStore)

return Signals.createComputed(function(_)
    return createEmojiSetsStore()
end)
