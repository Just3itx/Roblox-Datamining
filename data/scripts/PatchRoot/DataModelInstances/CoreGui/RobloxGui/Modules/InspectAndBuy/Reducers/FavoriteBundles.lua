-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)
local scriptParentParent = script.Parent.Parent
local SetFavoriteBundle = require(scriptParentParent.Actions.SetFavoriteBundle)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetFavoriteBundle.name] = function(arg1, arg2)
    local id = arg2.id
    local isFavorite = arg2.isFavorite
    return Cryo.Dictionary.join(arg1, { [id] = isFavorite })
end

return createReducer({}, tbl1)
