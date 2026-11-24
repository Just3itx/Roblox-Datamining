-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Promise = require(ExpChatSharedParent.Promise)

local context = require(ExpChatShared.context)

local Commands = script:FindFirstAncestor("Commands")
local _types = require(Commands.types)

local function matchesAlias(autoCastCommand, str1: string)
    for _, value in pairs(autoCastCommand) do
        if string.find(str1, "^" .. value .. " ") then
            return true
        end
    end

    return false
end

return function(arg1, num1: number, str1: string)
    return Promise.try(function()
        assert(context.store, "Store should exist")

        local autoCastCommand = context.store:getState().AutoCastCommands[arg1.name]
        if matchesAlias(autoCastCommand, str1) then
            local var1 = arg1.clientRun(context.store, num1, str1)
            if var1 and string.find(var1.metadata, "Success") then
                return Promise.resolve(var1)
            end
        end

        return Promise.reject()
    end)
end
