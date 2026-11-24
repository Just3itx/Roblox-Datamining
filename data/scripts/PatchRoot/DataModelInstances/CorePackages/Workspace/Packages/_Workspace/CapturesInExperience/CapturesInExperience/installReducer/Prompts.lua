-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Rodux = require(scriptParentParentParent.Rodux)

local PromptDismissed = require(scriptParentParent.Actions.PromptDismissed)
local PromptTriggered = require(scriptParentParent.Actions.PromptTriggered)
local _Types = require(scriptParentParent.Types)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PromptDismissed.name] = function(tbl2, arg1)
    return Cryo.List.filter(tbl2, function(arg2): boolean
        return arg2.PromptId ~= arg1.promptId
    end)
end

tbl1[PromptTriggered.name] = function(tbl2, arg1)
    local tbl3 = {
        PromptData = arg1.promptData,
        PromptType = arg1.promptType,
        PromptId = arg1.promptId
    }

    return Cryo.List.join(tbl2, { tbl3 })
end

return createReducer({}, tbl1)
