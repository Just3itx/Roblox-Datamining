-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Foundation = require(BuildExperienceParent.Foundation)
local GameDetail = require(BuildExperienceParent.GameDetail)
local Navigation = require(BuildExperienceParent.Navigation)
local React = require(BuildExperienceParent.React)
local Responsive = require(BuildExperienceParent.Responsive)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local ExperienceGuidelines = require(BuildExperienceParent.DataHydration.ExperienceGuidelines)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FIntBuildPostPublishSnackbarAutoDismissSeconds = require(BuildExperience.Flags.FIntBuildPostPublishSnackbarAutoDismissSeconds)
local FriendsOnlyShareDialog = require(BuildExperience.Components.ShareAudience.FriendsOnlyShareDialog)
local ContentMaturityUtils = require(BuildExperience.utils.ContentMaturityUtils)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)
local getGameDetailsNavigation = require(BuildExperience.utils.getGameDetailsNavigation)
local refreshPublishEligibility = require(BuildExperience.utils.refreshPublishEligibility)
local useClosableFocusRoot = require(BuildExperience.utils.useClosableFocusRoot)
local GetVersionInformationStore = require(BuildExperience.Stores.GetVersionInformationStore)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local Button = Foundation.Button
local Popover = Foundation.Popover
local Snackbar = Foundation.Snackbar
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local PrivacyType = UniverseConfiguration.PrivacyType

local FFlagEnableShareSheet = SharedFlags.FFlagEnableShareSheet
local FFlagBuildPublishNavigationSheet = require(BuildExperience.Flags.FFlagBuildPublishNavigationSheet)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildExperiencePlaytestCardPublishCta = require(BuildExperience.Flags.FFlagBuildExperiencePlaytestCardPublishCta)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)
local GetAdUpsellEventStore = if FFlagBuildAdUpsell then require(BuildExperience.Stores.GetAdUpsellEventStore) else nil
local useStore = require(BuildExperienceParent.RoactUtils).Hooks.RoactRodux.useStore
local getRootNavigation = Navigation.getRootNavigation
local useNavigation = Navigation.useNavigation
local OpenGameDetails = GameDetail.OpenGameDetails

local debug2 = CreatorAgentChat.debug
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local ConfigurationActionTelemetry = require(BuildExperience.Telemetry.ConfigurationActionTelemetry)
local sharePublishedExperience = require(BuildExperience.utils.sharePublishedExperience)
local sharePublishedExperience2 = sharePublishedExperience.sharePublishedExperience
local useSharePublishedExperience = sharePublishedExperience.useSharePublishedExperience
local Action = ConfigurationActionTelemetry.Action
local Context = ConfigurationActionTelemetry.Context
local FailureReason = ConfigurationActionTelemetry.FailureReason
local Stage = ConfigurationActionTelemetry.Stage

local tbl1 = {}

local function isPublishedVersion(publishResult): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(publishResult) ~= "table" then
        return false
    end
    return publishResult.status == "success" and typeof(publishResult.version) == "string" and publishResult.version ~= ""
end

local function buildPublicAudiences(tbl2)
    local publicAudiences = {}
    for _, value in tbl2 or {} do
        if value ~= UniverseActivation.Audience.Public and value ~= UniverseActivation.Audience.Friends then
            table.insert(publicAudiences, value)
        end
    end
    table.insert(publicAudiences, UniverseActivation.Audience.Public)
    return publicAudiences
end

local function getPublishFailure(error, stage)
    local var1 = if type(error) == "table" then error else nil

    if var1 == nil or var1.stage ~= GameConfigurationActions.PublishFailureStage.SetAudience then
        return {
            reason = if var1 ~= nil and var1.responseCode == 16 then FailureReason.AccountTooNew else FailureReason.RequestFailed,
            stage = stage,
            error = error
        }
    end

    local tbl2 = {
        reason = if isPublishedVersion(var1.publishResult) then FailureReason.AudienceNotPublic else FailureReason.RequestFailed,
        stage = Stage.SetAudience,
        error = 0
    }

    if var1.cause ~= nil then
        error = var1.cause
    end

    tbl2.error = error
    return tbl2
end

