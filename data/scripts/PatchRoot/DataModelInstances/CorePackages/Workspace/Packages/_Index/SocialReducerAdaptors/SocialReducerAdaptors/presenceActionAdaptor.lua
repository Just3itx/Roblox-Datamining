-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialReducerAdaptors = script:FindFirstAncestor("SocialReducerAdaptors")
local llama = require(SocialReducerAdaptors.dependencies).llama

return function(arg1)
    local function func1(tbl1)
        local presence = arg1.Models.Presence.new(
            llama.Dictionary.join(tbl1, {
                presence = llama.None,
                userPresenceType = (table.find({ "OFFLINE", "ONLINE", "IN_GAME", "IN_STUDIO" }, tbl1.presence) or 1) - 1,
                gameInstanceId = llama.None,
                gameId = tbl1.gameInstanceId,
                lastOnline = DateTime.now() and DateTime.fromUnixTimestamp(tbl1.lastOnline or 0):ToIsoDate() or "1970-01-01T00:00:00Z",
                type = llama.None
            })
        )
        return arg1.Actions.ReceivedUserPresence(presence)
    end

    return {
        ReceivedUserPresence = function(tbl1): {any} | {{[any]: any}}
            return if tbl1.payload then { tbl1 } else { func1(tbl1) }
        end
    }
end
