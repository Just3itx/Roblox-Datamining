-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Rodux = require(AppChatParent.Rodux)
local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

return Rodux.makeActionCreator(script.Name, function(modalSequence)
    return { modalSequence = modalSequence }
end)
