-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local DataHydrationUtils = require(ShareSheetParent.DataHydration.DataHydrationUtils)
local Friends = require(ShareSheetParent.DataHydration.Friends)
local Signals = require(ShareSheetParent.Signals)
local ListRecipientsStatus = require(ShareSheet.Recipients.ListRecipientsStatus)
local Recipient = require(ShareSheet.Recipients.Recipient)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)
local _Types = require(ShareSheet.Types)

local function validateUserId(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if (tonumber(str1) or 0) <= 0 then
        error(`Friends returned an invalid user id: {str1}`)
    end
end

local function areSameRecipients(tbl1, tbl2)
    if #tbl1 ~= #tbl2 then
        return false
    end
    for value, value2 in tbl1 do
        if tbl2[value] ~= value2 then
            return false
        end
    end
    return true
end

local function createFriendRecipientList(tbl1)
    local tbl2 = ({})

    local computed = Signals.createComputed(function(arg1)
        local result = {}
        local tbl3 = ({})

        for _, userId in tbl1.getPage(arg1).userIds do
            validateUserId(userId)

            if tbl3[userId] then
                error(`Duplicate user id in the friends page: {userId}`)
            end
            tbl3[userId] = true
            local var1 = tbl2[userId] or Recipient.fromUserId(userId)
            tbl2[userId] = var1
            table.insert(result, var1)
        end
        return result
    end, areSameRecipients)

    local getResult = Signals.createComputed(function(arg1)
        local page = tbl1.getPage(arg1)
        return {
            recipients = computed(arg1),
            status = page.status,
            nextPageToken = page.nextPageToken,
            isFetchingNextPage = page.isFetchingNextPage
        }
    end)

    return {
        getResult = getResult,
        refresh = tbl1.refresh,
        search = tbl1.search,
        loadMore = function(nextPageToken: string)
            local var1 = getResult(false)
            if var1.nextPageToken == nextPageToken and not var1.isFetchingNextPage then
                tbl1.fetchNextPage()
            end
        end
    }
end

local function createFriendsSearchRecipientList(query: string)
    local localPlayerUserId = DataHydrationUtils.getLocalPlayerUserId()
    local getPage, var2 = Signals.createSignal({ userIds = {}, status = ListRecipientsStatus.Loading, isFetchingNextPage = false })

    local function fetchPage(cursor: string?)
        local var3 = getPage(false)
        var2({
            userIds = var3.userIds,
            status = if cursor or #var3.userIds > 0 then ListRecipientsStatus.Ready else ListRecipientsStatus.Loading,
            nextPageToken = var3.nextPageToken,
            isFetchingNextPage = cursor ~= nil
        })
        Friends.Requests.SearchFriendsByQuery(
            localPlayerUserId,
            {
                query = query,
                limit = ShareSheetConstants.FIntShareSheetFriendsSearchPageSize,
                cursor = cursor
            }
        ):andThen(
            function(arg1)
                local userIds = not cursor and {} or table.clone(getPage(false).userIds)

                local tbl1 = ({})
                for _, value in userIds do
                    tbl1[value] = true
                end
                if arg1 and arg1.PageItems then
                    for _, pageItem in arg1.PageItems do
                        local str1 = tostring(pageItem.id)
                        if str1 ~= "-1" and not tbl1[str1] then
                            tbl1[str1] = true
                            table.insert(userIds, str1)
                        end
                    end
                end

                local nextCursor = if arg1 then arg1.NextCursor else nil
                local var5 = var2
                local tbl2 = {
                    userIds = userIds,
                    status = ListRecipientsStatus.Ready,
                    nextPageToken = 0,
                    isFetchingNextPage = false
                }

                if nextCursor == "" then
                    nextCursor = nil
                end

                tbl2.nextPageToken = nextCursor
                var5(tbl2)
            end
        ):catch(
            function()
                local var4 = getPage(false)
                var2({
                    userIds = var4.userIds,
                    status = ListRecipientsStatus.Failed,
                    nextPageToken = var4.nextPageToken,
                    isFetchingNextPage = false
                })
            end
        )
    end

    return (createFriendRecipientList({
        getPage = getPage,
        fetchNextPage = function()
            fetchPage(getPage(false).nextPageToken)
        end,
        refresh = function()
            fetchPage(nil)
        end
    }))
end

local function createOneToOneFriendsRecipientList()
    local var1 = Friends.FriendsStore.get()
    local allFriends = var1.GetAllFriends()
    local allFriendsStatus = var1.GetAllFriendsStatus()

    local getPage = Signals.createComputed(function(arg1)
        local var2 = allFriends(arg1)
        local var3 = allFriendsStatus(arg1)
        local bool1 = var3 == "Failed"
        local userIds = {}
        if var2 ~= nil then
            for _, friend in var2.friends do
                if friend.id ~= "-1" then
                    table.insert(userIds, friend.id)
                end
            end
        end
        return {
            userIds = userIds,
            status = if bool1 then ListRecipientsStatus.Failed elseif var2 == nil then ListRecipientsStatus.Loading else ListRecipientsStatus.Ready,
            nextPageToken = if var2 == nil or not var2.hasMore then nil else var2.nextCursor,
            isFetchingNextPage = not (var2 == nil) and var3 == "NotReady"
        }
    end)

    return (createFriendRecipientList({
        getPage = getPage,
        fetchNextPage = var1.FetchMoreFriends,
        refresh = function() end,
        search = createFriendsSearchRecipientList
    }))
end

return createOneToOneFriendsRecipientList
