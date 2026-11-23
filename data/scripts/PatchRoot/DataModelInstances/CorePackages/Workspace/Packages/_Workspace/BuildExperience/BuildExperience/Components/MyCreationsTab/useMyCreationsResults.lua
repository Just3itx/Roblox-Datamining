-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local Players = game:GetService("Players")

local FIntMyCreationsSessionListPollingIntervalSeconds = require(BuildExperience.Flags.FIntMyCreationsSessionListPollingIntervalSeconds)

local FFlagBuildExperienceMyCreationsFindSessionsByUniverse = require(BuildExperience.Flags.FFlagBuildExperienceMyCreationsFindSessionsByUniverse)
local FFlagBuildWithGroups = require(BuildExperience.Flags.FFlagBuildWithGroups)
local FFlagBuildExperienceCursorSearchPages = require(BuildExperience.Flags.FFlagBuildExperienceCursorSearchPages)

local Localization = require(BuildExperienceParent.Localization)
local Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = Localization.Hooks.useLocalization
local LocalizationRoactContext = Localization.LocalizationRoactContext
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local CreatorGroups = require(BuildExperienceParent.DataHydration.CreatorGroups)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local UniverseSearch = require(BuildExperienceParent.DataHydration.UniverseSearch)

local PrivacyType = UniverseConfiguration.PrivacyType

local thumbForUniverseId = require(BuildExperience.utils.thumbForUniverseId)
local useCursorSearchPages = require(BuildExperience.utils.useCursorSearchPages)

local GetBuildExperienceRefreshStore = require(BuildExperience.Stores.GetBuildExperienceRefreshStore)
local _GetMyCreationsFilterStore = require(BuildExperience.Stores.GetMyCreationsFilterStore)
local GetSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)

local useSignalState = SignalsReact.useSignalState

local pageSize = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then 15 else 50
local tbl1 = {}
local tbl2 = { games = "All" }

