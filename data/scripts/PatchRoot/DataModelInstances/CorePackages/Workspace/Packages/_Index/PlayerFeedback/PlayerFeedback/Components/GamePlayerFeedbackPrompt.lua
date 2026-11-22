-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedback = script:FindFirstAncestor("PlayerFeedback")
local PlayerFeedbackParent = PlayerFeedback.Parent
local React = require(PlayerFeedbackParent.React)
local UIBlox = require(PlayerFeedbackParent.UIBlox)
local InlinePrompt = require(PlayerFeedbackParent.AppBlox).InlinePrompt
local useLocalization = require(PlayerFeedbackParent.Localization).Hooks.useLocalization
local RobloxAppHooks = require(PlayerFeedbackParent.RobloxAppHooks)
local RoactServiceTags = require(PlayerFeedbackParent.RoactServiceTags)
local useRoactService = RobloxAppHooks.useRoactService
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local PlayerFeedbackEvents = require(PlayerFeedback.Analytics.Events.PlayerFeedbackEvents)
local GetFFlagEdpPlayerFeedbackPromptTitleOnly = require(PlayerFeedbackParent.SharedFlags).GetFFlagEdpPlayerFeedbackPromptTitleOnly
local Images = UIBlox.App.ImageSet.Images
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local function GamePlayerFeedbackPrompt(tbl1)
    local var1 = useLocalization({
        buttonLabelKey = "PlayerFeedbacks.VoteForm.PromptBanner.GiveFeedbackButton",
        messageKey = "PlayerFeedbacks.VoteForm.PromptBanner.Message",
        titleKey = "PlayerFeedbacks.VoteForm.PromptBanner.Title",
        titleOnlyKey = if GetFFlagEdpPlayerFeedbackPromptTitleOnly() then "PlayerFeedbacks.VoteForm.PromptBanner.TitleOnly" else nil
    })

    local var2 = useRoactService(AppEventIngestService)
    local onActivated = React.useCallback(function()
        PlayerFeedbackEvents.ClickPlayerFeedbackPromptCta(var2, tbl1.placeId)
        tbl1.onButtonClick()
    end, { var2, tbl1.placeId, tbl1.onButtonClick })

    local onDismiss = React.useCallback(function()
        PlayerFeedbackEvents.DismissPlayerFeedbackPrompt(var2, tbl1.placeId)
        tbl1.onDimiss()
    end, { var2, tbl1.placeId, tbl1.onDimiss })

    React.useEffect(function()
        PlayerFeedbackEvents.PlayerFeedbackPromptMounted(var2, tbl1.placeId)
    end, { var2, tbl1.placeId })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = if tbl1.width then UDim2.new(0, tbl1.width, 0, 0) else UDim2.new(1, 0, 0, 0),
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        InlinePrompt = React.createElement(InlinePrompt, {
            iconImage = if GetFFlagEdpPlayerFeedbackPromptTitleOnly() then nil else Images["icons/menu/platformChatOff"],
            titleMessage = if GetFFlagEdpPlayerFeedbackPromptTitleOnly() then var1.titleOnlyKey else var1.titleKey,
            sublineMessage = if GetFFlagEdpPlayerFeedbackPromptTitleOnly() then nil else var1.messageKey,
            buttonProps = {
                text = var1.buttonLabelKey,
                buttonType = ButtonType.Secondary,
                standardSize = StandardButtonSize.XSmall,
                onActivated = onActivated
            },
            showDismiss = true,
            onDismiss = onDismiss,
            backgroundTransparency = tbl1.backgroundTransparency,
            backgroundColor3 = tbl1.backgroundColor3
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return GamePlayerFeedbackPrompt
