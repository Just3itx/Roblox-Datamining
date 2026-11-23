-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)

local module = {}
module.__index = module

module.DiagCounters = {
    FetchedOlderConversation = game:DefineFastString("RoactChatFetchedOlderConversationCounter", "RoactChatFetchedOlderConversation"),
    UserLoadedChat = game:DefineFastString("RoactChatUserLoadedCounter", "RoactChatUserLoaded")
}

module.DiagCounters.ChatDetailsProfile = game:DefineFastString("RoactChatNavigationChatDetailsProfileCounter", "RoactChatNavigationChatDetailsProfile")
module.DiagCounters.ChatConversationProfile = game:DefineFastString("RoactChatNavigationChatConversationProfileCounter", "RoactChatNavigationChatConversationProfile")

module.NavigationEvents = {
    ChatDetailsProfile = "ChatDetailsProfile",
    ChatConversationProfile = "ChatConversationProfile"
}

local tbl1 = {
    [module.NavigationEvents.ChatConversationProfile] = {
        subpage = "peekView",
        page = "playerProfile",
        btn = "chatIcon"
    },
    [module.NavigationEvents.ChatDetailsProfile] = {
        subpage = "peekView",
        page = "playerProfile",
        btn = "chatDetailsMenu"
    }
}

function module.new(arg1, localUserId)
    assert(localUserId, "RoactChatAnalytics must be passed the ID of the local user")

    local tbl2 = {
        _diagImpl = arg1.Diag,
        _eventStreamImpl = arg1.EventStream,
        hasAlreadyFetchedOlderConversations = false,
        localUserId = localUserId
    }
    setmetatable(tbl2, module)

    return tbl2
end

function module:userFetchedOlderConversations()
    if self.hasAlreadyFetchedOlderConversations then
        return
    end
    self.hasAlreadyFetchedOlderConversations = true

    local tbl2 = {
        uid = self.localUserId
    }
    self._eventStreamImpl:setRBXEventStream("roactChat", "userFetchedOlderConversations", tbl2)

    local fetchedOlderConversation = module.DiagCounters.FetchedOlderConversation
    self._diagImpl:reportCounter(fetchedOlderConversation, 1)
end

function module:loadGameLinkCardInChat(arg1, arg2)
    local tbl2 = {
        uid = self.localUserId,
        cid = tostring(arg1),
        pid = tostring(arg2)
    }
    self._eventStreamImpl:setRBXEventStream("roactChat", "loadGameLinkCardInChat", tbl2)
end

function module:userLoadedChat()
    local tbl2 = {
        uid = self.localUserId
    }
    self._eventStreamImpl:setRBXEventStream("roactChat", "userLoadedChat", tbl2)

    local userLoadedChat2 = module.DiagCounters.UserLoadedChat
    self._diagImpl:reportCounter(userLoadedChat2, 1)
end

function module:navigate(arg1)
    assert(tbl1[arg1], "Invalid navigation option given")

    self._diagImpl:reportCounter(module.DiagCounters[arg1], 1)
    self._eventStreamImpl:setRBXEventStream(
        "chat",
        "buttonClick",
        Cryo.Dictionary.join({ uid = self.localUserId }, tbl1[arg1])
    )
end

return module
