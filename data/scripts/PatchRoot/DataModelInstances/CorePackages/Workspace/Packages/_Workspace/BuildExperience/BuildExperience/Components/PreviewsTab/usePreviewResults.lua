-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Players = game:GetService("Players")

local DataHydration = require(BuildExperienceParent.DataHydration)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local CreatorGroups = require(BuildExperienceParent.DataHydration.CreatorGroups)
local UniverseSearch = require(BuildExperienceParent.DataHydration.UniverseSearch)

local GamesFilter = require(BuildExperience.Stores.GetMyCreationsFilterStore.GamesFilter)
local _GetMyCreationsFilterStore = require(BuildExperience.Stores.GetMyCreationsFilterStore)
local thumbForUniverseId = require(BuildExperience.utils.thumbForUniverseId)
local useCursorSearchPages = require(BuildExperience.utils.useCursorSearchPages)

local DataStatus = DataHydration.DataStatus
local useSignalState = SignalsReact.useSignalState

local tbl1 = {
    games = GamesFilter.All
}
local previewGroups = {}
local tbl3 = {}

local function toPreviewItem(arg1)
    return {
        universeId = arg1.id,
        experienceName = arg1.name or "",
        creatorName = if typeof(arg1.creatorName) == "string" and arg1.creatorName ~= "" then arg1.creatorName else nil,
        gameIcon = thumbForUniverseId(arg1.id),
        isGroupGame = arg1.creatorType == "Group"
    }
end

local function createSource(creators)
    local var1 = table.create(#creators)
    for k, creator in creators do
        var1[k] = `{creator.creatorType}:{creator.creatorTargetId}`
    end

    return {
        key = table.concat(var1, ","),
        params = {
            creators = creators,
            surface = "BuildPreview",
            isArchived = false,
            sortParam = "LastUpdated",
            sortOrder = "Desc",
            pageSize = 15
        }
    }
end

local function ignorePromiseRejection() end

local function usePreviewSources(arg1, creatorTargetId: number, arg2)
    local var1 = React.useMemo(function()
        return (arg1.getAndFetchGroups("BuildPreview"))
    end, { arg1 })

    local var2 = useSignalState(var1.data)
    local var3 = useSignalState(var1.status)

    local games = arg2.games
    local groupId = arg2.groupId

    return (React.useMemo(function()
        if var2 == nil and games ~= GamesFilter.SharedGames then
            return {
                sources = nil,
                previewGroups = previewGroups,
                status = if var3 == DataStatus.Failed then DataStatus.Failed else DataStatus.NotReady
            }
        end

        local var4 = if var2 ~= nil then var2.groups else previewGroups
        local bool1 = false
        for _, value in var4 do
            bool1 = bool1 or value.id == groupId
        end

        local sources = {}
        if games ~= GamesFilter.SharedGames then
            local tbl5 = {}
            for _, value in var4 do
                if not bool1 or games ~= GamesFilter.GroupGames or value.id == groupId then
                    table.insert(tbl5, { creatorType = "Group", creatorTargetId = value.id })
                end
            end

            if #tbl5 > 0 then
                table.insert(sources, (createSource(tbl5)))
            end
        end

        if games ~= GamesFilter.GroupGames then
            table.insert(sources, (createSource({{ creatorType = "Team", creatorTargetId = creatorTargetId }})))
        end

        return {
            sources = sources,
            previewGroups = var4,
            status = DataStatus.Ready
        }
    end, {
        games,
        groupId,
        var2,
        var3,
        creatorTargetId
    }))
end

local function usePreviewResults(tbl4)
    local searchStore = tbl4.searchStore or UniverseSearch.getUniverseSearchStore()
    local creatorGroupsStore = tbl4.creatorGroupsStore or CreatorGroups.getCreatorGroupsStore()
    local var2 = tbl4.userId or (if Players.LocalPlayer then Players.LocalPlayer.UserId else 0)
    local current = tbl4.isFocused ~= false

    local var3 = tbl4.filter or tbl1
    local var4 = usePreviewSources(creatorGroupsStore, var2, var3)
    local var5 = useCursorSearchPages({ searchStore = searchStore, sources = var4.sources })

    local refresh = var5.refresh
    local games = var3.games
    local var1 = React.useCallback(function()
        if games ~= GamesFilter.SharedGames then
            creatorGroupsStore.fetchGroups("BuildPreview")
        end
        return refresh()
    end, { creatorGroupsStore, games, refresh })

    local var7 = React.useRef(false)
    React.useEffect(function()
        local current2 = var7.current
        var7.current = current
        if current and not current2 then
            var1():catch(ignorePromiseRejection)
        end
    end, { current, var1 })

    local items = React.useMemo(function()
        if #var5.items == 0 then
            return tbl3
        end

        local var8 = table.create(#var5.items)
        for _, item in var5.items do
            table.insert(var8, (toPreviewItem(item)))
        end
        return var8
    end, { var5.items })

    return {
        items = items,
        status = if var4.sources == nil then var4.status else var5.status,
        hasPreviews = #items > 0,
        previewGroups = var4.previewGroups,
        isLoadingMore = var5.isLoadingMore,
        failedLoadMore = var5.failedLoadMore,
        refresh = var1,
        loadMore = var5.loadMore
    }
end

return usePreviewResults
