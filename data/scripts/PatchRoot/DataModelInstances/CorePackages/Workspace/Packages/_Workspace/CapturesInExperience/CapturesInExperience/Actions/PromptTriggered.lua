-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local _PromptType = require(scriptParentParent.Enums.PromptType)
local _Types = require(scriptParentParent.Types)

return Rodux.makeActionCreator(script.Name, function(promptId, promptType, promptData)
    return { promptData = promptData, promptId = promptId, promptType = promptType }
end)
