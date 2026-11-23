-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local _types = require(AppChat.types)
local RoduxPresence = require(AppChat.Http.RoduxPresence)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local DataHydration = require(AppChatParent.DataHydration)
local useGetPresenceByUserId = require(AppChatParent.FriendsCommon).Hooks.useGetPresenceByUserId

local PresenceType = RoduxPresence.Enums.PresenceType
local PresenceType2 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local tbl1 = {
    [PresenceType.InGame] = "Active",
    [PresenceType.Online] = "Active",
    [PresenceType.InStudio] = "Active",
    [PresenceType.Offline] = "None",
    [PresenceType.Invisible] = "None"
}

local tbl2 = { InGame = "Active", Online = "Active", InStudio = "Active", Offline = "None" }

local tbl3 = {
    [PresenceType.InGame] = "ingameStatusLabel",
    [PresenceType.Online] = "onlinePresenceText",
    [PresenceType.InStudio] = "studioStatusLabel",
    [PresenceType.Offline] = "offlinePresenceText",
    [PresenceType.Invisible] = "offlinePresenceText"
}

local tbl4 = {
    InGame = "ingameStatusLabel",
    Online = "onlinePresenceText",
    InStudio = "studioStatusLabel",
    Offline = "offlinePresenceText"
}

local tbl5 = {
    offlinePresenceText = "Common.Presence.Label.Offline",
    onlinePresenceText = "Common.Presence.Label.Online",
    studioStatusLabel = "Common.Presence.Label.RobloxStudio",
    ingameStatusLabel = "Common.Presence.Label.InExperience"
}

local function useFoundationPresence(str1: string)
    local var1 = useLocalization(tbl5)

    local presenceText, var3 = React.useBinding(var1.offlinePresenceText)
    local presence, var5 = React.useState("None")

    local var6 = if FFlagAppChatPresenceStoreMigration then useGetPresenceByUserId(str1) else useSelector(function(arg1)
        if not str1
            or str1 == ""
            or arg1 == nil
            or arg1.ChatAppReducer == nil
            or arg1.ChatAppReducer.Presence == nil
            or arg1.ChatAppReducer.Presence.byUserId == nil
        then
            return nil
        end

        return RoduxPresence.Selectors.getUserPresenceByUserId(arg1, str1)
    end)

    React.useEffect(function()
        local offlinePresenceText = var1.offlinePresenceText
        local offline = if FFlagAppChatPresenceStoreMigration then PresenceType2.Offline else PresenceType.Offline

        if var6 then
            offline = var6.userPresenceType
            local lastLocation = var6.lastLocation

            if FFlagAppChatPresenceStoreMigration then
                offlinePresenceText = var1[tbl4[offline]]
            else
                offlinePresenceText = var1[tbl3[offline]]
            end

            local bool1 = if FFlagAppChatPresenceStoreMigration then offline == PresenceType2.InGame else offline == PresenceType.InGame

            if bool1 and lastLocation and lastLocation ~= "" then
                offlinePresenceText = lastLocation
            end
        end

        local var7 = if FFlagAppChatPresenceStoreMigration then tbl2 else tbl1
        var5(var7[offline] or "None")
        var3(offlinePresenceText)
    end, { var6, var1 })

    return React.useMemo(function()
        return { presence = presence, presenceText = presenceText }
    end, { presence, presenceText })
end

return useFoundationPresence
