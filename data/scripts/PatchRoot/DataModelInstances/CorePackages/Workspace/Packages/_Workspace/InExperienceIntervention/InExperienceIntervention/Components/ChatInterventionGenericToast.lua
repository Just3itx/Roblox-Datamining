-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local React = require(InExperienceInterventionParent.React)
local UIBlox = require(InExperienceInterventionParent.UIBlox)
local Foundation = require(InExperienceInterventionParent.Foundation)
local Images = UIBlox.App.ImageSet.Images
local useTokens = Foundation.Hooks.useTokens
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local Toast = UIBlox.App.Dialog.Toast

local duration = game:DefineFastInt("InExperienceInterventionToastDuration", 5)

function ChatNudgeToast(tbl1)
    local var1 = React.useRef(DateTime.now().UnixTimestampMillis)
    local var2 = useTokens()

    local function onAppeared()
        var1.current = DateTime.now().UnixTimestampMillis
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            tbl1.toastAppearEventName,
            tbl1.interventionType,
            var1.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            tbl1.remainingDurationSec
        )
    end

    local function onTouchSwipeUp()
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            tbl1.toastDismissEventName,
            tbl1.interventionType,
            var1.current,
            tbl1.eventId,
            tbl1.violatingChatLine,
            tbl1.remainingDurationSec
        )
    end

    return React.createElement(
        "ScreenGui",
        {
            IgnoreGuiInset = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            ResetOnSpawn = false,
            DisplayOrder = 7
        },
        {
            Toast = React.createElement(Toast, {
                toastContent = {
                    toastTitle = tbl1.toastTitle,
                    iconColorStyle = {
                        Color = tbl1.iconColor or var2.Color.System.Warning.Color3,
                        Transparency = 0
                    },
                    iconImage = Images["icons/status/error_large"],
                    iconSize = Vector2.new(36, 36),
                    onAppeared = onAppeared,
                    toastSubtitle = tbl1.toastBody,
                    sequenceNumber = DateTime.now().UnixTimestamp,
                    onTouchSwipeUp = onTouchSwipeUp
                },
                duration = duration
            })
        }
    )
end
return ChatNudgeToast
