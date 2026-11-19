-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local _Promise = require(CorePackages.Packages.Promise)

local GetCurrentHumanoidDescription = require(script.Parent.GetCurrentHumanoidDescription)
local GetAssetIdsFromDescription = require(script.Parent.GetAssetIdsFromDescription)
local GetAssetNamesForIds = require(script.Parent.GetAssetNamesForIds)

return function(arg1)
    local function getAddedAndRemovedIds(arg2, arg3)
        local var1 = Cryo.List.toSet(arg2)
        local var2 = Cryo.List.toSet(arg3)

        return Cryo.List.filter(arg3, function(arg4): boolean
            return var1[arg4] == nil
        end), (Cryo.List.filter(arg2, function(arg4): boolean
            return var2[arg4] == nil
        end))
    end
    return GetCurrentHumanoidDescription():andThen(function(arg2)
        local assetIdsFromDescription = GetAssetIdsFromDescription(arg2)
        local assetIdsFromDescription2 = GetAssetIdsFromDescription(arg1)

        local addedAssetIds, removedAssetIds = getAddedAndRemovedIds(assetIdsFromDescription, assetIdsFromDescription2)
        local var3 = Cryo.List.join(addedAssetIds, removedAssetIds)

        return GetAssetNamesForIds(var3):andThen(function(arg3)
            local addedNames = {}
            for _, value in ipairs(addedAssetIds) do
                table.insert(addedNames, arg3[value])
            end

            local removedNames = {}
            for _, value in ipairs(removedAssetIds) do
                table.insert(removedNames, arg3[value])
            end

            return {
                addedNames = addedNames,
                removedNames = removedNames,
                addedAssetIds = addedAssetIds,
                removedAssetIds = removedAssetIds
            }
        end)
    end)
end
