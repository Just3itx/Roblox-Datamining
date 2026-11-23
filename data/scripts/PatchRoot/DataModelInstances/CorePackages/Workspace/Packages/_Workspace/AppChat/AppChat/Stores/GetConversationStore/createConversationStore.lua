-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local createProxy = require(AppChatParent.SignalsExperimental).createProxy

local tbl1 = {
    oldestConversationIsFetched = false,
    isFetchingConversations = false,
    isFetchingNextPage = false,
    hasFetchedInitialPage = false,
    isExhausted = false,
    nextCursor = nil,
    error = nil
}

local tbl2 = {
    "oldestConversationIsFetched",
    "isFetchingConversations",
    "isFetchingNextPage",
    "hasFetchedInitialPage",
    "isExhausted",
    "nextCursor",
    "error"
}

local tbl3 = ({})
for _, value in tbl2 do
    tbl3[value] = true
end

local function normalizeConversation(arg1): {callButtonEligibility: number, clientId: number, conversationType: number, createdAt: number, hasGroupUp: number, hasUnreadMessages: number, id: number, initialLoadingStatus: number, initiator: number, isDefaultTitle: number, isUserLeaving: number, lastUpdated: number, moderationType: number, osaAcknowledgementStatus: number, participantPendingStatus: number, participants: number, pinnedGame: number, previewContent: number, previewMessageId: number, serverState: number, source: number, title: number, titleForViewer: number, type: number, userOptedIntoChatMessages: number, userPendingStatus: number, usersTyping: number}?
    if arg1 == nil or arg1.id == nil then
        return nil
    end

    return {
        id = tostring(arg1.id),
        source = arg1.source,
        type = arg1.type,
        createdAt = arg1.createdAt,
        clientId = arg1.clientId,
        initiator = arg1.initiator,
        participants = arg1.participants,
        conversationType = arg1.conversationType,
        title = arg1.title,
        titleForViewer = arg1.titleForViewer,
        isDefaultTitle = arg1.isDefaultTitle,
        lastUpdated = arg1.lastUpdated,
        previewMessageId = arg1.previewMessageId,
        previewContent = arg1.previewContent,
        hasUnreadMessages = arg1.hasUnreadMessages,
        hasGroupUp = arg1.hasGroupUp,
        usersTyping = arg1.usersTyping,
        isUserLeaving = arg1.isUserLeaving,
        serverState = arg1.serverState,
        pinnedGame = arg1.pinnedGame,
        moderationType = arg1.moderationType,
        userPendingStatus = arg1.userPendingStatus,
        participantPendingStatus = arg1.participantPendingStatus,
        callButtonEligibility = arg1.callButtonEligibility,
        osaAcknowledgementStatus = arg1.osaAcknowledgementStatus,
        userOptedIntoChatMessages = arg1.userOptedIntoChatMessages,
        initialLoadingStatus = arg1.initialLoadingStatus
    }
end

local function mergePreservedLocalFields(tbl4, tbl5) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4 == nil then
        return tbl5
    end

    return Cryo.Dictionary.join(
        tbl5,
        {
            usersTyping = tbl4.usersTyping,
            isUserLeaving = tbl4.isUserLeaving,
            pinnedGame = tbl4.pinnedGame
        }
    )
end

local function copyListStatus(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})
    local var1 = arg1(arg2)
    for _, value in tbl2 do
        result[value] = var1[value]
    end
    return result
end

local function clearProxy(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    for value in arg1 do
        arg1[value] = nil
    end
end

local function createConversationStore()
    local proxy = createProxy({})

    local proxy2 = createProxy({})
    local listStatus = createProxy(table.clone(tbl1))
    local tbl4 = {}

    local function setListStatus(tbl5) -- Luacid: Inlined by compiler; 1 call site recovered
        for value, value2 in tbl5 do
            if tbl3[value] ~= true then
                continue
            end

            local var1 = listStatus

            if value2 == Cryo.None then
                value2 = nil
            end

            var1[value] = value2
        end
    end

    return {
        getConversation = function(str1: string, arg1)
            return proxy(arg1)[str1]
        end,
        getConversations = function(arg1)
            local conversations = {}
            for _, value in (proxy(arg1)) do
                if value ~= nil then
                    table.insert(conversations, value)
                end
            end
            return conversations
        end,
        getParticipantMetadata = function(str1: string, arg1)
            return proxy2(arg1)[str1]
        end,
        getListStatus = function(arg1)
            return copyListStatus(listStatus, arg1)
        end,
        listStatus = listStatus,
        addClearListener = function(func1: (...any) -> (...any))
            table.insert(tbl4, func1)
        end,
        upsertConversation = function(arg1, bool1: boolean?)
            local var1 = normalizeConversation(arg1)
            if var1 == nil then
                return
            end

            local id = var1.id
            local var2 = proxy

            if bool1 ~= false then
                var1 = mergePreservedLocalFields(proxy[id], var1)
            end

            var2[id] = var1
        end,
        removeConversation = function(str1: string)
            proxy[str1] = nil
            proxy2[str1] = nil
        end,
        setParticipantMetadata = function(str1: string, tbl5)
            proxy2[str1] = tbl5
        end,
        setUsersTyping = function(str1: string, usersTyping)
            local var1 = proxy[str1]
            if var1 == nil then
                return
            end
            proxy[str1] = Cryo.Dictionary.join(var1, { usersTyping = usersTyping })
        end,
        setListStatus = setListStatus,
        clear = function()
            clearProxy(proxy)
            clearProxy(proxy2)
            clearProxy(listStatus)
            setListStatus(tbl1)
            for _, value in tbl4 do
                value()
            end
        end
    }
end

return createConversationStore
