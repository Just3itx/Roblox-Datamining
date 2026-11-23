-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local _ChatTimeouts = require(AppChat.installReducer.ChatTimeouts)
local React = require(AppChatParent.React)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local LuauPolyfill = require(AppChatParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local CurrentConversationTimeoutEnded = require(AppChat.Conversations.Actions.CurrentConversationTimeoutEnded)
local getEffectiveChatTimeoutDetails = require(AppChat.Utils.getEffectiveChatTimeoutDetails)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local var1 = require(AppChat.Logger):new(script.Name)

local function useChatTimeoutDetails(tbl1)
    local conversationId = tbl1.conversationId
    local var2 = useDispatch()
    local var3 = useSelector(function(arg1)
        return {
            userTimeout = getDeepValue2(arg1, "ChatAppReducer.ChatTimeouts.userTimeout"),
            conversationTimeout = getDeepValue2(arg1, `ChatAppReducer.ChatTimeouts.byConversationId.{conversationId}`)
        }
    end)
    local effectiveChatTimeoutDetails = getEffectiveChatTimeoutDetails(
        var3.userTimeout,
        var3.conversationTimeout,
        tbl1.conversationModerationType,
        DateTime.now().UnixTimestamp
    )

    React.useEffect(function()
        local var4 = nil
        if effectiveChatTimeoutDetails.isTimedOut then
            local unixTimestamp = DateTime.now().UnixTimestamp
            if not FFlagAppChatReactiveFeatureRestrictions or unixTimestamp < effectiveChatTimeoutDetails.timeoutEndTimestamp then
                var4 = setTimeout(function()
                    if not FFlagAppChatReactiveFeatureRestrictions then
                        var2(CurrentConversationTimeoutEnded(conversationId))

                        return
                    end

                    var2(AppChatNetworking.rodux.GetChatModerationStatuses.API(conversationId and { conversationId } or nil)):catch(
                        function()
                            var1:warning("Failed to refresh expired Party Chat restriction")
                        end
                    )
                end, (effectiveChatTimeoutDetails.timeoutEndTimestamp - unixTimestamp + 1) * 1000)
            end
        end
        return function()
            if var4 then
                clearTimeout(var4)
            end
        end
    end, {
        effectiveChatTimeoutDetails.isTimedOut,
        effectiveChatTimeoutDetails.timeoutEndTimestamp,
        conversationId,
        var2
    })

    return effectiveChatTimeoutDetails
end

return useChatTimeoutDetails
