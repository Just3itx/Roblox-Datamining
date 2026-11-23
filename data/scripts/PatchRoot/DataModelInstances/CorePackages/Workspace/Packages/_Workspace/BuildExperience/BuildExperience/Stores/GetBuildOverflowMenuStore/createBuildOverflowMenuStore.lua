-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local PublishStatus = require(BuildExperience.Chat.PublishStatus)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)
local launchPlaytestWithLoadingState = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.launchPlaytestWithLoadingState)
local getPrivatePlaytestersStore = require(BuildExperienceParent.DataHydration.PrivatePlaytesters).getPrivatePlaytestersStore
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperiencePrivateInvites = require(BuildExperience.Flags.FFlagBuildExperiencePrivateInvites)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)
local FFlagBuildExperienceMenuImprovements = require(BuildExperience.Flags.FFlagBuildExperienceMenuImprovements)
local FFlagBuildExperienceAnalytics = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceAnalytics
local FFlagBuildExperienceDisableNonPublicStats = require(BuildExperience.Flags.FFlagBuildExperienceDisableNonPublicStats)
local PrivacyType = UniverseConfiguration.PrivacyType

local function isInApp(): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return game.GameId == 0
end

local function isInGame(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not isInApp()
end

local function isAssistantDisabled(_): boolean
    return not isInGame()
end

local function isPlaytestDisabled(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return isInGame() or tbl1.placeId == nil or tbl1.isNewGameTarget and not tbl1.hasPublishedTurn
end

local function isStatsDisabled(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.shareAudience ~= PrivacyType.Public
end

local function isVersionHistoryDisabled(tbl1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1.placeId == nil
end

local function hasExistingRoster(tbl1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = getPrivatePlaytestersStore(false).getAndFetchInvitedPlayers(tbl1.universeId)
    return var1.status(false) == "Ready" and #var1.players(false) > 0
end

local function isInviteToPlaytestDisabled(tbl1): boolean
    if hasExistingRoster(tbl1) then
        return false
    end
    local privatePlaytestersStore = getPrivatePlaytestersStore(false)
    return #privatePlaytestersStore.getAndFetchInvitedPlayers(tbl1.universeId).players(false) >= privatePlaytestersStore.MAX_INVITES
end

local function omitInviteToPlaytest(tbl1)
    local var1 = table.clone(tbl1)
    for value, value2 in var1 do
        local items = {}
        local bool1 = false
        for _, item in value2.items do
            if item.id == "invite-to-playtest" then
                bool1 = true
            else
                table.insert(items, item)
            end
        end
        if bool1 then
            var1[value] = { items = items }
        end
    end
    return var1
end

local function getPublishText(tbl1)
    return if PublishStatus.isPublishLatest(tbl1.hasPublishedVersion, tbl1.hasPublishedTurn) then LocalizationStrings.BUILD_MENU_PUBLISH_LATEST else LocalizationStrings.BUILD_MENU_PUBLISH
end

local function getShareAudience(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(tbl1.universeId).data()
    return GameConfigurationLabels.getAudience(var1)
end

local function isShareUnavailable(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.shareAudience == nil or tbl1.shareAudience == PrivacyType.Private
end

local function onShareActivated(tbl1)
    if tbl1.placeId == nil then
        return nil
    end

    if isShareUnavailable(tbl1) then
        return nil
    end

    local shareAudience = getShareAudience(tbl1)

    if shareAudience == PrivacyType.FriendsOnly then
        return {
            type = "confirmFriendsShare",
            placeId = tbl1.placeId
        }
    end

    if shareAudience == PrivacyType.Public then
        return {
            type = "share",
            placeId = tbl1.placeId
        }
    end

    return nil
end

local function onAssistantActivated(_): {type: string}?
    return if isInApp() then nil else { type = "leaveExperience" }
end

local function onPlaytestActivated(tbl1)
    if not (isPlaytestDisabled(tbl1) or isVersionHistoryDisabled(tbl1)) then
        sendBuildExperienceEvent(
            "PLAYTEST_CLICK",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId,
                conversationId = tbl1.sessionId
            },
            { context = "overflow_menu" }
        )
        launchPlaytestWithLoadingState(tbl1.placeId, "BuildOverflowMenu", true)
    end

    return nil
end

local function onVersionHistoryActivated(tbl1): {type: string}?
    return if isVersionHistoryDisabled(tbl1) then nil else { type = "openVersionHistory" }
end

local tbl1 = {
    id = "get-users",
    text = LocalizationStrings.BUILD_MENU_GET_USERS,
    requiredPermission = "canAdvertise",
    isDisabled = function(tbl1): boolean
        return tbl1.getUsersUniverseEligible ~= true
    end,
    getTrailingText = function(tbl1)
        return if (tbl1.getUsersFreeCreditsRemaining or 0) > 0 then LocalizationStrings.BUILD_MENU_GET_USERS_FREE_TAG else nil
    end,
    onActivated = function()
        return { type = "openGetUsers" }
    end
}

local function createBuildOverflowMenuStore()
    local tbl2 = {
        id = "settings",
        text = LocalizationStrings.BUILD_MENU_SETTINGS,
        requiredPermission = "canEdit",
        onActivated = function()
            return { type = "openPage", page = "settings" }
        end
    }

    local tbl3 = {
        id = "share",
        text = LocalizationStrings.BUILD_MENU_SHARE,
        isDisabled = if FFlagBuildExperiencePrivateInvites then nil else isShareUnavailable,
        onActivated = 0
    }

    function tbl3.onActivated(tbl4)
        if FFlagBuildExperiencePrivateInvites then
            return { type = "share" }
        end
        return (onShareActivated(tbl4))
    end

    local tbl4 = {
        id = "version-history",
        text = LocalizationStrings.BUILD_MENU_VERSIONS,
        isDisabled = isVersionHistoryDisabled,
        requiredPermission = "canEdit",
        onActivated = onVersionHistoryActivated
    }
    local tbl5 = {
        id = "invite-to-playtest",
        text = LocalizationStrings.BUILD_MENU_INVITE_TO_PLAYTEST,
        isDisabled = isInviteToPlaytestDisabled,
        requiredPermission = "canEdit",
        onActivated = function(tbl5)
            sendBuildExperienceEvent(
                "ADD_TO_PLAYTEST_CLICK",
                {
                    universeId = tbl5.universeId,
                    placeId = tbl5.placeId,
                    conversationId = tbl5.sessionId
                },
                { source = "overflow_menu" }
            )
            return if hasExistingRoster(tbl5) then { type = "openInviteManagement" } else {
                type = "openInvitePicker"
            }
        end
    }

    local tbl6 = {
        id = "stats",
        text = LocalizationStrings.BUILD_MENU_STATS,
        isDisabled = if FFlagBuildExperienceDisableNonPublicStats then isStatsDisabled else nil,
        requiredPermission = "canViewAnalytics",
        onActivated = 0
    }
    function tbl6.onActivated(tbl7): {page: string, type: string}?
        return if FFlagBuildExperienceDisableNonPublicStats and isStatsDisabled(tbl7) then nil else {
            type = "openPage",
            page = "stats"
        }
    end

    local tbl7 = {
        id = "monetization",
        text = LocalizationStrings.BUILD_MENU_MONETIZATION,
        requiredPermission = "canMonetize",
        onActivated = function()
            return { type = "openPage", page = "monetization" }
        end
    }

    local var1 = nil
    local tbl8

    if FFlagBuildExperienceMenuImprovements then
        tbl8 = {{
            items = {
                {
                    id = "publish",
                    text = LocalizationStrings.BUILD_MENU_PUBLISH,
                    requiredPermission = "canPublish",
                    onActivated = function()
                        return { type = "openPage", page = "publish" }
                    end
                },
                tbl3,
                tbl4,
                tbl2
            }
        }}

        if FFlagBuildExperiencePrivateInvites then
            table.insert(tbl8[1].items, 3, tbl5)
        end
    else
        tbl8 = {
            {
                items = {
                    {
                        id = "assistant",
                        text = LocalizationStrings.BUILD_MENU_BACK_TO_BUILD,
                        isDisabled = isAssistantDisabled,
                        onActivated = onAssistantActivated
                    },
                    {
                        id = "playtest",
                        text = LocalizationStrings.BUILD_MENU_PLAYTEST,
                        isDisabled = isPlaytestDisabled,
                        requiredPermission = "canEdit",
                        onActivated = onPlaytestActivated
                    }
                }
            },
            {
                items = {
                    tbl2,
                    {
                        id = "publish",
                        text = LocalizationStrings.BUILD_MENU_PUBLISH,
                        getText = getPublishText,
                        requiredPermission = "canPublish",
                        onActivated = function()
                            return { type = "openPage", page = "publish" }
                        end
                    },
                    tbl3,
                    tbl4
                }
            }
        }

        if FFlagBuildExperiencePrivateInvites then
            table.insert(tbl8[2].items, 2, tbl5)
        end
        if FFlagBuildExperienceAnalytics then
            var1 = {
                items = { tbl6 }
            }
            table.insert(tbl8, var1)
        end
    end
    if FFlagBuildExperienceManageDevProduct and not FFlagBuildExperienceMenuImprovements then
        table.insert(tbl8, 1, { items = { tbl7 } })
    end
    local getItems = Signals.createSignal(tbl8)

    return {
        getItems = getItems,
        useItems = function(tbl9)
            local universeId = if tbl9 == nil then nil else tbl9.universeId

            local var2 = React.useMemo(function()
                return Signals.createComputed(function(arg1)
                    if not FFlagBuildExperiencePrivateInvites or universeId == nil then
                        return nil
                    end
                    local var2 = UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(universeId).data(arg1)
                    return if var2 == nil then nil else var2.creatorType
                end)
            end, { universeId })
            local bool1 = SignalsReact.useSignalState(var2) == "Group"
            local var3 = React.useMemo(function()
                return Signals.createComputed(function(arg1): number
                    if not FFlagBuildExperiencePrivateInvites or universeId == nil then
                        return 0
                    end

                    local var3 = UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(universeId).data(arg1)

                    if var3 == nil or var3.creatorType ~= "Group" then
                        return #getPrivatePlaytestersStore(false).getAndFetchInvitedPlayers(universeId).players(arg1)
                    end

                    return 0
                end)
            end, { universeId })
            local var4 = SignalsReact.useSignalState(var3)

            local var5 = nil
            if FFlagBuildExperienceAnalytics then
                local var6 = React.useMemo(function()
                    return Signals.createComputed(function(arg1)
                        if universeId == nil then
                            return nil
                        end
                        local var6 = UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(universeId).data(arg1)
                        return GameConfigurationLabels.getAudience(var6)
                    end)
                end, { universeId })

                var5 = SignalsReact.useSignalState(var6)
            end
            local var6 = SignalsReact.useSignalState(getItems)

            local bool2 = FFlagEnableBuildAdPromotion

            if bool2 then
                if tbl9 == nil or tbl9.canOpenGetUsers ~= true then
                    bool2 = false
                else
                    bool2 = tbl9.getUsersUserEligible == true
                end
            end

            local var7 = FFlagBuildExperiencePrivateInvites and bool1

            local var8 = React.useMemo(function()
                if not FFlagBuildExperienceMenuImprovements then
                    local var8 = FFlagBuildExperienceAnalytics and not FFlagBuildExperienceDisableNonPublicStats and var5 ~= PrivacyType.Public
                    if not (FFlagBuildExperiencePrivateInvites or var8 or bool2) then
                        return var6
                    end
                    local var9 = table.clone(var6)
                    if var8 then
                        local var10 = table.find(var9, var1)
                        if var10 ~= nil then
                            table.remove(var9, var10)
                        end
                    end
                    if bool2 then
                        local var10 = var9[1]
                        if var10 ~= nil then
                            local items = table.clone(var10.items)
                            table.insert(items, tbl1)
                            var9[1] = { items = items }
                        end
                    end
                    if var7 then
                        var9 = omitInviteToPlaytest(var9)
                    end
                    return var9
                end

                local items = {}

                if FFlagBuildExperienceAnalytics and (FFlagBuildExperienceDisableNonPublicStats or var5 == PrivacyType.Public) then
                    table.insert(items, tbl6)
                end
                if FFlagBuildExperienceManageDevProduct then
                    table.insert(items, tbl7)
                end
                if bool2 then
                    table.insert(items, tbl1)
                end
                if #items == 0 and not FFlagBuildExperiencePrivateInvites then
                    return var6
                end
                local var8 = table.clone(var6)
                if #items > 0 then
                    table.insert(var8, 1, { items = items })
                end
                if var7 then
                    var8 = omitInviteToPlaytest(var8)
                end
                return var8
            end, {
                var6,
                var4,
                var5,
                bool2,
                var7
            })

            return if tbl9 == nil then {} else var8
        end
    }
end
return createBuildOverflowMenuStore
