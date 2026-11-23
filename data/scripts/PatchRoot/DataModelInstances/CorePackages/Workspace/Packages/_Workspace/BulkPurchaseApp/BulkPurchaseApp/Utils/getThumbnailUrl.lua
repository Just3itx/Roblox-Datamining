-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local UserLib = require(BulkPurchaseAppParent.UserLib)
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants

local function getRbxThumbType(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "AvatarBundle" then Constants.RbxthumbTypes.BundleThumbnail else Constants.RbxthumbTypes.Asset
end

local function getThumbnailUrl(str1: string, str2: string)
    return getRbxthumbWithTypeSizeAndOptions(
        str1,
        if str2 == "AvatarBundle" then getRbxThumbType("AvatarBundle") else Constants.RbxthumbTypes.Asset,
        150
    )
end
return getThumbnailUrl
