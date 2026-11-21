-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")
local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent

local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")

local Context = require(DiscoveryAnalytics.Constants).Context
local buttonClick = require(DiscoveryAnalyticsParent.Analytics.buttonClick)
local gameDetailReferral = require(DiscoveryAnalytics.Events.gameDetailReferral)
local gamePlayIntent = require(DiscoveryAnalytics.Events.gamePlayIntent)
local joinGameInPlacesList = require(DiscoveryAnalytics.Events.joinGameInPlacesList)
local openModalFromGameTile = require(DiscoveryAnalytics.Events.openModalFromGameTile)
local peopleListInteractionV2 = require(DiscoveryAnalytics.Events.peopleListInteractionV2)
local peopleListViewGameDetail = require(DiscoveryAnalytics.Events.peopleListViewGameDetail)
local touchSwipe = require(DiscoveryAnalytics.Events.touchSwipe)
local AppPage = require(DiscoveryAnalyticsParent.RobloxAppEnums).AppPage
local RobloxAppSessionization = require(DiscoveryAnalyticsParent.RobloxAppSessionization)
local SessionType = RobloxAppSessionization.SessionType
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession

local SharedFlags = require(DiscoveryAnalyticsParent.SharedFlags)

local FFlagProfilePlatformFavoritesEnableGameDetailAnalytics = SharedFlags.FFlagProfilePlatformFavoritesEnableGameDetailAnalytics
local FFlagProfilePlatformImproveGameDetailsAnalytics = SharedFlags.FFlagProfilePlatformImproveGameDetailsAnalytics
local FFlagEnableTopSongsSort = SharedFlags.FFlagEnableTopSongsSort
local FFlagLuaAppSduiHomePageSupport = SharedFlags.FFlagLuaAppSduiHomePageSupport

local module = {}

