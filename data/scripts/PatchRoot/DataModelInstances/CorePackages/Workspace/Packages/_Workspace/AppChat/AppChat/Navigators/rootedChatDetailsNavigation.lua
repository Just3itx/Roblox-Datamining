-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)

local ConversationChannels = require(AppChat.Models.ConversationChannels)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local EnumScreens = require(AppChat.EnumScreens)
local ConversationRoduxSeed = require(AppChat.Utils.ConversationRoduxSeed)
local isFriendsPlaceholderConversationId = ConversationRoduxSeed.isFriendsPlaceholderConversationId
local normalizeStoreConversationForRodux = ConversationRoduxSeed.normalizeStoreConversationForRodux

local module = {}

function module.navigateToRootedChatDetails(conversationId: string, rootedNavigationRequestId: number?)
    return RoactNavigation.Actions.navigate({
        routeName = EnumScreens.ChatLandingStack,
        params = { conversationId = conversationId },
        action = RoactNavigation.StackActions.reset({
            index = 1,
            actions = { RoactNavigation.Actions.navigate({
                    routeName = EnumScreens.ChatDetails,
                    params = {
                        conversationId = conversationId,
                        isRooted = true,
                        rootedNavigationRequestId = rootedNavigationRequestId
                    }
                }) }
        })
    })
end

function module.tryNavigateToRootedChatDetails(tbl1, arg1): boolean
    local conversationId = arg1 and arg1.conversationId
    if not conversationId or arg1.rooted ~= true then
        return false
    end

    local var1 = GetConversationStore(false).getConversation(conversationId, false)
    if var1 then
        tbl1.dispatch(ReceivedConversation(normalizeStoreConversationForRodux(var1)))
    end

    if var1 == nil and not isFriendsPlaceholderConversationId(conversationId)
        or var1 ~= nil and var1.source ~= ConversationChannels.Source.Friends
    then
        tbl1.fetchLatestConversationDetails(conversationId)
    end

    tbl1.callback(module.navigateToRootedChatDetails(conversationId, arg1.rootedNavigationRequestId))

    return true
end

return module
