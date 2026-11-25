-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)

local ConversationRecipient = require(script.Parent.Kinds.ConversationRecipient)
local _GetExternalChatMessageSenderStore = require(ShareSheetParent.AppChat.GetExternalChatMessageSenderStore)
local _LuauPolyfill = require(ShareSheetParent.LuauPolyfill)
local _RecipientKind = require(script.Parent.Kinds.RecipientKind)
local _Signals = require(ShareSheetParent.Signals)
local UserRecipient = require(script.Parent.Kinds.UserRecipient)

local var1 = table.freeze({ conversation = ConversationRecipient.kind, user = UserRecipient.kind })

local var2 = table.freeze({})

local function getKind(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return var1[arg1.kind]
end

return {
    canSend = function(arg1, arg2)
        return getKind(arg2).canSend(arg1, arg2)
    end,
    fromConversation = ConversationRecipient.create,
    fromUserId = UserRecipient.create,
    getName = function(arg1, arg2)
        return getKind(arg1).getName(arg1, arg2)
    end,
    getParticipantIds = function(arg1, str1: string)
        return getKind(arg1).getParticipantIds(arg1, str1)
    end,
    send = function(arg1, arg2, str1: string)
        return getKind(arg2).send(arg1, arg2, str1)
    end,
    useEligibleRecipients = function(arg1)
        local var3 = React.useMemo(function()
            local result = {}
            for _, recipient in arg1.recipients do
                local var3 = result[recipient.kind] or {}
                table.insert(var3, recipient)
                result[recipient.kind] = var3
            end
            return result
        end, { arg1.recipients })

        local function getKindProps(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
            return {
                recipients = var3[str1] or var2,
                isActive = arg1.isActive,
                isGroupChatEnabled = arg1.isGroupChatEnabled,
                maxCount = arg1.maxCount
            }
        end

        local conversation = var1.conversation.useEligibility((getKindProps("conversation")))
        local user = var1.user.useEligibility((getKindProps("user")))

        return React.useMemo(function() -- name: getEligibleRecipients
            local tbl1 = { conversation = conversation, user = user }

            local bool1 = not arg1.isActive
            for value, value2 in tbl1 do
                if var3[value] and value2.isLoading then
                    bool1 = true
                end
            end

            if bool1 then
                return {
                    recipients = {},
                    isLoading = true
                }
            end
            local recipients = {}
            for _, recipient in arg1.recipients do
                if not tbl1[recipient.kind].isEligible(recipient) then
                    continue
                end

                table.insert(recipients, recipient)
                if #recipients >= arg1.maxCount then
                    break
                end
            end

            return { recipients = recipients, isLoading = false }
        end, {
            conversation,
            arg1.isActive,
            arg1.maxCount,
            arg1.recipients,
            var3,
            user
        })
    end
}
