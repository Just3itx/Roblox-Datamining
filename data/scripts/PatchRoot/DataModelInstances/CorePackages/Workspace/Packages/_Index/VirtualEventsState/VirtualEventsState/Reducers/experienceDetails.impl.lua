-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local Cryo = require(VirtualEventsState.Parent.Cryo)
local Rodux = require(VirtualEventsState.Parent.Rodux)
local _ExperienceDetailsModel = require(VirtualEventsState.Models.ExperienceDetailsModel)

return function(arg1)
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[arg1.GetExperiencesDetails.Succeeded.name] = function(tbl2, arg2)
        local var1 = arg2.ids[1]
        local var2 = arg2.responseBody.data[1]

        return Cryo.Dictionary.join(tbl2, { [var1] = var2 })
    end

    tbl1[arg1.GetExperiencesDetails.Failed.name] = function<T>(tbl2, _): T
        return tbl2
    end

    return (createReducer({}, tbl1))
end
