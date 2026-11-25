-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)

local ConversationUtils = require(ShareSheet.Utils.ConversationUtils)
local _GetConversationListStore = require(ShareSheetParent.AppChat.GetConversationListStore)
local _RecipientKind = require(script.Parent.RecipientKind)
local useExternalChatConversationEligibility = require(ShareSheetParent.AppChat.useExternalChatConversationEligibility)

return {
    create = function(conversation)
        return {
            kind = "conversation",
            id = conversation.id,
            conversation = conversation
        }
    end,
    kind = {
        useEligibility = function(arg1)
            local conversations = React.useMemo(function()
                local var1 = table.create(#arg1.recipients)
                for k, recipient in arg1.recipients do
                    var1[k] = recipient.conversation
                end
                return var1
            end, { arg1.recipients })

            local var2 = useExternalChatConversationEligibility({
                conversations = conversations,
                isActive = arg1.isActive,
                isGroupChatEnabled = arg1.isGroupChatEnabled,
                maxConversationCount = arg1.maxCount
            })

            return React.useMemo(function()
                local tbl1 = ({})
                for _, eligibleConversation in var2.eligibleConversations do
                    tbl1[eligibleConversation] = true
                end
                return {
                    isLoading = var2.isLoading,
                    isEligible = function(arg2): boolean
                        return tbl1[arg2.conversation] == true
                    end
                }
            end, { var2 })
        end,
        canSend = function(arg1, arg2)
            return arg1.canSendToConversation(arg2.conversation)
        end,
        send = function(arg1, arg2, arg3)
            return arg1.sendToConversation(arg2.conversation, arg3)
        end,
        getName = function(arg1)
            return ConversationUtils.getDisplayName(arg1.conversation)
        end,
        getParticipantIds = function(arg1, arg2)
            local participantIds = {}

            for _, value in arg1.conversation.participants or {} do
                if value ~= arg2 then
                    table.insert(participantIds, value)
                end
            end
            return participantIds
        end
    }
}
