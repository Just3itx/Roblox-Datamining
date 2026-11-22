-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local RoduxSquadsParent = RoduxSquads.Parent
local Rodux = require(RoduxSquadsParent.Rodux)
local CurrentExperienceInviteStatusUpdated = require(RoduxSquads.Actions).CurrentExperienceInviteStatusUpdated

local _RoduxSquadsTypes = require(script.Parent.Parent.RoduxSquadsTypes)

return function()
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[CurrentExperienceInviteStatusUpdated.name] = function(_: boolean, arg1)
        return arg1.payload.isExperienceInvitePending
    end

    return createReducer(false, tbl1)
end
