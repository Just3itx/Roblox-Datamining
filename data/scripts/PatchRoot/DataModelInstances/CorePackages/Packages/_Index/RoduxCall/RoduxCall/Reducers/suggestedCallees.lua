-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCall = script:FindFirstAncestor("RoduxCall")
local RoduxCallParent = RoduxCall.Parent
local Rodux = require(RoduxCallParent.Rodux)
local SuggestedCalleeModel = require(RoduxCall.Models).SuggestedCalleeModel
local ClearSuggestedCallees = require(RoduxCall.Actions).ClearSuggestedCallees

local _roduxCallTypes = require(script.Parent.Parent.roduxCallTypes)

local tbl1 = {
    suggestedCallees = {}
}
return function(arg1)
    local networkingCall = arg1.NetworkingCall
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingCall.GetSuggestedCallees.Succeeded.name] = function(_, arg2)
        local suggestedCallees = arg2.responseBody.suggestedCallees

        local tbl4 = {}
        for _, value in ipairs(suggestedCallees) do
            assert(SuggestedCalleeModel.isValid(value))
            local var1 = SuggestedCalleeModel.format(value)
            tbl4[#tbl4 + 1] = var1
        end

        return { suggestedCallees = tbl4 }
    end
    tbl3[ClearSuggestedCallees.name] = function(_, _)
        return tbl1
    end

    return createReducer(tbl2, tbl3)
end
