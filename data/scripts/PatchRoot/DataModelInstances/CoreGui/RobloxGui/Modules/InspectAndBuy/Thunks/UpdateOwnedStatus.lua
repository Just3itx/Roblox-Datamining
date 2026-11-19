-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Constants = require(scriptParentParent.Constants)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local SetAssets = require(scriptParentParent.Actions.SetAssets)

local function UpdateOwnedStatus(arg1, arg2)
    return Thunk.new(script.Name, {}, function(arg3, _)
        local state = arg3:getState()

        if arg2 == Constants.ItemType.Asset then
            if state.assets[arg1] then
                local purchaseSuccess = AssetInfo.fromPurchaseSuccess(arg1)
                arg3:dispatch(SetAssets({ purchaseSuccess }))
            end
        elseif arg2 == Constants.ItemType.Bundle and state.bundles[arg1] then
            local purchaseSuccess = BundleInfo.fromPurchaseSuccess(arg1)
            arg3:dispatch(SetBundles({ purchaseSuccess }))
        end
    end)
end

return UpdateOwnedStatus
