-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent
local Signals = require(FriendsChatParent.Signals)
local createSignal = Signals.createSignal
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)

return function()
    local getSelectedConversationId, setSelectedConversationId = createSignal(nil)

    local getFocusInputBarRequestTime, var4 = createSignal(nil)

    local getConversationListFocusRequestTime, var6 = createSignal(nil)
    local getIsInputBarFocused, setInputBarFocused = createSignal(false)
    local getEffectiveConversationId = Signals.createComputed(function(arg1)
        local var9 = getSelectedConversationId(arg1)

        if var9 == nil then
            return nil
        end

        if GetConversationStore(arg1).getConversation(var9, arg1) == nil then
            return nil
        end

        return var9
    end)

    local var9 = nil
    return {
        getSelectedConversationId = getSelectedConversationId,
        getEffectiveConversationId = getEffectiveConversationId,
        setSelectedConversationId = setSelectedConversationId,
        getFocusInputBarRequestTime = getFocusInputBarRequestTime,
        requestFocusInputBar = function(num1: number?)
            var4(num1 or os.clock())
        end,
        clearFocusInputBarRequest = function()
            var4(nil)
        end,
        getConversationListFocusRequestTime = getConversationListFocusRequestTime,
        requestFocusConversationList = function(num1: number?)
            var6(num1 or os.clock())
        end,
        clearConversationListFocusRequest = function()
            var6(nil)
        end,
        getIsInputBarFocused = getIsInputBarFocused,
        setInputBarFocused = setInputBarFocused,
        cleanup = Signals.createEffect(function(arg1)
            local var10 = getSelectedConversationId(arg1)
            local var11 = getEffectiveConversationId(arg1)
            if var11 ~= nil then
                var9 = var11
            elseif var10 ~= nil and var10 == var9 then
                var9 = nil
                setSelectedConversationId(nil)
            else
                var9 = nil
            end
        end)
    }
end
