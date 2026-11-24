-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

return function()
    local getChatWindowWidth, setChatWindowWidth = createSignal(nil)

    return { getChatWindowWidth = getChatWindowWidth, setChatWindowWidth = setChatWindowWidth }
end
