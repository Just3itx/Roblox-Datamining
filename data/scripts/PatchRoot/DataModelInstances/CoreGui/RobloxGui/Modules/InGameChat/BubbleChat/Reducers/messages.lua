-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local AddMessage = require(script.Parent.Parent.Actions.AddMessage)
local RemoveMessage = require(script.Parent.Parent.Actions.RemoveMessage)
local SetMessageText = require(script.Parent.Parent.Actions.SetMessageText)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[AddMessage.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.message.id] = arg2.message })
end

tbl1[RemoveMessage.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.message.id] = Cryo.None })
end

tbl1[SetMessageText.name] = function(arg1, arg2)
    local var1 = arg1[arg2.messageId]
    if not var1 then
        return arg1
    end

    return Cryo.Dictionary.join(arg1, { [arg2.messageId] = Cryo.Dictionary.join(var1, { text = arg2.newText }) })
end

return (createReducer({}, tbl1))
