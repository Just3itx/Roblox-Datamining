-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local useLocalization = Localization.Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local _DataHydration = require(BuildExperienceParent.DataHydration)
local ExperienceGuidelines = require(BuildExperienceParent.DataHydration.ExperienceGuidelines)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)
local ArchiveGameDialog = require(BuildExperience.Components.GameConfigurations.ArchiveGameDialog)
local ExperienceShareOverlays = require(BuildExperience.Components.ShareAudience.ExperienceShareOverlays)
local BuildMaturityBanner = require(BuildExperience.Components.GameConfigurations.BuildMaturityBanner.BuildMaturityBanner)
local ContentMaturityUtils = require(BuildExperience.utils.ContentMaturityUtils)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local refreshPublishEligibility = require(BuildExperience.utils.refreshPublishEligibility)
local useArchiveGameFlow = require(BuildExperience.utils.useArchiveGameFlow)
local useExperienceShareFlow = require(BuildExperience.utils.useExperienceShareFlow)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local GameConfigurationList = require(script.Parent.Parent.GameConfigurationList.GameConfigurationList)
local getPrivatePlaytestersStore = require(BuildExperienceParent.DataHydration.PrivatePlaytesters).getPrivatePlaytestersStore
local FFlagBuildExperiencePrivateInvites = require(BuildExperience.Flags.FFlagBuildExperiencePrivateInvites)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceConfigurationRowTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceConfigurationRowTelemetry)
local sendConfigurationRowClick = require(BuildExperience.Telemetry.sendConfigurationRowClick)

local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName

local engineFeature = SharedFlags.FFlagMyStatsMediaSelector
    and CaptureService.PromptCaptureGalleryPermissionAsync
    and game:GetEngineFeature("CaptureServiceStartUploadCoreScriptBypass")

local PrivacyType = UniverseConfiguration.PrivacyType

local signal = Signals.createSignal(nil)

