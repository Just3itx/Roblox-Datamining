-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local context = ExpChatShared.context
local GlobalCommands = ExpChatShared.GlobalCommands
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

return function(str1: string, num1: number)
    if not context.translator then
        var1:warning("context.translator is nil, cannot execute command")
        return false
    end

    for _, value in ipairs(GlobalCommands.getGlobalEnabledCommands()) do
        for _, alia in ipairs(value.alias) do
            if str1 ~= alia and string.find(str1, "^" .. alia .. "%s") == nil then
                continue
            end

            local var2 = value.clientRun(context.store, num1, str1, context)

            if var2 ~= nil then
                local key = var2.key
                local var3 = nil

                if type(key) == "string" and key ~= "" then
                    var3 = context.translator:FormatByKey(key, var2.args)
                elseif type(key) == "table" and #key > 0 then
                    local tbl1 = {}
                    for _, value2 in key do
                        local translator = context.translator
                        local args = var2.args
                        table.insert(tbl1, translator:FormatByKey(value2, args))
                    end
                    var3 = table.concat(tbl1, "\n")
                end

                if var3 then
                    GetMessagesStore(false).addSystemMessage(var3, "RBXGlobal")
                    if FFlagExpChatUseChannelTabsStore then
                        GetChannelTabsStore(false).markChannelUnread("RBXGlobal")
                    end
                end
            end

            return true
        end
    end

    return false
end
