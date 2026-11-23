-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local GetConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetUnreadMessageCountStore = require(AppChat.Stores.GetUnreadMessageCountStore)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)

local Ports = require(AppChat.AppChatData.Ports)
local createHttpPort = require(AppChat.AppChatData.Ports.createHttpPort)
local createFakeRealtime = require(script.createFakeRealtime)
local createFakeServer = require(script.createFakeServer)

local var1 = nil

local function clearStores()
    GetConversationStore(false).clear()
    GetConversationMessageStore(false).clear()
    GetConversationMessageListStore(false).clear()
    GetUnreadMessageCountStore(false).reset()
    searchIntroducedConversationIds.clear()
end

return {
    install = function()
        assert(var1 == nil, "AppChatData.Testing.install() called again before restore()")

        local current = Ports.current
        local server = createFakeServer()
        local realtime = createFakeRealtime()

        Ports.current = {
            http = createHttpPort(server.request),
            realtime = realtime.port
        }
        clearStores()

        local function restore()
            if var1 ~= restore then
                return
            end
            Ports.current = current
            clearStores()
            var1 = nil
        end
        var1 = restore

        return { server = server, realtime = realtime, restore = restore }
    end
}
