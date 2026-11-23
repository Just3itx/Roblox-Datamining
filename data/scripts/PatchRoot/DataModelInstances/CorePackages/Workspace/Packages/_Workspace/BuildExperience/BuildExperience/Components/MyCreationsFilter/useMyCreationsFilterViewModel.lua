-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorGroups = require(BuildExperienceParent.DataHydration.CreatorGroups)
local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = Localization.Hooks.useLocalization
local useSignalState = SignalsReact.useSignalState
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceFiltersSaveLabel = require(BuildExperience.Flags.FFlagBuildExperienceFiltersSaveLabel)
local FFlagBuildExperiencePreviewsTab = require(BuildExperience.Flags.FFlagBuildExperiencePreviewsTab)
local GamesFilter = require(BuildExperience.Stores.GetMyCreationsFilterStore.GamesFilter)
local GetMyCreationsFilterStore = require(BuildExperience.Stores.GetMyCreationsFilterStore)
local matchesSearchQuery = require(BuildExperience.utils.matchesSearchQuery)
local useClosableFocusRoot = require(BuildExperience.utils.useClosableFocusRoot)
local _MyCreationsFilterView = require(script.Parent.MyCreationsFilterView)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local tbl1 = { games = "MyGames" }
local tbl2 = {
    "All",
    "MyGames",
    "GroupGames",
    "SharedGames"
}
local function getGroupIcon(id: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("rbxthumb://type=GroupIcon&id=%d&w=150&h=150", id)
end

local function useMyCreationsFilterViewModel(tbl3)
    local var1 = tbl3.filterStore or GetMyCreationsFilterStore()
    local var2 = var1.useFilter()
    local creatorGroupsStore = tbl3.creatorGroupsStore or CreatorGroups.getCreatorGroupsStore()
    local var3 = React.useMemo(function()
        return (creatorGroupsStore.getAndFetchGroups("Build"))
    end, { creatorGroupsStore })
    local var4 = useSignalState(var3.data)
    local groups = if var4 ~= nil then var4.groups else nil
    local tbl4 = tbl1
    local tbl5 = tbl2
    if FFlagBuildExperiencePreviewsTab then
        groups = tbl3.groups or groups
        tbl4 = tbl3.defaultFilter or tbl4
        tbl5 = tbl3.options or tbl5
    end
    local tbl6 = {
        all = LocalizationStrings.MY_CREATIONS_FILTER_ALL,
        allGames = LocalizationStrings.MY_CREATIONS_FILTER_ALL_GAMES,
        apply = if FFlagBuildExperienceFiltersSaveLabel then LocalizationStrings.MY_CREATIONS_FILTER_SAVE else LocalizationStrings.MY_CREATIONS_FILTER_APPLY,
        games = LocalizationStrings.MY_CREATIONS_FILTER_GAMES,
        groupGames = LocalizationStrings.MY_CREATIONS_FILTER_GROUP_GAMES,
        groups = LocalizationStrings.MY_CREATIONS_FILTER_GROUPS,
        myGames = LocalizationStrings.MY_CREATIONS_FILTER_MY_GAMES,
        reset = LocalizationStrings.MY_CREATIONS_FILTER_RESET,
        searchGroups = LocalizationStrings.MY_CREATIONS_FILTER_SEARCH_GROUPS,
        sharedGames = LocalizationStrings.MY_CREATIONS_FILTER_SHARED_GAMES,
        title = LocalizationStrings.MY_CREATIONS_FILTER_TITLE
    }
    local var5 = useLocalization(tbl6)
    local all = var5.all
    local allGames = var5.allGames
    local groupGames = var5.groupGames
    local myGames = var5.myGames
    local sharedGames = var5.sharedGames

    local var6, var7 = React.useState(var2)
    local groupSearchText, onGroupSearchTextChanged = React.useState("")
    local var10, var11 = React.useState(false)

    local onOpenSheet = React.useCallback(function()
        var7(var1.getFilter())
        onGroupSearchTextChanged("")
        var11(true)
    end, { var1 })

    local var13 = React.useCallback(function()
        var11(false)
    end, {})

    local focusRootRef = useClosableFocusRoot({ surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp, isOpen = var10, onClose = var13 })

    local onGamesChanged = React.useCallback(function(games: string)
        if not table.find(tbl5, games) then
            return
        end

        var7(function(arg1)
            return {
                games = games,
                groupId = if games == "GroupGames" then arg1.groupId else nil
            }
        end)
    end, { tbl5 })

    local var16 = React.useCallback(function(groupId: number)
        var7(function(arg1)
            return {
                games = "GroupGames",
                groupId = if arg1.groupId == groupId then nil else groupId
            }
        end)
    end, {})

    local onApply = React.useCallback(function()
        var1.setFilter(var6)
        var11(false)
    end, { var6, var1 })

    local onReset = React.useCallback(function()
        var7(tbl4)
        onGroupSearchTextChanged("")
    end, { tbl4 })

    local bool1 = groups == nil or #groups == 0

    local gamesOptions = React.useMemo(function()
        if FFlagBuildExperiencePreviewsTab then
            local tbl7 = {
                [GamesFilter.All] = all,
                [GamesFilter.MyGames] = myGames,
                [GamesFilter.GroupGames] = groupGames,
                [GamesFilter.SharedGames] = sharedGames
            }
            local result = {}
            for _, value in tbl5 do
                if not bool1 or value ~= GamesFilter.GroupGames then
                    table.insert(result, { value = value, label = tbl7[value] })
                end
            end

            return result
        end

        local tbl7 = {
            { value = "All", label = all },
            { value = "MyGames", label = myGames }
        }

        if not bool1 then
            table.insert(tbl7, { value = "GroupGames", label = groupGames })
        end
        table.insert(tbl7, { value = "SharedGames", label = sharedGames })
        return tbl7
    end, {
        all,
        groupGames,
        bool1,
        myGames,
        sharedGames,
        tbl5
    })
    local groupId = var6.groupId
    local var8 = React.useMemo(function()
        local result = {}
        if groups == nil then
            return result
        end
        for _, group in groups do
            if not matchesSearchQuery(group.name, groupSearchText) then
                continue
            end

            local tbl7 = {
                id = group.id,
                name = group.name,
                icon = getGroupIcon(group.id),
                isSelected = group.id == groupId,
                onActivated = 0
            }

            function tbl7.onActivated()
                var16(group.id)
            end

            table.insert(result, tbl7)
        end

        return result
    end, {
        groupSearchText,
        groups,
        var16,
        groupId
    })
    local name = nil
    if var2.games == "GroupGames" and var2.groupId ~= nil and groups ~= nil then
        for _, group in groups do
            if group.id == var2.groupId then
                name = group.name
                break
            end
        end
    end

    if name ~= nil then
        allGames = name
    elseif var2.games == "MyGames" then
        allGames = myGames
    elseif var2.games == "GroupGames" then
        allGames = groupGames
    elseif var2.games == "SharedGames" then
        allGames = sharedGames
    end

    return {
        LayoutOrder = tbl3.LayoutOrder,
        label = allGames,
        onOpenSheet = onOpenSheet,
        isSheetOpen = var10,
        onSheetClosed = var13,
        focusRootRef = focusRootRef,
        titleText = var5.title,
        gamesLegend = var5.games,
        gamesOptions = gamesOptions,
        selectedGames = var6.games,
        onGamesChanged = onGamesChanged,
        isGroupsVisible = var6.games == "GroupGames" and groups ~= nil and #groups > 0,
        groupsLegend = var5.groups,
        groupSearchText = groupSearchText,
        groupSearchPlaceholder = var5.searchGroups,
        onGroupSearchTextChanged = onGroupSearchTextChanged,
        groups = var8,
        applyText = var5.apply,
        resetText = var5.reset,
        onApply = onApply,
        onReset = onReset,
        testId = tbl3.testId
    }
end

return useMyCreationsFilterViewModel
