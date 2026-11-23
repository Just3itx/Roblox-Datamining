-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local ChatCardPriority = require(script.Parent.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(script.Parent.ChatCardEmphasis.useChatCardEmphasis)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function PushNotificationsUpsellCard(tbl1)
    local var1 = useLocalization({
        disabledDescription = LocalizationStrings.CHAT_NOTIFICATION_DISABLED_DESCRIPTION,
        dontAskAgain = LocalizationStrings.CHAT_DONT_ASK_AGAIN,
        notifyMe = LocalizationStrings.CHAT_NOTIFY_ME,
        openSettings = LocalizationStrings.CHAT_OPEN_SETTINGS,
        promptDescription = LocalizationStrings.CHAT_NOTIFICATION_PROMPT_DESCRIPTION,
        promptTitle = LocalizationStrings.CHAT_NOTIFICATION_PROMPT_TITLE
    })
    local bool1 = tbl1.shouldOpenSettings == true
    local var2 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(ChatCardPriority.PushNotificationsUpsell) else nil
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
        testId = "PushNotificationsUpsellCard"
    }

    local tbl3 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var1.promptTitle,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        Description = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = if bool1 then var1.disabledDescription else var1.promptDescription,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
        }),
        Actions = 0
    }

    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = { LayoutOrder = 3, tag = "row gap-small size-full-0 auto-y" }

    local tbl5 = {
        PrimaryAction = React.createElement(Button, {
            LayoutOrder = 1,
            text = if bool1 then var1.openSettings else var1.notifyMe,
            size = InputSize.Small,
            variant = if var2 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            isLoading = tbl1.isRequestPending == true,
            onActivated = if bool1 then tbl1.onOpenSettings else tbl1.onNotifyMe,
            testId = if bool1 then "PushNotificationsUpsellCard.OpenSettings" else "PushNotificationsUpsellCard.NotifyMe"
        }),
        NotNow = React.createElement(Button, {
            LayoutOrder = 2,
            text = var1.dontAskAgain,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onNotNow,
            testId = "PushNotificationsUpsellCard.NotNow"
        })
    }
    tbl3.Actions = createElement2(var4, tbl4, tbl5)
    return createElement(var3, tbl2, tbl3)
end

return PushNotificationsUpsellCard
