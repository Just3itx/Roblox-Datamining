-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local _ConversationChannels = require(AppChat.Models.ConversationChannels)

return function(tbl1, str1: string)
    for value, value2 in tbl1 do
        if not value2 or value2.type ~= "one_to_one" or not value2.participants then
            continue
        end

        for _, participant in value2.participants do
            if participant == str1 then
                return value
            end
        end
    end

    return nil
end
