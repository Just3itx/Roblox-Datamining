-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DataHydration = require(BuildExperienceParent.DataHydration)
local React = require(BuildExperienceParent.React)

local PublishBottomSheetContainer = require(script.Parent.PublishBottomSheetContainer)
local VersionHistoryContainer = require(BuildExperience.Components.VersionHistory.VersionHistoryContainer)
local BuildOverflowMenuScreens = require(BuildExperience.Components.BuildPillMenu.BuildOverflowMenuScreens)
local GameInfoUtils = require(BuildExperience.utils.GameInfoUtils)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)

local Screens = BuildOverflowMenuScreens.Screens

local function resolvePlaceId(target, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if target.placeId ~= nil then
        return target.placeId
    end
    if not GameInfoUtils.isGameInfoReady(arg1) then
        return nil
    end

    return tonumber(arg1.rootPlaceId)
end

local function PublishSheetController(tbl1)
    local var1, var2 = React.useState(false)
    local navigateToSubPage = tbl1.navigateToSubPage
    local onClose = tbl1.onClose
    local target = tbl1.target

    local gameInfo = GameInfoUtils.useGameInfo(target.universeId)
    local placeId = resolvePlaceId(target, gameInfo)

    local var3 = React.useMemo(function()
        return {
            universeId = target.universeId,
            placeId = placeId,
            sessionId = target.sessionId,
            experienceName = target.experienceName,
            gameIcon = target.gameIcon,
            isNewGameTarget = target.isNewGameTarget
        }
    end, {
        target.universeId,
        placeId,
        target.sessionId,
        target.experienceName,
        target.gameIcon,
        target.isNewGameTarget
    })

    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression("publish", var3, tbl1.isOpen)
        useBuildPageImpression("version-history", var3, var1 and placeId ~= nil)
    end

    local var6 = GameInfoUtils.isTitleDescriptionReady(gameInfo)
    local onOpenTitleDescriptionPage = React.useCallback(function()
        if not var6 then
            return
        end
        onClose()
        navigateToSubPage(Screens.BuildTitleDescription, var3)
    end, {
        onClose,
        navigateToSubPage,
        var6,
        var3
    })
    local onOpenMediaSelectionPage = React.useCallback(function()
        onClose()
        navigateToSubPage(Screens.BuildMediaSelection, var3)
    end, { onClose, navigateToSubPage, var3 })

    local onOpenVersionTitleDescriptionPage = React.useCallback(function()
        if placeId == nil then
            return
        end
        onClose()
        navigateToSubPage(Screens.BuildVersionTitleDescription, var3)
    end, {
        onClose,
        navigateToSubPage,
        placeId,
        var3
    })
    local onOpenVersionHistory = React.useCallback(function()
        if placeId == nil then
            return
        end
        onClose()
        var2(true)
    end, { onClose, placeId })

    local var4 = React.useCallback(function()
        var2(false)
    end, {})

    return React.createElement(React.Fragment, nil, {
        PublishSheet = if tbl1.isOpen then React.createElement(PublishBottomSheetContainer, {
            isOpen = true,
            target = var3,
            gameInfo = gameInfo,
            onClose = onClose,
            onOpenTitleDescriptionPage = onOpenTitleDescriptionPage,
            onOpenMediaSelectionPage = onOpenMediaSelectionPage,
            onOpenVersionTitleDescriptionPage = onOpenVersionTitleDescriptionPage,
            onOpenVersionHistory = onOpenVersionHistory,
            showPreviewButton = tbl1.showPreviewButton
        }) else nil,
        VersionHistory = if var1 and placeId ~= nil then React.createElement(
            VersionHistoryContainer,
            {
                placeId = placeId,
                isOpen = true,
                onClose = var4,
                testId = "build-publish-version-history"
            }
        ) else nil
    })
end

return PublishSheetController
