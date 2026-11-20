-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local ShowToast = require(scriptParentParent.Actions.ShowToast)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[ShowToast.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { toastTitle = arg2.toastTitle, toastSubtitle = arg2.toastSubtitle })
end

return createReducer({ toastTitle = nil, toastSubtitle = nil }, tbl1)
