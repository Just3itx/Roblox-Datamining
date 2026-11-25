-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local Signals = require(ServerDrivenUiParent.Signals)
local PresenceType = require(ServerDrivenUiParent.DataHydration).Presence.PresenceEnums.PresenceType

local useSelector = require(ServerDrivenUiParent.RoactUtils).Hooks.RoactRodux.useSelector
local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local useGetOnlineFriends = require(ServerDrivenUiParent.FriendsHydrationReact).useGetOnlineFriends

local FFlagSduiSocialDataMigrateOffLegacyPresence = require(ServerDrivenUiParent.SharedFlags).FFlagSduiSocialDataMigrateOffLegacyPresence

local function useOnlineFriendsInGameByUniverseId()
    local var1 = useGetOnlineFriends()

    return React.useMemo(function()
        local result = {}
        for _, value in var1 or {} do
            local presence = value.presence
            if presence and presence.userPresenceType == PresenceType.InGame and presence.universeId and presence.universeId ~= "" then
                local var2 = result[presence.universeId] or {}
                var2[value.id] = value.id
                result[presence.universeId] = var2
            end
        end
        return result
    end, { var1 })
end

local function useFriendsInGame()
    local var1 = useSelector(function(arg1)
        return arg1.LocalUserId
    end)

    local var2 = useSelector(function(arg1)
        return arg1.InGameUsersByGame
    end)

    return React.useMemo(function()
        local result = {}
        for value, value2 in var2 do
            local tbl1 = ({})
            for value3, _ in value2 do
                if value3 ~= tostring(var1) then
                    tbl1[value3] = value3
                end
            end
            if next(tbl1) then
                result[tostring(value)] = tbl1
            end
        end
        return result
    end, { var1, var2 })
end

local function useSduiSocialData()
    local getInGameFriendsByGame, var2 = React.useMemo(function()
        return Signals.createSignal({})
    end, {})

    var2(if FFlagSduiSocialDataMigrateOffLegacyPresence then useOnlineFriendsInGameByUniverseId() else useFriendsInGame())

    return React.useMemo(function()
        return { getInGameFriendsByGame = getInGameFriendsByGame }
    end, { getInGameFriendsByGame })
end

return useSduiSocialData
