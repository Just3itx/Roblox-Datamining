-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetEquippedAssets = require(scriptParentParent.Actions.SetEquippedAssets)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[SetEquippedAssets.name] = function(_, arg1)
    local result = {}
    for _, equippedAsset in ipairs(arg1.equippedAssets) do
        local assetId = equippedAsset.assetId
        result[tostring(assetId)] = true
    end
    return result
end

return createReducer({}, tbl1)