local function privacyLabelForSearchItem(arg1, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    return if UniverseConfiguration.getPrivacyTypeForAudiences(arg1.audiences) == PrivacyType.Public then tbl3.live else nil
end

local function universeSearchParamsForPage(creatorTargetId: number, search: string, pageIndex: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = {
        creatorType = "User",
        creatorTargetId = creatorTargetId,
        surface = "CreatorHubCreations",
        isArchived = false,
        isTeamCreateEnabled = true,
        sortParam = "LastUpdated",
        sortOrder = "Desc",
        pageIndex = pageIndex,
        pageSize = pageSize,
        search = 0,
        needsAssetOptions = true
    }

    if search == "" then
        search = nil
    end

    tbl3.search = search
    return tbl3
end

local function multiCreatorSearchParamsForPage(creators, search: string, cursor: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl3 = {
        creators = creators,
        surface = "Build",
        isArchived = false,
        isTeamCreateEnabled = true,
        sortParam = "LastUpdated",
        sortOrder = "Desc",
        pageSize = pageSize,
        cursor = cursor,
        search = 0,
        needsAssetOptions = true
    }

    if search == "" then
        search = nil
    end

    tbl3.search = search
    return tbl3
end

local function keyForCreators(tbl3)
    if tbl3 == nil then
        return nil
    end
    local var1 = table.create(#tbl3)
    for value, value2 in tbl3 do
        var1[value] = `{value2.creatorType}:{value2.creatorTargetId}`
    end
    return table.concat(var1, ",")
end

local function isCursorRequested(cursors, nextCursor: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if cursors == nil then
        return false
    end
    for _, cursor in cursors do
        if cursor == nextCursor then
            return true
        end
    end
    return false
end

local function descriptionForSessionStatus(arg1, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local _roblox = arg1._meta and arg1._meta._roblox
    local sessionStatus = if _roblox then _roblox.sessionStatus else nil
    return if sessionStatus == nil then nil else tbl3[sessionStatus]
end

local function requestHandleToPromise(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Promise.new(function(callback, callback2)
        task.spawn(function()
            while arg1.state(false).status == "pending" do
                task.wait()
            end

            local var1 = arg1.state(false)
            if var1.status == "succeeded" then
                callback(var1.result)
                return
            end
            callback2(var1.error)
        end)
    end)
end

local function ignorePromiseRejection() end

local function getSessionUniverseId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local _roblox = arg1._meta and arg1._meta._roblox
    if _roblox == nil then
        return nil
    end
    local universeId = _roblox.universeId
    return if typeof(universeId) == "number" and universeId ~= 0 then universeId else nil
end

local function buildLatestSessionByUniverseId(tbl3)
    local latestSessionByUniverseId = ({})
    for _, value in tbl3 do
        local sessionUniverseId = getSessionUniverseId(value)

        if sessionUniverseId ~= nil and latestSessionByUniverseId[sessionUniverseId] == nil then
            latestSessionByUniverseId[sessionUniverseId] = value
        end
    end
    return latestSessionByUniverseId
end

local function useUniverseSessions(arg1, current)
    local var1, var2 = React.useState({})

    local var3 = React.useRef(var1)
    var3.current = var1
    local var4 = React.useRef({})

    local var5 = React.useRef(current)
    var5.current = current
    local var6 = React.useRef(true)

    React.useEffect(function()
        var6.current = true
        return function()
            var6.current = false
        end
    end, {})

    local var7 = React.useCallback(function(bool1: boolean)
        local tbl3 = {}
        for _, value in var5.current do
            if value.isArchived then
                continue
            end

            local id = value.id
            local var7 = var4.current[id]
            if var7 ~= nil then
                table.insert(tbl3, var7.promise)
            elseif bool1 or var3.current[id] == nil then
                local handle = arg1.sessionFindByUniverse({ universeId = id, sort = "desc", application = "build", filterByPinForBuild = true })

                local tbl4 = { handle = handle, promise = nil }

                var4.current[id] = tbl4

                local promise = requestHandleToPromise(handle):andThen(function()
                    local var9 = var4.current[id]
                    if var9 == nil or var9.handle ~= handle then
                        return
                    end
                    var4.current[id] = nil
                    if var6.current then
                        local var8 = table.clone(var3.current)
                        var8[id] = handle
                        var3.current = var8
                        var2(var8)
                    end
                end, function(arg2)
                    local var9 = var4.current[id]
                    if var9 ~= nil and var9.handle == handle then
                        var4.current[id] = nil
                    end
                    return Promise.reject(arg2)
                end)
                tbl4.promise = promise
                table.insert(tbl3, promise)
            end
        end
        return Promise.all(tbl3)
    end, { arg1 })

    React.useEffect(function()
        var7(false):catch(ignorePromiseRejection)
    end, { current, var7 })

    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local result = {}
            for _, item in current do
                local var8 = var1[item.id]
                local var9 = if var8 == nil then nil else var8.state(arg2)

                if var9 == nil or var9.status ~= "succeeded" or var9.result == nil then
                    continue
                end

                local sessions = var9.result.sessions
                local session = if typeof(sessions) == "table" then sessions[1] else nil

                if session ~= nil then
                    table.insert(result, session)
                end
            end

            return result
        end)
    end, { current, var1 })
    return {
        entries = useSignalState(var8),
        refresh = React.useCallback(function()
            return var7(true)
        end, { var7 })
    }
end

local function buildUniverseItems(items, tbl3, tbl4, tbl5, func1: ((...any) -> (...any))?)
    local latestSessionByUniverseId = buildLatestSessionByUniverseId(tbl3)
    local universeItems = {}
    for _, item in items do
        if item.isArchived then
            continue
        end

        local id = item.id
        local var1 = latestSessionByUniverseId[id]
        local name = item.name

        if typeof(name) ~= "string" or name == "" then
            name = func1(id)
        end
        table.insert(universeItems, {
            sessionId = if var1 then var1.sessionId else nil,
            universeId = id,
            placeId = item.rootPlaceId,
            experienceName = name,
            creatorName = if typeof(item.creatorName) == "string" and item.creatorName ~= "" then item.creatorName else nil,
            description = if var1 then descriptionForSessionStatus(var1, tbl4) else nil,
            visibilityLabel = privacyLabelForSearchItem(item, tbl5),
            gameIcon = thumbForUniverseId(id),
            isGroupGame = if FFlagBuildWithGroups then item.creatorType == "Group" else nil
        })
    end
    return universeItems
end

local function useUniverseSearchList(num2: number, creatorTargetId: number, query: string, bool1: boolean, tbl3, tbl4, tbl5, func1: ((...any) -> (...any))?, arg1, tbl6)
    local var1 = React.useRef({})
    local var2 = React.useRef(query)
    var2.current = query
    local creators = if FFlagBuildWithGroups then tbl6.creators else nil
    local var3 = if FFlagBuildWithGroups then keyForCreators(creators) else nil
    local var4 = if FFlagBuildWithGroups then React.useRef(creators) else nil

    if FFlagBuildWithGroups then
        var4.current = creators
    end
    local var5, var6 = React.useState(
        {
            query = query,
            pageIndexes = { 0 },
            creators = creators,
            cursors = FFlagBuildWithGroups and {} or nil
        }
    )
    local var7 = React.useMemo(function()
        local result = {}
        if FFlagBuildWithGroups then
            local creators2 = var5.creators
            if creators2 ~= nil then
                local var7 = var5.cursors or {}
                for _, value in var5.pageIndexes do
                    local tbl7 = multiCreatorSearchParamsForPage(creators2, var5.query, var7[value])
                    table.insert(result, (num2.getSearch(tbl7)))
                end

                return result
            end
        else
            for _, value in var5.pageIndexes do
                table.insert(result, (num2.getSearch((universeSearchParamsForPage(creatorTargetId, var5.query, value)))))
            end
        end
        return result
    end, { var5, num2, creatorTargetId })

    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local items = {}
            local tbl8 = {}
            local var8 = nil
            local var9 = nil
            local num3 = 0
            local num4 = 0
            local str1 = "NotReady"
            local str2 = "NotReady"

            for value, value2 in var7 do
                local var10 = value2.data(arg2)
                str1 = value2.status(arg2)
                if value == 1 then
                    str2 = str1
                end

                if var10 == nil then
                    continue
                end

                var9 = var10.totalResults or var10.totalHits or var9
                local var11 = var10.data or tbl1
                num3 += #var11
                num4 = 0
                for _, value3 in var11 do
                    if not tbl8[value3.id] then
                        tbl8[value3.id] = true
                        num4 += 1
                        table.insert(items, value3)
                    end
                end

                var8 = var10
            end

            local pageIndexesLen = nil
            local var10 = nil
            local var11 = nil
            if FFlagBuildWithGroups then
                if str1 == "Ready" and var8 ~= nil then
                    local nextCursor = var8.nextCursor

                    if nextCursor ~= nil and nextCursor ~= "" and num4 > 0 and not isCursorRequested(var5.cursors, nextCursor) then
                        pageIndexesLen = #var5.pageIndexes
                        var10 = nextCursor
                    end
                elseif str1 == "Failed" and #var7 > 1 then
                    var11 = var5.pageIndexes[#var5.pageIndexes]
                end
            elseif str1 == "Ready" and var8 ~= nil then
                local nextResultIndex = var8.nextResultIndex
                if nextResultIndex ~= nil then
                    pageIndexesLen = nextResultIndex / pageSize
                elseif var9 ~= nil and num3 < var9 then
                    pageIndexesLen = var5.pageIndexes[#var5.pageIndexes] + 1
                end
                if pageIndexesLen ~= nil and (pageIndexesLen < 0 or table.find(var5.pageIndexes, pageIndexesLen)) then
                    pageIndexesLen = nil
                end
            elseif str1 == "Failed" and #var7 > 1 then
                var11 = var5.pageIndexes[#var5.pageIndexes]
            end

            return {
                items = items,
                status = str2,
                nextPageIndex = pageIndexesLen,
                nextCursor = var10,
                failedPageIndex = var11,
                isLoadingMore = #var7 > 1 and str1 == "NotReady"
            }
        end)
    end, { var5.pageIndexes, var5.cursors, var7 })
    local var9 = useSignalState(var8)
    local var10 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then useUniverseSessions(arg1, var9.items) else nil

    local var11 = React.useCallback(function(str1: string, pageIndex: number, bool2: boolean?, cursor: string?, tbl7)
        local str2 = if FFlagBuildWithGroups then `{pageIndex}\000{str1}\000{cursor or ""}\000{keyForCreators(tbl7) or ""}` else `{pageIndex}\000{str1}`

        if bool2 then
            var1.current[str2] = nil
        end
        local var11 = var1.current[str2]
        if var11 ~= nil then
            return var11
        end

        local var12 = if FFlagBuildWithGroups then multiCreatorSearchParamsForPage(tbl7, str1, cursor) else universeSearchParamsForPage(creatorTargetId, str1, pageIndex)
        local var13 = nil
        var13 = num2.refreshSearch(var12):finally(function()
            if var1.current[str2] == var13 then
                var1.current[str2] = nil
            end
        end)
        var1.current[str2] = var13
        return var13
    end, { num2, creatorTargetId })

    local refresh = React.useCallback(function(str1: string?)
        local var12 = str1 or var2.current
        if not FFlagBuildWithGroups then
            var6({ query = var12, pageIndexes = { 0 } })

            return var11(var12, 0)
        end

        local current = var4.current
        var6({ query = var12, pageIndexes = { 0 }, creators = current, cursors = {} })

        if current == nil then
            return Promise.resolve()
        end
        return var11(var12, 0, nil, nil, current)
    end, { var11 })

    React.useEffect(function()
        if not bool1 then
            return
        end
        local var13 = FFlagBuildWithGroups and keyForCreators(var5.creators) ~= var3
        if var5.query ~= query or var13 then
            refresh(query):catch(ignorePromiseRejection)
        end
    end, {
        var3,
        query,
        bool1,
        refresh,
        var5.creators,
        var5.query
    })
    local loadMore = React.useCallback(function()
        local var13 = var9.failedPageIndex or var9.nextPageIndex
        local query2 = var5.query
        if var9.isLoadingMore or var13 == nil or var2.current ~= query2 then
            return
        end

        if not FFlagBuildWithGroups then
            if var9.failedPageIndex == nil then
                var6(function(arg2)
                    if arg2.query ~= query2 or table.find(arg2.pageIndexes, var13) then
                        return arg2
                    end
                    local pageIndexes = table.clone(arg2.pageIndexes)
                    table.insert(pageIndexes, var13)
                    return {
                        query = arg2.query,
                        pageIndexes = pageIndexes
                    }
                end)
            end
            var11(query2, var13, var9.failedPageIndex ~= nil):catch(ignorePromiseRejection)
            return
        end

        local creators2 = var5.creators
        if creators2 == nil or keyForCreators(creators2) ~= keyForCreators(var4.current) then
            return
        end
        local bool2 = var9.failedPageIndex ~= nil
        local var14 = if bool2 then (var5.cursors or {})[var13] else var9.nextCursor

        if not bool2 then
            var6(function(arg2)
                if arg2.query ~= query2 or arg2.creators ~= creators2 or table.find(arg2.pageIndexes, var13) then
                    return arg2
                end
                local pageIndexes = table.clone(arg2.pageIndexes)
                table.insert(pageIndexes, var13)
                local cursors = table.clone(arg2.cursors or {})
                cursors[var13] = var14
                return {
                    query = arg2.query,
                    pageIndexes = pageIndexes,
                    creators = arg2.creators,
                    cursors = cursors
                }
            end)
        end
        var11(query2, var13, bool2, var14, creators2):catch(ignorePromiseRejection)
    end, {
        var9,
        var11,
        var5.creators,
        var5.cursors,
        var5.query
    })
    local useMemo = React.useMemo
    local function func2()
        return (buildUniverseItems(
            var9.items,
            if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then var10.entries else tbl3,
            tbl4,
            tbl5,
            func1
        ))
    end

    local items = var9.items
    local var14 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then var10.entries else tbl3
    return {
        items = useMemo(func2, { tbl4, items, var14, tbl5, func1 }),
        status = if FFlagBuildWithGroups and tbl6.creators == nil then tbl6.status else var9.status,
        sourceItemCount = #var9.items,
        failedLoadMore = var9.failedPageIndex ~= nil,
        isLoadingMore = var9.isLoadingMore,
        query = var5.query,
        refresh = refresh,
        refreshSessions = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then var10.refresh else nil,
        loadMore = loadMore
    }
end

local function useUniverseListItems<T>(items, tbl3, tbl4, tbl5, func1: ((...any) -> (...any))?, arg1)
    local var1 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then useUniverseSessions(arg1, items) else nil

    if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
        tbl3 = var1.entries
    end

    return {
        items = React.useMemo(function()
            return (buildUniverseItems(items, tbl3, tbl4, tbl5, func1))
        end, {
            tbl4,
            tbl3,
            items,
            tbl5,
            func1
        }),
        refreshSessions = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then var1.refresh else nil
    }
end

local function useCreatorSearchList(searchStore, current: string, bool1: boolean, tbl3, tbl4, tbl5, func1: ((...any) -> (...any))?, arg1, tbl6)
    local creators = tbl6.creators
    local var1 = keyForCreators(creators)

    local var2 = React.useRef(current)
    if bool1 then
        var2.current = current
    end
    local current2 = var2.current

    local sources = React.useMemo(function(): {{key: string, params: {creators: {[any]: any}, cursor: string?, isArchived: boolean, isTeamCreateEnabled: boolean, needsAssetOptions: boolean, pageSize: number, search: number, sortOrder: string, sortParam: string, surface: string}}}?
        return if creators == nil then nil else {{
            key = `{current2}\000{var1}`,
            params = multiCreatorSearchParamsForPage(creators, current2, nil)
        }}
    end, { current2, creators, var1 })

    local var4 = useCursorSearchPages({ searchStore = searchStore, sources = sources })

    local tbl7 = useUniverseListItems(var4.items, tbl3, tbl4, tbl5, func1, arg1)

    return {
        items = tbl7.items,
        status = if creators == nil then tbl6.status else var4.status,
        sourceItemCount = #var4.items,
        failedLoadMore = var4.failedLoadMore,
        isLoadingMore = var4.isLoadingMore,
        query = current2,
        refresh = var4.refresh,
        refreshSessions = tbl7.refreshSessions,
        loadMore = var4.loadMore
    }
end

local function useBuildCreators(arg1, creatorTargetId: number, arg2)
    local var1 = React.useMemo(function()
        return (arg1.getAndFetchGroups("Build"))
    end, { arg1 })
    local var2 = useSignalState(var1.data)
    local var3 = useSignalState(var1.status)
    local games = arg2.games
    local groupId = arg2.groupId

    return React.useMemo(function()
        local tbl3 = { creatorType = "User", creatorTargetId = creatorTargetId }
        if games == "MyGames" then
            return {
                creators = { tbl3 },
                status = "Ready"
            }
        elseif games == "SharedGames" then
            return {
                creators = {{ creatorType = "Team", creatorTargetId = creatorTargetId }},
                status = "Ready"
            }
        end

        if var2 == nil then
            return {
                creators = nil,
                status = if var3 == "Failed" then "Failed" else "NotReady"
            }
        end

        if games == "GroupGames" and groupId ~= nil then
            for _, group in var2.groups do
                if group.id ~= groupId then
                    continue
                end

                return {
                    creators = {{
                        creatorType = "Group",
                        creatorTargetId = group.id
                    }},
                    status = "Ready"
                }
            end
        end

        if games == "GroupGames" and #var2.groups == 0 then
            return { creators = nil, status = "Ready" }
        end

        local creators = games == "GroupGames" and {} or { tbl3 }
        for _, group in var2.groups do
            table.insert(creators, { creatorType = "Group", creatorTargetId = group.id })
        end
        return { creators = creators, status = "Ready" }
    end, {
        games,
        groupId,
        var2,
        var3,
        creatorTargetId
    })
end

local function useMyCreationsResults(tbl3)
    local var1 = useLocalization({
        building = LocalizationStrings.MY_CREATIONS_BUILDING,
        inputNeeded = LocalizationStrings.MY_CREATIONS_INPUT_NEEDED,
        loadError = LocalizationStrings.MY_CREATIONS_LOAD_ERROR,
        live = LocalizationStrings.MY_CREATIONS_LIVE,
        private = LocalizationStrings.MY_CREATIONS_PRIVATE,
        public = LocalizationStrings.MY_CREATIONS_PUBLIC,
        publiclyUnavailable = LocalizationStrings.MY_CREATIONS_PUBLICLY_UNAVAILABLE,
        ready = LocalizationStrings.MY_CREATIONS_READY,
        restricted = LocalizationStrings.MY_CREATIONS_RESTRICTED
    })
    local var2 = React.useContext(LocalizationRoactContext)
    local var3 = var1[Localization.RobloxLocaleIdKey]
    local var4 = React.useCallback(function(universeId: number)
        return var2:Format(LocalizationStrings.MY_CREATIONS_UNIVERSE_NAME, { UNIVERSE_ID = universeId })
    end, { var2, var3 })
    local loadError = var1.loadError
    local var5 = React.useMemo(function()
        return {
            waiting_on_client = var1.inputNeeded,
            idle = var1.ready,
            working = var1.building
        }
    end, { var1.inputNeeded, var1.ready, var1.building })

    local var6 = React.useMemo(function()
        return {
            live = var1.live,
            private = var1.private,
            public = var1.public,
            publiclyUnavailable = var1.publiclyUnavailable,
            restricted = var1.restricted
        }
    end, {
        var1.live,
        var1.private,
        var1.public,
        var1.publiclyUnavailable,
        var1.restricted
    })

    local creatorAgentChatStore = tbl3.creatorAgentChatStore or CreatorAgentChat.getCreatorAgentChatStore()
    local searchStore = tbl3.searchStore
    if searchStore == nil then
        searchStore = UniverseSearch.getUniverseSearchStore()
    end
    local searchQueryStore = tbl3.searchQueryStore or GetSearchQueryStore()
    local buildExperienceRefreshStore = GetBuildExperienceRefreshStore()
    local var7 = tbl3.appLifecycleObserverService or AppLifecycleObserverService
    local current = tbl3.isFocused ~= false
    local hasCompletedFocusedRefresh, var9 = React.useState(false)
    local var10 = searchQueryStore.useDebouncedQuery()
    local var8 = useSignalState(buildExperienceRefreshStore.getRefreshTick)
    local var12 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then React.useRef(var8) else nil
    local var13 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then React.useRef(current) else nil
    local sessionListStore = creatorAgentChatStore.getSessionListStore()
    local var14 = useSignalState(sessionListStore.getSessions)
    local var15 = useSignalState(sessionListStore.getNextPageToken)
    local var16 = useSignalState(sessionListStore.getStatus)
    local var17 = useSignalState(sessionListStore.getLoadMoreStatus)
    local sessionListStatus = if var16 == "pending" then "NotReady" elseif var16 == "succeeded" then "Ready" else "Failed"

    local var18 = tbl3.userId or (if Players.LocalPlayer then Players.LocalPlayer.UserId else 0)
    local creatorGroupsStore = if FFlagBuildWithGroups then tbl3.creatorGroupsStore or CreatorGroups.getCreatorGroupsStore() else nil
    local var19 = if FFlagBuildWithGroups then useBuildCreators(creatorGroupsStore, var18, tbl3.filter or tbl2) else nil
    local var20

    if FFlagBuildExperienceCursorSearchPages then
        local func1 = useCreatorSearchList

        if not FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
            creatorAgentChatStore = nil
        end

        var20 = func1(searchStore, var10, current, var14, var5, var6, var4, creatorAgentChatStore, var19)
    else
        local func1 = useUniverseSearchList

        if not FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
            creatorAgentChatStore = nil
        end

        var20 = func1(searchStore, var18, var10, current, var14, var5, var6, var4, creatorAgentChatStore, var19)
    end

    local refresh = var20.refresh
    local refreshSessions = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then var20.refreshSessions else nil
    local var21 = if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then React.useRef(refreshSessions) else nil

    if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
        var21.current = refreshSessions
    end

    local var11 = React.useCallback(function()
        local var22 = requestHandleToPromise((sessionListStore.refresh()))
        if FFlagBuildWithGroups then
            creatorGroupsStore.fetchGroups("Build")
        end
        if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
            return Promise.all({ refresh(), var22, var21.current():catch(ignorePromiseRejection) })
        end

        return Promise.all({ refresh(), var22 })
    end, { creatorGroupsStore, refresh, sessionListStore })

    React.useEffect(function()
        local connection = var7.OnUnhide:Connect(function()
            if not current then
                return
            end

            refresh():catch(ignorePromiseRejection)
            if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
                var21.current():catch(ignorePromiseRejection)
            end
            sessionListStore.refresh()
        end)

        return function()
            connection:Disconnect()
        end
    end, {
        var7,
        current,
        refresh,
        sessionListStore
    })
    React.useEffect(function()
        local var23

        if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
            var23 = var12.current ~= var8 or current and not var13.current
            var12.current = var8
            var13.current = current
        else
            var23 = false
        end
        if not current then
            var9(false)
            return
        end

        var9(false)
        refresh():catch(ignorePromiseRejection)
        if FFlagBuildExperienceMyCreationsFindSessionsByUniverse and var23 then
            var21.current():catch(ignorePromiseRejection)
        end
        local var24 = sessionListStore.refresh()
        return Signals.createEffect(function(arg1)
            if var24.state(arg1).status == "succeeded" then
                var9(true)
            end
        end)
    end, {
        current,
        var8,
        refresh,
        sessionListStore
    })

    local num2 = math.max(0, tbl3.pollingIntervalSeconds or FIntMyCreationsSessionListPollingIntervalSeconds)
    React.useEffect(function()
        if not current or num2 == 0 then
            return
        end

        local bool2 = false
        local function scheduleNextPoll() -- Luacid: Inlined by compiler; 1 call site recovered
            task.delay(num2, function()
                if bool2 then
                    return
                end
                if FFlagBuildExperienceMyCreationsFindSessionsByUniverse then
                    var21.current():catch(ignorePromiseRejection)
                end
                sessionListStore.refresh()
                scheduleNextPoll()
            end)
        end

        scheduleNextPoll()

        return function()
            bool2 = true
        end
    end, { current, num2, sessionListStore })

    local items = var20.items
    local items2 = var20.items

    local status = var20.status
    local sourceItemCount = var20.sourceItemCount
    local hasDisplayedResult = status == "Ready" or sourceItemCount > 0
    local bool3 = var17 == "pending"
    local failedLoadMore = var20.failedLoadMore
    local isLoadingMore = var20.isLoadingMore

    local var23 = React.useCallback(function()
        local var23 = sessionListStore.loadMore()
        if var23 == nil then
            return Promise.resolve()
        end
        return requestHandleToPromise(var23)
    end, {
        bool3,
        var15,
        sessionListStatus,
        sessionListStore
    })
    local loadMore = var20.loadMore

    local loadMoreIfNeeded = React.useCallback(function(arg1)
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        if arg1.CanvasPosition.Y <= 0 or absoluteCanvasSizeY <= 0 or arg1.AbsoluteWindowSize.Y <= 0 then
            return
        end

        if not (math.max(0, absoluteCanvasSizeY - arg1.AbsoluteWindowSize.Y - 250) < arg1.CanvasPosition.Y) then
            return
        end

        loadMore()
        if var15 ~= nil and not bool3 and sessionListStatus == "Ready" then
            var23()
        end
    end, {
        bool3,
        var23,
        loadMore,
        var15,
        sessionListStatus
    })

    local query = var20.query
    return {
        displayedItems = items,
        items = items2,
        listStatus = status,
        hasDisplayedResult = hasDisplayedResult,
        hasPendingSummary = false,
        isSettledNoResults = query == var10 and hasDisplayedResult and #items2 == 0,
        query = query,
        sourceItemCount = sourceItemCount,
        sessionCount = #var14,
        sessionListStatus = sessionListStatus,
        hasCompletedFocusedRefresh = hasCompletedFocusedRefresh,
        loadError = loadError,
        refresh = var11,
        loadMoreIfNeeded = loadMoreIfNeeded,
        failedLoadMore = failedLoadMore,
        retryLoadMore = loadMore,
        isLoadingMore = isLoadingMore
    }
end

return useMyCreationsResults
