-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _useProfileNames = require(AppChat.Hooks.useProfileNames)

return function(arg1, arg2)
    if arg1 == nil or arg2 == nil then
        return nil
    end
    local var1 = arg1.namesByUserId[tostring(arg2)]
    return if var1 then var1.combinedName else nil
end
