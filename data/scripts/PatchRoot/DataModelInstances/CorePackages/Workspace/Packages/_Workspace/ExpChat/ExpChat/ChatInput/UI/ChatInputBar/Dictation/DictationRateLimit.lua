-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local createDictationRateLimit = require(script.Parent.createDictationRateLimit)
local GetDictationStateStore = require(ExpChat.Stores.GetDictationStateStore)

return createDictationRateLimit({
    getIsListening = function()
        return GetDictationStateStore(false).getIsListening(false)
    end
})
