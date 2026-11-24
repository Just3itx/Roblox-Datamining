-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent

local Rodux = require(ExperienceLoadingScriptParent.Rodux)
local SetIsSubjectToChinaPolicies = require(ExperienceLoadingScript.Actions.SetIsSubjectToChinaPolicies)
local SetGameProductInfo = require(ExperienceLoadingScript.Actions.SetGameProductInfo)
local SetUniverseId = require(ExperienceLoadingScript.Actions.SetUniverseId)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetGameProductInfo.name] = function(_, arg1)
    return arg1.productInfo
end

local productInfo = createReducer(nil, tbl1)

local createReducer2 = Rodux.createReducer
local tbl2 = {}
tbl2[SetUniverseId.name] = function(_, arg1)
    return {
        universeId = arg1.universeId,
        placeId = arg1.placeId
    }
end

local gameIds = createReducer2(nil, tbl2)

local createReducer3 = Rodux.createReducer
local tbl3 = {}
tbl3[SetIsSubjectToChinaPolicies.name] = function(_, arg1)
    return arg1.isSubjectToChinaPolicies
end

local isSubjectToChinaPolicies = createReducer3(nil, tbl3)

return Rodux.combineReducers(
    {
        isSubjectToChinaPolicies = isSubjectToChinaPolicies,
        productInfo = productInfo,
        gameIds = gameIds
    }
)
