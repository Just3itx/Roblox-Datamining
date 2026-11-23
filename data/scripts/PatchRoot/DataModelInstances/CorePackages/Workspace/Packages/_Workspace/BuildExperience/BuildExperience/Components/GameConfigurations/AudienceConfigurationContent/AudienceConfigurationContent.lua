-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local ExperienceQuestionnaire = require(BuildExperienceParent.DataHydration.ExperienceQuestionnaire)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local ContentMaturityUtils = require(BuildExperience.utils.ContentMaturityUtils)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local formatError = require(BuildExperience.utils.formatError)
local refreshPublishEligibility = require(BuildExperience.utils.refreshPublishEligibility)
local refreshAdCampaignEligibility = require(BuildExperience.utils.refreshAdCampaignEligibility)
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)
local ConfigurationActionTelemetry = require(BuildExperience.Telemetry.ConfigurationActionTelemetry)

local debug2 = CreatorAgentChat.debug
local Action = ConfigurationActionTelemetry.Action
local FailureReason = ConfigurationActionTelemetry.FailureReason
local Stage = ConfigurationActionTelemetry.Stage

local Icon = Foundation.Icon
local List = Foundation.List
local Popover = Foundation.Popover
local RadioGroup = Foundation.RadioGroup
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens

local PrivacyType = UniverseConfiguration.PrivacyType

local tbl1 = {
    [PrivacyType.Private] = "Private",
    [PrivacyType.FriendsOnly] = "Friends",
    [PrivacyType.Public] = "Public"
}

local num1 = game:DefineFastInt("BuildExperienceAudienceTooltipMaxWidth", 220)

local function getSelectedAudience(audiences) -- Luacid: Inlined by compiler; 2 call sites recovered
    if audiences == nil then
        return nil
    end

    return tbl1[UniverseConfiguration.getPrivacyTypeForAudiences(audiences)]
end

local tbl2 = {
    Private = PrivacyType.Private,
    Friends = PrivacyType.FriendsOnly,
    Public = PrivacyType.Public
}

