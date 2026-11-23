-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DataHydration = require(BuildExperienceParent.DataHydration)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local PublishBottomSheet = require(script.Parent.PublishBottomSheet)
local GameInfoUtils = require(BuildExperience.utils.GameInfoUtils)

local function getEnrichedTarget(target, gameInfo, creatorName: string)
    local var1 = if GameInfoUtils.isGameInfoReady(gameInfo) then gameInfo else nil
    local creator = if var1 then var1.creator else nil
    local tbl1 = {
        universeId = target.universeId,
        placeId = 0,
        sessionId = 0,
        experienceName = 0,
        creatorName = 0,
        gameIcon = 0,
        isCreatorVerified = 0,
        isNewGameTarget = 0
    }
    local placeId = target.placeId

    if not placeId then
        if var1 then
            placeId = tonumber(var1.rootPlaceId)
        else
            placeId = nil
        end
    end

    tbl1.placeId = placeId
    tbl1.sessionId = target.sessionId
    tbl1.experienceName = GameInfoUtils.getGameInfoName(gameInfo)
    if creator and creator.name ~= "" then
        creatorName = creator.name
    end

    tbl1.creatorName = creatorName
    tbl1.gameIcon = target.gameIcon
    tbl1.isCreatorVerified = if creator then creator.hasVerifiedBadge == true else false
    tbl1.isNewGameTarget = target.isNewGameTarget
    return tbl1
end

local function PublishBottomSheetContainer(tbl1)
    local loading = useLocalization({ loading = LocalizationStrings.BUILD_MENU_LOADING }).loading
    local target = getEnrichedTarget(tbl1.target, tbl1.gameInfo, loading)

    return React.createElement(PublishBottomSheet, {
        isOpen = tbl1.isOpen,
        target = target,
        onClose = tbl1.onClose,
        onOpenTitleDescriptionPage = tbl1.onOpenTitleDescriptionPage,
        onOpenMediaSelectionPage = tbl1.onOpenMediaSelectionPage,
        onOpenVersionTitleDescriptionPage = tbl1.onOpenVersionTitleDescriptionPage,
        onOpenVersionHistory = tbl1.onOpenVersionHistory,
        showPreviewButton = tbl1.showPreviewButton,
        testId = tbl1.testId
    })
end

return PublishBottomSheetContainer
