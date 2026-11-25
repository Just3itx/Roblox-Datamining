-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent

local Signals = require(TextChannelWindowParent.Signals)
local _Message = require(script.Parent.Message)

local function createChannelMessagesStore(tbl1)
    local tbl2 = ({})

    local function getOrCreate(arg1)
        if not tbl2[arg1] then
            local getByMessageId, setByMessageId = Signals.createSignal({})
            local getOrderedIds, setOrderedIds = Signals.createSignal({})

            local getMessages = Signals.createComputed(function(arg2)
                local var5 = getOrderedIds(arg2)
                local var6 = getByMessageId(arg2)
                local var7 = table.create(#var5)
                for _, value in var5 do
                    local var8 = var6[value]
                    if var8 then
                        table.insert(var7, var8)
                    end
                end
                return var7
            end)

            tbl2[arg1] = {
                getByMessageId = getByMessageId,
                setByMessageId = setByMessageId,
                getOrderedIds = getOrderedIds,
                setOrderedIds = setOrderedIds,
                getMessages = getMessages,
                messageGetters = {}
            }
        end
        return tbl2[arg1]
    end

    local function upsertMessage(arg1, arg2)
        local orCreate = getOrCreate(arg1)
        local messageId = arg2.messageId

        orCreate.setByMessageId(function(arg3)
            local var1 = table.clone(arg3)
            var1[messageId] = arg2
            return var1
        end)

        local tbl3 = {}
        orCreate.setOrderedIds(function(arg3)
            for _, value in arg3 do
                if value == messageId then
                    return arg3
                end
            end
            local var1 = table.clone(arg3)
            table.insert(var1, messageId)
            if not (#var1 > 200) then
                return var1
            end

            local var2 = table.create(200)
            table.move(var1, #var1 - 200 + 1, #var1, 1, var2)
            if tbl3 then
                for i = 1, #var1 - 200 do
                    table.insert(tbl3, var1[i])
                end
            end
            return var2
        end)

        if not tbl3 or not (#tbl3 > 0) then
            return
        end

        orCreate.setByMessageId(function(arg3)
            local var1 = table.clone(arg3)
            for _, value in tbl3 do
                var1[value] = nil
            end
            return var1
        end)
        for _, value in tbl3 do
            orCreate.messageGetters[value] = nil
        end
    end

    local function isHistorical(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return not (arg1 == nil) and arg1.isHistorical == true
    end

    return {
        insertHistorical = function(arg1, tbl3)
            local historyArm = if tbl1 and tbl1.getHistoryArm then tbl1.getHistoryArm() else nil

            if not historyArm or #tbl3 == 0 then
                return
            end

            local orCreate = getOrCreate(arg1)
            local byMessageId = orCreate.getByMessageId(false)
            local orderedIds = orCreate.getOrderedIds(false)

            local num1 = 0
            for _, orderedId in orderedIds do
                if not isHistorical(byMessageId[orderedId]) then
                    break
                end

                num1 += 1
            end

            local var1 = if historyArm.maxAgeSeconds > 0 then workspace:GetServerTimeNow() - historyArm.maxAgeSeconds else nil
            local tbl4 = {}
            local tbl5 = ({})
            for _, value in tbl3 do
                local messageId = value.messageId
                if byMessageId[messageId] ~= nil or tbl5[messageId] then
                    continue
                end

                tbl5[messageId] = true
                if value.content ~= "" and not (var1 and value.timestamp.UnixTimestamp < var1) then
                    table.insert(tbl4, value)
                end
            end

            if #tbl4 == 0 then
                return
            end

            local num2 = #orderedIds - num1
            local num3 = math.max(0, math.min(historyArm.maxCount, 200 - num2))
            local tbl6 = table.move(orderedIds, 1, num1, 1, table.create(num1 + #tbl4))
            for _, value in tbl4 do
                table.insert(tbl6, value.messageId)
            end

            local num4 = math.max(0, #tbl6 - num3)
            local tbl7 = table.move(tbl6, 1, num4, 1, table.create(num4))
            local tbl8 = table.move(tbl6, num4 + 1, #tbl6, 1, table.create(num3 + num2))
            table.move(orderedIds, num1 + 1, #orderedIds, #tbl8 + 1, tbl8)

            orCreate.setByMessageId(function(arg2)
                local var2 = table.clone(arg2)
                for _, value in tbl4 do
                    var2[value.messageId] = value
                end
                for _, value in tbl7 do
                    var2[value] = nil
                end
                return var2
            end)
            orCreate.setOrderedIds(function()
                return tbl8
            end)
            for _, value in tbl7 do
                orCreate.messageGetters[value] = nil
            end

            if tbl1 and tbl1.logHistoryExposure then
                tbl1.logHistoryExposure()
            end
        end,
        upsertMessage = upsertMessage,
        removeMessage = function(arg1, str1: string)
            local orCreate = getOrCreate(arg1)

            orCreate.setByMessageId(function(arg2)
                if arg2[str1] == nil then
                    return arg2
                end
                local var1 = table.clone(arg2)
                var1[str1] = nil
                return var1
            end)

            orCreate.setOrderedIds(function(arg2)
                local var1 = table.find(arg2, str1)
                if not var1 then
                    return arg2
                end
                local var2 = table.clone(arg2)
                table.remove(var2, var1)
                return var2
            end)
        end,
        insertIfAbsent = function(arg1, arg2)
            if getOrCreate(arg1).getByMessageId(false)[arg2.messageId] ~= nil then
                return
            end
            upsertMessage(arg1, arg2)
        end,
        removeChannelEntry = function(arg1)
            tbl2[arg1] = nil
        end,
        clearChannel = function(arg1)
            local var1 = tbl2[arg1]
            if not var1 then
                return
            end
            var1.setByMessageId(function()
                return {}
            end)
            var1.setOrderedIds(function()
                return {}
            end)
            table.clear(var1.messageGetters)
        end,
        getMessagesForChannel = function(arg1)
            return getOrCreate(arg1).getMessages
        end,
        getMessageById = function(arg1, str1: string)
            local orCreate = getOrCreate(arg1)
            if not orCreate.messageGetters[str1] then
                orCreate.messageGetters[str1] = Signals.createComputed(function(arg2)
                    return orCreate.getByMessageId(arg2)[str1]
                end)
            end
            return orCreate.messageGetters[str1]
        end
    }
end
return createChannelMessagesStore
