-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local ExpChatShared = require(CorePackages.Workspace.Packages.ExpChatShared)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local Promise = require(CorePackages.Packages.Promise)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local ExpChatMessageHelpers = require(script.Parent.ExpChatMessageHelpers)
local enrichMissingUsernames = require(script.Parent.inExpChatMessagesLoaderUsernameEnrichment).enrichMissingUsernames

local ChannelTabDisplayLabel = ExpChatShared.ChannelTabDisplayLabel
local GetChannelTabsStore = ExpChat.Stores.GetChannelTabsStore

local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatUseSharedChannelTabDisplayLabel = SharedFlags.FFlagExpChatUseSharedChannelTabDisplayLabel

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local function getLocalizedChannelTabLabels()
    local localizationKeys = ChannelTabDisplayLabel.LocalizationKeys
    return {
        yourServer = localization:Format(localizationKeys.yourServer),
        moreServers = localization:Format(localizationKeys.moreServers),
        friends = localization:Format(localizationKeys.friends),
        system = localization:Format(localizationKeys.system),
        team = localization:Format(localizationKeys.team)
    }
end

return {
    type = "groupedListItem",
    fetch = function(_)
        local store = ExpChatShared.context.store
        if not store then
            return Promise.resolve({})
        end

        local state = store:getState()

        local messagesStore = ExpChatShared.context.messagesStore
        if not messagesStore then
            return Promise.resolve({})
        end
        local byMessageId = messagesStore.getByMessageId(false) or {}
        local windowMessagesInOrder = messagesStore.getWindowMessagesInOrder(false) or {}
        local windowMessagesInOrderByTabId = messagesStore.getWindowMessagesInOrderByTabId(false) or {}

        local translator = ExpChatShared.context.translator

        if not ExpChatMessageHelpers.areChannelTabsEnabled() then
            local tbl1 = {}
            local tbl2 = {}

            for _, value in ipairs(windowMessagesInOrder) do
                local var1 = byMessageId[value]
                if not var1 then
                    continue
                end

                if var1.textChannel then
                    table.insert(tbl1, value)
                else
                    table.insert(tbl2, value)
                end
            end

            local tbl3 = {}

            local items = ExpChatMessageHelpers.collectItems(byMessageId, tbl1)
            ExpChatMessageHelpers.annotateWhisperItems(
                items,
                byMessageId,
                localization:Format("Feature.ReportAbuse.Label.SentPrivately")
            )
            if #items > 0 then
                table.insert(tbl3, {
                    id = ExpChatMessageHelpers.CHANNEL_GENERAL,
                    label = localization:Format(
                        if FFlagExpChatUseSharedChannelTabDisplayLabel then ChannelTabDisplayLabel.LocalizationKeys.yourServer else "CoreScripts.TextChat.ChannelTabs.Here"
                    ),
                    items = items
                })
            end

            local var1 = ExpChatMessageHelpers.collectItems(byMessageId, tbl2)
            if #var1 > 0 then
                table.insert(tbl3, {
                    id = ExpChatMessageHelpers.CHANNEL_GLOBAL,
                    label = localization:Format("CoreScripts.TextChat.ChannelTabs.Global2"),
                    items = var1
                })
            end

            return enrichMissingUsernames(tbl3)
        end

        local var1 = not state.TextChannels and {} or state.TextChannels.allTextChannels or {}

        local allChannelTabs = GetChannelTabsStore(false).getChannelTabsState(false).allChannelTabs
        local localizedChannelTabLabels = if FFlagExpChatUseSharedChannelTabDisplayLabel then getLocalizedChannelTabLabels() else nil
        local tbl1 = ({})
        local tbl2 = {}
        for id, value in pairs(windowMessagesInOrderByTabId) do
            local items = ExpChatMessageHelpers.collectItems(byMessageId, value)
            if not (#items > 0) then
                continue
            end

            local displayLabel

            if FFlagExpChatUseSharedChannelTabDisplayLabel then
                local var3

                if FFlagExpChatUseChannelTabsStore then
                    local allChannelTab = allChannelTabs[id]
                    if allChannelTab then
                        var3 = allChannelTab.type
                    else
                        var3 = nil
                    end
                else
                    local allChannelTabs2 = state.ChannelTabs and state.ChannelTabs.allChannelTabs
                    local allChannelTab = allChannelTabs2 and allChannelTabs2[id]
                    if allChannelTab then
                        var3 = allChannelTab.Type
                    else
                        var3 = nil
                    end
                end
                if var3 then
                    displayLabel = ChannelTabDisplayLabel.getDisplayLabel(var3, id, var1[id], Players.LocalPlayer, localizedChannelTabLabels)
                else
                    displayLabel = id
                end
            else
                displayLabel = ExpChatMessageHelpers.localizeString(translator, ExpChatMessageHelpers.formatChannelLabel(id, var1[id]))
            end

            table.insert(tbl2, id)
            tbl1[id] = { id = id, label = displayLabel, items = items }
        end

        table.sort(tbl2, function(channelGeneral, channelGeneral2): boolean
            local allChannelTab = allChannelTabs[channelGeneral]
            local allChannelTab2 = allChannelTabs[channelGeneral2]

            if allChannelTab and allChannelTab2 then
                return allChannelTab.tabIndex < allChannelTab2.tabIndex
            end

            if allChannelTab then
                return true
            end

            if allChannelTab2 then
                return false
            end

            if channelGeneral == ExpChatMessageHelpers.CHANNEL_GENERAL then
                return true
            end

            if channelGeneral2 == ExpChatMessageHelpers.CHANNEL_GENERAL then
                return false
            end

            return channelGeneral < channelGeneral2
        end)

        local tbl3 = {}
        for _, value in ipairs(tbl2) do
            table.insert(tbl3, tbl1[value])
        end

        return enrichMissingUsernames(tbl3)
    end
}
