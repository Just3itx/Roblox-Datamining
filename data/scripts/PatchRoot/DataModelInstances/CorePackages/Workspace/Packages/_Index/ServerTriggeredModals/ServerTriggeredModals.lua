-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SharedFlags = require(script.Parent.SharedFlags)
local SduiV2 = require(script.SduiV2)
local PromptsHandler = require(script.SduiV2.PromptsHandler)

local FFlagLuaAppsServerTriggeredModals = SharedFlags.FFlagLuaAppsServerTriggeredModals
local FFlagEnableProfileCompletion = SharedFlags.FFlagEnableProfileCompletion
local FFlagEnableSduiV2HomepagePrompts = SharedFlags.FFlagEnableSduiV2HomepagePrompts
local FFlagEnableHomepagePromptsForModalsAndBanners = SharedFlags.FFlagEnableHomepagePromptsForModalsAndBanners
local FFlagPromptsHandlerEnabled = SharedFlags.FFlagPromptsHandlerEnabled
local FFlagEdpGameLeavePromptsHandlerEnabled = SharedFlags.FFlagEdpGameLeavePromptsHandlerEnabled
local FFlagEdpOpenPromptsHandlerEnabled = SharedFlags.FFlagEdpOpenPromptsHandlerEnabled
local FFlagChatPushUpsellPromptsEnabled = SharedFlags.FFlagChatPushUpsellPromptsEnabled
local FFlagNotificationStreamPromptsHandlerEnabled = SharedFlags.FFlagNotificationStreamPromptsHandlerEnabled

return {
    ["jest.config"] = script["jest.config"],
    CheckForSduiModal = if FFlagLuaAppsServerTriggeredModals then require(script.CheckForSduiModal) else nil,
    SduiModal = if FFlagLuaAppsServerTriggeredModals then require(script.SduiModal) else nil,
    PromptsContainer = if FFlagEnableSduiV2HomepagePrompts or FFlagPromptsHandlerEnabled then require(script.PromptsContainer) else nil,
    CheckForPrompts = if FFlagEnableSduiV2HomepagePrompts then require(script.CheckForPrompts) else nil,
    PromptsConstants = require(script.PromptsConstants),
    fetchPrompts = if FFlagEnableProfileCompletion or FFlagPromptsHandlerEnabled then SduiV2.fetchPrompts else nil,
    PromptsEntryPoint = if FFlagEnableProfileCompletion or FFlagPromptsHandlerEnabled then SduiV2.PromptsEntryPoint else nil,
    PromptStyle = if FFlagEnableHomepagePromptsForModalsAndBanners or FFlagPromptsHandlerEnabled then SduiV2.PromptStyle else nil,
    usePromptEntries = if FFlagEnableHomepagePromptsForModalsAndBanners then SduiV2.usePromptEntries else nil,
    PromptsSystemBanner = if FFlagEnableHomepagePromptsForModalsAndBanners then require(script.PromptsSystemBanner) else nil,
    reportPromptImpression = if FFlagEnableProfileCompletion then require(script.reportPromptImpression) else nil,
    PromptsHandler = if FFlagPromptsHandlerEnabled then PromptsHandler.PromptsHandler else nil,
    EdpGameLeavePromptsHandler = if FFlagEdpGameLeavePromptsHandlerEnabled then require(script.SduiV2.EdpGameLeavePromptsHandler) else nil,
    EdpOpenPromptsHandler = if FFlagEdpOpenPromptsHandlerEnabled then require(script.SduiV2.EdpOpenPromptsHandler) else nil,
    ChatPromptsHandler = if FFlagChatPushUpsellPromptsEnabled then require(script.SduiV2.ChatPromptsHandler) else nil,
    StreamPromptsHandler = if FFlagNotificationStreamPromptsHandlerEnabled then require(script.SduiV2.StreamPromptsHandler) else nil
}
