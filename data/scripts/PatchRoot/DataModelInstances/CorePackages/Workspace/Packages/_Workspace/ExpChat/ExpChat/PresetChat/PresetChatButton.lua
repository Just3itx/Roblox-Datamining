-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Config = require(ExpChat.Config)
local Constants = require(ExpChat.PresetChat.Constants)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)
local Localization = require(ExpChat.Localization)
local PresetChatTooltip = require(script.Parent.PresetChatTooltip)
local hasPresetEmoji = require(script.Parent.hasPresetEmoji)
local setIsPresetTrayOpen = require(script.Parent.Thunks.setIsPresetTrayOpen)
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local FFlagExpChatCenterMobilePresetButton = require(ExpChat.Flags.FFlagExpChatCenterMobilePresetButton)
local FFlagExpChatPresetFullWidthButtonFixes = require(ExpChat.Flags.FFlagExpChatPresetFullWidthButtonFixes)
local FFlagExpChatPresetEntryPointClickAction = require(ExpChat.Flags.FFlagExpChatPresetEntryPointClickAction)

local FFlagExpChatPresetChatCircleFaceEmojiEntryPointRolloutEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatCircleFaceEmojiEntryPointRolloutEnabled)

local ExpChatPresetChatEmojiTabExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiTabExperimentation

return React.memo(function(tbl1) -- name: PresetChatButton
    local var1 = React.useRef(false)
    local var2 = if FFlagExpChatPresetFullWidthButtonFixes then React.useRef(nil) else nil
    local var3 = if FFlagExpChatPresetFullWidthButtonFixes then React.useRef(nil) else nil

    if tbl1.fullWidth then
        var2 = var3
    end
    local var4 = Localization.useLocalization({ sendQuickWords = "CoreScripts.TextChat.Action.SendQuickWords" })

    local presetChatStore = GetPresetChatStore(false)
    local var5 = SignalsReact.useSignalState(presetChatStore.getIsTrayOpen)

    local bool1 = false
    if FFlagExpChatPresetChatCircleFaceEmojiEntryPointRolloutEnabled then
        local var6 = SignalsReact.useSignalState(presetChatStore.getCategoryGroups)
        bool1 = React.useMemo(function()
            return hasPresetEmoji(var6)
        end, { var6 })
    elseif ExpChatPresetChatEmojiTabExperimentation.isExperimentEnabled then
        bool1 = ExpChatPresetChatEmojiTabExperimentation.getIsEmojiIconEnabled()
    end

    local onActivated = React.useCallback(function()
        if FFlagExpChatUseUnifiedTooltipStore then
            local chatTooltipStore = GetChatTooltipStore(false)
            if not var1.current then
                var1.current = true
                chatTooltipStore.reportImpression("PresetChatTooltip")
            end
            chatTooltipStore.setIsDismissed("PresetChatTooltip", true)
        end
        local isTrayOpen = presetChatStore.getIsTrayOpen(false)
        setIsPresetTrayOpen(presetChatStore, not isTrayOpen)
        local analytics = ExpChatShared.Analytics
        local expChatPresetActionConfig = ExpChatShared.Analytics.ExpChatPresetActionConfig
        local tbl2 = {
            event_type = Constants.Analytics.EventTypes.Click,
            component = Constants.Analytics.Components.PresetEntryPointButton,
            extra_json = if FFlagExpChatPresetEntryPointClickAction then HttpService:JSONEncode(
                {
                    click_action = if isTrayOpen then Constants.Analytics.ClickActions.Close else Constants.Analytics.ClickActions.Open
                }
            ) else nil
        }
        analytics:TelemetryLogEvent(expChatPresetActionConfig, tbl2, ExpChatShared.Analytics.DefaultStandardizedFields)
    end, { presetChatStore })

    local element

    if tbl1.fullWidth then
        element = React.createElement(Foundation.Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fit,
            onActivated = onActivated,
            text = var4.sendQuickWords,
            variant = Foundation.Enums.ButtonVariant.Standard,
            width = UDim.new(1, 0),
            ref = if FFlagExpChatPresetFullWidthButtonFixes then var2 else nil,
            testId = "--social-exp-chat-button-send-quick-words"
        })
    else
        element = React.createElement(Foundation.IconButton, {
            icon = {
                name = if bool1 then Config.PresetChat.EmojiIcon else Config.PresetChat.Icon,
                variant = if var5 then Config.PresetChat.IconVariantActive else Config.PresetChat.IconVariant
            },
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = if tbl1.size ~= nil then tbl1.size else Foundation.Enums.InputSize.Small,
            isCircular = tbl1.isCircular == nil or tbl1.isCircular,
            isDisabled = false,
            onActivated = onActivated,
            ref = if FFlagExpChatPresetFullWidthButtonFixes then var2 else nil,
            testId = "--social-exp-chat-iconbutton-quick-words"
        })
    end

    local createElement = React.createElement
    local var7 = PresetChatTooltip
    local tbl2 = {
        targetTextChannel = tbl1.targetTextChannel,
        anchorRef = 0
    }

    if not FFlagExpChatPresetFullWidthButtonFixes then
        var2 = nil
    end

    tbl2.anchorRef = var2
    local element2 = createElement(var7, tbl2, element)

    if not FFlagExpChatCenterMobilePresetButton or tbl1.addTopPadding == nil then
        return element2
    end

    return React.createElement(Foundation.View, {
        tag = {
            ["size-full-0 auto-y"] = FFlagExpChatPresetFullWidthButtonFixes and tbl1.fullWidth == true,
            ["auto-xy"] = not FFlagExpChatPresetFullWidthButtonFixes or tbl1.fullWidth ~= true or false
        },
        padding = {
            top = UDim.new(0, if tbl1.addTopPadding then 8 else 0),
            bottom = UDim.new(0, 1)
        }
    }, element2)
end)
