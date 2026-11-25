-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _PurchasePromptParent = PurchasePrompt.Parent

local RequestType = require(PurchasePrompt.Enums.RequestType)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum

local tbl1 = {
    [RequestType.Asset] = ProductTypeEnum.Asset,
    [RequestType.Bundle] = ProductTypeEnum.Bundle,
    [RequestType.GamePass] = ProductTypeEnum.Gamepass,
    [RequestType.Product] = ProductTypeEnum.Product,
    [RequestType.AvatarCreationFee] = ProductTypeEnum.AvatarCreationFee,
    [RequestType.Experience] = ProductTypeEnum.Experience,
    [RequestType.Look] = ProductTypeEnum.Look,
    [RequestType.DeveloperSubscription] = ProductTypeEnum.DeveloperSubscription,
    [RequestType.VIPServer] = ProductTypeEnum.VIPServer
}

function getProductTypeFromRequestType(arg1)
    return tbl1[arg1] or ProductTypeEnum.Unknown
end

return getProductTypeFromRequestType