function module.get(arg1, arg2, arg3)
    local tbl1 = {
        [AppPage.Home] = "home",
        [AppPage.Games] = "games",
        [AppPage.SearchPage] = "gameSearch",
        [AppPage.GameDetail] = "gameDetails",
        [AppPage.Chat] = "chat",
        [AppPage.SongDetail] = if FFlagEnableTopSongsSort then "songDetails" else nil,
        ChartsSortDetail = "games",
        HomeSortDetail = if FFlagLuaAppSduiHomePageSupport then "home" else nil
    }

    local function getPageName(arg4) -- Luacid: Inlined by compiler; 10 call sites recovered
        return tbl1[arg4] or arg4
    end

    local function startGameDetailSourceSession() -- Luacid: Inlined by compiler; 7 call sites recovered
        SetGamePlaySession(arg1, SessionType.StructuralIdentifier.GameDetailSource, false)
    end

    local function startGamePlayFromFriendsListSession() -- Luacid: Inlined by compiler; 1 call site recovered
        SetGamePlaySession(arg1, SessionType.StructuralIdentifier.GamePlayFromFriendsList, true)
    end

    local module2 = {
        reportSeeAllWithId = function(arg4, gameSetTargetId, arg5)
            local tbl2 = {
                aType = "touch",
                aValue = tostring(arg4),
                gameSetTargetId = gameSetTargetId,
                pos = tonumber(arg5)
            }

            arg3:setRBXEventStream("SeeAll", "gamesPageInteraction", tbl2)
        end,
        reportFilterChangeWithId = function(arg4, gameSetTargetId, arg5)
            local tbl2 = {
                aType = "touch",
                aValue = tostring(arg4),
                gameSetTargetId = gameSetTargetId,
                pos = tonumber(arg5)
            }

            arg3:setRBXEventStream("SFMenu", "gamesPageInteraction", tbl2)
        end
    }
    local function reportGameDetailReferralWithId(pg, pid, gameSetTypeId, gameSetTargetId, sortPos, pos, tis, isAd, nativeAdData, universeId, navigationUniverseId, appliedFilters, topicDataPosition, isSdui, positionInRow, rowNumber, rowOnPage, heroUnitId, loadSource, tileType, sortSubId, analyticsData, seeAllFlag)
        local robloxLocaleId = LocalizationService.RobloxLocaleId
        startGameDetailSourceSession()
        gameDetailReferral(arg3, pg, {
            pg = pg,
            tis = tis,
            sortPos = sortPos,
            pid = pid,
            ad = if isAd then "yes" else "no",
            isAd = isAd,
            nativeAdData = nativeAdData or "",
            universeId = universeId,
            navigationUniverseId = navigationUniverseId,
            pos = pos,
            gameSetTypeId = gameSetTypeId,
            gameSetTargetId = gameSetTargetId,
            locale = robloxLocaleId,
            appliedFilters = appliedFilters,
            topicDataPosition = topicDataPosition or pos,
            isSdui = isSdui,
            positionInRow = positionInRow,
            rowNumber = rowNumber,
            rowOnPage = rowOnPage,
            heroUnitId = heroUnitId,
            loadSource = loadSource,
            tileType = tileType,
            sortSubId = sortSubId,
            analyticsData = analyticsData,
            seeAllFlag = seeAllFlag or 0
        })
    end
    function module2.reportOpenGameDetailWithId(pid, gameSetTypeId, gameSetTargetId, sortPos, pos, tis, isAd, arg4, universeId, arg5, navigationUniverseId, appliedFilters, topicDataPosition, isSdui, positionInRow, rowNumber, rowOnPage, heroUnitId, loadSource, tileType, sortSubId, analyticsData, seeAllFlag)
        reportGameDetailReferralWithId(
            getPageName(arg5),
            pid,
            gameSetTypeId,
            gameSetTargetId,
            sortPos,
            pos,
            tis,
            isAd,
            arg4 or "",
            universeId,
            navigationUniverseId,
            appliedFilters,
            topicDataPosition,
            isSdui,
            positionInRow,
            rowNumber,
            rowOnPage,
            heroUnitId,
            loadSource,
            tileType,
            sortSubId,
            analyticsData,
            seeAllFlag
        )
    end

    function module2.reportOpenGameDetailFromGameDetail(pid, pos, tis, arg4, nativeAdData, universeId, arg5, refId)
        local pg = getPageName(arg5)
        gameDetailReferral(arg3, pg, {
            pg = pg,
            pos = pos,
            tis = tis,
            sortPos = 0,
            refId = refId,
            pid = pid,
            ad = if arg4 then "yes" else "no",
            nativeAdData = nativeAdData or "",
            src = "recommended",
            universeId = universeId
        })
    end
    if FFlagProfilePlatformFavoritesEnableGameDetailAnalytics then
        function module2.reportOpenGameDetailFromProfile(pid, pos, tis, universeId, arg4, sortPos, rowOnPage, friendId)
            local pg = getPageName(arg4)
            startGameDetailSourceSession()
            local tbl2 = {
                ad = "no",
                friendId = 0,
                pg = 0,
                pid = 0,
                pos = 0,
                rowOnPage = 0,
                sortPos = 0,
                tis = 0,
                universeId = 0
            }
            if not FFlagProfilePlatformImproveGameDetailsAnalytics then
                friendId = nil
            end

            tbl2.friendId = friendId
            tbl2.pg = pg
            tbl2.pid = pid
            tbl2.pos = pos
            tbl2.rowOnPage = rowOnPage
            tbl2.sortPos = sortPos
            tbl2.tis = tis
            tbl2.universeId = universeId

            gameDetailReferral(arg3, pg, tbl2)
        end
    end

    if FFlagProfilePlatformImproveGameDetailsAnalytics then
        function module2.reportOpenGameDetailFromProfileContext(pid, universeId, arg4, friendId, arg5)
            startGameDetailSourceSession()
            local pg = getPageName(arg4)
            gameDetailReferral(arg3, arg5, { ad = "no", friendId = friendId, pg = pg, pid = pid, universeId = universeId })
        end
    end

    function module2.reportOpenGameDetailFromSearch(pid, pos, tis, arg4, arg5, universeId, arg6, sortPos, gameSetTypeId, rowOnPage, topicDataPosition, tileType, seeAllFlag)
        local pageName = getPageName(arg6)
        startGameDetailSourceSession()
        local pg = getPageName(arg6)
        local tbl2 = {
            pg = 0,
            tis = 0,
            pid = 0,
            ad = 0,
            nativeAdData = 0,
            universeId = 0,
            pos = 0,
            sortPos = 0,
            gameSetTypeId = 0,
            rowOnPage = 0,
            topicDataPosition = 0,
            tileType = 0,
            seeAllFlag = 0
        }
        local nativeAdData = arg5 or ""
        tbl2.pg = pg
        tbl2.tis = tis
        tbl2.pid = pid
        tbl2.ad = if arg4 then "yes" else "no"
        tbl2.nativeAdData = nativeAdData
        tbl2.universeId = universeId
        tbl2.pos = pos
        tbl2.sortPos = sortPos
        tbl2.gameSetTypeId = gameSetTypeId
        tbl2.rowOnPage = rowOnPage
        tbl2.topicDataPosition = topicDataPosition or pos
        tbl2.tileType = tileType
        tbl2.seeAllFlag = seeAllFlag or 0

        gameDetailReferral(arg3, pageName, tbl2)
    end

    function module2.reportOpenGameDetailFromPeopleList(friendId, position, absolutePosition, pid, universeId, fromWhere, arg4)
        local pg = getPageName(AppPage.Home)
        startGameDetailSourceSession()
        gameDetailReferral(arg3, arg4, {
            pg = pg,
            friendId = friendId,
            position = position,
            absolutePosition = absolutePosition,
            pid = pid,
            universeId = universeId,
            fromWhere = fromWhere
        })
    end
    function module2.reportOpenGameDetailFromChat(pid, conversationId, universeId, arg4)
        local pg = getPageName(AppPage.Chat)
        startGameDetailSourceSession()
        gameDetailReferral(arg3, arg4, { pg = pg, pid = pid, universeId = universeId, conversationId = conversationId })
    end

    function module2.reportPeopleListInteraction(arg4, arg5, arg6, arg7, arg8, arg9)
        peopleListInteractionV2(arg2.EventStream, arg4, arg5, arg6, arg8, arg7, arg9)
    end

    function module2.reportViewProfileFromPeopleList(arg4, arg5, arg6, arg7, arg8)
        peopleListViewGameDetail(arg2.EventStream, arg4, arg5, arg6, arg7, arg8)
    end

    function module2.reportPeopleListJoinGame(friendId, position, absolutePosition, placeId, rootPlaceId, gameInstanceId, inGameFriendCount, joinAttemptId, source)
        startGamePlayFromFriendsListSession()
        local tbl2 = {
            uid = tostring(Players.LocalPlayer.UserId),
            friendId = friendId,
            position = position,
            absolutePosition = absolutePosition,
            rootPlaceId = rootPlaceId,
            gameInstanceId = gameInstanceId,
            inGameFriendCount = inGameFriendCount,
            joinAttemptId = joinAttemptId,
            source = source
        }
        arg3:setRBXEventStream("contactFriendFinder", "joinGameInPeopleList", tbl2)
        local peopleListInHomePage = Context.PeopleListInHomePage
        gamePlayIntent(
            arg3,
            peopleListInHomePage,
            {
                placeId = placeId,
                rootPlaceId = rootPlaceId,
                joinAttemptId = joinAttemptId,
                friendId = friendId
            }
        )
    end
    function module2.reportJoinGameInPlacesList(friendId, placeId, rootPlaceId, arg4, joinAttemptId)
        joinGameInPlacesList(arg2.EventStream, friendId, placeId, rootPlaceId, arg4, joinAttemptId)
        local gamePlayIntentInPlacesList = Context.GamePlayIntentInPlacesList
        gamePlayIntent(
            arg3,
            gamePlayIntentInPlacesList,
            {
                placeId = placeId,
                rootPlaceId = rootPlaceId,
                joinAttemptId = joinAttemptId,
                friendId = friendId
            }
        )
    end
    if FFlagEnableTopSongsSort then
        function module2.reportOpenGameDetailFromSongDetail(pid, pos, tis, arg4, nativeAdData, universeId, arg5, refSongId)
            startGameDetailSourceSession()
            local pg = getPageName(arg5)
            gameDetailReferral(arg3, pg, {
                pg = pg,
                pos = pos,
                tis = tis,
                sortPos = 0,
                refSongId = refSongId,
                pid = pid,
                ad = if arg4 then "yes" else "no",
                nativeAdData = nativeAdData or "",
                src = "songDetails",
                universeId = universeId
            })
        end
    end
    function module2.reportOpenModalFromGameTileForPlacesList(arg4)
        openModalFromGameTile(arg2.EventStream, arg4)
    end

    function module2.reportButtonClicked(arg4, arg5)
        buttonClick(arg2.EventStream, arg4, arg5)
    end

    function module2.reportTouchSearchInsteadForPlayerNamed(arg4, arg5)
        buttonClick(arg2.EventStream, getPageName(arg5), "searchInsteadForPlayerNamed", arg4)
    end

    function module2.reportTouchSwipe(arg4, arg5, arg6, arg7)
        touchSwipe(arg2.EventStream, arg4, arg5, arg6, arg7)
    end

    return module2
end

return module
