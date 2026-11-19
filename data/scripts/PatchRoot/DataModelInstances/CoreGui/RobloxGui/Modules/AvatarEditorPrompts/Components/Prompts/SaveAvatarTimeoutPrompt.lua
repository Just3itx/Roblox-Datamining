-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local useSignalState = require(CorePackages.Packages.SignalsReact).useSignalState

local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local useDispatch = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useDispatch

local AvatarExperienceCommon = require(CorePackages.Workspace.Packages.AvatarExperienceCommon)
local AXPartialPageModal = AvatarExperienceCommon.Components.AXPartialPageModal
local getTimeoutStatusStore = AvatarExperienceCommon.Stores.getTimeoutStatusStore
local formatTimeoutEndTime = AvatarExperienceCommon.Utils.formatTimeoutEndTime
local LabelAbuseTypeMapping = AvatarExperienceCommon.Constants.LabelAbuseTypeMapping
local Foundation = require(CorePackages.Packages.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local scriptParentParentParent = script.Parent.Parent.Parent

local CloseOpenPrompt = require(scriptParentParentParent.Thunks.CloseOpenPrompt)

local function SaveAvatarTimeoutPrompt()
    local var1 = useDispatch()
    local timeoutStatusStore = getTimeoutStatusStore()
    local var2 = useSignalState(timeoutStatusStore.getTimeoutDetails)

    local var3 = React.useCallback(function()
        var1(CloseOpenPrompt)
    end, { var1 })

    local rule = var2 and LabelAbuseTypeMapping and LabelAbuseTypeMapping[var2.labelTranslationKey]
        or "Feature.NotApproved.Label.AbuseType.Other"

    local var5 = useLocalization({ rule = rule })

    local var6 = useLocalization({
        titleText = "Feature.Timeout.Prompt.SaveTitleText",
        bodyText = {
            "Feature.Timeout.Prompt.BodyText",
            rule = var5.rule or "",
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

return SaveAvatarTimeoutPrompt
