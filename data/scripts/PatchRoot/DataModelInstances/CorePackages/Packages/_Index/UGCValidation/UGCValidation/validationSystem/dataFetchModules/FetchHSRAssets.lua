-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local ParseContentIds = require(scriptParentParentParent.util.ParseContentIds)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local _Types = require(scriptParentParentParent.util.Types)

local getFFlagUGCValidateVersionedContentIds = require(scriptParentParentParent.flags.getFFlagUGCValidateVersionedContentIds)

local module = {}

function module.getData(arg1, arg2)
    if arg2.consumerEnv == ValidationEnums.ConsumerEnv.IEC then
        return {}
    end

    local data = ({})

    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    for _, descendant in descendants do
        if not descendant:IsA("WrapLayer") then
            continue
        end

        local hsrAssetId = descendant.HSRAssetId
        if not hsrAssetId or hsrAssetId == "" then
            continue
        end

        local referenceKey

        if getFFlagUGCValidateVersionedContentIds() then
            local var1, var2 = ParseContentIds.tryParseContentId(hsrAssetId)
            if var1 then
                referenceKey = ParseContentIds.getReferenceKey(var1, var2)
            else
                referenceKey = nil
            end
        else
            referenceKey = ParseContentIds.tryGetAssetIdFromContentId(hsrAssetId)
        end
        if not referenceKey or data[referenceKey] then
            continue
        end

        local preloadedHsrAsset = arg2.preloadedHsrAssets[referenceKey]
        if preloadedHsrAsset then
            data[referenceKey] = preloadedHsrAsset
        else
            local success, result = pcall(function(): {Instance}
                return game:GetObjectsAllOrNone(hsrAssetId)
            end)

            if not success then
                return nil
            end

            data[referenceKey] = result or {}
        end
    end
    return data
end

return module
