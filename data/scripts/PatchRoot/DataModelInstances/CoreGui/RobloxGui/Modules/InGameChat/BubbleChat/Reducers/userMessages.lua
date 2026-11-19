-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local AddMessage = require(script.Parent.Parent.Actions.AddMessage)
local RemoveMessage = require(script.Parent.Parent.Actions.RemoveMessage)
local PlayerRemoved = require(RobloxGui.Modules.VoiceChat.Actions.PlayerRemoved)

local createReducer = Rodux.createReducer

local tbl1 = {}

tbl1[AddMessage.name] = function(arg1, arg2)
    local var1 = arg1[arg2.message.userId] or {}

    return Cryo.Dictionary.join(arg1, { [arg2.message.userId] = Cryo.List.join(var1, { arg2.message.id }) })
end

tbl1[RemoveMessage.name] = function(arg1, arg2)
    local var1 = arg1[arg2.message.userId]

    if not var1 then
        return arg1
    end

    if #var1 == 1 and var1[1] == arg2.message.id then
        return Cryo.Dictionary.join(arg1, { [arg2.message.userId] = Cryo.None })
    end

    local join = Cryo.Dictionary.join

    local tbl2 = {
        [arg2.message.userId] = Cryo.List.filter(var1, function(id): boolean
            return id ~= arg2.message.id
        end)
    }

    return join(arg1, tbl2)
end

tbl1[PlayerRemoved.name] = function(arg1, arg2)
    if not arg1[arg2.userId] then
        return arg1
    end

    return Cryo.Dictionary.join(arg1, { [arg2.userId] = Cryo.None })
end

return (createReducer({}, tbl1))