local function getAudienceChangeParameters(configurationData, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local audiences = if configurationData == nil then nil else configurationData.audiences
    return {
        fromAudience = if audiences == nil then "unknown" else UniverseConfiguration.getPrivacyTypeForAudiences(audiences),
        toAudience = tbl2[str1]
    }
end

local function isVisibilityAudience(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == UniverseActivation.Audience.Public or arg1 == UniverseActivation.Audience.Friends
end

local function getAudiencesForValue(str1: string, audiences)
    local audiencesForValue = {}
    for _, value in audiences do
        if not isVisibilityAudience(value) then
            table.insert(audiencesForValue, value)
        end
    end

    if str1 ~= "Public" then
        if str1 == "Friends" then
            table.insert(audiencesForValue, UniverseActivation.Audience.Friends)
        end

        return audiencesForValue
    end

    table.insert(audiencesForValue, UniverseActivation.Audience.Public)
    return audiencesForValue
end

local function AudienceRow(tbl3)
    local var1 = React.useCallback(function()
        tbl3.onActivated(tbl3.value)
    end, { tbl3.onActivated, tbl3.value })
    local testId = `{tbl3.testId}-row-{string.lower(tbl3.value)}`
    local lock = if tbl3.isLocked then React.createElement(Icon, {
        LayoutOrder = 1,
        name = IconName.LockClosed,
        ref = tbl3.lockIconRef,
        size = IconSize.Small,
        tag = "auto-xy content-default"
    }) else nil
    local createElement = React.createElement
    local var2 = View
    local tbl4 = {
        LayoutOrder = tbl3.LayoutOrder,
        onActivated = 0,
        tag = "size-full-0 auto-y radius-medium",
        testId = 0
    }

    if tbl3.isDisabled then
        var1 = nil
    end

    tbl4.onActivated = var1

    tbl4.testId = `{testId}-button`
    return createElement(var2, tbl4, {
        ListItem = React.createElement(List.Item, {
            LayoutOrder = tbl3.LayoutOrder,
            title = tbl3.title,
            trailing = React.createElement(View, { tag = "row align-y-center gap-medium auto-xy" }, {
                Lock = lock,
                Radio = React.createElement(RadioGroup.Item, {
                    LayoutOrder = 2,
                    isDisabled = tbl3.isDisabled or tbl3.isLocked,
                    label = "",
                    size = InputSize.Medium,
                    testId = `{testId}-radio`,
                    value = tbl3.value
                })
            }),
            testId = testId
        })
    })
end

local function getSelectedAudienceFromState(str1: string?, bool1: boolean, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 ~= nil then
        return str1
    elseif bool1 then
        return getSelectedAudience(arg1.audiences)
    end

    return nil
end

local function getUniverseActivationStore(arg1)
    return UniverseActivation.getUniverseActivationStore(arg1)
end

local function getQuestionnaireStore(arg1)
    return ExperienceQuestionnaire.getExperienceQuestionnaireStore(arg1)
end

local function getUniverseConfigurationStore(arg1)
    return UniverseConfiguration.getUniverseConfigurationStore(arg1)
end

local function useAudienceStores()
    return {
        universeActivationStore = SignalsReact.useSignalState(getUniverseActivationStore),
        questionnaireStore = SignalsReact.useSignalState(getQuestionnaireStore),
        universeConfigurationStore = SignalsReact.useSignalState(getUniverseConfigurationStore)
    }
end

local function useAudienceData(universeId: number, universeActivationStore: number, universeConfigurationStore: number, str1: string?)
    local var1 = React.useMemo(function()
        return universeConfigurationStore.getAndFetchConfiguration(universeId)
    end, { universeId, universeConfigurationStore })
    local isConfigurationRefreshPending, var3 = React.useState(true)

    React.useEffect(function()
        local bool1 = true
        var3(true)
        universeConfigurationStore.refreshConfiguration(universeId):catch(function(arg1)
            debug2.log(
                "warn",
                "AudienceConfigurationContent configuration refresh failed",
                {
                    errorMessage = formatError(arg1),
                    universeId = universeId
                }
            )
        end):finally(function()
            if bool1 then
                var3(false)
            end
        end)

        return function()
            bool1 = false
        end
    end, { universeConfigurationStore, universeId })

    local configurationData = SignalsReact.useSignalState(var1.data)
    local isAudiencesReady = SignalsReact.useSignalState(var1.status) == "Ready" and configurationData ~= nil

    local var5 = React.useMemo(function()
        return universeActivationStore.getAndFetchEligibility(universeId)
    end, { universeActivationStore, universeId })
    local var6 = SignalsReact.useSignalState(var5.status)

    local var7 = ContentMaturityUtils.isContentUnrated(universeId)
    local var8 = ContentMaturityUtils.isSealBroken(universeId)

    local lockReason = var7 and (if var8 then "RatingRequired" else "PublishRequired") or nil
    return {
        configurationData = configurationData,
        isAudiencesReady = isAudiencesReady,
        isConfigurationRefreshPending = isConfigurationRefreshPending,
        isEligibilityResolved = var6 == "Ready" or var6 == "Failed",
        isNonPrivateLocked = lockReason ~= nil,
        lockReason = lockReason,
        selectedAudience = getSelectedAudienceFromState(str1, isAudiencesReady, configurationData)
    }
end

local function useQuestionnaireHandler(universeId: number, questionnaireStore: number)
    local creatorHub = useLocalization({ creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB }).creatorHub
    local var1 = useOpenWebView()

    local var2 = React.useCallback(function()
        refreshPublishEligibility(universeId)
    end, { questionnaireStore, universeId })

    return React.useCallback(function(tbl3)
        if FFlagBuildExperienceActionOutcomeTelemetry then
            ConfigurationActionTelemetry.sendClick(
                Action.UpdateRating,
                { universeId = universeId },
                if tbl3 == nil then nil else tbl3.context
            )
        end

        var1(GameConfigurationActions.getExperienceQuestionnaireUrl(universeId), creatorHub, var2)
    end, {
        creatorHub,
        var1,
        var2,
        universeId
    })
end

local function cancelEligibilityRecheck(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local current = tbl3.current
    tbl3.current = nil
    if current ~= nil then
        current:cancel()
    end
end

local function useAudienceController(universeId: number)
    local tbl3 = useAudienceStores()
    local var1, var2 = React.useState(nil)
    local isMutationPending, var4 = React.useState(false)

    local var5 = React.useRef(nil)
    local var6 = var5
    React.useEffect(function()
        return function()
            cancelEligibilityRecheck(var5)
        end
    end, { var5, universeId })

    local tooltipTarget, var8 = React.useState(nil)
    local onTooltipPressedOutside = React.useCallback(function()
        var8(nil)
    end, {})

    local tbl4 = useAudienceData(universeId, tbl3.universeActivationStore, tbl3.universeConfigurationStore, var1)
    local handleQuestionnaire = useQuestionnaireHandler(universeId, tbl3.questionnaireStore)

    local configurationData = tbl4.configurationData
    local isAudiencesReady = tbl4.isAudiencesReady
    local isConfigurationRefreshPending = tbl4.isConfigurationRefreshPending
    local isEligibilityResolved = tbl4.isEligibilityResolved
    local isNonPrivateLocked = tbl4.isNonPrivateLocked
    local var11 = not isAudiencesReady or isMutationPending or isConfigurationRefreshPending

    return {
        handleAudienceActivated = React.useCallback(function(str1: string)
            local function showLockedTooltip() -- Luacid: Inlined by compiler; 2 call sites recovered
                var8(function(arg1): string?
                    return if arg1 == str1 then nil else str1
                end)
            end

            local function applyAudienceChange()
                if var11 then
                    return
                end

                local audiencesForValue = getAudiencesForValue(str1, configurationData.audiences)

                var8(nil)
                var2(str1)
                var4(true)

                tbl3.universeActivationStore.setAudiences(universeId, audiencesForValue):andThen(function(arg1)
                    GameConfigurationActions.updateCachedAudience(universeId, arg1.audiences)
                    if FFlagBuildExperienceActionOutcomeTelemetry then
                        ConfigurationActionTelemetry.sendSuccess(
                            Action.AudienceChange,
                            { universeId = universeId },
                            nil,
                            (getAudienceChangeParameters(configurationData, str1))
                        )
                    end
                    tbl3.universeActivationStore.activate(universeId):andThen(function()
                        if FFlagEnableBuildAdPromotion then
                            refreshAdCampaignEligibility(universeId)
                        end
                    end):catch(function(arg2)
                        debug2.log(
                            "warn",
                            "AudienceConfigurationContent activate after audience update failed",
                            {
                                errorMessage = formatError(arg2),
                                universeId = universeId
                            }
                        )
                        var2(nil)
                    end):finally(function()
                        var4(false)
                    end)
                end):catch(function(error)
                    debug2.log(
                        "warn",
                        "AudienceConfigurationContent set audiences failed",
                        {
                            errorMessage = formatError(error),
                            universeId = universeId
                        }
                    )

                    if FFlagBuildExperienceActionOutcomeTelemetry then
                        ConfigurationActionTelemetry.sendFailure(
                            Action.AudienceChange,
                            { universeId = universeId },
                            {
                                reason = FailureReason.RequestFailed,
                                stage = Stage.SetAudience,
                                error = error
                            },
                            nil,
                            (getAudienceChangeParameters(configurationData, str1))
                        )
                    end
                    var2(nil)
                    var4(false)
                end)
            end
            local bool1 = isNonPrivateLocked and str1 ~= "Private"
            if bool1 then
                showLockedTooltip()
            end

            if var11 then
                return
            end
            if not bool1 then
                var4(true)
            end

            local var12 = var6
            cancelEligibilityRecheck(var12)

            if str1 == "Private" then
                applyAudienceChange()
                return
            end

            if not bool1 then
                var2(str1)
            end

            local current = tbl3.universeActivationStore.refreshEligibility(universeId)
            var12.current = current

            current:catch(function(arg1)
                if var12.current == current then
                    debug2.log(
                        "warn",
                        "AudienceConfigurationContent eligibility recheck failed",
                        {
                            errorMessage = formatError(arg1),
                            universeId = universeId
                        }
                    )
                end
            end):finally(function()
                if var12.current ~= current then
                    return
                end
                var12.current = nil

                if not ContentMaturityUtils.isContentUnrated(universeId) then
                    applyAudienceChange()
                    return
                end

                if bool1 then
                    return
                end

                if FFlagBuildExperienceActionOutcomeTelemetry then
                    ConfigurationActionTelemetry.sendFailure(
                        Action.AudienceChange,
                        { universeId = universeId },
                        {
                            reason = FailureReason.ContentUnrated,
                            stage = Stage.RefreshEligibility,
                            error = nil
                        },
                        nil,
                        (getAudienceChangeParameters(configurationData, str1))
                    )
                end
                var2(nil)
                var4(false)
                showLockedTooltip()
            end)
        end, {
            configurationData,
            var6,
            var11,
            isEligibilityResolved,
            isNonPrivateLocked,
            tbl3.universeActivationStore,
            tbl3.universeConfigurationStore,
            universeId
        }),
        handleQuestionnaire = handleQuestionnaire,
        isMutationPending = isMutationPending,
        isNonPrivateLocked = tbl4.isNonPrivateLocked,
        lockReason = tbl4.lockReason,
        onTooltipPressedOutside = onTooltipPressedOutside,
        selectedAudience = tbl4.selectedAudience,
        tooltipTarget = tooltipTarget
    }
end

local function AudienceHeader()
    local var1 = useLocalization({
        body = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_BODY,
        title = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PAGE_TITLE
    })
    local body = var1.body
    local title = var1.title

    return React.createElement(View, { LayoutOrder = 1, tag = "col gap-xsmall size-full-0 auto-y" }, {
        Title = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = title,
                tag = "size-full-0 auto-y text-title-large text-align-x-left content-default"
            }
        ),
        Body = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = body,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
            }
        )
    })
