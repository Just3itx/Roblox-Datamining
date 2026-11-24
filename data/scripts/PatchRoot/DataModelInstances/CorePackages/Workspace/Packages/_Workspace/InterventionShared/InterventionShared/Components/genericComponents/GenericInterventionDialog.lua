-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local VRService = game:GetService("VRService")

local React = require(InterventionSharedParent.React)
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local Constants = require(InterventionShared.Utils.Constants)
local Cryo = require(InterventionSharedParent.Cryo)
local EvidenceField = require(InterventionShared.Components.genericComponents.EvidenceField)
local InterventionDialogFooter = require(InterventionShared.Components.genericComponents.InterventionDialogFooter)
local InterventionDialogLoadingSkeleton = require(InterventionShared.Components.genericComponents.InterventionDialogLoadingSkeleton)
local InterventionAnalytics = require(InterventionShared.InterventionAnalytics)
local LinkingProtocol = require(InterventionSharedParent.LinkingProtocol).LinkingProtocol
local PostDismissIntervention = require(InterventionShared.Http.PostDismissIntervention)
local Responsive = require(InterventionSharedParent.Responsive)
local NotificationModalsManager = require(InterventionSharedParent.NotificationModalsManager)
local UrlBuilder = require(InterventionSharedParent.UrlBuilder).UrlBuilder

