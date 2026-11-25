-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Message = require(script.Parent.Message)

return {
    mapTextChatMessage = function(arg1, str1: string)
        if arg1.TextSource then
            return Message.createUserMessageFromTextChatMessage(arg1, str1)
        end
        return Message.createSystemMessageFromTextChatMessage(arg1)
    end,
    mapSendingMessage = function(arg1, str1: string)
        return Message.createUserMessageFromTextChatMessage(arg1, str1)
    end,
    applyMessage = function(tbl1, arg1)
        for value, value2 in tbl1 do
            if value2.messageId ~= arg1.messageId then
                continue
            end

            local var1 = table.clone(tbl1)
            if arg1.content == "" then
                table.remove(var1, value)
                return var1
            end
            var1[value] = arg1

            return var1
        end

        if arg1.content == "" then
            return tbl1
        end

        local var1 = table.clone(tbl1)
        table.insert(var1, arg1)
        return var1
    end
}
