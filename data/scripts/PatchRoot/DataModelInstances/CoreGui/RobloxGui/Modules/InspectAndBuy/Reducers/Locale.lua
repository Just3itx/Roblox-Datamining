-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetLocale = require(scriptParentParent.Actions.SetLocale)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetLocale.name] = function(_, arg1)
    return arg1.locale
end

return createReducer("en-us", tbl1)
