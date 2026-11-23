-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signals = require(AppChatParent.Signals)

local createShareLinkV2Store = require(script.createShareLinkV2Store)

return Signals.createComputed(function(_)
    return createShareLinkV2Store()
end)