local FocusNavigableSurfaceIdentifierEnum = require(InterventionSharedParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local Foundation = require(InterventionSharedParent.Foundation)
local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local Divider = Foundation.Divider
local IconName = Foundation.Enums.IconName
local IconPosition = Foundation.Enums.IconPosition
local IconVariant = Foundation.Enums.IconVariant
local FoundationText = Foundation.Text
local View = Foundation.View
local Images = require(InterventionSharedParent.FoundationImages).Images

local useInterventionFocusRoot = require(InterventionShared.Hooks.useInterventionFocusRoot)
local useInterventionPlacement = require(InterventionShared.Hooks.useInterventionPlacement)
local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization
local usePreferredInput = Responsive.usePreferredInput
local useSinkCoreShortcuts = require(InterventionShared.Hooks.useSinkCoreShortcuts)
local useTokens = Foundation.Hooks.useTokens
local useWebView = require(InterventionShared.Hooks.useWebView)

local FFlagInterventionDialogBlockExperienceInput = require(InterventionShared.Flags.FFlagInterventionDialogBlockExperienceInput)
local FFlagNavigateToSafetyDashboardForAppeals = require(InterventionSharedParent.SharedFlags).FFlagNavigateToSafetyDashboardForAppeals
local FFlagUFRDialogContentCutoffFix = require(InterventionShared.Flags.FFlagUFRDialogContentCutoffFix)
local FFlagUFRImprovements = require(InterventionShared.Flags.FFlagUFRImprovements)

local iconsActionsAccept = Images["icons/actions/accept"]

local function getNonEmptyString(str1: string?): string? -- Luacid: Inlined by compiler; 7 call sites recovered
    return if str1 == "" then nil else str1
end

return React.memo(function(tbl1) -- name: GenericInterventionDialog
    local var1 = useTokens()

    local nonEmptyString = getNonEmptyString(tbl1.interventionId)
    local nonEmptyString2 = getNonEmptyString(tbl1.dsaMessage)
    local nonEmptyString3 = getNonEmptyString(tbl1.evidence)
    local fieldValue = getNonEmptyString(tbl1.formattedEndDate)
    local nonEmptyString4 = getNonEmptyString(tbl1.userNote)
    local nonEmptyString5 = getNonEmptyString(tbl1.violationReason)
    local id = getNonEmptyString(tbl1.violationUid)

    local var2 = useRef(DateTime.now().UnixTimestampMillis)
    local placement = useInterventionPlacement()
    local var4 = useLocalization(Constants.localizationKeys)
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var5 = if FFlagNavigateToSafetyDashboardForAppeals then if id then UrlBuilder.static.safetyDashboard.violation({ id = id }) else UrlBuilder.static.safetyDashboard.violations() else UrlBuilder.static.appealsPortal.main()
    local var6 = useWebView
    local var7 = if FFlagNavigateToSafetyDashboardForAppeals then var4.AccountStatusTitleText else var4.AppealsPortalTitleText
    local var8 = var6(var5, var7)

    local default = LinkingProtocol.default

    local ref = useInterventionFocusRoot(
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ModerationOverlay,
            isAutoFocusRoot = true
        }
    )

    if FFlagInterventionDialogBlockExperienceInput then
        useSinkCoreShortcuts(placement == Constants.InterventionPlacementType.InExperience)
    end

    useEffect(function()
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogRendered, {
            eventType = InterventionAnalytics.Constants.EventTypes.ModalAppeared,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var2.current,
            eventId = tbl1.eventId,
            evidence = tbl1.evidence,
            duration = tbl1.durationForAnalytics,
            acknowledgeable = tbl1.acknowledgeable,
            abuseVector = tbl1.abuseVectorForAnalytics
        })
    end, { var2 })

    local var10 = useCallback(function()
        if not tbl1.acknowledgeable or not nonEmptyString then
            return
        end
        local bool2 = false
        PostDismissIntervention(nonEmptyString):andThen(function(_)
            bool2 = true
            InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogInterventionDismissSuccess, {
                eventType = InterventionAnalytics.Constants.EventTypes.DialogInterventionDismissSuccess,
                interventionType = tbl1.interventionTypeForAnalytics,
                placement = placement,
                renderedTimestamp = var2.current,
                eventId = tbl1.eventId,
                acknowledgeable = tbl1.acknowledgeable,
                abuseVector = tbl1.abuseVectorForAnalytics
            })

            if tbl1.onAcknowledgementSuccess then
                tbl1.onAcknowledgementSuccess()
            end
        end):catch(function(arg1)
            InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogInterventionDismissFailed, {
                eventType = InterventionAnalytics.Constants.EventTypes.DialogInterventionDismissFailed,
                interventionType = tbl1.interventionTypeForAnalytics,
                placement = placement,
                renderedTimestamp = var2.current,
                eventId = tbl1.eventId,
                error = arg1.error,
                acknowledgeable = tbl1.acknowledgeable,
                abuseVector = tbl1.abuseVectorForAnalytics
            })

            if not bool2 and tbl1.onAcknowledgementFailure then
                tbl1.onAcknowledgementFailure()
            end
        end)
    end, {
        tbl1.acknowledgeable,
        nonEmptyString,
        tbl1.interventionTypeForAnalytics,
        placement,
        var2.current,
        tbl1.eventId,
        tbl1.abuseVectorForAnalytics,
        tbl1.onAcknowledgementSuccess,
        tbl1.onAcknowledgementFailure
    })

    local var11 = useCallback(function()
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogCtaClicked, {
            eventType = InterventionAnalytics.Constants.EventTypes.CtaClicked,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var2.current,
            eventId = tbl1.eventId,
            acknowledgeable = tbl1.acknowledgeable,
            abuseVector = tbl1.abuseVectorForAnalytics
        })
        var10()
        tbl1.onDismiss()
    end, {
        tbl1.onDismiss,
        tbl1.interventionTypeForAnalytics,
        placement,
        var2.current,
        tbl1.eventId,
        tbl1.abuseVectorForAnalytics,
        tbl1.acknowledgeable,
        nonEmptyString,
        var10,
        tbl1.onAcknowledgementSuccess
    })

    local var12 = useCallback(function()
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogAppealClicked, {
            eventType = InterventionAnalytics.Constants.EventTypes.AppealClicked,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var2.current,
            eventId = tbl1.eventId,
            acknowledgeable = tbl1.acknowledgeable,
            abuseVector = tbl1.abuseVectorForAnalytics
        })

        if tbl1.useDetailedLayout and tbl1.onAppeal then
            tbl1.onAppeal()

            if not tbl1.shouldOpenAppealsPortal then
                var10()
                tbl1.onDismiss()

                NotificationModalsManager.SetUIBloxToast({
                    iconImage = iconsActionsAccept,
                    toastTitle = var4.TakeALookText,
                    toastSubtitle = var4.FeedbackHelpsText,
                    sequenceNumber = DateTime.now().UnixTimestamp,
                    iconColorStyle = {
                        Color = var1.Color.System.Success.Color3,
                        Transparency = 0
                    }
                })

                return
            end
        end

        if VRService.VREnabled or bool1 then
            default:openURL(var5)
            return
        end
        var8()
    end, {
        var8,
        default,
        VRService.VREnabled,
        bool1,
        tbl1.interventionTypeForAnalytics,
        placement,
        var2.current,
        var5,
        tbl1.abuseVectorForAnalytics,
        tbl1.acknowledgeable,
        nonEmptyString,
        tbl1.eventId,
        var4.FeedbackHelpsText,
        var4.TakeALookText,
        tbl1.onAppeal,
        tbl1.shouldOpenAppealsPortal,
        tbl1.onDismiss,
        tbl1.useDetailedLayout,
        var1.Color.System.Success.Color3,
        var10
    })

    local tbl2 = {}
    local useDetailedLayout = tbl1.useDetailedLayout

    if tbl1.bodyText and tbl1.bodyText ~= "" then
        tbl2.BodyText = React.createElement(FoundationText, {
            Text = tbl1.bodyText,
            tag = "auto-xy text-body-medium content-default text-align-x-left text-wrap",
            testId = "dialog-body-text",
            LayoutOrder = 1
        })
    end

    if useDetailedLayout then
        local tbl3 = {}
        local var13 = FFlagUFRImprovements and nonEmptyString5 or nonEmptyString4 or fieldValue

        if nonEmptyString3 then
            tbl3.EvidenceItem = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y padding-x-medium",
                    testId = "dialog-evidence-item",
                    LayoutOrder = 1
                },
                {
                    EvidenceText = React.createElement(
                        FoundationText,
                        {
                            Text = nonEmptyString3,
                            tag = "auto-xy text-body-medium text-align-x-left text-wrap",
                            RichText = true
                        }
                    )
                }
            )

            if FFlagUFRImprovements and var13 then
                tbl3.DividerBelowEvidence = React.createElement(Divider, { LayoutOrder = 2 })
            end
        end

        if nonEmptyString5 then
            if not FFlagUFRImprovements and nonEmptyString3 then
                tbl3.DividerAfterEvidence = React.createElement(Divider, { LayoutOrder = 2 })
            end

            tbl3.ReasonItem = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y padding-x-medium",
                    testId = "dialog-reason-item",
                    LayoutOrder = 3
                },
                {
                    ReasonField = React.createElement(EvidenceField, { fieldLabel = var4.ReasonText, fieldValue = nonEmptyString5 })
                }
            )
        end

        if nonEmptyString4 then
            tbl3.NoteItem = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y padding-x-medium",
                    testId = "dialog-note-item",
                    LayoutOrder = 4
                },
                {
                    NoteText = React.createElement(EvidenceField, { fieldLabel = var4.ModeratorNoteLabel, fieldValue = nonEmptyString4 })
                }
            )
        end

        if fieldValue then
            tbl3.EndingOnItem = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y row padding-x-medium align-y-center",
                    testId = "dialog-ending-on-item",
                    LayoutOrder = 5
                },
                {
                    EndingOnInfo = React.createElement(View, {
                        tag = {
                            ["col fill"] = true,
                            ["auto-xy"] = FFlagUFRDialogContentCutoffFix,
                            ["auto-y"] = not FFlagUFRDialogContentCutoffFix
                        },
                        LayoutOrder = 1
                    }, {
                        EvidenceField = React.createElement(EvidenceField, { fieldLabel = var4.EndsOnText, fieldValue = fieldValue, hasColon = false })
                    }),
                    CountdownBadge = React.createElement(Badge, {
                        text = tbl1.countdownText or var4.CompleteText,
                        variant = BadgeVariant.Neutral,
                        icon = tbl1.countdownText and {
                            name = IconName.Clock,
                            position = IconPosition.Left,
                            variant = IconVariant.Filled
                        } or nil,
                        LayoutOrder = 2
                    })
                }
            )
        end

        if not Cryo.isEmpty(tbl3) then
            tbl2.DetailedList = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y padding-top-xxsmall padding-x-xxsmall padding-bottom-medium",
                    testId = "dialog-detailed-list",
                    LayoutOrder = 2
                },
                React.createElement(
                    View,
                    {
                        tag = "col gap-medium size-full-0 auto-y padding-y-large stroke-standard stroke-default radius-large bg-shift-100"
                    },
                    tbl3
                )
            )
        end
    elseif nonEmptyString3 or nonEmptyString5 or tbl1.isAppealable then
        tbl2.Evidence = React.createElement(View, {
            tag = "size-full-0 auto-y padding-xxsmall",
            LayoutOrder = 2
        }, { React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y col gap-small padding-medium radius-medium bg-surface-200 stroke-standard stroke-default"
                },
                {
                    EvidenceText = nonEmptyString3
                        and React.createElement(FoundationText, {
                            Text = nonEmptyString3,
                            tag = "auto-xy text-body-medium text-align-x-left text-wrap",
                            RichText = true,
                            LayoutOrder = 1
                        }),
                    Reason = nonEmptyString5
                        and React.createElement(FoundationText, {
                            Text = `<b>{var4.ReasonText}:</b>\n{nonEmptyString5}`,
                            tag = "auto-xy text-body-medium text-align-x-left text-wrap",
                            RichText = true,
                            LayoutOrder = 2
                        }),
                    AppealButton = tbl1.isAppealable
                        and React.createElement(Button, {
                            text = var4.ReportMistakeText,
                            variant = ButtonVariant.Standard,
                            size = ButtonSize.XSmall,
                            width = UDim.new(1, 0),
                            onActivated = var12,
                            LayoutOrder = 3
                        })
                }
            ) })
    end

    if nonEmptyString2 and not useDetailedLayout then
        tbl2.DsaMessage = React.createElement(FoundationText, {
            Text = nonEmptyString2,
            tag = "auto-xy text-caption-small content-default text-align-x-left text-wrap",
            LayoutOrder = 3
        })
    end

    local actions = {{
        variant = ButtonVariant.Emphasis,
        size = ButtonSize.Small,
        text = var4.OkText,
        onActivated = var11
    }}

    return React.createElement(Dialog.Root, {
        size = DialogSize.Medium,
        hasCloseButton = false,
        ref = ref,
        hasBackdrop = not VRService.VREnabled,
        disablePortal = placement ~= Constants.InterventionPlacementType.InExperience
    }, {
        DialogTitle = not tbl1.isLoading and React.createElement(Dialog.Title, { text = tbl1.titleText }),
        DialogContent = React.createElement(
            Dialog.Content,
            useDetailedLayout and { LayoutOrder = 2 } or nil,
            if tbl1.isLoading then React.createElement(InterventionDialogLoadingSkeleton) else React.createElement(View, { tag = "size-full-0 auto-y col gap-medium" }, tbl2)
        ),
        DialogFooter = not tbl1.isLoading
            and useDetailedLayout
            and React.createElement(InterventionDialogFooter, {
                ctaText = var4.OkText,
                dsaMessage = tbl1.dsaMessage,
                isAppealable = tbl1.isAppealable,
                onAppealActivated = var12,
                onCtaActivated = var11
            }),
        DialogActions = not tbl1.isLoading and not useDetailedLayout and React.createElement(Dialog.Actions, { actions = actions })
    })
end)
