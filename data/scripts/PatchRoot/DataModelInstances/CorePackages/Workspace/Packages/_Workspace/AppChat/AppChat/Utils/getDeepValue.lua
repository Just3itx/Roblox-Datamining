-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local FFlagAppChatGetDeepValuePreserveFalse = require(AppChat.Flags.FFlagAppChatGetDeepValuePreserveFalse)
local getDeepValue2 = require(script.Parent.getDeepValue2)

return if FFlagAppChatGetDeepValuePreserveFalse then getDeepValue2 else function(arg1, str1: string)
    for _, value in ipairs(str1:split(".")) do
        if not arg1[value] then
            return nil
        end

        arg1 = arg1[value]
    end

    return arg1
end
