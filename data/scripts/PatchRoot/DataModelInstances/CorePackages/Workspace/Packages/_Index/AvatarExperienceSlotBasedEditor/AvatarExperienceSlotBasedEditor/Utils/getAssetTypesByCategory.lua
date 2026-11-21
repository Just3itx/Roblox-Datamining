-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local Cryo = require(AvatarExperienceSlotBasedEditorParent.Cryo)
local Categories = require(script.Parent.Parent.Enums.Categories)
local _Types = require(script.Parent.Parent.Types)
local BodyAssetTypes = require(script.Parent.Parent.Constants).BodyAssetTypes

local function getAssetTypesByCategory(body, tbl1)
    local tbl2 = ({})

    local var1 = body ~= Categories.Body and {} or Cryo.List.map(BodyAssetTypes, function(arg1): string
        return tostring(arg1.Value)
    end)

    for _, value in tbl1 do
        var1 = Cryo.List.join(var1 or {}, Cryo.List.map(Cryo.List.filter(value.assetTypes, function(arg1): boolean
            if tbl2[arg1] then
                return false
            end

            tbl2[arg1] = true
            return true
        end), function(arg1): string
            return tostring(arg1.Value)
        end))
    end

    local find = Cryo.List.find
    local rightShoeAccessoryValue = Enum.AssetType.RightShoeAccessory.Value

    if find(var1, tostring(rightShoeAccessoryValue)) then
        table.insert(var1, tostring(Enum.AssetType.LeftShoeAccessory.Value))
    end

    return var1
end

return getAssetTypesByCategory
