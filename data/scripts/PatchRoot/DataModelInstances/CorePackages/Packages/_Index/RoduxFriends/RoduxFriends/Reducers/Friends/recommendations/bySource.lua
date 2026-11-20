-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParentParent.llama)

local Actions = scriptParentParentParentParent.Actions
local RecommendationSourceCreated = require(Actions.RecommendationSourceCreated)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local tbl1 = {}

return function(_)
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[RecommendationSourceCreated.name] = function(arg1, arg2)
        local source = arg2.payload.source
        local var1 = arg2.payload.recommendationIds or {}

        local var2 = llama.List.reduce(var1, function(arg3, arg4)
            arg3[tostring(arg4)] = true
            return arg3
        end, {})

        return llama.Dictionary.join(arg1, { [source] = var2 })
    end

    return createReducer(tbl2, tbl3)
end
