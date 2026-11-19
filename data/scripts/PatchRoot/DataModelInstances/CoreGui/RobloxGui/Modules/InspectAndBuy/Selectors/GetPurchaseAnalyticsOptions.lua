-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)
local _Analytics = require(scriptParentParent.Services.Analytics)
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)

return function(arg1, str1: string?, bundle: string?, price: number?)
    if not str1 then
        return { price = price }
    end

    local var1, var2

    if bundle == Constants.ItemType.Bundle then
        local var3 = arg1.bundles and arg1.bundles[str1]
        if not var3 then
            return { price = price }
        end

        var1 = var3.bundleType
        var2 = tonumber(var3.price)
    else
        local asset = arg1.assets and arg1.assets[str1]
        if not asset then
            return { price = price }
        end

        var1 = asset.assetTypeId
        var2 = tonumber(asset.price)
    end

    local tbl1 = { itemSubType = 0, price = 0 }

    if var1 == nil or var1 == "" then
        var1 = nil
    end

    tbl1.itemSubType = var1
    tbl1.price = price or var2
    return tbl1
end
