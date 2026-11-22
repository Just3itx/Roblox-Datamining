-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = dependencies.React
local UserList = require(scriptParentParentParentParent.UserList)

local useSelector = dependencies.Hooks.useSelector
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local EntityType = UserList.Enums.EntityType

local FFlagPymkCarouselPresenceStoreMigration = require(scriptParentParentParent.Flags.FFlagPymkCarouselPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagPymkCarouselPresenceStoreMigration then require(scriptParentParentParentParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local DataHydration = require(scriptParentParentParentParent.DataHydration)
local PresenceType = if FFlagPymkCarouselPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local var1 = if FFlagPymkCarouselPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local tbl1 = { skipFetch = true }

local function useUserPresence(tbl2)
    if FFlagPymkCarouselPresenceStoreMigration then
        React.useEffect(function()
            if tbl2.forceFetchUserPresence > 0 and tbl2.entityType ~= EntityType.Contact then
                var1.RefreshPresenceByUserId(tostring(tbl2.userId))
            end
        end, { tbl2.forceFetchUserPresence, tbl2.userId, tbl2.entityType })

        local var2 = useGetPresenceByUserId(tostring(tbl2.userId), tbl1)
        return var2 and var2.userPresenceType or PresenceType.Offline
    end
    local var2 = useSelector(function(arg1)
        return getDeepValue(arg1, string.format("PYMKCarousel.Presence.byUserId.%s", tbl2.userId)) or {}
    end)
    return (React.useMemo(function()
        if not (var2 and var2.userPresenceType) then
            return "Offline"
        end

        local str1 = tostring(var2.userPresenceType)
        return (string.gsub(str1, "PresenceType%.", ""))
    end, { var2 }))
end

return useUserPresence