local function PreviewButton(tbl2)
    local preview = useLocalization({ preview = LocalizationStrings.GAME_CONFIGURATION_PREVIEW }).preview
    local var1 = useStore()
    local var2 = useNavigation()

    local onPreview = tbl2.onPreview
    local onActivated = React.useCallback(function()
        if FFlagBuildExperienceActionOutcomeTelemetry then
            local tbl3 = {
                context = Context.PublishFooter
            }
            sendBuildExperienceEvent("PREVIEW_CLICK", tbl2.telemetryIds, tbl3)
        end
        local rootNavigation = getRootNavigation(var2)
        OpenGameDetails(
            tostring(tbl2.target.universeId),
            getGameDetailsNavigation(rootNavigation),
            { source = "BuildExperiencePublish" }
        )(
            var1
        )

        if onPreview then
            onPreview()
        end
    end, {
        var2,
        tbl2.target.universeId,
        var1,
        onPreview,
        tbl2.telemetryIds
    })

    return React.createElement(Button, {
        text = preview,
        size = InputSize.Medium,
        variant = ButtonVariant.Standard,
        fillBehavior = FillBehavior.Fill,
        onActivated = onActivated,
        width = UDim.new(1, 0),
        LayoutOrder = 2,
        testId = `{tbl2.actionsTestId}-preview`
    })
end

