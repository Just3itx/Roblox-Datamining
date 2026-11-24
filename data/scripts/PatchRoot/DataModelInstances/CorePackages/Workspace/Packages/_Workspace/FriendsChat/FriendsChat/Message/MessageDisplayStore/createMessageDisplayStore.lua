-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Cryo = require(FriendsChatParent.Cryo)
local Signals = require(FriendsChatParent.Signals)

local GetConversationMessageStore = require(FriendsChatParent.AppChat.GetConversationMessageStore)

local classifyMessage = require(script.Parent.classifyMessage)
local buildRowDisplay = require(script.Parent.buildRowDisplay)
local createFrozenSortTimes = require(script.Parent.createFrozenSortTimes)
local createGetIsGroup = require(script.Parent.createGetIsGroup)
local resolveNameInfos = require(script.Parent.resolveNameInfos)
local getLocalUserId = require(script.Parent.Parent.Parent.Utils.getLocalUserId)

local tbl1 = {}

local function createMessageDisplayStore(arg1, str1: string?)
    local tbl2 = ({})
    local frozenSortTimes = createFrozenSortTimes()

    local getIsGroup = createGetIsGroup(str1)

    local function resolveForRowSpec(arg2, arg3)
        if arg2.kind == "userText" or arg2.kind == "hiddenUser" then
            return {
                namesByUserId = resolveNameInfos({ arg2.senderUserId }, arg3)
            }
        end

        if arg2.kind ~= "replyHeader" then
            return {}
        end

        return {
            namesByUserId = resolveNameInfos({ arg2.senderUserId, arg2.repliedToUserId }, arg3),
            localUserId = getLocalUserId(),
            isGroup = getIsGroup(arg3)
        }
    end

    local function getMessageRowSpecs(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = tbl2[str2]
        if var1 == nil then
            var1 = Signals.createComputed(function(arg2)
                local var2 = GetConversationMessageStore(arg2).getMessage(str2, arg2)
                if var2 == nil then
                    return tbl1
                end
                return classifyMessage(var2)
            end)
            tbl2[str2] = var1
        end
        return var1
    end

    local computed = Signals.createComputed(function(arg2)
        local tbl3 = {}
        local num1 = 0

        for _, sourceId in (arg1(arg2)) do
            local count = #getMessageRowSpecs(sourceId)(arg2)
            if count == 0 then
                continue
            end

            if num1 + count > 50 then
                break
            end

            num1 += count
            table.insert(tbl3, { sourceId = sourceId, count = count, sortTime = frozenSortTimes(sourceId, arg2) })
        end

        table.sort(tbl3, function(arg3, arg4): boolean
            if arg3.sortTime == arg4.sortTime then
                return arg3.sourceId < arg4.sourceId
            end

            return arg3.sortTime < arg4.sortTime
        end)

        local idList = {}
        local idToHandle = ({})
        for _, value in tbl3 do
            for rowIndex = 1, value.count do
                local str2 = `{value.sourceId}_{rowIndex}`
                table.insert(idList, str2)
                idToHandle[str2] = {
                    messageId = value.sourceId,
                    rowIndex = rowIndex
                }
            end
        end
        return { idList = idList, idToHandle = idToHandle }
    end)

    return {
        getDisplayIds = Signals.createComputed(function(arg2)
            return computed(arg2).idList
        end, Cryo.List.equals),
        getDisplayFromId = function(str2: string?, arg2, arg3)
            if str2 == nil then
                return nil
            end
            local var1 = computed(false).idToHandle[str2]
            if var1 == nil then
                return nil
            end
            local var2 = getMessageRowSpecs(var1.messageId)(arg2)[var1.rowIndex]
            if var2 == nil then
                return nil
            end
            return buildRowDisplay(var2, resolveForRowSpec(var2, arg2), arg3 or {})
        end,
        getMessageIdFromDisplayId = function(str2: string?)
            if str2 == nil then
                return nil
            end
            local var1 = computed(false).idToHandle[str2]
            return if var1 then var1.messageId else nil
        end
    }
end
return createMessageDisplayStore
