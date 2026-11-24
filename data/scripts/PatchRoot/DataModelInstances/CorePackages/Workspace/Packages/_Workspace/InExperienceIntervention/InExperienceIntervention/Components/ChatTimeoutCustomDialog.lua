-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local React = require(InExperienceInterventionParent.React)
local InterventionContestFeedbackFooter = require(InExperienceIntervention.Components.InterventionContestFeedbackFooter)

local UIBlox = require(InExperienceInterventionParent.UIBlox)
local Foundation = require(InExperienceInterventionParent.Foundation)
local FoundationText = Foundation.Text
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local View = Foundation.View
local Button = Foundation.Button
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local useTokens = Foundation.Hooks.useTokens
local useProperty = require(InExperienceInterventionParent.GuiObjectUtils).useProperty

local ReactFocusNavigation = require(InExperienceInterventionParent.ReactFocusNavigation)
local FocusNavigationUtils = require(InExperienceInterventionParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

function ChatTimeoutCustomDialog(tbl1)
    local var1 = useLayerCollector()
    local var2 = React.useRef(DateTime.now().UnixTimestampMillis)
    local ref = React.useRef(nil)
    local yOffset, var4 = React.useState(0)
    local var5 = useTokens()

    local var6 = useStyle()
    local var7 = useLocalization(Constants.localizationKeys)

    local var8 = useProperty(ref, "AbsoluteSize")

    local onActivated = React.useCallback(function()
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.CtaClicked,
            InExperienceInterventionAnalytics.Constants.InterventionTypes.Timeout,
            var2.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            tbl1.duration
        )
        tbl1.onDismiss()
    end, { var2 })

    React.useEffect(function()
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.ModalAppeared,
            InExperienceInterventionAnalytics.Constants.InterventionTypes.Timeout,
            var2.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            tbl1.duration
        )
    end, { var2 })

    React.useEffect(function()
        local num1 = math.min(var1.absoluteSize.Y - Constants.UNIBAR_HEIGHT - Constants.DIALOG_HEADER_HEIGHT, if var8 then var8.Y else 0)

        var4(num1)
    end, { var1.absoluteSize.Y, var8 })

    local var10 = if tbl1.duration <= 60 then var7.CannotSend1MinText else useLocalization({ value = { Constants.localizationKeys.CannotSendText, number = math.ceil(tbl1.duration / 60) } }).value
    return React.createElement(PartialPageModal, {
        title = var7.TextChatSuspensionText,
        screenSize = var1.absoluteSize
    }, {
        ScrollView = React.createElement(ScrollView, {
            Size = UDim2.new(1, 0, 0, yOffset),
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 1, 0),
                scrollBarVisibility = ScrollBarVisibility.Always,
                ScrollingDirection = Enum.ScrollingDirection.Y
            }
        }, {
            FocusNavigationCoreScriptsProvider = React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = focusNavigationService },
                {
                    FocusNavigationCoreScriptsWrapper = React.createElement(FocusRoot, {
                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                        isIsolated = true,
                        isAutoFocusRoot = true,
                        frameProps = {
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y
                        }
                    }, {
                        InnerContent = React.createElement(View, {
                            ref = ref,
                            Size = UDim2.new(1, -Constants.SCROLL_BAR_WIDTH, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            tag = "col gap-large align-x-center align-y-center padding-x-small padding-top-large"
                        }, {
                            ChatDisabledText = React.createElement(FoundationText, {
                                LayoutOrder = 1,
                                Text = var10,
                                textStyle = var6.Theme.TextEmphasis,
                                fontStyle = var5.Typography.LabelLarge,
                                Size = UDim2.new(1, 0, 0, 0),
                                TextXAlignment = Enum.TextXAlignment.Center,
                                TextYAlignment = Enum.TextYAlignment.Center,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                TextWrapped = true
                            }),
                            WarningTextLabel = React.createElement(FoundationText, {
                                LayoutOrder = 2,
                                Text = var7.MayLoseAccessText,
                                tag = "padding-small size-full-800 text-wrap",
                                TextWrapped = true,
                                AutomaticSize = Enum.AutomaticSize.Y
                            }),
                            UnderstandButtonFrame = React.createElement(
                                View,
                                {
                                    Size = UDim2.new(1, 0, 0, 0),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    LayoutOrder = 3
                                },
                                {
                                    UnderstandButton = React.createElement(Button, {
                                        text = var7.IUnderstandText,
                                        variant = ButtonVariant.Standard,
                                        onActivated = onActivated,
                                        fillBehavior = FillBehavior.Fill,
                                        FillDirection = Enum.FillDirection.Horizontal
                                    })
                                }
                            ),
                            FeedbackFrame = React.createElement(
                                View,
                                {
                                    Size = UDim2.new(1, 0, 0, 0),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    LayoutOrder = 4
                                },
                                {
                                    FeedbackFooter = React.createElement(InterventionContestFeedbackFooter, {
                                        onDismiss = tbl1.onDismiss,
                                        renderTimestamp = var2.current,
                                        interventionType = InExperienceInterventionAnalytics.Constants.InterventionTypes.Timeout,
                                        eventId = tbl1.eventId,
                                        violatingChatLine = tbl1.violatingChatLine,
                                        duration = tbl1.duration
                                    })
                                }
                            )
                        })
                    })
                }
            )
        })
    })
end
return ChatTimeoutCustomDialog
