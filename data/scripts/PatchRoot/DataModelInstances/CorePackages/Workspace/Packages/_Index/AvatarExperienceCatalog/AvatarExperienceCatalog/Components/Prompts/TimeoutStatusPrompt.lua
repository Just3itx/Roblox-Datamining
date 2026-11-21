-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState

local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2
local Constants = require(AvatarExperienceCatalog.Constants)

local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AXPartialPageModal = AvatarExperienceCommon.Components.AXPartialPageModal
local getTimeoutStatusStore = AvatarExperienceCommon.Stores.getTimeoutStatusStore
local formatTimeoutEndTime = AvatarExperienceCommon.Utils.formatTimeoutEndTime
local LabelAbuseTypeMapping = AvatarExperienceCommon.Constants.LabelAbuseTypeMapping
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function TimeoutStatusPrompt()
    local var1 = useNavigation()
    local timeoutStatusStore = getTimeoutStatusStore()
    local var2 = useSignalState(timeoutStatusStore.getTimeoutDetails)

    React.useEffect(function()
        sendAXCounterV2(
            Constants.COUNTERS.TimeoutStatusPromptShown,
            {
                labelTranslationKey = if var2 then var2.labelTranslationKey else ""
            }
        )
    end, {})

    local var3 = React.useCallback(function()
        var1.dispatch(RoactNavigation.Actions.back(nil))
    end, { var1 })

    local rule = var2 and LabelAbuseTypeMapping and LabelAbuseTypeMapping[var2.labelTranslationKey]
        or "Feature.NotApproved.Label.AbuseType.Other"

    local var5 = useLocalization({ rule = rule })

    local var6 = useLocalization({
        titleText = "Feature.Timeout.Prompt.TitleText",
        bodyText = {
            "Feature.Timeout.Prompt.BodyText",
            rule = var5.rule,
            time = if var2 then formatTimeoutEndTime(var2.endDate) else ""
        },
        closeText = "Feature.Timeout.Label.OK"
    })

    return React.createElement(AXPartialPageModal, {
        onBackgroundPress = var3,
        buttonStackProps = {
            rowLayout = false,
            buttons = {{
                props = {
                    onActivated = var3,
                    text = var6.closeText,
                    variant = ButtonVariant.Standard,
                    size = InputSize.Medium
                }
            }}
        }
    }, {
        ViewFrame = React.createElement(
            View,
            { tag = "auto-y size-full-0 padding-bottom-xxlarge col align-x-left align-y-top" },
            {
                PromptBodyTitle = React.createElement(FoundationText, {
                    tag = "auto-xy padding-bottom-small text-align-x-left text-heading-small text-wrap",
                    Text = var6.titleText,
                    LayoutOrder = 2
                }),
                PromptBodyText = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-align-x-left text-body-large text-wrap font-family-code",
                        Text = var6.bodyText,
                        LayoutOrder = 3
                    }
                )
            }
        )
    })
end

return TimeoutStatusPrompt
