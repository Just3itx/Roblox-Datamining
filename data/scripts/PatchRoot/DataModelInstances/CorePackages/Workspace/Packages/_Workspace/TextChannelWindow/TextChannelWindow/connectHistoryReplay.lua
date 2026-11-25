-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local function connectHistoryReplay(callback: (...any) -> (...any), tbl1)
    local var1 = tbl1 and tbl1.service or TextChatService
    local var2 = tbl1 and tbl1.defer or function(arg1)
        task.defer(arg1)
    end

    local success, result = pcall(function()
        return var1.CoreMessageReceived
    end)
    if not (success and result) then
        return
    end

    local tbl2 = {}
    local bool1 = false

    local function flush()
        bool1 = false
        local tbl3 = tbl2
        tbl2 = {}
        callback(tbl3)
    end

    result:Connect(function(arg1)
        if arg1.IsHistorical ~= true or arg1.TextSource == nil then
            return
        end

        table.insert(tbl2, arg1)
        if not bool1 then
            bool1 = true
            var2(flush)
        end
    end)

    pcall(function()
        var1:ChatIsLoaded()
    end)
end

return connectHistoryReplay