local function PublishFooter(tbl2)
    local var1 = useLocalization({
        accountTooNewError = LocalizationStrings.GAME_CONFIGURATION_PUBLISH_ACCOUNT_TOO_NEW_ERROR,
        creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB,
        linkCopied = LocalizationStrings.GAME_CONFIGURATION_LINK_COPIED,
        publish = LocalizationStrings.GAME_CONFIGURATION_PUBLISH,
        publishAudienceError = LocalizationStrings.GAME_CONFIGURATION_PUBLISH_AUDIENCE_ERROR,
        publishError = LocalizationStrings.GAME_CONFIGURATION_PUBLISH_ERROR,
        publishSuccess = LocalizationStrings.GAME_CONFIGURATION_PUBLISH_SUCCESS,
        share = LocalizationStrings.GAME_CONFIGURATION_SHARE,
        updateRating = LocalizationStrings.GAME_CONFIGURATION_UPDATE_RATING
    })
    local accountTooNewError = var1.accountTooNewError
    local creatorHub = var1.creatorHub
    local linkCopied = var1.linkCopied
    local publish = var1.publish
    local publishAudienceError = var1.publishAudienceError
    local publishError = var1.publishError
    local publishSuccess = var1.publishSuccess
    local share = var1.share
    local updateRating = var1.updateRating
    local var2 = useSharePublishedExperience(tbl2.target.universeId)
    local var3 = SignalsReact.useSignalState(PlaceVersionHistory.getPlaceVersionHistoryStore)
    local var4 = SignalsReact.useSignalState(UniverseConfiguration.getUniverseConfigurationStore)

    local var5 = SignalsReact.useSignalState(var4.getAndFetchConfiguration(tbl2.target.universeId).data)
    local var6 = React.useMemo(function()
        return var4.getAndFetchSummary(tbl2.target.universeId).data
    end, { var4, tbl2.target.universeId })
    local var7 = SignalsReact.useSignalState(var6)
    local audience = GameConfigurationLabels.getAudience(var5)

    local var8 = SignalsReact.useSignalState(UniverseActivation.getUniverseActivationStore)
    local var9 = var8
    local var10 = React.useMemo(function()
        return var8.getAndFetchEligibility(tbl2.target.universeId)
    end, { var8, tbl2.target.universeId })
    local var11 = SignalsReact.useSignalState(var10.data)
    local var12 = React.useMemo(function()
        return ContentMaturityUtils.isSealBroken(tbl2.target.universeId)
            and ContentMaturityUtils.isContentUnrated(tbl2.target.universeId)
    end, { var11, tbl2.target.universeId })
    local var13 = useOpenWebView()
    local isLoading, var15 = React.useState(false)
    local title, var17 = React.useState("")
    local var18, var19 = React.useState(nil)
    local bool1 = title == publishSuccess and tbl2.target.placeId ~= nil and audience ~= nil and audience ~= PrivacyType.Private

    local telemetryIds = if FFlagBuildExperienceActionOutcomeTelemetry then React.useMemo(function()
        return {
            universeId = tbl2.target.universeId,
            placeId = tbl2.target.placeId,
            conversationId = tbl2.target.sessionId
        }
    end, { tbl2.target.universeId, tbl2.target.placeId, tbl2.target.sessionId }) else nil

    local onClose = React.useCallback(function()
        var17("")
        var19(nil)
    end, {})
    React.useEffect(function()
        if title == "" then
            return nil
        end

        local var22 = task.delay(FIntBuildPostPublishSnackbarAutoDismissSeconds, var17, "")
        return function()
            task.cancel(var22)
        end
    end, { title })

    local onShare = React.useCallback(function()
        if tbl2.target.placeId == nil then
            return
        end

        var19(nil)
        if FFlagEnableShareSheet then
            var2(tbl2.target.placeId)
            return
        end
        local var22 = sharePublishedExperience2(tbl2.target.placeId)
        if var22 ~= nil and var22.copiedToClipboard and linkCopied ~= nil then
            var17(linkCopied)
        end
    end, { linkCopied, tbl2.target.placeId, var2 })

    local onActivated = React.useCallback(function()
        if FFlagBuildExperienceActionOutcomeTelemetry then
            ConfigurationActionTelemetry.sendClick(
                Action.Share,
                telemetryIds,
                Context.PublishSnackbar,
                {
                    audience = tostring(audience)
                }
            )
        end
        var17("")
        if audience == PrivacyType.FriendsOnly then
            var19("friends")
        elseif audience == PrivacyType.Public then
            onShare()
        end
    end, { audience, onShare, telemetryIds })

    local onCancel = React.useCallback(function()
        var19(nil)
    end, {})

    local var25 = React.useCallback(function()
        if FFlagBuildExperienceActionOutcomeTelemetry then
            ConfigurationActionTelemetry.sendClick(Action.UpdateRating, telemetryIds, Context.PublishFooter)
        end
        var13(GameConfigurationActions.getExperienceQuestionnaireUrl(tbl2.target.universeId), creatorHub, function()
            refreshPublishEligibility(tbl2.target.universeId)
        end)
    end, {
        creatorHub,
        var13,
        tbl2.target.universeId,
        telemetryIds
    })

    local var26 = React.useCallback(function()
        if isLoading then
            return
        end
        local placeId = tbl2.target.placeId
        if placeId == nil then
            return
        end

        local title = nil
        local description = nil
        local function selectVersionNotes(arg1)
            local var26 = GetVersionInformationStore().getDraft()
            local placeVersion = if arg1 == nil then nil else arg1.placeVersions[1]

            if var26 ~= nil and var26.placeId == placeId then
                title = if var26.title == "" then nil else var26.title
                description = if var26.description == "" then nil else var26.description
            elseif placeVersion ~= nil then
                title = placeVersion.title
                description = placeVersion.description
            end
        end

        sendBuildExperienceEvent(
            "PUBLISH_CLICK",
            {
                universeId = tbl2.target.universeId,
                placeId = placeId,
                conversationId = tbl2.target.sessionId
            }
        )
        var15(true)
        onClose()
        local saveAndPublish = Stage.SaveAndPublish
        local bool2 = false
        local function recordSuccessfulPublish(arg1) -- Luacid: unused: defined but never referenced
            if typeof(arg1) ~= "table" or arg1.status ~= "success" or typeof(arg1.version) ~= "string" or arg1.version == "" then
                return
            end
            GetAdUpsellEventStore(false).reportMenuPublish(tbl2.target.universeId, tbl2.target.sessionId, arg1.version, bool2)
        end

        local function publish2(arg1)
            saveAndPublish = Stage.SaveAndPublish
            local var26 = arg1 or var7
            if FFlagBuildAdUpsell then
                bool2 = true
            end
            return GameConfigurationActions.publishExperience({
                universeId = tbl2.target.universeId,
                placeId = placeId,
                title = title,
                description = description,
                isActive = not (var26 == nil) and var26.isActive == true,
                audiences = buildPublicAudiences(if var26 then var26.audiences else nil)
            })
        end
        local function startPublish() -- Luacid: Inlined by compiler; 1 call site recovered
            if var9 == nil then
                return publish2()
            end
            saveAndPublish = Stage.RefreshEligibility
            return var9.refreshEligibility(tbl2.target.universeId):andThen(function()
                if not (ContentMaturityUtils.isSealBroken(tbl2.target.universeId)
                    and ContentMaturityUtils.isContentUnrated(tbl2.target.universeId)) then
                    saveAndPublish = Stage.RefreshSummary
                    return var4.refreshSummary(tbl2.target.universeId):andThen(function(arg1)
                        return publish2(arg1)
                    end)
                end

                return ExperienceGuidelines.getExperienceGuidelinesStore().refreshDetailedGuidelines(tbl2.target.universeId):andThen(
                    function()
                        return tbl1
                    end,
                    function(arg1)
                        debug2.log(
                            "warn",
                            "build_experience content maturity refresh failed",
                            {
                                errorMessage = tostring(arg1),
                                universeId = tbl2.target.universeId
                            }
                        )
                        return tbl1
                    end
                )
            end)
        end

        local var26 = GetVersionInformationStore().getDraft()
        local var27

        if var26 ~= nil and var26.placeId == placeId then
            local var28 = GetVersionInformationStore().getDraft()

            if var28 ~= nil and var28.placeId == placeId then
                if var28.title == "" then
                    title = nil
                else
                    title = var28.title
                end

                if var28.description == "" then
                    description = nil
                else
                    description = var28.description
                end
            end

            var27 = startPublish()
        else
            var27 = var3.fetchPageHistory(placeId):andThen(selectVersionNotes, function()
                local var28 = GetVersionInformationStore().getDraft()

                if var28 ~= nil and var28.placeId == placeId then
                    title = if var28.title == "" then nil else var28.title
                    description = if var28.description == "" then nil else var28.description
                end
            end):andThen(startPublish)
        end

        var27:andThen(function(arg1)
            if arg1 == tbl1 then
                if FFlagBuildExperienceActionOutcomeTelemetry then
                    ConfigurationActionTelemetry.sendFailure(
                        Action.Publish,
                        telemetryIds,
                        {
                            reason = FailureReason.RatingRequired,
                            stage = saveAndPublish,
                            error = nil
                        }
                    )
                end
                return
            end

            if typeof(arg1) ~= "table" or arg1.status ~= "success" or typeof(arg1.version) ~= "string" or arg1.version == "" then
                local error = error
                local tbl3 = { errorMessage = 0 }

                local str1 = tostring(arg1.status)
                local version = arg1.version
                tbl3.errorMessage = "save_and_publish expected status=success and a non-empty version; " .. `got status={str1}, version={tostring(version)}`
                error(tbl3)
            end

            if FFlagBuildExperienceActionOutcomeTelemetry then
                ConfigurationActionTelemetry.sendSuccess(Action.Publish, telemetryIds, nil, { version = tostring(arg1.version) })
            end

            if FFlagBuildAdUpsell
                and typeof(arg1) == "table"
                and arg1.status == "success"
                and typeof(arg1.version) == "string"
                and arg1.version ~= ""
            then
                GetAdUpsellEventStore(false).reportMenuPublish(tbl2.target.universeId, tbl2.target.sessionId, arg1.version, bool2)
            end

            GetVersionInformationStore().clearDraft(placeId)
            var3.fetchHistory(placeId)
            if FFlagBuildExperiencePlaytestCardPublishCta then
                var3.fetchLiveVersion(placeId)
            end
            var17(publishSuccess)
        end):catch(function(arg1)
            local bool3 = typeof(arg1) == "table"
            local bool4 = bool3
                and arg1.stage == GameConfigurationActions.PublishFailureStage.SetAudience
                and isPublishedVersion(arg1.publishResult)
            local bool5 = bool3 and arg1.responseCode == 16
            local var28 = if bool4 then publishAudienceError else publishError

            if bool5 then
                var28 = accountTooNewError
            end
            if bool4 then
                GetVersionInformationStore().clearDraft(placeId)
                var3.fetchHistory(placeId)
                if FFlagBuildExperiencePlaytestCardPublishCta then
                    var3.fetchLiveVersion(placeId)
                end
            end
            local publishFailure = getPublishFailure(arg1, saveAndPublish)
            local log = debug2.log
            local str1 = "warn"
            local str2 = "build_experience publish failed"
            local tbl3 = {
                errorMessage = if bool3 and arg1.errorMessage ~= nil then tostring(arg1.errorMessage) else tostring(arg1),
                placeId = placeId,
                responseCode = if bool3 then arg1.responseCode else nil,
                stage = publishFailure.stage,
                universeId = tbl2.target.universeId
            }
            log(str1, str2, tbl3)

            if FFlagBuildExperienceActionOutcomeTelemetry then
                ConfigurationActionTelemetry.sendFailure(Action.Publish, telemetryIds, publishFailure)
            end
            var17(var28)
        end):finally(function()
            var15(false)
        end)
    end, {
        if FFlagBuildAdUpsell then audience else nil,
        onClose,
        isLoading,
        var3,
        tbl2.target.placeId,
        tbl2.target.sessionId,
        tbl2.target.universeId,
        var9,
        var4,
        var7,
        accountTooNewError,
        publishAudienceError,
        publishError,
        publishSuccess,
        telemetryIds
    })

    local str1 = `{tbl2.testId}.actions`
    local var27 = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = tbl2.target.universeId, isNewGame = tbl2.target.isNewGameTarget }) else nil
    local var28 = not FFlagBuildCheckGamePermissions or var27.canPublish
    local var29 = React.useRef(nil)
    local var30 = Foundation.Hooks.useTokens()
    local ref = useClosableFocusRoot({
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.PopUp,
        isOpen = title ~= "",
        onClose = onClose
    })
    local bool2 = Responsive.usePreferredInput() == Responsive.Input.Directional
    local snackbar = React.createElement(Snackbar, {
        LayoutOrder = 1,
        ref = ref,
        title = title,
        action = bool1 and { text = share, onActivated = onActivated } or nil,
        onClose = if bool2 then nil else onClose,
        testId = `{tbl2.testId}.publish-snackbar`
    })

    local createElement = React.createElement
    local var32 = View
    local tbl3 = {
        LayoutOrder = 3,
        tag = {
            ["col gap-small size-full-0 auto-y"] = true,
            ["bg-surface-0"] = not FFlagBuildPublishNavigationSheet
        }
    }
    local tbl4 = {
        PublishSnackbar = React.createElement(
            Popover.Root,
            {
                isOpen = title ~= "",
                testId = `{tbl2.testId}.publish-snackbar-popover`
            },
            {
                Anchor = React.createElement(Popover.Anchor, { anchorRef = var29 }),
                Content = React.createElement(Popover.Content, {
                    align = PopoverAlign.Center,
                    backgroundStyle = var30.Color.None,
                    hasArrow = false,
                    selectionGroup = false,
                    side = PopoverSide.Top
                }, { Snackbar = snackbar })
            }
        ),
        Actions = 0,
        FriendsOnlyShareDialog = 0
    }

    local createElement2 = React.createElement
    local var33 = View
    local tbl5 = {
        LayoutOrder = 2,
        ref = var29,
        tag = "row gap-small size-full-0 auto-y padding-y-medium",
        testId = str1
    }
    local tbl6 = { Publish = 0, Preview = 0 }
    local createElement3 = React.createElement
    local var34 = Button
    local tbl7 = {
        text = 0,
        size = 0,
        variant = 0,
        fillBehavior = 0,
        isDisabled = 0,
        isLoading = 0,
        onActivated = 0,
        width = 0,
        LayoutOrder = 1,
        testId = 0
    }

    if not var12 then
        updateRating = publish
    end

    tbl7.text = updateRating
    tbl7.size = InputSize.Medium
    tbl7.variant = ButtonVariant.Emphasis
    tbl7.fillBehavior = FillBehavior.Fill
    tbl7.isDisabled = tbl2.target.placeId == nil or not var28
    tbl7.isLoading = isLoading
    if not var12 then
        var25 = var26
    end

    tbl7.onActivated = var25
    tbl7.width = UDim.new(1, 0)

    tbl7.testId = `{str1}-publish`
    tbl6.Publish = createElement3(var34, tbl7)

    tbl6.Preview = if tbl2.showPreviewButton == false then nil else React.createElement(
        PreviewButton,
        {
            target = tbl2.target,
            actionsTestId = str1,
            onPreview = tbl2.onPreview,
            telemetryIds = telemetryIds
        }
    )
    tbl4.Actions = createElement2(var33, tbl5, tbl6)

    tbl4.FriendsOnlyShareDialog = if var18 == "friends" and audience == PrivacyType.FriendsOnly then React.createElement(FriendsOnlyShareDialog, { onCancel = onCancel, onShare = onShare }) else nil
    return createElement(var32, tbl3, tbl4)
end

return PublishFooter
