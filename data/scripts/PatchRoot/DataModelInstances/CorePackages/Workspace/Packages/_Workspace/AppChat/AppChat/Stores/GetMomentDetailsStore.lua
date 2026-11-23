-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signals = require(AppChatParent.Signals)

local createMomentDetailsStore = require(script.createMomentDetailsStore)

return Signals.createComputed(function(_)
    return createMomentDetailsStore()
end)
