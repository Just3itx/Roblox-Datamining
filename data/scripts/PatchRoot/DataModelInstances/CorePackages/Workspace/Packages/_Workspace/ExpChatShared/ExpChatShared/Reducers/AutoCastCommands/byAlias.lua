-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)
local Dictionary = require(ExpChatSharedParent.llama).Dictionary

local Commands = ExpChatShared.Commands
local RBXWhisperCommand = require(Commands.Whisper.RBXWhisperCommand)
local RBXTeamCommand = require(Commands.RBXTeamCommand)

local Actions = ExpChatShared.Actions
local CommandAliasChanged = require(Actions.CommandAliasChanged)

local tbl1 = {
    RBXWhisperCommand = {
        primaryAlias = RBXWhisperCommand.alias[1],
        secondaryAlias = RBXWhisperCommand.alias[2]
    },
    RBXTeamCommand = {
        primaryAlias = RBXTeamCommand.alias[1],
        secondaryAlias = RBXTeamCommand.alias[2]
    }
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[CommandAliasChanged.name] = function(arg1, arg2)
    return Dictionary.join(arg1, { [arg2.name] = { primaryAlias = arg2.primaryAlias, secondaryAlias = arg2.secondaryAlias } })
end

return createReducer(tbl1, tbl2)
