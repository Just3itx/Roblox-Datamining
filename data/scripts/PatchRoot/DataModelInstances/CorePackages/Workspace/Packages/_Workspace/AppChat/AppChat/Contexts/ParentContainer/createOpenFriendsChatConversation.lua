-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Promise = require(AppChatParent.Promise)
local ChatSessionRefCount = require(AppChat.Hooks.ChatSessionRefCount)

local function createOpenFriendsChatConversation(tbl1)
    local var1 = nil

    local num1 = 0

    return function(str1: string)
        ChatSessionRefCount.reserve()
        if var1 ~= nil then
            var1:cancel()
        end

        num1 += 1
        local num2 = num1

        local bool1 = true
        local function cancelReservation() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool1 then
                return
            end

            bool1 = false

            ChatSessionRefCount.acquire()
            ChatSessionRefCount.release()
        end

        local var2 = Promise.resolve():andThen(function()
            if not tbl1.isChatAvailable() then
                return false
            end
            return tbl1.openConversation(str1)
        end):andThen(function(arg1)
            if not arg1 then
                return false
            end
            return tbl1.requestSelectFriendsTab()
        end):andThen(function(arg1): boolean
            if not arg1 then
                return false
            end
            tbl1.ensureOpenChat(function(): boolean
                return num2 == num1
            end)
            bool1 = false
            return true
        end):catch(function(): boolean
            return false
        end):andThen(function(arg1)
            if not arg1 then
                cancelReservation()
            end

            return arg1
        end)

        local promise = Promise.new(function(arg1, arg2, callback)
            callback(function()
                cancelReservation()
                var2:cancel()
            end)
            var2:andThen(arg1, arg2)
        end)
        var2:finally(function()
            if var2:getStatus() == Promise.Status.Cancelled then
                promise:cancel()
            end
        end)

        var1 = promise
        return promise
    end
end

return createOpenFriendsChatConversation
