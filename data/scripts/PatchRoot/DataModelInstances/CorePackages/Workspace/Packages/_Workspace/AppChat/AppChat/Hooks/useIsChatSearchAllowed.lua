-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local useAppPolicy = require(AppChat.Hooks.useAppPolicy)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)

return function()
    local var1 = useAppPolicy(function(arg1)
        return arg1.getChatHeaderSearch()
    end)
    local var2 = useIsChatEnabled()

    if not (var1 and var2) then
        var2 = false
    end

    return var2
end
