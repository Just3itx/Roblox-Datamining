-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)
local scriptParentParent = script.Parent.Parent
local SetCollectibleResellableInstances = require(scriptParentParent.Actions.SetCollectibleResellableInstances)
local CollectibleInstance = require(scriptParentParent.Models.CollectibleInstance)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetCollectibleResellableInstances.name] = function(arg1, arg2)
    local collectibleItemId = arg2.collectibleItemId

    local tbl2 = {}
    for _, value in arg2.collectibleItemInstances do
        local getCollectibleItemInstances = CollectibleInstance.fromGetCollectibleItemInstances(value)
        tbl2[getCollectibleItemInstances.collectibleInstanceId] = getCollectibleItemInstances
    end

    return Cryo.Dictionary.join(arg1, { [collectibleItemId] = tbl2 })
end

return createReducer({}, tbl1)
