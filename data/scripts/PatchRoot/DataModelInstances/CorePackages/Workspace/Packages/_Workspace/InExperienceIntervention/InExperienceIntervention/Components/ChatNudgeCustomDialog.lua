-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local Players = game:GetService("Players")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local React = require(InExperienceInterventionParent.React)
local InterventionContestFeedbackFooter = require(InExperienceIntervention.Components.InterventionContestFeedbackFooter)

local UIBlox = require(InExperienceInterventionParent.UIBlox)
local Foundation = require(InExperienceInterventionParent.Foundation)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local FoundationText = Foundation.Text
local View = Foundation.View
local Button = Foundation.Button
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local LocalPlayer = Players.LocalPlayer
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local useProperty = require(InExperienceInterventionParent.GuiObjectUtils).useProperty

local ReactFocusNavigation = require(InExperienceInterventionParent.ReactFocusNavigation)
local FocusNavigationUtils = require(InExperienceInterventionParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

function ChatNudgeCustomDialog(tbl1)
    local var1 = React.useRef(DateTime.now().UnixTimestampMillis)
    local ref = React.useRef(nil)
    local yOffset, var3 = React.useState(0)
    React.useEffect(function()
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.ModalAppeared,
            InExperienceInterventionAnalytics.Constants.InterventionTypes.Nudge,
            var1.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            nil
        )
    end, { var1 })
    local var4 = useLocalization(Constants.localizationKeys)
    local var5 = useStyle()
    local var6 = useLayerCollector()
    local var7 = useTokens()

    local var8 = useProperty(ref, "AbsoluteSize")

    React.useEffect(function()
        local var9 = if var8 then var8.Y else 0
        local num1 = math.min(var6.absoluteSize.Y - Constants.UNIBAR_HEIGHT - Constants.DIALOG_HEADER_HEIGHT, var9)

        var3(num1)
    end, { var6.absoluteSize.Y, var8 })

    local var9 = if LocalPlayer then `{LocalPlayer.DisplayName}: {tbl1.violatingChatLine}` else tbl1.violatingChatLine

    local onActivated = React.useCallback(function()
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.CtaClicked,
            InExperienceInterventionAnalytics.Constants.InterventionTypes.Nudge,
            var1.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            nil
        )
        tbl1.onDismiss()
    end, { var1 })

    local element

    if tbl1.violatingChatLine then
        element = React.createElement(
            View,
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            },
            {
                Layout = React.createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, Constants.STANDARD_PADDING / 2)
                }),
                ChatIncludesTextFrame = React.createElement(
                    View,
                    {
                        Size = UDim2.new(1, 0, 0, 0),
                        LayoutOrder = 1,
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        ChatIncludesText = React.createElement(FoundationText, {
                            Text = var4.ChatIncludesText,
                            fontStyle = var7.Typography.BodySmall,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            AnchorPoint = Vector2.new(0, 0),
                            AutomaticSize = Enum.AutomaticSize.XY
                        })
                    }
                ),
                ViolatingTextFrame = React.createElement(View, {
                    Size = UDim2.new(1, 0, 0, Constants.VIOLATION_HEIGHT),
                    LayoutOrder = 2,
                    BackgroundTransparency = 0,
                    BackgroundColor3 = var5.Theme.BackgroundUIDefault.Color,
                    tag = "col gap-small align-x-center align-y-center padding-x-large radius-medium stroke-default"
                }, {
                    ViolationText = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = var9,
                        textStyle = var5.Theme.TextMuted,
                        fontStyle = var5.Font.Body,
                        Size = UDim2.new(1, 0, 0, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = true,
                        TextTruncate = Enum.TextTruncate.AtEnd
                    })
                })
            }
        )
    else
        element = nil
    end

    return React.createElement(PartialPageModal, {
        title = var4.ChatBreaksRulesText,
        screenSize = var6.absoluteSize
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
                            MiddleContent = element,
                            WarningText = React.createElement(FoundationText, {
                                LayoutOrder = 3,
                                Text = var4.TextChatMayBeSuspendedText,
                                textStyle = var5.Theme.TextEmphasis,
                                fontStyle = var5.Font.Body,
                                Size = UDim2.new(1, 0, 0, 0),
                                TextXAlignment = Enum.TextXAlignment.Center,
                                TextYAlignment = Enum.TextYAlignment.Center,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                TextWrapped = true
                            }),
                            UnderstandButtonFrame = React.createElement(
                                View,
                                {
                                    Size = UDim2.new(1, 0, 0, 0),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    LayoutOrder = 4
                                },
                                {
                                    UnderstandButton = React.createElement(Button, {
                                        text = var4.IUnderstandText,
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
                                    LayoutOrder = 5
                                },
                                {
                                    FeedbackFooter = React.createElement(InterventionContestFeedbackFooter, {
                                        onDismiss = tbl1.onDismiss,
                                        renderTimestamp = var1.current,
                                        interventionType = InExperienceInterventionAnalytics.Constants.InterventionTypes.Nudge,
                                        eventId = tbl1.eventId,
                                        violatingChatLine = tbl1.violatingChatLine,
                                        duration = nil
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

return ChatNudgeCustomDialog
