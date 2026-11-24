-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local runGlobalChatCommand = require(ExpChat.runGlobalChatCommand)
local runVirtualChatCommand = require(ExpChat.runVirtualChatCommand)

local ExpChatParent = ExpChat.Parent
local Promise = require(ExpChatParent.Promise)
local List = require(ExpChatParent.llama).List
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Analytics = ExpChatShared.Analytics
local Logger = require(script.Parent.Logger)
local Config = require(ExpChat.Config)
local DictationAnalytics = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationAnalytics)
local computeEditDistance = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.computeEditDistance)
local bool1 = game:DefineFastFlag("ExpChatFlipDictationPriorityV2", false)

local function truncateToCharLimit(str1: string): (string, boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (#str1 > Config.MessageCharacterLimit) then
        return str1, false
    end

    return string.sub(str1, 1, Config.MessageCharacterLimit), true
end
local Commands = ExpChatShared.Commands
local GlobalCommands = ExpChatShared.GlobalCommands
local autoCastCommand = ExpChatShared.Commands.autoCastCommand
local RBXWhisperCommand = ExpChatShared.Commands.Whisper.RBXWhisperCommand

local ChatInputBarResetTargetChannel = ExpChatShared.Actions.ChatInputBarResetTargetChannel

local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagExpChatFixBackspaceNilTargetChannel = ExpChatShared.Flags.FFlagExpChatFixBackspaceNilTargetChannel
local FFlagExpChatDictatedSpeechEnabled = require(ExpChat.Flags.FFlagExpChatDictatedSpeechEnabled)
local bool2 = game:DefineFastFlag("ExpChatUseVirtualCommandRunner", false)
local getFFlagExpChatProtectedChatInternalAPIs = SharedFlags.getFFlagExpChatProtectedChatInternalAPIs
local FFlagExpChatDictation = SharedFlags.FFlagExpChatDictation
local FFlagExpChatDictationGrafanaMetrics = require(ExpChat.Flags.FFlagExpChatDictationGrafanaMetrics)

return function(arg1)
    return {
        activateWhisperMode = function(userId: number)
            local player = Players:GetPlayerByUserId(userId)
            local localPlayer = Players.LocalPlayer
            if not player or player == localPlayer then
                return
            end

            assert(localPlayer, "Players.LocalPlayer should be non-nil")

            local playerName = player.Name
            local tbl1 = { autoCastCommand(RBXWhisperCommand, localPlayer.UserId, "/w @" .. playerName) }

            Promise.any(tbl1):catch(function(arg2)
                Logger:debug("Could not send autoCastCommand. Error: {}", arg2)
            end)
        end,
        onToggleTranslation = function(bool3: boolean)
            GetMessagesStore(false).toggleGlobalTranslation(bool3)
        end,
        onToggleIndividualTranslation = function(useTranslation: boolean, str1: string)
            local tbl1 = {
                useTranslation = useTranslation,
                senderUserId = if Players.LocalPlayer then Players.LocalPlayer.UserId else nil,
                localeId = if Players.LocalPlayer then Players.LocalPlayer.LocaleId else nil
            }

            Analytics.FireClientAnalyticsWithEventName("MessageTranslationToggled", tbl1)

            GetMessagesStore(false).toggleMessageTranslation(useTranslation, str1)
        end,
        resetTargetChannel = function(bool3: boolean?)
            local var1 = arg1
            local var2 = ChatInputBarResetTargetChannel
            if not FFlagExpChatFixBackspaceNilTargetChannel then
                bool3 = nil
            end

            var1(var2(bool3))
        end,
        onHovered = function()
            GetTransparencyStore(false).resetAllTransparency()
        end,
        onUnhovered = function()
            GetTransparencyStore(false).resetAllTransparency()
        end,
        onSendChat = function(str1: string, tbl1, bool3: boolean?, arg2)
            if string.sub(str1, 1, 1) == "/"
                and runVirtualChatCommand(
                    str1,
                    Players.LocalPlayer and Players.LocalPlayer.UserId or 0,
                    Commands.getVirtualLocalEnabledCommands(),
                    "RBXGeneral"
                )
            then
                return
            end

            local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            local var1 = arg2
            if var1 == nil and chatInputBarConfiguration then
                var1 = chatInputBarConfiguration.TargetTextChannel
            end

            Logger:debug("onSendChat: {} to {}", str1, if var1 then var1.Name else "nil")
            if not var1 then
                Logger:warning("TargetTextChannel was nil!")
                return
            end

            Promise.try(function()
                if bool1 then
                    if FFlagExpChatDictatedSpeechEnabled and bool3 then
                        var1:SendDictatedSpeechAsync(str1)
                    elseif getFFlagExpChatProtectedChatInternalAPIs() then
                        var1:SendInternalAsync(str1)
                    else
                        var1:SendAsync(str1)
                    end
                elseif getFFlagExpChatProtectedChatInternalAPIs() then
                    var1:SendInternalAsync(str1)
                elseif FFlagExpChatDictatedSpeechEnabled and bool3 then
                    var1:SendDictatedSpeechAsync(str1)
                else
                    var1:SendAsync(str1)
                end

                local numParticipants = List.count(var1:GetChildren(), function(arg3)
                    return arg3:IsA("TextSource")
                end)

                local tbl2 = {
                    channelName = var1.Name,
                    senderUserId = if Players.LocalPlayer then Players.LocalPlayer.UserId else nil,
                    numParticipants = numParticipants,
                    isDefaultChannel = if Config[var1.Name] then "true" else "false"
                }
                if FFlagExpChatDictation and tbl1 then
                    tbl2[DictationAnalytics.Properties.SttMode] = tbl1.mode
                    tbl2[DictationAnalytics.Properties.SttOutcome] = tbl1.outcome
                end

                Analytics.FireClientAnalyticsWithEventName("LuaMessageSent", tbl2)

                if not FFlagExpChatDictation or not tbl1 then
                    return
                end

                local textStt = tbl1.textStt or ""
                local var3 = tbl1.textSent or str1
                local str2, bool4 = truncateToCharLimit(textStt)
                local str3, bool5 = truncateToCharLimit(var3)
                DictationAnalytics.fire(DictationAnalytics.Events.MessageSent, {
                    [DictationAnalytics.Properties.SttMode] = tbl1.mode,
                    [DictationAnalytics.Properties.SttOutcome] = tbl1.outcome,
                    [DictationAnalytics.Properties.FinalCharCount] = #var3,
                    [DictationAnalytics.Properties.WasEdited] = textStt ~= var3,
                    [DictationAnalytics.Properties.EditDistance] = computeEditDistance(textStt, var3),
                    [DictationAnalytics.Properties.TextStt] = str2,
                    [DictationAnalytics.Properties.TextSent] = str3,
                    [DictationAnalytics.Properties.TextSttTruncated] = bool4,
                    [DictationAnalytics.Properties.TextSentTruncated] = bool5
                })
                if FFlagExpChatDictationGrafanaMetrics then
                    DictationAnalytics.reportMessageSentCounter(tbl1.mode)
                end
            end):catch(function(arg3)
                warn(arg3.error)
            end)
        end,
        onSendGlobalChat = function(text: string, _, bool3: boolean?)
            if string.sub(text, 1, 1) == "/" then
                local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0

                if if bool2 then runVirtualChatCommand(text, userId, GlobalCommands.getGlobalEnabledCommands(), "RBXGlobal") else runGlobalChatCommand(text, userId) then
                    return
                end
            end
            Promise.try(function()
                if FFlagExpChatDictatedSpeechEnabled and bool3 then
                    TextChatService:SendDictatedSpeechUniverseChatAsync(text)
                    return
                end
                TextChatService:SendUniverseChatMessageAsync(text, "")
            end):catch(function(arg2)
                warn(arg2.error)
            end)
        end
    }
end