end

local function AudienceList(tbl3)
    local var1 = useLocalization({
        friends = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_FRIENDS,
        private = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PRIVATE,
        public = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PUBLIC
    })
    local friends = var1.friends
    local private = var1.private
    local public = var1.public
    local onValueChanged = React.useCallback(function(str1: string)
        tbl3.onAudienceActivated(str1)
    end, { tbl3.onAudienceActivated })

    return React.createElement(RadioGroup.Root, {
        LayoutOrder = 2,
        onValueChanged = onValueChanged,
        Selectable = false,
        tag = "size-full-0 auto-y",
        value = if tbl3.selectedAudience == nil then "" else tbl3.selectedAudience
    }, {
        List = React.createElement(List.Root, {
            hasDivider = { hasDivider = true, isInset = false },
            isContained = true,
            size = InputSize.Medium,
            testId = `{tbl3.testId}-list`
        }, {
            Private = React.createElement(AudienceRow, {
                LayoutOrder = 1,
                isDisabled = tbl3.isDisabled,
                isLocked = false,
                lockIconRef = nil,
                onActivated = tbl3.onAudienceActivated,
                testId = tbl3.testId,
                title = private,
                value = "Private"
            }),
            Friends = React.createElement(AudienceRow, {
                LayoutOrder = 2,
                isDisabled = tbl3.isDisabled,
                isLocked = tbl3.isNonPrivateLocked,
                lockIconRef = tbl3.friendsLockIconRef,
                onActivated = tbl3.onAudienceActivated,
                testId = tbl3.testId,
                title = friends,
                value = "Friends"
            }),
            Public = React.createElement(AudienceRow, {
                LayoutOrder = 3,
                isDisabled = tbl3.isDisabled,
                isLocked = tbl3.isNonPrivateLocked,
                lockIconRef = tbl3.publicLockIconRef,
                onActivated = tbl3.onAudienceActivated,
                testId = tbl3.testId,
                title = public,
                value = "Public"
            })
        })
    })
