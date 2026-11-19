-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent

local SetIsSubjectToChinaPolicies = require(scriptParentParent.Actions.SetIsSubjectToChinaPolicies)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetIsSubjectToChinaPolicies.name] = function(_, arg1)
    return arg1.isSubjectToChinaPolicies
end

return (createReducer(true, tbl1))
