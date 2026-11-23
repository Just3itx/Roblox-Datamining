-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
local llama = require(AppChatParent.LuaSocialLibrariesDeps).llama
local UserModel = require(AppChatParent.UserLib).Models.UserModel
local AddUsers = require(AppChatParent.UserLib).Actions.AddUsers
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local function extractConversationsAndUsers(arg1, arg2)
    local tbl1 = {}
    local tbl2 = {}

    for _, value in arg1 do
        table.insert(tbl1, value.id)
        if value.participant_user_ids then
            for _, participantUserId in value.participant_user_ids do
                local str1 = tostring(participantUserId)
                if tbl2[str1] then
                    continue
                end

                local userData = value.user_data
                if not userData then
                    continue
                end

                local var1 = userData[str1]
                if not var1 then
                    continue
                end

                local var2 = arg2[str1]
                local dataTable = UserModel.fromDataTable({
                    id = var1.id,
                    name = var1.name,
                    displayName = if var2 then var2.displayName else var1.display_name,
                    isFriend = if var2 then var2.isFriend else false
                })

                tbl2[dataTable.id] = dataTable
            end
        else
            for _, participant in ipairs(value.participants) do
                if tbl2[tostring(participant.targetId)] then
                    continue
                end

                local var1 = arg2[tostring(participant.targetId)]
                    or UserModel.fromDataTable(
                        {
                            id = participant.targetId,
                            name = participant.name,
                            displayName = participant.displayName,
                            isFriend = false
                        }
                    )

                tbl2[var1.id] = var1
            end
        end
    end

    return tbl1, tbl2, (llama.Dictionary.keys(tbl2))
end

return function(arg1)
    return function(arg2)
        if not arg1 then
            return
        end
        local state = arg2:getState()
        local _, tbl1, var1 = extractConversationsAndUsers(arg1, state.Users or {})

        arg2:dispatch(AddUsers(tbl1))

        if not FFlagAppChatPresenceStoreMigration then
            arg2:dispatch(NetworkingPresence.GetPresencesFromUserIds.API(var1)):catch(function(arg3)
                warn("NetworkingPresence failure in processConversations, Status: " .. tostring(arg3))
            end)
        end
    end
end
