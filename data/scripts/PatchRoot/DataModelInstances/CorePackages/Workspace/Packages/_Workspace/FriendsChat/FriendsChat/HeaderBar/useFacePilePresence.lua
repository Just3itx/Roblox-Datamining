-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local Foundation = require(FriendsChatParent.Foundation)
local DataHydration = require(FriendsChatParent.DataHydration)
local FFlagFriendsChatFacePileGroupPresence = require(FriendsChat.Flags.FFlagFriendsChatFacePileGroupPresence)

local UserPresence = Foundation.Enums.UserPresence
local PresenceType = DataHydration.Presence.PresenceEnums.PresenceType

local var1 = DataHydration.Presence.PresenceStore.get()

local function toUserPresence(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == PresenceType.InGame then
        return UserPresence.InExperience
    end

    if arg1 == PresenceType.InStudio or arg1 == PresenceType.Online then
        return UserPresence.Active
    end

    return UserPresence.None
end

local function aggregateGroupPresence(tbl1, arg1)
    local bool1 = false
    local bool2 = false

    for _, value in tbl1 do
        local var2 = var1.GetPresenceByUserId(tostring(value)).data(arg1)
        if not var2 then
            continue
        end

        local userPresenceType = var2.userPresenceType
        if userPresenceType == PresenceType.InGame or userPresenceType == PresenceType.InStudio then
            bool1 = true
        elseif userPresenceType == PresenceType.Online then
            bool2 = true
        end
    end

    return if bool1 then UserPresence.InExperience elseif bool2 then UserPresence.Active else UserPresence.None
end

local function useFacePilePresence(tbl1)
    local var2 = tbl1[1]

    local var3 = FFlagFriendsChatFacePileGroupPresence and #tbl1 >= 2
    local str1 = if var3 then table.concat(tbl1, ",") elseif var2 == nil then "" else tostring(var2)

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var3 then
                return (aggregateGroupPresence(tbl1, arg1))
            end
            if var2 == nil then
                return UserPresence.None
            end
            local var4 = var1.GetPresenceByUserId(tostring(var2)).data(arg1)
            local userPresenceType = if var4 then var4.userPresenceType else nil
            return toUserPresence(userPresenceType)
        end)
    end, { str1 })

    return (SignalsReact.useSignalState(var4))
end

return useFacePilePresence
