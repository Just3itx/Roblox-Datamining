-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local CollectionService = game:GetService("CollectionService")
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateNoExtraTagsRequireHsrAssets = require(scriptParentParentParent.flags.getFFlagUGCValidateNoExtraTagsRequireHsrAssets)

local module = {
    categories = Constants.AllAssetUploadCategories,
    requiredData = getFFlagUGCValidateNoExtraTagsRequireHsrAssets()
        and { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.hsrAssets }
        or { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = { "Asset_EF_TaggedJacket", "Bundle_EF_BodyWithLLLTagged.LeftLeg" }
}
local function collectTaggedPaths(arg1, tbl1)
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)
    for _, descendant in descendants do
        if #CollectionService:GetTags(descendant) > 0 then
            table.insert(tbl1, descendant:GetFullName())
        end
    end
end

function module.run(arg1, arg2)
    local tbl1 = {}
    collectTaggedPaths(arg2.rootInstance, tbl1)

    if getFFlagUGCValidateNoExtraTagsRequireHsrAssets() then
        for _, hsrAsset in arg2.hsrAssets do
            for _, value in hsrAsset do
                collectTaggedPaths(value, tbl1)
            end
        end
    else
        local hsrAssets = arg2.hsrAssets
        if type(hsrAssets) == "table" then
            for _, hsrAsset in hsrAssets do
                if type(hsrAsset) ~= "table" then
                    continue
                end

                for _, value in hsrAsset do
                    collectTaggedPaths(value, tbl1)
                end
            end
        end
    end

    if #tbl1 > 0 then
        arg1:fail(ErrorSourceStrings.Keys.InstanceTagsFound, { ProblematicDescendantPaths = table.concat(tbl1, ", ") })
    end
end

return module
