-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local Rodux = require(CrossExperience.dependencies).Rodux

local Participants = require(script.Participants)
local Experience = require(script.Experience)

return function(arg1)
    local experience = nil
    local participants = if arg1 and arg1.Participants then arg1.Participants else nil

    if arg1 and arg1.Experience then
        experience = arg1.Experience
    end

    return Rodux.combineReducers({ Participants = Participants(participants), Experience = Experience(experience) })
end
