-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local LuauPolyfill = require(AppChatParent.LuauPolyfill)
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local createCurrentTimeSignal = require(AppChatParent.SignalsUtils).createCurrentTimeSignal
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout

local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local getEffectiveChatTimeoutDetails = require(AppChat.Utils.getEffectiveChatTimeoutDetails)
local toTimeoutEntry = require(AppChat.Utils.toTimeoutEntry)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local var1 = require(AppChat.Logger):new(script.Name)

local function areChatTimeoutDetailsEqual(arg1, arg2): boolean
    return arg1.isTimedOut == arg2.isTimedOut
        and arg1.timeoutEndTimestamp == arg2.timeoutEndTimestamp
        and arg1.decisionEventId == arg2.decisionEventId
        and arg1.duration == arg2.duration
        and (not FFlagAppChatReactiveFeatureRestrictions or arg1.requiresAcknowledgement == arg2.requiresAcknowledgement)
end

local function useChatTimeoutDetailsFromHydration(tbl1)
    local var2 = React.useMemo(function()
        if FFlagAppChatReactiveFeatureRestrictions then
            return function(): number
                return DateTime.now().UnixTimestamp
            end
        end
        return createCurrentTimeSignal(1)
    end, {})

    local chatModerationStatusDataHydration = GetChatModerationStatusDataHydration(false)

    local bool1 = false
    local var3

    if FFlagAppChatReactiveFeatureRestrictions then
        var3, bool1 = chatModerationStatusDataHydration.getCachedUserStatus()
    else
        var3 = chatModerationStatusDataHydration.getUserStatus()
    end

    local conversationId = tbl1.conversationId
    local var4 = var3
    local bool2 = false
    if conversationId then
        if FFlagAppChatReactiveFeatureRestrictions then
            var4, bool2 = chatModerationStatusDataHydration.getCachedConversationStatus(conversationId)
        else
            var4 = chatModerationStatusDataHydration.getConversationStatus(conversationId)
        end
    end

    React.useEffect(function()
        if not FFlagAppChatReactiveFeatureRestrictions or not bool1 and not bool2 then
            return
        end

        chatModerationStatusDataHydration.refreshStatuses(conversationId and { conversationId } or nil):catch(function()
            var1:warning("Failed to fetch Party Chat moderation status")
        end)
    end, {
        conversationId,
        bool2,
        chatModerationStatusDataHydration,
        bool1
    })
    local var5 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var5 = var3.data(arg1)
            local var6 = var3.status(arg1)
            local var7 = var4.data(arg1)
            local var8 = var4.status(arg1)

            return getEffectiveChatTimeoutDetails(
                if var6 == DataHydration.DataStatus.Failed then nil else toTimeoutEntry(var5),
                if conversationId and var8 ~= DataHydration.DataStatus.Failed then toTimeoutEntry(var7) else nil,
                tbl1.conversationModerationType,
                var2(arg1)
            )
        end, areChatTimeoutDetailsEqual)
    end, {
        conversationId,
        var4.data,
        var4.status,
        var2,
        tbl1.conversationModerationType,
        var3.data,
        var3.status
    })

    if FFlagAppChatReactiveFeatureRestrictions then
        React.useEffect(function()
            local var6 = nil

            local effect = Signals.createEffect(function(arg1)
                local var7 = var6
                if var7 then
                    clearTimeout(var7)
                    var6 = nil
                end

                local var8 = var5(arg1)
                local unixTimestamp = DateTime.now().UnixTimestamp

                if not var8.isTimedOut or not (unixTimestamp < var8.timeoutEndTimestamp) then
                    return
                end

                var6 = setTimeout(function()
                    var6 = nil
                    chatModerationStatusDataHydration.refreshStatuses(conversationId and { conversationId } or nil):catch(function()
                        var1:warning("Failed to refresh expired Party Chat restriction")
                    end)
                end, (var8.timeoutEndTimestamp - unixTimestamp + 1) * 1000)
            end)

            return function()
                local var7 = var6
                if var7 then
                    clearTimeout(var7)
                end
                effect()
            end
        end, { conversationId, var5, chatModerationStatusDataHydration })
    end

    return var5
end

return useChatTimeoutDetailsFromHydration
