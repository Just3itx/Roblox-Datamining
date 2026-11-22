-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local React = require(SocialTabsPageParent.React)
local Signals = require(SocialTabsPageParent.Signals)
local SignalsReact = require(SocialTabsPageParent.SignalsReact)
local DataHydration = require(SocialTabsPageParent.DataHydration)
local var1 = DataHydration.Presence.PresenceStore.get()
local PresenceType = DataHydration.Presence.PresenceEnums.PresenceType

local tbl1 = {
    [PresenceType.InGame] = 3,
    [PresenceType.Online] = 2,
    [PresenceType.InStudio] = 1,
    [PresenceType.Offline] = 0
}

local function getStorePresenceWeight(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1] or 0
end

local function usersOrderEqual(tbl2, tbl3)
    if tbl2 == tbl3 then
        return true
    end
    if not tbl2 or not tbl3 or #tbl2 ~= #tbl3 then
        return false
    end
    for value, value2 in tbl2 do
        if value2.id ~= tbl3[value].id then
            return false
        end
    end
    return true
end

local function useSortedUsersByPresence(tbl2)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if #tbl2 == 0 then
                return tbl2
            end

            local tbl3 = {}
            for originalIndex, user in tbl2 do
                local var2 = var1.GetPresenceByUserId(tostring(user.id)).data(arg1)
                local var3 = if var2 then var2.userPresenceType else PresenceType.Offline
                table.insert(tbl3, { user = user, weight = getStorePresenceWeight(var3), originalIndex = originalIndex })
            end

            table.sort(tbl3, function(arg2, arg3): boolean
                if arg2.weight == arg3.weight then
                    return arg2.originalIndex < arg3.originalIndex
                end

                return arg2.weight > arg3.weight
            end)

            local result = {}
            for _, value in tbl3 do
                table.insert(result, value.user)
            end
            return result
        end, usersOrderEqual)
    end, { tbl2 })

    return SignalsReact.useSignalState(var2)
end

return useSortedUsersByPresence