end

local function EligibilityTooltip(tbl3)
    local var1 = useLocalization({
        notEligible = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_NOT_ELIGIBLE,
        notEligibleDescription = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_NOT_ELIGIBLE_DESCRIPTION,
        publishRequired = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PUBLISH_REQUIRED,
        publishRequiredDescription = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PUBLISH_REQUIRED_DESCRIPTION
    })
    local notEligible = var1.notEligible
    local notEligibleDescription = var1.notEligibleDescription
    local publishRequired = var1.publishRequired
    local publishRequiredDescription = var1.publishRequiredDescription
    local var2 = useTokens()
    local x = useScaledValue(num1)
    local bool1 = tbl3.lockReason == "PublishRequired"
    if not bool1 then
        publishRequired = notEligible
    end

    if bool1 then
        notEligibleDescription = publishRequiredDescription
    end

    local testId = if bool1 then `{tbl3.testId}-eligibility-tooltip--publish` else `{tbl3.testId}-eligibility-tooltip--not-eligible`
    return React.createElement(
        Popover.Root,
        {
            isOpen = tbl3.isOpen,
            testId = `{tbl3.testId}-eligibility-tooltip`
        },
        {
            Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl3.anchorRef }),
            Content = React.createElement(Popover.Content, {
                align = PopoverAlign.Center,
                backgroundStyle = var2.Color.System.Contrast,
                hasArrow = true,
                onPressedOutside = tbl3.onPressedOutside,
                radius = Radius.Small,
                selectionGroup = false,
                side = PopoverSide.Left
            }, {
                Layout = React.createElement(View, {
                    tag = "col gap-xsmall auto-xy padding-x-small padding-y-small",
                    sizeConstraint = {
                        MaxSize = Vector2.new(x, math.huge)
                    },
                    testId = testId
                }, {
                    Title = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = publishRequired,
                        tag = "auto-xy text-title-small text-wrap text-align-x-left content-inverse-emphasis",
                        testId = `{tbl3.testId}-eligibility-tooltip--header`
                    }),
                    Text = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = notEligibleDescription,
                        tag = "auto-xy text-body-small text-wrap text-align-x-left content-inverse-default",
                        testId = `{tbl3.testId}-eligibility-tooltip--text`
                    })
                })
            })
        }
    )
