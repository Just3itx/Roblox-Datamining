-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SignalsReact = require(ExpChatParent.SignalsReact)

local useStore = RoactUtils.Hooks.RoactRodux.useStore
local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local emojiUnicodeToId = require(ExpChat.PresetChat.emojiUnicodeToId)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local selectSelectedTabName = require(ExpChat.selectSelectedTabName)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local FFlagExpChatBlockExpressionTrayFromRBXWhisper = require(ExpChat.Flags.FFlagExpChatBlockExpressionTrayFromRBXWhisper)

local var1 = ExpChatShared.Logger:new("ExpChat/PresetChat/useOnEmojiActivated")

local function getRBXGeneralChannel(): TextChannel? -- Luacid: Inlined by compiler; 1 call site recovered
    local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
    return if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil
end

local function useOnEmojiActivated(tbl1)
    local var2 = useStore()
    local var3 = SignalsReact.useSignalState(GetMessagesStore(false).getCanLocalUserChat)
    local textChannel = tbl1.textChannel
    local onSendChat = tbl1.onSendChat
    local onSendGlobalChat = tbl1.onSendGlobalChat
    local closePresetTray = tbl1.closePresetTray

    local useCallback = React.useCallback
    local function func1(str1: string)
        if FFlagExpChatPresetTrayDismissAnalytics then
            local presetChatStore = GetPresetChatStore(false)
            if presetChatStore.getIsTrayOpen(false) then
                presetChatStore.incrementPresetClickCount(emojiUnicodeToId(str1))
            end
        end

        local var4 = GetFFlagTextChatEnableUniverseChatTabs() and selectSelectedTabName(var2:getState()) == "RBXGlobal"
        if not var3 then
            var1:debug("Emoji activated but the local user can't chat; skipping send.")
        elseif var4 and onSendGlobalChat then
            onSendGlobalChat(str1)
        elseif not onSendChat then
            var1:warning("Emoji activated but no chat send callback was provided; skipping send.")
        elseif FFlagExpChatBlockExpressionTrayFromRBXWhisper and textChannel and string.find(textChannel.Name, "^RBXWhisper") then
            local rBxGeneralChannel = getRBXGeneralChannel()

            if rBxGeneralChannel then
                onSendChat(str1, nil, nil, rBxGeneralChannel)
            else
                var1:warning("Emoji activated on a whisper channel but there is no RBXGeneral; skipping send.")
            end
        else
            onSendChat(str1)
        end
        closePresetTray()
    end

    local var4 = if FFlagExpChatBlockExpressionTrayFromRBXWhisper then textChannel or false else false
    return useCallback(func1, { var2, var3, var4, onSendChat or false, onSendGlobalChat or false, closePresetTray })
end

return useOnEmojiActivated
