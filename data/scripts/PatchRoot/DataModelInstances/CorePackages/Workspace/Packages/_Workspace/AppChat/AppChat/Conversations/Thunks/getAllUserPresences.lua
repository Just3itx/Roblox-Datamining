-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
return if require(AppChat.Flags.FFlagAppChatPresenceStoreMigration) then nil else function()
    return function(arg1)
        local users = arg1:getState().Users
        local tbl1 = {}
        for k, _ in pairs(users) do
            if k ~= "-1" then
                table.insert(tbl1, k)
            end
        end

        arg1:dispatch(NetworkingPresence.GetPresencesFromUserIds.API(tbl1)):catch(function(arg2)
            warn("NetworkingPresence failure in getAllUserPresences, Status: " .. tostring(arg2))
        end)
    end
end
