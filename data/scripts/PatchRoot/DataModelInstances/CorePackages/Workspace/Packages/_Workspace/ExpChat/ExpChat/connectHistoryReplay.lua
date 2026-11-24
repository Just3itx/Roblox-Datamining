-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local isHistoricalMessage = require(ExpChat.isHistoricalMessage)

local function connectCoreMessageReceived(arg1, func1: (...any) -> (...any)): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return arg1.CoreMessageReceived
    end)
    if not (success and result) then
        return false
    end

    result:Connect(func1)
    return true
end

local function connectHistoryReplay(callback: (...any) -> (...any), tbl1)
    local var1 = tbl1 and tbl1.service or TextChatService
    local var2 = not tbl1 and function(arg1)
        task.defer(arg1)
    end or tbl1.defer or function(arg1)
        task.defer(arg1)
    end

    local tbl2 = {}
    local bool1 = false

    local function flush()
        bool1 = false
        local tbl3 = tbl2
        tbl2 = {}
        callback(tbl3)
    end

    if connectCoreMessageReceived(var1, function(arg1)
        if not isHistoricalMessage(arg1) or arg1.TextSource == nil then
            return
        end

        table.insert(tbl2, arg1)
        if not bool1 then
            bool1 = true
            var2(flush)
        end
    end) then
        pcall(function()
            var1:ChatIsLoaded()
        end)
    end
end

return connectHistoryReplay