end

local function EligibilityBanner(tbl3)
    local banner = useLocalization({ banner = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_BANNER }).banner

    return React.createElement(View, {
        LayoutOrder = 3,
        onActivated = tbl3.onActivated,
        stateLayer = {},
        tag = "row align-y-center gap-small size-full-0 auto-y padding-medium radius-medium bg-shift-200",
        testId = `{tbl3.testId}-eligibility-banner`
    }, {
        Lock = React.createElement(
            Icon,
            {
                LayoutOrder = 1,
                name = IconName.LockClosed,
                size = IconSize.Small,
                tag = "auto-xy content-emphasis"
            }
        ),
        Text = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = banner,
            tag = "fill auto-y text-body-small text-align-x-left text-truncate-end content-emphasis"
        }),
        ExternalLink = React.createElement(
            Icon,
            {
                LayoutOrder = 3,
                name = IconName.ArrowUpRightFromSquare,
                size = IconSize.Small,
                tag = "auto-xy content-emphasis"
            }
        )
    })
end

local function AudienceConfigurationContent(tbl3)
    local testId = tbl3.testId or "audience-configuration-content"
    local tbl4 = useAudienceController(tbl3.universeId)
    local friendsLockIconRef = React.useRef(nil)
    local publicLockIconRef = React.useRef(nil)
    local anchorRef = if tbl4.tooltipTarget == "Public" then publicLockIconRef else friendsLockIconRef
    local bool1 = tbl4.isNonPrivateLocked and tbl4.lockReason == "RatingRequired"
    local handleQuestionnaire = tbl4.handleQuestionnaire

    local onActivated = if FFlagBuildExperienceActionOutcomeTelemetry then React.useCallback(function()
        handleQuestionnaire({ context = ConfigurationActionTelemetry.Context.AudienceBanner })
    end, { handleQuestionnaire }) else handleQuestionnaire

    return React.createElement(
        View,
        {
            LayoutOrder = tbl3.layoutOrder,
            tag = "col gap-medium size-full-0 auto-y padding-y-large",
            testId = testId
        },
        {
            Header = React.createElement(AudienceHeader),
            List = React.createElement(AudienceList, {
                friendsLockIconRef = friendsLockIconRef,
                isDisabled = tbl4.isMutationPending,
                isNonPrivateLocked = tbl4.isNonPrivateLocked,
                onAudienceActivated = tbl4.handleAudienceActivated,
                publicLockIconRef = publicLockIconRef,
                selectedAudience = tbl4.selectedAudience,
                testId = testId
            }),
            Tooltip = React.createElement(EligibilityTooltip, {
                anchorRef = anchorRef,
                isOpen = tbl4.tooltipTarget ~= nil,
                lockReason = tbl4.lockReason,
                onPressedOutside = tbl4.onTooltipPressedOutside,
                testId = testId
            }),
            ContextBanner = if bool1 then React.createElement(EligibilityBanner, { onActivated = onActivated, testId = testId }) else nil
        }
    )
end

return AudienceConfigurationContent
