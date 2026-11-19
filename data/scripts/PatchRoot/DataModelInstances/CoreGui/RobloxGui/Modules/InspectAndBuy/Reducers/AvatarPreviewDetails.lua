-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetAvatarPreviewDetails = require(scriptParentParent.Actions.SetAvatarPreviewDetails)
local UpdateBulkPuchaseResults = require(scriptParentParent.Actions.UpdateBulkPuchaseResults)
local AvatarExperienceModel = require(CorePackages.Workspace.Packages.AvatarExperienceModel)
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local FFlagAXEnableFetchAvatarPreview = require(scriptParentParent.Flags.FFlagAXEnableFetchAvatarPreview)

local FFlagAXEnableInspectAndBuyBulkPurchase = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAXEnableInspectAndBuyBulkPurchase

local createReducer = Rodux.createReducer

local tbl1 = {
    [UpdateBulkPuchaseResults.name] = FFlagAXEnableInspectAndBuyBulkPurchase and function(arg1, arg2)
        local robuxSpent = arg2.result.RobuxSpent
        local totalPrice = arg1.totalPrice - robuxSpent
        return Cryo.Dictionary.join(arg1, { totalPrice = totalPrice })
    end or nil,
    [SetAvatarPreviewDetails.name] = FFlagAXEnableFetchAvatarPreview and function(arg1, arg2)
        local tbl1 = {}
        local totalPrice, totalValue

        if arg2.avatarPreviewDetails and arg2.avatarPreviewDetails.look then
            local look = arg2.avatarPreviewDetails.look

            totalPrice = look.totalPrice
            totalValue = look.totalValue

            if look.items then
                tbl1 = Cryo.List.map(look.items, function(arg3)
                    return {
                        id = tostring(arg3.id),
                        itemType = if arg3.itemType == ItemTypeEnum.Asset then ItemTypeEnum.Asset else ItemTypeEnum.Bundle,
                        noPriceStatus = arg3.noPriceStatus,
                        quantityOwned = arg3.quantityOwned
                    }
                end)
            end
        else
            totalPrice = nil
            totalValue = nil
        end

        return Cryo.Dictionary.join(arg1, { totalPrice = totalPrice, totalValue = totalValue, items = tbl1 })
    end or nil
}

return createReducer({}, tbl1)
