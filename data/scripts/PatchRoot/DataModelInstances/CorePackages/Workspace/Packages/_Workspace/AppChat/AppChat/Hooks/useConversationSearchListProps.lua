-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local DateTime = require(AppChatParent.Time).DateTime
local React = require(AppChatParent.React)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useStore = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useStore

local RoactPaginator = require(AppChat.SocialLibraries).RoactPaginator
local ConversationRoduxSeed = require(AppChat.Utils.ConversationRoduxSeed)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationViewModelStore = require(AppChat.Stores.GetConversationViewModelStore)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local getConversationTimestamp = require(AppChat.Utils.getConversationTimestamp)
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local getLastMessageContent = require(AppChat.Conversations.getLastMessageContent)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)
local useConversationSearch = require(AppChat.Hooks.useConversationSearch)
local useChatSearchResultsTelemetry = require(AppChat.Hooks.useChatSearchResultsTelemetry)
local FFlagAppChatSearchSessionTelemetry = require(AppChat.Flags.FFlagAppChatSearchSessionTelemetry)

local FFlagAppChatDerivedConversationLatestActivity = require(AppChat.Flags.FFlagAppChatDerivedConversationLatestActivity)

local tbl1 = {}
local tbl2 = {}

local function toLuaDateTime(lastUpdated) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(lastUpdated) == "DateTime" then
        return DateTime.fromUnixTimestamp(lastUpdated.UnixTimestamp)
    end
    return if type(lastUpdated) == "table" and typeof(lastUpdated.dateTime) == "DateTime" then lastUpdated else nil
end

local function getInboxRowFields(id: string)
    if GetConversationStore(false).getConversation(id, false) == nil then
        return nil, nil
    end
    local conversationViewModelStore = GetConversationViewModelStore(false)
    local var1 = conversationViewModelStore.getUnixTime(id)(false)

    return if var1 == nil then nil else DateTime.fromUnixTimestamp(var1), conversationViewModelStore.getSubtitle(id)(false)
end

local function buildSearchItemList(items, str1: string?, bool1: boolean)
    local searchItemList = {}
    for _, item in items do
        if item.otherParticipants == nil then
            local join = Cryo.Dictionary.join
            local tbl3 = {
                otherParticipants = getOtherParticipants(item, str1)
            }
            item = join(item, tbl3)
        end

        if not bool1 and item.conversationType == "MultiUserConversation" then
            continue
        end

        local var1 = toLuaDateTime(item.lastUpdated)
        local lastMessageContent = getLastMessageContent(item) or ""
        if FFlagAppChatDerivedConversationLatestActivity then
            local var2, var3 = getInboxRowFields(item.id)
            lastMessageContent = var3 or lastMessageContent
            var1 = var2 or var1
        end

        table.insert(
            searchItemList,
            Cryo.Dictionary.join(item, {
                title = getConversationTitle(item),
                lastMessageContent = lastMessageContent,
                shortRelativeTime = var1 and getConversationTimestamp(var1),
                longRelativeTime = var1 and var1:GetLongRelativeTime(),
                unixTime = var1 and var1:GetUnixTimestamp(),
                isSearchResult = true
            })
        )
    end

    return searchItemList
end

local function useConversationSearchListProps(str1: string?, bool1: boolean, str2: string?, bool2: boolean, callback: ((...any) -> (...any))?, str3: string?)
    local var1 = useConversationSearch(str1, bool1, str3)
    local var2 = useDispatch()
    local var3 = useStore()

    local navigateToConversation = React.useCallback(function(str4: string)
        local var4 = GetConversationStore(false).getConversation(str4, false)
        local state = var3:getState()
        local bool3 = not (var4 == nil) and state.ChatAppReducer.Conversations[str4] == nil

        if bool3 or searchIntroducedConversationIds.has(str4) then
            SignalsExperimental.batch(function()
                if bool3 then
                    var2(ReceivedConversation(ConversationRoduxSeed.normalizeStoreConversationForRodux(var4)))
                end

                searchIntroducedConversationIds.remove(str4)
            end)

            if not ConversationRoduxSeed.isFriendsPlaceholderConversationId(str4) then
                var2(fetchLatestConversationDetails(str4))
            end
        end

        if callback ~= nil then
            callback(str4)
        end
    end, { var2, callback, var3 })

    local itemList = React.useMemo(function()
        if not var1.isActive then
            return tbl1
        end

        return (buildSearchItemList(var1.items, str2, bool2))
    end, {
        var1.isActive,
        var1.items,
        bool2,
        str2
    })

    if FFlagAppChatSearchSessionTelemetry then
        useChatSearchResultsTelemetry(var1, #itemList)
    end

    if not var1.isActive then
        return false, tbl2
    end

    local tbl3 = {
        itemList = itemList,
        conversationsIsFetching = var1.isFetching,
        isSearchAwaitingResults = var1.isAwaitingResults,
        oldestConversationIsFetched = var1.nextCursor == nil
    }
    tbl3[RoactPaginator.loadNext] = function()
        var1.loadNext()
    end

    tbl3.isSearchActive = true
    tbl3.navigateToConversation = navigateToConversation
    return true, tbl3
end

return useConversationSearchListProps
