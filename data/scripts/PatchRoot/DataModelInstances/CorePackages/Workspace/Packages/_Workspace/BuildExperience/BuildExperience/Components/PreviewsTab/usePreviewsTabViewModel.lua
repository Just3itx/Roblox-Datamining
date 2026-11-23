-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local GameDetail = require(BuildExperienceParent.GameDetail)
local Localization = require(BuildExperienceParent.Localization)
local Navigation = require(BuildExperienceParent.Navigation)
local React = require(BuildExperienceParent.React)
local useStore = require(BuildExperienceParent.RoactUtils).Hooks.RoactRodux.useStore

local descriptionWithGroupIcon = require(BuildExperience.utils.descriptionWithGroupIcon)
local getGameDetailsNavigation = require(BuildExperience.utils.getGameDetailsNavigation)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _PreviewsTabView = require(script.Parent.PreviewsTabView)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local _usePreviewResults = require(script.Parent.usePreviewResults)

local OpenGameDetails = GameDetail.OpenGameDetails
local getRootNavigation = Navigation.getRootNavigation
local useLocalization = Localization.Hooks.useLocalization
local useNavigation = Navigation.useNavigation

local function usePreviewsTabViewModel(tbl1)
    local var1 = useNavigation()
    local var2 = useStore()
    local var3 = useLocalization(
        {
            loadError = LocalizationStrings.MY_CREATIONS_LOAD_ERROR,
            noGames = LocalizationStrings.MY_CREATIONS_NO_GAMES
        }
    )
    local results = tbl1.results
    local loadMore = results.loadMore

    local var4 = React.useCallback(function(universeId: number)
        sendBuildExperienceEvent("PREVIEW_CLICK", { universeId = universeId }, { context = "BuildPreviews" })

        OpenGameDetails(tostring(universeId), getGameDetailsNavigation(getRootNavigation(var1)), { source = "BuildPreviews" })(
            var2
        )
    end, { var1, var2 })

    local rows = React.useMemo(function()
        local var5 = table.create(#results.items)
        for _, item in results.items do
            local tbl2 = {
                universeId = item.universeId,
                title = item.experienceName,
                description = if item.isGroupGame then descriptionWithGroupIcon(nil, true, item.creatorName) else item.creatorName,
                gameIcon = item.gameIcon,
                onActivated = 0
            }

            function tbl2.onActivated()
                var4(item.universeId)
            end

            table.insert(var5, tbl2)
        end

        return var5
    end, { var4, results.items })

    local loadMoreIfNeeded = React.useCallback(function(arg1)
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        if arg1.CanvasPosition.Y <= 0 or absoluteCanvasSizeY <= 0 or arg1.AbsoluteWindowSize.Y <= 0 then
            return
        end

        if math.max(0, absoluteCanvasSizeY - arg1.AbsoluteWindowSize.Y - 250) < arg1.CanvasPosition.Y then
            loadMore()
        end
    end, { loadMore })

    return {
        rows = rows,
        listStatus = results.status,
        loadError = var3.loadError,
        isLoadingMore = results.isLoadingMore,
        failedLoadMore = results.failedLoadMore,
        refresh = results.refresh,
        loadMoreIfNeeded = loadMoreIfNeeded,
        retryLoadMore = loadMore,
        emptyText = var3.noGames
    }
end

return usePreviewsTabViewModel
