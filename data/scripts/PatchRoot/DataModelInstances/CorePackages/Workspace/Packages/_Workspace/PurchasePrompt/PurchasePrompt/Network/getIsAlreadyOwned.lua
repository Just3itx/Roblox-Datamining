-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local ProductTypeEnum = require(scriptParentParent.types).ProductTypeEnum
local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(scriptParentParent.Parent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow

local tbl1 = {
    [ProductTypeEnum.VIPServer] = true
}

local function getIsAlreadyOwned(arg1, arg2, arg3, bool1: boolean?)
    if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow and bool1 or tbl1[arg3] then
        return Promise.resolve(false)
    end

    return arg1.getPlayerOwns(Players.LocalPlayer, arg2, arg3):catch(function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return getIsAlreadyOwned
