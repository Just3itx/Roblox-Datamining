-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local RunService = game:GetService("RunService")
local ItemLicenseType = require(AvatarExperienceCommonParent.AvatarExperienceModel).Enums.ItemLicenseType
local normalize = require(script.Parent.normalize)
local getRawItemLicensingInfo = require(script.Parent.getRawItemLicensingInfo)

local FFlagAXMarketplaceLicensingItemDetails = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXMarketplaceLicensingItemDetails

local tbl1 = { ItemLicenseType.FirstParty, ItemLicenseType.ThirdParty }

local normalizeTableFn = normalize.makeNormalizeTableFn({
    id = {
        fn = normalize.normalizeString
    },
    licenseType = normalize.makeRequired(normalize.makeNormalizeValueFn(tbl1)),
    badgeAssetId = {
        fn = normalize.normalizeString
    },
    name = {
        fn = normalize.normalizeString
    },
    licenseHolder = {
        fn = normalize.normalizeString
    },
    licenseDisplayName = FFlagAXMarketplaceLicensingItemDetails and {
        fn = normalize.normalizeString
    } or nil
})

return function(arg1)
    local var1 = getRawItemLicensingInfo(arg1) or arg1
    local licenseType = if type(var1) == "table" then var1.licenseType else nil

    if RunService:IsStudio() and licenseType ~= nil and table.find(tbl1, licenseType) == nil then
        warn(`Unsupported item licensing type: {tostring(licenseType)}`)
    end

    return (normalizeTableFn(var1))
end
