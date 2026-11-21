-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local unpackContent = require(script.Parent.Parent.ContentKinds.unpackContent)
local SystemContentModel = require(script.Parent.Parent.ContentKinds.System.SystemContentModel)
local _projectMessageEnvelope = require(script.Parent.projectMessageEnvelope)
local getReplyPreview = require(script.Parent.Reply.getReplyPreview)

local isSystemMessage = SystemContentModel.isSystemMessage

local function sameSender(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local author = arg1.author
    local author2 = arg2.author
    return not (author == nil or author2 == nil) and author.userId == author2.userId
end

local function getGroupBreakReason(arg1, arg2, arg3, num1: number, num2: number?, num3: number?)
    if num3 ~= nil
        and arg2 ~= nil
        and not isSystemMessage(arg3)
        and num3 <= arg3.sentAtUnixMilliseconds - arg2.sentAtUnixMilliseconds
    then
        return "time"
    end

    if isSystemMessage(arg1) or isSystemMessage(arg3) then
        return "system"
    end

    if not sameSender(arg1, arg3) then
        return "sender"
    end

    if getReplyPreview.getReplyText(arg3) == nil then
        if num2 == nil or not (num2 <= num1) then
            return nil
        end

        return "count"
    end

    return "reply"
end

local function hasRenderableContent(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local contents = arg1.contents
    if type(contents) ~= "table" then
        return false
    end
    for _, content in contents do
        if unpackContent(content) ~= nil then
            return true
        end
    end
    return false
end

local function orderedMessages(tbl1)
    local result = {}
    for _, value in tbl1 do
        if type(value) == "table" and hasRenderableContent(value) then
            table.insert(result, value)
        end
    end
    table.sort(result, function(arg1, arg2): boolean
        if arg1.sentAtUnixMilliseconds == arg2.sentAtUnixMilliseconds then
            return arg1.id < arg2.id
        end

        return arg1.sentAtUnixMilliseconds < arg2.sentAtUnixMilliseconds
    end)

    return result
end

local function indexPrevious(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    if tbl1 == nil then
        return result
    end
    for _, value in tbl1 do
        result[value.id] = value
    end
    return result
end

local function messageRow(tbl1, message, isFirst: boolean, isLast: boolean)
    local var1 = tbl1[message.id]
    return if var1 == nil
        or var1.kind ~= "message"
        or var1.message ~= message
        or var1.groupPosition.isFirst ~= isFirst
        or var1.groupPosition.isLast ~= isLast then {
        kind = "message",
        id = message.id,
        message = message,
        groupPosition = { isFirst = isFirst, isLast = isLast }
    } else var1
end

local function systemRow(tbl1, message) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[message.id]
    return if var1 == nil or var1.kind ~= "system" or var1.message ~= message then {
        kind = "system",
        id = message.id,
        message = message
    } else var1
end

local function appendRows(tbl1, tbl2, message, isFirst: boolean, isLast: boolean) -- Luacid: unused: defined but never referenced
    if isSystemMessage(message) then
        table.insert(tbl1, (systemRow(tbl2, message)))
        return
    end
    table.insert(tbl1, (messageRow(tbl2, message, isFirst, isLast)))
end

local function timestampRow(tbl1, arg1, arg2)
    local id = `timestamp:{arg1.id}`
    local sentAtUnixMilliseconds = if arg2 == nil then nil else arg2.sentAtUnixMilliseconds
    local var1 = tbl1[id]
    return if var1 == nil
        or var1.kind ~= "timestamp"
        or var1.displayUnixMilliseconds ~= arg1.sentAtUnixMilliseconds
        or var1.referenceUnixMilliseconds ~= sentAtUnixMilliseconds then {
        kind = "timestamp",
        id = id,
        displayUnixMilliseconds = arg1.sentAtUnixMilliseconds,
        referenceUnixMilliseconds = sentAtUnixMilliseconds
    } else var1
end

local function finish(tbl1, tbl2) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl1 == nil or #tbl1 ~= #tbl2 then
        return tbl2
    end
    for value, value2 in tbl2 do
        if tbl1[value] ~= value2 then
            return tbl2
        end
    end
    return tbl1
end

return {
    groupMessages = function(tbl1, num1: number?, num2: number?, tbl2, tbl3)
        local bool1 = tbl3 == nil or tbl3.shouldInsertTimestampRows ~= false
        local tbl4 = orderedMessages(tbl1)
        local tbl5 = indexPrevious(tbl2)
        local tbl6 = {}
        local num3 = 1

        local function appendGroup(num4: number)
            local num5 = num4 - num3 + 1
            for i = 0, num5 - 1 do
                local message = tbl4[num3 + i]
                local tbl7 = tbl6
                local tbl8 = tbl5
                local isFirst = i == 0
                local isLast = i == num5 - 1

                if isSystemMessage(message) then
                    local tbl9 = tbl8[message.id]
                    if tbl9 == nil or tbl9.kind ~= "system" or tbl9.message ~= message then
                        tbl9 = {
                            kind = "system",
                            id = message.id,
                            message = message
                        }
                    end

                    table.insert(tbl7, tbl9)
                else
                    table.insert(tbl7, (messageRow(tbl8, message, isFirst, isLast)))
                end
            end
        end
        local function appendTimestamp(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            table.insert(tbl6, (timestampRow(tbl5, arg1, arg2)))
        end

        local var1 = if #tbl4 > 0 and not isSystemMessage(tbl4[1]) then tbl4[1] else nil

        for i = 2, #tbl4 do
            local var2 = tbl4[i]
            local num4 = i - num3

            local groupBreakReason = getGroupBreakReason(tbl4[i - 1], var1, var2, num4, num1, num2)
            if groupBreakReason ~= nil then
                appendGroup(i - 1)
                if groupBreakReason == "time" and bool1 then
                    appendTimestamp(var2, var1)
                end

                num3 = i
            end
            if not isSystemMessage(var2) then
                var1 = var2
            end
        end

        if #tbl4 > 0 then
            appendGroup(#tbl4)
        end

        return finish(nil, (finish(tbl2, tbl6)))
    end,
    ungroupedRows = function(tbl1, tbl2)
        local tbl3 = orderedMessages(tbl1)
        local tbl4 = indexPrevious(tbl2)
        local tbl5 = {}
        for _, message in tbl3 do
            if isSystemMessage(message) then
                local tbl6 = tbl4[message.id]
                if tbl6 == nil or tbl6.kind ~= "system" or tbl6.message ~= message then
                    tbl6 = {
                        kind = "system",
                        id = message.id,
                        message = message
                    }
                end

                table.insert(tbl5, tbl6)
            else
                table.insert(tbl5, (messageRow(tbl4, message, true, true)))
            end
        end

        if tbl2 == nil or #tbl2 ~= #tbl5 then
            return finish(nil, tbl5)
        end

        for value, value2 in tbl5 do
            if tbl2[value] ~= value2 then
                return finish(nil, tbl5)
            end
        end

        return finish(nil, tbl2)
    end
}
