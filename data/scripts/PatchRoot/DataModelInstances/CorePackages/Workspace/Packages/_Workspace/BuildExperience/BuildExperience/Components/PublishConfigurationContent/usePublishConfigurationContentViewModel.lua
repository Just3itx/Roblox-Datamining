-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local _PublishConfigurationContentView = require(script.Parent.PublishConfigurationContentView)
local ExperienceGuidelines = require(BuildExperienceParent.DataHydration.ExperienceGuidelines)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local ContentMaturityUtils = require(BuildExperience.utils.ContentMaturityUtils)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)
local refreshPublishEligibility = require(BuildExperience.utils.refreshPublishEligibility)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceConfigurationRowTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceConfigurationRowTelemetry)
local sendConfigurationRowClick = require(BuildExperience.Telemetry.sendConfigurationRowClick)

local FFlagMyStatsMediaSelector = SharedFlags.FFlagMyStatsMediaSelector

local function usePublishConfigurationContentViewModel(tbl1)
    local var1 = useLocalization({
        creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB,
        loading = LocalizationStrings.GAME_CONFIGURATION_LOADING,
        questionnaireRequiredBanner = LocalizationStrings.GAME_CONFIGURATION_QUESTIONNAIRE_REQUIRED_BANNER
    })
    local creatorHub = var1.creatorHub
    local loading = var1.loading
    local questionnaireRequiredBanner = var1.questionnaireRequiredBanner
    local var2 = useOpenWebView()
    local var3 = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = tbl1.universeId, isNewGame = tbl1.isNewGame }) else nil
    local experienceGuidelinesStore = ExperienceGuidelines.getExperienceGuidelinesStore()
    local var4 = React.useMemo(function()
        return experienceGuidelinesStore.getAndFetchDetailedGuidelines(tbl1.universeId)
    end, { experienceGuidelinesStore, tbl1.universeId })
    local var5 = SignalsReact.useSignalState(var4.data)

    local var6 = nil

    local universeActivationStore = UniverseActivation.getUniverseActivationStore()
    local var7 = React.useMemo(function()
        return universeActivationStore.getAndFetchEligibility(tbl1.universeId)
    end, { universeActivationStore, tbl1.universeId })
    local var8 = SignalsReact.useSignalState(var7.data)

    local var9 = ContentMaturityUtils.isContentUnrated(tbl1.universeId)
    local var10 = ContentMaturityUtils.isSealBroken(tbl1.universeId)
    local provisionalRating = if var8 then var8.provisionalRating else nil
    local var11 = var9 and not var10
    if var10 and var9 then
        var6 = questionnaireRequiredBanner
    end

    local contentMaturityText = GameConfigurationLabels.getContentMaturityText(var5, provisionalRating, var11) or loading

    local var13 = React.useCallback(function()
        var2(GameConfigurationActions.getCreatorHubConfigureUrl(tbl1.universeId), creatorHub)
    end, { creatorHub, var2, tbl1.universeId })

    local onOpenContentMaturity = React.useCallback(function()
        var2(GameConfigurationActions.getExperienceQuestionnaireUrl(tbl1.universeId), creatorHub, function()
            refreshPublishEligibility(tbl1.universeId)
        end)
    end, { creatorHub, var2, tbl1.universeId })

    local var15 = if FFlagBuildExperienceConfigurationRowTelemetry then React.useCallback(function(str1: string)
        sendConfigurationRowClick(
            "publish",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId,
                sessionId = tbl1.sessionId
            },
            str1
        )
    end, { tbl1.universeId, tbl1.placeId, tbl1.sessionId }) else nil

    local tbl2 = {
        buildMaturityBannerText = var6,
        contentMaturityText = contentMaturityText,
        onOpenIconAndThumbnails = 0,
        onOpenTitleDescriptionPage = 0,
        onOpenContentMaturity = 0,
        onOpenVersionTitleDescriptionPage = 0,
        onOpenVersionHistory = 0,
        onRowActivated = 0,
        isEditDisabled = 0,
        isIconAndThumbnailsDisabled = 0,
        layoutOrder = 0,
        testId = 0
    }

    if FFlagMyStatsMediaSelector then
        var13 = tbl1.onOpenMediaSelectionPage
    end

    tbl2.onOpenIconAndThumbnails = var13

    tbl2.onOpenTitleDescriptionPage = tbl1.onOpenTitleDescriptionPage
    tbl2.onOpenContentMaturity = onOpenContentMaturity
    tbl2.onOpenVersionTitleDescriptionPage = tbl1.onOpenVersionTitleDescriptionPage
    tbl2.onOpenVersionHistory = tbl1.onOpenVersionHistory
    if not FFlagBuildExperienceConfigurationRowTelemetry then
        var15 = nil
    end

    tbl2.onRowActivated = var15
    tbl2.isEditDisabled = FFlagBuildCheckGamePermissions and not var3.canEdit
    tbl2.isIconAndThumbnailsDisabled = FFlagBuildCheckGamePermissions and not (FFlagMyStatsMediaSelector or var3.canViewOnCreatorHub)
    tbl2.layoutOrder = tbl1.layoutOrder
    tbl2.testId = tbl1.testId
    return tbl2
end

return usePublishConfigurationContentViewModel
