-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local llama = require(AppChatParent.LuaSocialLibrariesDeps).llama
local RoduxPresence = require(AppChat.Http.RoduxPresence)

if require(AppChat.Flags.FFlagAppChatPresenceStoreMigration) then
    return nil
end

local tbl1 = {
    "OFFLINE",
    "ONLINE",
    "IN_GAME",
    "IN_STUDIO"
}

local function convertFromOldPresenceModel(arg1)
    local presence = RoduxPresence.Models.Presence.new(
        llama.Dictionary.join(arg1, {
            presence = llama.None,
            userPresenceType = (table.find(tbl1, arg1.presence) or 1) - 1,
            gameInstanceId = llama.None,
            gameId = arg1.gameInstanceId,
            lastOnline = DateTime.now() and DateTime.fromUnixTimestamp(arg1.lastOnline or 0):ToIsoDate() or "1970-01-01T00:00:00Z"
        })
    )

    return RoduxPresence.Actions.ReceivedUserPresence(presence)
end

local tbl2 = {
    ReceivedUserPresence = function(arg1)
        return if arg1.payload then arg1 else { convertFromOldPresenceModel(arg1) }
    end
}

local var1 = RoduxPresence.installReducer()

return function(arg1, arg2)
    local var2 = tbl2[arg2.type]
    local var3 = not var2 and { arg2 } or var2(arg2)
    return llama.List.reduce(var3, var1, arg1 or { byUserId = {}, byGameId = {}, byGameInstanceId = {}, byPlaceId = {} })
end
