-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RetrievalStatus = require(CorePackages.Workspace.Packages.Http).Enum.RetrievalStatus
local scriptParentParent = script.Parent.Parent
local IsDetailsItemPartOfBundleAndOffsale = require(scriptParentParent.Selectors.IsDetailsItemPartOfBundleAndOffsale)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getFavoriteForAsset")
local inspectAndBuyKeyMapper2 = createInspectAndBuyKeyMapper("getFavoriteForBundle")

return function(arg1): boolean
    local assetId = arg1.detailsInformation.assetId
    if not assetId then
        return false
    end
    local var1 = IsDetailsItemPartOfBundleAndOffsale(arg1)
    if var1 == nil then
        return false
    end
    local asset = arg1.assets[assetId]
    if not asset then
        return false
    end

    if not var1 then
        local var2 = inspectAndBuyKeyMapper(arg1.storeId, assetId)
        return arg1.FetchingStatus[var2] == RetrievalStatus.Fetching or arg1.FetchingStatus[var2] == RetrievalStatus.Done
    end

    local bundleId = UtilityFunctions.getBundleId(asset)

    local var2 = inspectAndBuyKeyMapper2(arg1.storeId, bundleId)
    return arg1.FetchingStatus[var2] == RetrievalStatus.Fetching or arg1.FetchingStatus[var2] == RetrievalStatus.Done
end
