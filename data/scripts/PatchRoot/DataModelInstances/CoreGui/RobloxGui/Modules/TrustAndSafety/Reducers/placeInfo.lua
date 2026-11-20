-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent
local SetPlaceInfo = require(scriptParentParent.Actions.SetPlaceInfo)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetPlaceInfo.name] = function(_, arg1)
    return {
        name = arg1.name,
        description = arg1.description
    }
end

return createReducer({ name = "", description = "" }, tbl1)
