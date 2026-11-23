-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Signals = require(AppChatParent.Signals)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)
local createProxy = SignalsExperimental.createProxy

local ArraySet = require(AppChat.DataStructures.ArraySet)
local FFlagAppChatBatchMessageListPagePublication = require(AppChat.Flags.FFlagAppChatBatchMessageListPagePublication)
local FFlagAppChatIncrementalPaginationProjection = require(AppChat.Flags.FFlagAppChatIncrementalPaginationProjection)
local FFlagAppChatGroupedVariantNeighbourIds = require(AppChat.Flags.FFlagAppChatGroupedVariantNeighbourIds)

local function newConversationOrdering() -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        messageIds = ArraySet.new({})
    }
end

local function newMessagePaginationMetadata() -- Luacid: Inlined by compiler; 1 call site recovered
    return { nextPageCursor = nil, isLoading = false, fetchedOldest = false }
end

local function createConversationMessageListStore()
    local conversations = createProxy({})

    local metadata = createProxy({})

    local proxy3 = createProxy({})
    local proxy4 = createProxy({})

    local tbl1 = ({})
    local tbl2 = ({})
    local num1 = 0
    local num2 = 0
    local tbl3 = {}
    local tbl4 = ({})

    local function publishMutation(str1: string, operation: string, tbl5, tbl6, boundaryMessageId: string?)
        num1 += 1

        if tbl1[str1] == nil then
            local var1, var2 = Signals.createSignal(nil)
            tbl1[str1] = var1
            tbl2[str1] = var2
        end

        local tbl7 = {
            operation = operation,
            messageIds = table.clone(tbl5),
            insertedIds = table.clone(tbl6),
            boundaryMessageId = boundaryMessageId,
            revision = num1
        }
        if not (num2 > 0) then
            tbl2[str1](tbl7)
            return
        end

        local tbl8 = tbl4[str1]
        if tbl8 == nil then
            tbl8 = {}
            tbl4[str1] = tbl8
            table.insert(tbl3, str1)
        end
        table.insert(tbl8, tbl7)
    end
    local function publishQueuedMutations()
        local tbl5 = tbl3
        local tbl6 = tbl4
        tbl3 = {}
        tbl4 = {}
        for _, value in tbl5 do
            local mutations = tbl6[value]
            if #mutations == 1 then
                tbl2[value](mutations[1])
            else
                tbl2[value]({
                    operation = "Batch",
                    messageIds = {},
                    insertedIds = {},
                    boundaryMessageId = nil,
                    revision = mutations[#mutations].revision,
                    mutations = mutations
                })
            end
        end
    end

    local function addTraceback(arg1)
        if type(arg1) == "string" then
            return debug.traceback(arg1, 2)
        end
        return arg1
    end

    local function getOrDefaultOrdering(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = conversations[str1]
        if var1 ~= nil then
            return var1
        end

        return newConversationOrdering()
    end

    local function getOrDefaultMetadata(str1: string) -- Luacid: unused: defined but never referenced
        local var1 = metadata[str1]
        if var1 ~= nil then
            return var1
        end

        return newMessagePaginationMetadata()
    end

    local function getNeighbourKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 6 call sites recovered
        return str1 .. "\0" .. str2
    end

    local function writeNeighbourIds(str1: string, tbl5, num3: number, num4: number)
        local num5 = math.max(num3, 1)
        local messageIds = tbl5.messageIds

        for i = num5, math.min(num4, messageIds:size()) do
            local neighbourKey = getNeighbourKey(str1, (tbl5.messageIds:at(i)))
            proxy3[neighbourKey] = tbl5.messageIds:at(i - 1)
            proxy4[neighbourKey] = tbl5.messageIds:at(i + 1)
        end
    end

    local function clearNeighbourIds(str1: string, tbl5) -- Luacid: Inlined by compiler; 3 call sites recovered
        for _, value in tbl5 do
            local neighbourKey = getNeighbourKey(str1, value)
            proxy3[neighbourKey] = nil
            proxy4[neighbourKey] = nil
        end
    end

    local function runOrderingWrite(callback: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
        if not FFlagAppChatGroupedVariantNeighbourIds then
            callback()

            return
        end

        local var1 = nil
        local var2 = nil
        SignalsExperimental.batch(function()
            num2 += 1

            var1, var2 = xpcall(callback, addTraceback)
            num2 -= 1
            if num2 == 0 then
                publishQueuedMutations()
            end
        end)
        if not var1 then
            error(var2, 0)
        end
    end

    local function prependMessagesInternal(str1: string, tbl5)
        local orDefaultOrdering = getOrDefaultOrdering(str1)
        local var1 = orDefaultOrdering.messageIds:size()

        local tbl6 = {}
        local var2

        if FFlagAppChatIncrementalPaginationProjection then
            var2 = orDefaultOrdering.messageIds:at(1)
            local tbl7 = ({})
            for _, value in tbl5 do
                if not (orDefaultOrdering.messageIds:has(value) or tbl7[value]) then
                    tbl7[value] = true
                    table.insert(tbl6, value)
                end
            end
        else
            var2 = nil
        end

        if not orDefaultOrdering.messageIds:prependAll(tbl5) then
            if FFlagAppChatIncrementalPaginationProjection and #tbl5 > 0 then
                publishMutation(str1, "Prepend", tbl5, {}, nil)
            end
            return
        end

        conversations[str1] = table.clone(orDefaultOrdering)
        if FFlagAppChatGroupedVariantNeighbourIds then
            writeNeighbourIds(str1, orDefaultOrdering, 1, orDefaultOrdering.messageIds:size() - var1 + 1)
        end
        if FFlagAppChatIncrementalPaginationProjection then
            publishMutation(str1, "Prepend", tbl5, tbl6, var2)
        end
    end

    local function appendMessagesInternal(str1: string, tbl5)
        local orDefaultOrdering = getOrDefaultOrdering(str1)
        local var1 = orDefaultOrdering.messageIds:size()
        local var2 = orDefaultOrdering.messageIds:at(var1)

        local tbl6 = {}
        for _, value in tbl5 do
            if orDefaultOrdering.messageIds:add(value) then
                table.insert(tbl6, value)
            end
        end

        if #tbl6 > 0 then
            conversations[str1] = table.clone(orDefaultOrdering)
        end
        if FFlagAppChatGroupedVariantNeighbourIds and #tbl6 > 0 then
            writeNeighbourIds(str1, orDefaultOrdering, var1, orDefaultOrdering.messageIds:size())
        end

        return tbl6, var2
    end

    local function appendMessagesAndPublish(str1: string, tbl5) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl6, var1 = appendMessagesInternal(str1, tbl5)
        if FFlagAppChatIncrementalPaginationProjection and #tbl5 > 0 then
            publishMutation(str1, "Append", tbl5, tbl6, var1)
        end
    end

    local function removeMessageInternal(str1: string, str2: string)
        local var1 = conversations[str1]
        if var1 == nil then
            return
        end
        local var2 = var1.messageIds:indexOf(str2)
        if var2 == nil or not var1.messageIds:remove(str2) then
            return
        end
        conversations[str1] = table.clone(var1)
        if FFlagAppChatGroupedVariantNeighbourIds then
            clearNeighbourIds(str1, { str2 })

            writeNeighbourIds(str1, var1, var2 - 1, var2)
        end
        if FFlagAppChatIncrementalPaginationProjection then
            publishMutation(str1, "Remove", { str2 }, {}, nil)
        end
    end

    local function updatePagination(str1: string, str2: string?, fetchedOldest: boolean)
        local var1 = metadata[str1]
        local var2 = var1 == nil and {
            nextPageCursor = nil,
            isLoading = false,
            fetchedOldest = false
        } or var1

        metadata[str1] = Cryo.Dictionary.union(var2, {
            nextPageCursor = str2 and str2 ~= "" and str2 or var2.nextPageCursor,
            isLoading = false,
            fetchedOldest = fetchedOldest
        })
    end

    local function receivePageInternal(str1: string, tbl5, str2: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local tbl6, var1 = appendMessagesInternal(str1, tbl5)
        updatePagination(str1, str2, str2 == nil or str2 == "")
        if FFlagAppChatIncrementalPaginationProjection then
            publishMutation(str1, "AppendAndAdvanceCursor", tbl5, tbl6, var1)
        end
    end

    local function clearConversationInternal(str1: string)
        if FFlagAppChatGroupedVariantNeighbourIds then
            local var1 = conversations[str1]
            if var1 ~= nil then
                clearNeighbourIds(str1, (var1.messageIds:values()))
            end
        end
        conversations[str1] = nil
        metadata[str1] = nil
        if FFlagAppChatIncrementalPaginationProjection then
            publishMutation(str1, "Reset", {}, {}, nil)
        end
    end

    local function clearInternal()
        local tbl5 = {}
        local tbl6 = ({})
        for value, value2 in conversations do
            table.insert(tbl5, value)
            tbl6[value] = true
            if FFlagAppChatGroupedVariantNeighbourIds and value2 ~= nil then
                clearNeighbourIds(value, (value2.messageIds:values()))
            end
            conversations[value] = nil
        end
        for value in metadata do
            metadata[value] = nil
        end
        if not FFlagAppChatIncrementalPaginationProjection then
            return
        end

        for value in tbl1 do
            if not tbl6[value] then
                table.insert(tbl5, value)
            end
        end
        for _, value in tbl5 do
            publishMutation(value, "Reset", {}, {}, nil)
        end
    end

    return {
        conversations = conversations,
        metadata = metadata,
        getMutation = function(str1: string)
            local var1 = tbl1[str1]
            if var1 ~= nil then
                return var1
            end
            local var2, var3 = Signals.createSignal(nil)
            tbl1[str1] = var2
            tbl2[str1] = var3
            return var2
        end,
        batchMutations = function(callback: (...any) -> (...any))
            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(callback, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        prependMessages = function(str1: string, tbl5)
            local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
                prependMessagesInternal(str1, tbl5)
            end

            if not FFlagAppChatGroupedVariantNeighbourIds then
                func1()
                return
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        appendMessages = function(str1: string, tbl5)
            local function func1()
                appendMessagesAndPublish(str1, tbl5)
            end

            if not FFlagAppChatGroupedVariantNeighbourIds then
                appendMessagesAndPublish(str1, tbl5)
                return
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        removeMessage = function(str1: string, str2: string)
            local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
                removeMessageInternal(str1, str2)
            end

            if not FFlagAppChatGroupedVariantNeighbourIds then
                func1()
                return
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        publishMessageUpdates = function(str1: string, tbl5)
            if #tbl5 > 0 then
                publishMutation(str1, "Update", tbl5, {}, nil)
            end
        end,
        setLoading = function(str1: string, isLoading: boolean)
            local var1 = metadata[str1]
            metadata[str1] = Cryo.Dictionary.union(
                var1 == nil and { nextPageCursor = nil, isLoading = false, fetchedOldest = false } or var1,
                { isLoading = isLoading }
            )
        end,
        updatePagination = updatePagination,
        receivePage = function(str1: string, tbl5, str2: string?)
            if not FFlagAppChatGroupedVariantNeighbourIds then
                if FFlagAppChatBatchMessageListPagePublication then
                    SignalsExperimental.batch(function()
                        receivePageInternal(str1, tbl5, str2)
                    end)
                else
                    receivePageInternal(str1, tbl5, str2)
                end

                return
            end

            local function func1()
                receivePageInternal(str1, tbl5, str2)
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        clearConversation = function(str1: string)
            local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
                clearConversationInternal(str1)
            end

            if not FFlagAppChatGroupedVariantNeighbourIds then
                func1()
                return
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        clear = function()
            local func1 = clearInternal

            if not FFlagAppChatGroupedVariantNeighbourIds then
                func1()

                return
            end

            local var1 = nil
            local var2 = nil
            SignalsExperimental.batch(function()
                num2 += 1

                var1, var2 = xpcall(func1, addTraceback)
                num2 -= 1
                if num2 == 0 then
                    publishQueuedMutations()
                end
            end)
            if not var1 then
                error(var2, 0)
            end
        end,
        getIndex = function(str1: string, str2: string, arg1)
            local var1 = conversations(arg1)[str1]
            if var1 == nil then
                return nil
            end
            return var1.messageIds:indexOf(str2)
        end,
        getOrderedIds = function(str1: string, arg1)
            local var1 = conversations(arg1)[str1]
            if var1 == nil then
                return {}
            end
            return var1.messageIds:values()
        end,
        getPrevId = function(str1: string, str2: string, arg1)
            local var1 = conversations(arg1)[str1]
            if var1 == nil then
                return nil
            end
            local var2 = var1.messageIds:indexOf(str2)
            if var2 == nil or var2 <= 1 then
                return nil
            end
            return var1.messageIds:at(var2 - 1)
        end,
        getNextId = function(str1: string, str2: string, arg1)
            local var1 = conversations(arg1)[str1]
            if var1 == nil then
                return nil
            end
            local var2 = var1.messageIds:indexOf(str2)
            if var2 == nil or var1.messageIds:size() <= var2 then
                return nil
            end
            return var1.messageIds:at(var2 + 1)
        end,
        getNeighbourIds = function(str1: string, str2: string, arg1)
            local neighbourKey = getNeighbourKey(str1, str2)
            return {
                prevId = proxy3(arg1)[neighbourKey],
                nextId = proxy4(arg1)[neighbourKey]
            }
        end,
        getMetadata = function(str1: string, arg1)
            return metadata(arg1)[str1]
        end
    }
end
return createConversationMessageListStore
