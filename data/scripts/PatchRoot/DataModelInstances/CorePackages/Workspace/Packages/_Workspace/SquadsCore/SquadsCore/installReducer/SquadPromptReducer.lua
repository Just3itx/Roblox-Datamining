-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SetSquadPrompt = require(SquadsCore.Actions.SetSquadPrompt)
local CloseSquadPrompt = require(SquadsCore.Actions.CloseSquadPrompt)

local Cryo = require(SquadsCoreParent.Cryo)
local createReducer = require(SquadsCoreParent.Rodux).createReducer

local tbl1 = {}
tbl1[SetSquadPrompt.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { arguments = arg2.arguments or {} })
end

tbl1[CloseSquadPrompt.name] = function(_, _)
    return {
        arguments = {}
    }
end

return createReducer({ arguments = {} }, tbl1)
