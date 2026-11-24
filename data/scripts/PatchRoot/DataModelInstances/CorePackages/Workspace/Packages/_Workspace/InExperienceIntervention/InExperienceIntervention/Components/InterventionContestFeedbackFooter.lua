-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local React = require(InExperienceInterventionParent.React)
local UIBlox = require(InExperienceInterventionParent.UIBlox)
local Foundation = require(InExperienceInterventionParent.Foundation)

local useStyle = UIBlox.Core.Style.useStyle
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local FillBehavior = Foundation.Enums.FillBehavior
local View = Foundation.View
local Images = UIBlox.App.ImageSet.Images

local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local NotificationModalsManager = require(InExperienceInterventionParent.NotificationModalsManager)
local iconsActionsAccept = Images["icons/actions/accept"]
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

function getDynamicViewTagForTranslatedText(mistakeText, letUsKnowLinkText, smallScreenThreshold): string
    local str1 = "align-x-center align-y-center row"
    local num1 = string.len(mistakeText) + string.len(letUsKnowLinkText)

    if Constants.MAX_CHARACTERS_IN_SHORT_LINE <= num1 and smallScreenThreshold < Constants.SMALL_SCREEN_THRESHOLD
        or Constants.MAX_CHARACTERS_IN_LONG_LINE <= num1
    then
        str1 = "align-x-center align-y-center col flex-fill"
    end

    return str1
end

function InterventionFeedbackFooter(tbl1)
    local var1 = useLocalization(Constants.localizationKeys)
    local var2 = useLayerCollector()
    local tag = getDynamicViewTagForTranslatedText(var1.MistakeText, var1.LetUsKnowLinkText, var2.absoluteSize.X)

    local var3 = useStyle()

    local function handleMistakeActivated()
        tbl1.onDismiss()
        NotificationModalsManager.SetUIBloxToast({
            iconImage = iconsActionsAccept,
            toastTitle = var1.TakeALookText,
            toastSubtitle = var1.FeedbackHelpsText,
            sequenceNumber = DateTime.now().UnixTimestamp,
            iconColorStyle = {
                Color = var3.Tokens.Color.System.Success.Color3,
                Transparency = 0
            }
        })

        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.AppealClicked,
            tbl1.interventionType,
            tbl1.renderTimestamp,
            tbl1.eventId,
            tbl1.violatingChatLine,
            tbl1.duration
        )
    end

    return React.createElement(View, {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        tag = tag,
        Wraps = true
    }, {
        MistakeTextLabelFrame = React.createElement(View, {
            LayoutOrder = 1,
            Size = UDim2.new(0.5, 0, 0, Constants.TIMEOUT_INLINE_HEIGHT),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1
        }, {
            MistakeTextLabel = React.createElement(FoundationText, {
                Text = var1.MistakeText,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                tag = "padding-small text-align-x-center size-1200-900",
                AutomaticSize = Enum.AutomaticSize.X
            })
        }),
        LinkFrame = React.createElement(View, {
            LayoutOrder = 2,
            Size = UDim2.new(0.5, 0, 0, Constants.TIMEOUT_INLINE_HEIGHT),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X
        }, {
            Button = React.createElement(Button, {
                text = var1.LetUsKnowLinkText,
                variant = ButtonVariant.Text,
                onActivated = handleMistakeActivated,
                size = ButtonSize.Small,
                fillBehavior = FillBehavior.Fill
            })
        })
    })
end

return InterventionFeedbackFooter
