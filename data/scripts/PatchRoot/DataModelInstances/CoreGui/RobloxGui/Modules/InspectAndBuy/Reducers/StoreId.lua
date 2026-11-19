-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent
local UpdateStoreId = require(scriptParentParent.Actions.UpdateStoreId)

local num1 = 0

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UpdateStoreId.name] = function(_, _): string
    num1 += 1
    return tostring(num1)
end

return createReducer("0", tbl1)
