-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local useStableSignal = require(ExpChatParent.ChatUIPrimitives).Hooks.useStableSignal
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)

local ChatWindow = require(script.Parent.ChatWindow)
local createMessageChildren = require(script.Parent.createMessageChildren)
local useV2MessagePool = require(ExpChat.ChatWindow.UI.BottomLockedScrollViewV3.useV2MessagePool)

local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local FFlagExpChatRewriteInline = require(ExpChat.Flags.FFlagExpChatRewriteInline)

local getFFlagChatWindowUseCallbackOptimizations = require(ExpChat.Flags.getFFlagChatWindowUseCallbackOptimizations)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local isGlobalChatMessage = require(ExpChat.isGlobalChatMessage)

local function ChatWindowMessageSource(tbl1)
    local messageComponentsSignal, var2 = useStableSignal({})
    local var3 = React.useRef(nil)

    local onTextMessageLabelButtonActivated = React.useCallback(function(arg1)
        if isGlobalChatMessage(arg1) then
            return
        end

        tbl1.resetTargetChannel()

        local var4 = tonumber(arg1.userId)
        if var4 then
            tbl1.activateWhisperMode(var4)
        end
    end, getFFlagChatWindowUseCallbackOptimizations() and { tbl1.resetTargetChannel, tbl1.activateWhisperMode } or nil)

    local messagesStore = GetMessagesStore(false)
    local var5 = React.useBinding(0)
    local textTransparency = tbl1.textTransparency or var5
    local children

    if FFlagExpChatEnableV2ChatWindow then
        children = useV2MessagePool({
            enabled = true,
            visible = tbl1.visible,
            messagesStore = messagesStore,
            textTransparency = textTransparency,
            chatWindowSettings = tbl1.chatWindowSettings or {},
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled or false,
            onTextMessageLabelButtonActivated = onTextMessageLabelButtonActivated,
            targetTextChannel = tbl1.targetTextChannel,
            isChannelBarVisible = tbl1.isChannelBarVisible,
            showTranslationButton = tbl1.showTranslationButton or false,
            chatWindowTransparencyBindable = if FFlagExpChatRewriteInline then tbl1.transparencyValue else nil,
            selectedChannelName = if GetFFlagTextChatEnableUniverseChatTabs() then tbl1.selectedChannelName else nil
        }).children
    else
        children = nil
    end

    local var7 = React.useMemo(function()
        if FFlagExpChatEnableV2ChatWindow then
            return nil
        end
        return createMessageChildren({
            messages = tbl1.messages or {},
            verifiedUserIds = tbl1.verifiedUserIds or {},
            textTransparency = textTransparency,
            transparencyValue = tbl1.transparencyValue,
            chatWindowSettings = tbl1.chatWindowSettings,
            showTranslationButton = tbl1.showTranslationButton or false,
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
            onTextMessageLabelButtonActivated = onTextMessageLabelButtonActivated
        })
    end, {
        tbl1.messages,
        tbl1.verifiedUserIds,
        textTransparency,
        tbl1.transparencyValue,
        tbl1.chatWindowSettings,
        tbl1.showTranslationButton,
        tbl1.isSpatialUIEnabled,
        onTextMessageLabelButtonActivated
    })

    if FFlagExpChatEnableV2ChatWindow then
        var7 = children
    end

    if var3.current ~= var7 then
        var2(var7 or {})
        var3.current = var7
    end

    return React.createElement(ChatWindow, Dictionary.join(tbl1, { messageComponentsSignal = messageComponentsSignal }))
end

return ChatWindowMessageSource