local function GameConfigurationContent(tbl1)
    local testId = tbl1.testId or "game-configuration-content"
    local var1 = useLocalization({
        access = LocalizationStrings.GAME_CONFIGURATION_ACCESS,
        accessAndSharing = LocalizationStrings.GAME_CONFIGURATION_ACCESS_AND_SHARING,
        accessBody = LocalizationStrings.GAME_CONFIGURATION_ACCESS_BODY,
        archiveGame = LocalizationStrings.GAME_CONFIGURATION_ARCHIVE_GAME,
        audience = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE,
        contentRating = LocalizationStrings.GAME_CONFIGURATION_CONTENT_RATING,
        creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB,
        creatorHubDescription = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB_DESCRIPTION,
        gameConfiguration = LocalizationStrings.GAME_CONFIGURATION_GAME_CONFIGURATION,
        gameConfigurationBody = LocalizationStrings.GAME_CONFIGURATION_GAME_CONFIGURATION_BODY,
        salesOptions = LocalizationStrings.GAME_CONFIGURATION_SALES_OPTIONS,
        friendsOnlyAudience = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_FRIENDS_ONLY,
        gameDetails = LocalizationStrings.GAME_CONFIGURATION_GAME_DETAILS,
        gameDetailsBody = LocalizationStrings.GAME_CONFIGURATION_GAME_DETAILS_BODY,
        iconAndThumbnails = LocalizationStrings.GAME_CONFIGURATION_ICON_AND_THUMBNAILS,
        loading = LocalizationStrings.GAME_CONFIGURATION_LOADING,
        privateAudience = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PRIVATE,
        privateInvitesRowDescription = LocalizationStrings.PRIVATE_INVITES_ROW_DESCRIPTION,
        privateInvitesRowLoadError = LocalizationStrings.PRIVATE_INVITES_ROW_LOAD_ERROR,
        privateInvitesRowTitle = LocalizationStrings.PRIVATE_INVITES_ROW_TITLE,
        privateInvitesRowTitleEmpty = LocalizationStrings.PRIVATE_INVITES_ROW_TITLE_EMPTY,
        privateInvitesShareLink = LocalizationStrings.PRIVATE_INVITES_SHARE_LINK,
        publicAudience = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PUBLIC,
        questionnaireRequiredBanner = LocalizationStrings.GAME_CONFIGURATION_QUESTIONNAIRE_REQUIRED_BANNER,
        titleAndDescription = LocalizationStrings.GAME_CONFIGURATION_TITLE_AND_DESCRIPTION,
        unknownAudience = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_UNKNOWN
    })
    local var2 = React.useContext(Localization.LocalizationRoactContext)
    local access = var1.access
    local accessAndSharing = var1.accessAndSharing
    local accessBody = var1.accessBody
    local archiveGame = var1.archiveGame
    local audience = var1.audience
    local contentRating = var1.contentRating
    local creatorHub = var1.creatorHub
    local creatorHubDescription = var1.creatorHubDescription
    local friendsOnlyAudience = var1.friendsOnlyAudience
    local gameDetails = var1.gameDetails
    local gameDetailsBody = var1.gameDetailsBody
    local iconAndThumbnails = var1.iconAndThumbnails
    local loading = var1.loading
    local privateAudience = var1.privateAudience
    local privateInvitesRowDescription = var1.privateInvitesRowDescription
    local privateInvitesRowLoadError = var1.privateInvitesRowLoadError
    local privateInvitesRowTitle = var1.privateInvitesRowTitle
    local privateInvitesRowTitleEmpty = var1.privateInvitesRowTitleEmpty
    local privateInvitesShareLink = var1.privateInvitesShareLink
    local publicAudience = var1.publicAudience
    local questionnaireRequiredBanner = var1.questionnaireRequiredBanner
    local titleAndDescription = var1.titleAndDescription
    local unknownAudience = var1.unknownAudience
    local var3 = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = tbl1.universeId, isNewGame = tbl1.isNewGame }) else nil
    local var4 = not FFlagBuildCheckGamePermissions or var3.canPublish
    local var5 = not FFlagBuildCheckGamePermissions or var3.canMonetize
    local var6 = not FFlagBuildCheckGamePermissions or var3.canViewOnCreatorHub
    local var7 = useOpenWebView()
    local var8 = useArchiveGameFlow({ context = "settings" })
    local var9 = if FFlagBuildExperiencePrivateInvites then useExperienceShareFlow(tbl1.universeId, tbl1.placeId) else nil
    local onShare = if var9 == nil then nil else var9.onShare

    local var10 = React.useMemo(function()
        return UniverseConfiguration.getUniverseConfigurationStore().getAndFetchConfiguration(tbl1.universeId)
    end, { tbl1.universeId })

    local var11 = React.useMemo(function()
        if not FFlagBuildExperiencePrivateInvites then
            return nil
        end
        return UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(tbl1.universeId)
    end, { tbl1.universeId })
    local var12 = React.useMemo(function()
        return ExperienceGuidelines.getExperienceGuidelinesStore().getAndFetchDetailedGuidelines(tbl1.universeId)
    end, { tbl1.universeId })
    local var13 = SignalsReact.useSignalState(var10.data)

    local var14 = SignalsReact.useSignalState(if var11 ~= nil then var11.data else signal)
    local var15 = SignalsReact.useSignalState(var12.data)
    local bool1 = not (var14 == nil) and var14.creatorType == "Group"
    local audience2 = if var13 then GameConfigurationLabels.getAudience(var13) else nil
    local description = if var13 == nil then loading elseif audience2 == PrivacyType.Private then privateAudience elseif audience2 == PrivacyType.Public then publicAudience elseif audience2 == PrivacyType.FriendsOnly then friendsOnlyAudience else GameConfigurationLabels.getAudienceText(var13) or unknownAudience
    local var17 = nil
    local var18 = React.useMemo(function()
        return UniverseActivation.getUniverseActivationStore().getAndFetchEligibility(tbl1.universeId)
    end, { tbl1.universeId })
    local var19 = SignalsReact.useSignalState(var18.data)
    local var20 = React.useMemo(function()
        return ContentMaturityUtils.isSealBroken(tbl1.universeId)
    end, { var19, tbl1.universeId })
    local var21 = React.useMemo(function()
        return ContentMaturityUtils.isContentUnrated(tbl1.universeId)
    end, { var19, tbl1.universeId })

    local provisionalRating = if var19 then var19.provisionalRating else nil
    local var22 = var21 and not var20
    if var20 and var21 then
        var17 = questionnaireRequiredBanner
    end

    local var16 = GameConfigurationLabels.getContentMaturityText(var15, provisionalRating, var22) or loading

    local onActivated = React.useCallback(function()
        var7(GameConfigurationActions.getCreatorHubConfigureUrl(tbl1.universeId), creatorHub)
    end, { creatorHub, var7, tbl1.universeId })

    local var23 = React.useCallback(function()
        var7(GameConfigurationActions.getExperienceQuestionnaireUrl(tbl1.universeId), creatorHub, function()
            refreshPublishEligibility(tbl1.universeId)
        end)
    end, { creatorHub, var7, tbl1.universeId })

    local rows = React.useMemo(function()
        return {
            {
                id = "icon-thumbnails",
                title = iconAndThumbnails,
                trailingIcon = if engineFeature then nil else IconName.ArrowUpRightFromSquare,
                onActivated = if engineFeature then tbl1.onOpenMediaSelectionPage else onActivated,
                isDisabled = not (engineFeature or var6)
            },
            {
                id = "title-description",
                title = titleAndDescription,
                description = tbl1.experienceName,
                trailingIcon = nil,
                onActivated = tbl1.onOpenTitleDescriptionPage
            }
        }
    end, {
        var6,
        onActivated,
        tbl1.experienceName,
        tbl1.onOpenMediaSelectionPage,
        tbl1.onOpenTitleDescriptionPage,
        iconAndThumbnails,
        titleAndDescription
    })

    local onOpenPlaytestPicker = tbl1.onOpenPlaytestPicker
    local onOpenPlaytestManagement = tbl1.onOpenPlaytestManagement
    local var27 = FFlagBuildExperiencePrivateInvites

    if var27 then
        if onOpenPlaytestPicker == nil or onOpenPlaytestManagement == nil then
            var27 = false
        else
            var27 = not bool1
        end
    end

    local var28 = React.useMemo(function()
        if not var27 then
            return nil
        end
        return getPrivatePlaytestersStore(false).getAndFetchInvitedPlayers(tbl1.universeId)
    end, { var27, tbl1.universeId })

    local var29 = React.useMemo(function()
        return Signals.createComputed(function(arg1): number
            if var28 == nil then
                return 0
            end

            return #var28.players(arg1)
        end)
    end, { var28 })
    local invitedCount = SignalsReact.useSignalState(var29)

    local var31 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var28 ~= nil then
                return (var28.status(arg1))
            end

            return "NotReady"
        end)
    end, { var28 })
    local var32 = SignalsReact.useSignalState(var31)

    local maxInvites = getPrivatePlaytestersStore(false).MAX_INVITES

    local var33 = nil
    if var27 then
        if var32 == "Ready" then
            local var24 = if invitedCount > 0 then var2:Format(LocalizationStrings.PRIVATE_INVITES_SENT, { INVITED_COUNT = invitedCount, MAX_INVITES = maxInvites }) else nil
            var33 = invitedCount > 0
                and {
                    id = "playtest",
                    title = privateInvitesRowTitle,
                    description = var24,
                    trailingIcon = nil,
                    onActivated = onOpenPlaytestManagement
                }
                or {
                    id = "playtest",
                    title = privateInvitesRowTitleEmpty,
                    description = privateInvitesRowDescription,
                    trailingIcon = nil,
                    onActivated = onOpenPlaytestPicker
                }
        else
            local tbl2 = {
                id = "playtest",
                title = privateInvitesRowTitle,
                description = 0,
                trailingIcon = nil,
                onActivated = nil
            }

            if var32 == "Failed" then
                loading = privateInvitesRowLoadError
            end

            tbl2.description = loading
            var33 = tbl2
        end
    end

    local var24 = React.useMemo(function()
        local tbl2 = {{
            id = "audience",
            title = audience,
            description = description,
            trailingIcon = nil,
            onActivated = tbl1.onOpenAudiencePage,
            isDisabled = not var4
        }}

        if var33 ~= nil then
            table.insert(tbl2, var33)

            table.insert(
                tbl2,
                {
                    id = "playtest-share-link",
                    title = privateInvitesShareLink,
                    trailingIcon = nil,
                    onActivated = onShare
                }
            )
        end

        table.insert(tbl2, {
            id = "content-rating",
            title = contentRating,
            description = var16,
            trailingIcon = IconName.ArrowUpRightFromSquare,
            onActivated = var23
        })
        return tbl2
    end, {
        description,
        var4,
        var16,
        var23,
        var33,
        onShare,
        tbl1.onOpenAudiencePage,
        audience,
        contentRating,
        privateInvitesShareLink
    })

    local var25 = React.useMemo(function()
        return {{
            id = "creator-hub",
            title = creatorHub,
            description = creatorHubDescription,
            trailingIcon = IconName.ArrowUpRightFromSquare,
            onActivated = onActivated,
            isDisabled = not var6
        }}
    end, {
        var6,
        creatorHub,
        creatorHubDescription,
        onActivated
    })
    local tbl2 = {}
    if FFlagBuildExperienceMonetizationNativeUI then
        table.insert(
            tbl2,
            {
                id = "sales-options",
                title = var1.salesOptions,
                onActivated = tbl1.onOpenMonetizationPage,
                isDisabled = not var5
            }
        )
    end

    local var36 = FFlagBuildExperienceMonetizationNativeUI

    local onRowActivated = if FFlagBuildExperienceConfigurationRowTelemetry then React.useCallback(function(str1: string)
        sendConfigurationRowClick(
            "settings",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId,
                sessionId = tbl1.sessionId
            },
            str1
        )
    end, { tbl1.universeId, tbl1.placeId, tbl1.sessionId }) else nil

    local var26 = React.useCallback(function()
        if FFlagBuildExperienceConfigurationRowTelemetry and onRowActivated ~= nil then
            onRowActivated("archive-game")
        end
        var8.requestArchive(tbl1.universeId)
    end, { var8.requestArchive, tbl1.universeId, onRowActivated })

    local createElement = React.createElement
    local var39 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-xlarge size-full-0 auto-y padding-y-large",
        testId = testId
    }
    local tbl4 = {
        GameDetails = React.createElement(GameConfigurationList, {
            layoutOrder = 1,
            title = gameDetails,
            body = gameDetailsBody,
            rows = rows,
            onRowActivated = onRowActivated,
            testId = `{testId}-game-details`
        }),
        Access = 0,
        GameConfiguration = 0,
        CreatorHub = 0,
        ArchiveGame = 0,
        ArchiveDialog = 0,
        ShareOverlays = 0
    }
    local createElement2 = React.createElement
    local var40 = View
    local tbl5 = { LayoutOrder = 2, tag = "col gap-medium size-full-0 auto-y" }

    local tbl6 = { Configuration = 0, BuildMaturityBanner = 0 }
    local createElement3 = React.createElement
    local var41 = GameConfigurationList
    local tbl7 = { layoutOrder = 1, title = 0, body = 0, rows = 0, onRowActivated = 0, testId = 0 }

    if var27 then
        access = accessAndSharing
    end

    tbl7.title = access
    tbl7.body = accessBody
    tbl7.rows = var24
    tbl7.onRowActivated = onRowActivated
    tbl7.testId = `{testId}-access`
    tbl6.Configuration = createElement3(var41, tbl7)

    tbl6.BuildMaturityBanner = if var17 == nil then nil else React.createElement(BuildMaturityBanner, { text = var17 })
    tbl4.Access = createElement2(var40, tbl5, tbl6)

    tbl4.GameConfiguration = if var36 then React.createElement(GameConfigurationList, {
        layoutOrder = 3,
        title = var1.gameConfiguration,
        body = var1.gameConfigurationBody,
        rows = tbl2,
        onRowActivated = onRowActivated,
        testId = `{testId}-game-configuration`
    }) else nil

    tbl4.CreatorHub = React.createElement(GameConfigurationList, {
        layoutOrder = if var36 then 4 else 3,
        title = creatorHub,
        rows = var25,
        onRowActivated = onRowActivated,
        testId = `{testId}-creator-hub`
    })
    tbl4.ArchiveGame = React.createElement(View, {
        LayoutOrder = if var36 then 5 else 4,
        onActivated = var26,
        stateLayer = {},
        tag = "row align-y-center size-full-0 auto-y padding-large stroke-standard stroke-default radius-large bg-surface-0",
        testId = `{testId}-archive-game`
    }, {
        Label = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = archiveGame,
                tag = "fill auto-y text-title-medium text-align-x-left content-default"
            }
        )
    })
    tbl4.ArchiveDialog = React.createElement(ArchiveGameDialog, { isOpen = var8.isOpen, onArchive = var8.confirm, onCancel = var8.cancel })

    tbl4.ShareOverlays = if FFlagBuildExperiencePrivateInvites and var9 ~= nil then React.createElement(
        ExperienceShareOverlays,
        {
            activeDialog = var9.activeDialog,
            hasShareError = var9.hasShareError,
            onCancel = var9.onCancelDialog,
            onConfirmFriends = var9.onConfirmFriends,
            onConfirmPlaytesters = var9.onConfirmPlaytesters
        }
    ) else nil
    return createElement(var39, tbl3, tbl4)
end

return GameConfigurationContent
