-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local dismissed = require(AppChatParent.AppCommonLib).Signal.new()

return {
    dismissed = dismissed,
    dismiss = function()
        dismissed:fire()
    end
}
