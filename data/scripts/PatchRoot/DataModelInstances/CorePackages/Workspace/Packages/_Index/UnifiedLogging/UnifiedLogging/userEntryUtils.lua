-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    extractFieldsFromUserEntry = function(arg1)
        if not arg1 then
            return {}
        end

        return {
            presence = arg1.presence and arg1.presence.userPresenceType or "",
            friendStatus = if arg1.isFriend then "friend" else "notFriend",
            presenceUniverseId = if not arg1.presence or not arg1.presence.universeId or arg1.presence.universeId == "" then "-1" else arg1.presence.universeId
        }
    end
}
