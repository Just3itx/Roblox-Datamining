-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ClientSettingsLoaded = require(Actions.ClientSettingsLoaded)
local ClientSettingsChanged = require(Actions.ClientSettingsChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ClientSettingsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(arg1, arg2.value)
end

tbl1[ClientSettingsChanged.name] = function(arg1, arg2)
    return Dictionary.join(arg1, { [arg2.property] = arg2.value })
end

return createReducer({ preferredTransparency = 1 }, tbl1)
