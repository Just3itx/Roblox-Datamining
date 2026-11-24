-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local Analytics = ExpChatShared.Analytics
local FFlagExpChatReportVirtualCommandTelemetry = ExpChatShared.Flags.FFlagExpChatReportVirtualCommandTelemetry
local context = ExpChatShared.context
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

return function(str1: string, num1: number, tbl1, str2: string)
    if not context.translator then
        var1:warning("context.translator is nil, cannot execute command")
        return false
    end

    for _, value in ipairs(tbl1) do
        for _, alia in ipairs(value.alias) do
            if str1 ~= alia and string.find(str1, "^" .. alia .. "%s") == nil then
                continue
            end

            if FFlagExpChatReportVirtualCommandTelemetry then
                Analytics:reportTextChatCommandClientSent(value.name)
            end

            task.spawn(function()
                local var2 = value.clientRun(context.store, num1, str1, context)

                if var2 == nil then
                    return
                end

                local key = var2.key
                local var3 = nil

                if type(key) == "string" and key ~= "" then
                    var3 = context.translator:FormatByKey(key, var2.args)
                elseif type(key) == "table" and #key > 0 then
                    local tbl2 = {}
                    for _, value2 in key do
                        local translator = context.translator
                        local args = var2.args
                        table.insert(tbl2, translator:FormatByKey(value2, args))
                    end
                    var3 = table.concat(tbl2, "\n")
                end

                if not var3 then
                    return
                end

                GetMessagesStore(false).addSystemMessage(var3, str2, var2.metadata)
                if FFlagExpChatUseChannelTabsStore then
                    GetChannelTabsStore(false).markChannelUnread(str2)
                end
            end)

            return true
        end
    end

    return false
end
