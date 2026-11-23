-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local chatTypes = require(BuildExperience.Chat.chatTypes)

local function getMessageKey(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1.kind == "assistant_turn" then
        local assistantTurnAnchorKey = chatTypes.makeAssistantTurnAnchorKey(arg1.sessionId, arg1.endSequenceId)
        if assistantTurnAnchorKey ~= nil then
            return assistantTurnAnchorKey
        end
        if arg1.turnKey ~= nil then
            return `turn:{arg1.turnKey}`
        end
    end
    if arg1.id ~= nil then
        return `message:{arg1.id}`
    end
    return nil
end

return {
    getMessageKey = getMessageKey,
    getMessageIndexByKey = function(tbl1)
        local messageIndexByKey = ({})
        for value, value2 in tbl1 do
            local messageKey = getMessageKey(value2)

            if messageKey ~= nil then
                messageIndexByKey[messageKey] = value
            end
        end
        return messageIndexByKey
    end,
    getLastMessageKey = function(tbl1)
        for i = #tbl1, 1, -1 do
            local var1 = tbl1[i]
            local bool1 = if var1.kind == "assistant_turn" then not var1.isDone or var1.isOptimisticallyCancelled == true else not (var1.id == nil)
                and string.sub(var1.id, -#chatTypes.PENDING_USER_MESSAGE_ID_SUFFIX) == chatTypes.PENDING_USER_MESSAGE_ID_SUFFIX
            local messageKey = if bool1 then nil else getMessageKey(var1)

            if messageKey ~= nil then
                return messageKey
            end
        end
        return nil
    end
}
