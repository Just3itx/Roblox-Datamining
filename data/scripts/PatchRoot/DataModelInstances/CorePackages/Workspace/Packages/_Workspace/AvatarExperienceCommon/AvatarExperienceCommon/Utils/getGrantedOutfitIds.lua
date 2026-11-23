-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local OutfitTypes = require(AvatarExperienceCommon.Enums.OutfitTypes)
local _CategoryTypes = require(AvatarExperienceCommon.Types.CategoryTypes.CategoryTypes)
local NON_EDITABLE_MAKEUP_GRANT_KEY = require(AvatarExperienceCommon.Constants).NON_EDITABLE_MAKEUP_GRANT_KEY

local function getGrantedOutfitIds(tbl1, arg1, bool1: boolean?)
    if not tbl1 then
        return {}
    end

    local var1

    if arg1 == OutfitTypes.Avatar then
        var1 = bool1 == nil and { OutfitTypes.EditableAvatar, OutfitTypes.Avatar }
            or bool1 and { OutfitTypes.EditableAvatar }
            or { OutfitTypes.Avatar }
    else
        var1 = arg1 ~= OutfitTypes.Makeup and { arg1 }
            or bool1 == nil and { OutfitTypes.Makeup, NON_EDITABLE_MAKEUP_GRANT_KEY }
            or bool1 and { OutfitTypes.Makeup }
            or { NON_EDITABLE_MAKEUP_GRANT_KEY }
    end

    local grantedOutfitIds = {}
    local tbl2 = ({})
    for _, value in var1 do
        local var2 = tbl1.grantedOutfitsByType[value]
        if not var2 then
            continue
        end

        for _, value2 in var2 do
            local str1 = tostring(value2)
            if not tbl2[str1] then
                tbl2[str1] = true
                table.insert(grantedOutfitIds, str1)
            end
        end
    end

    return grantedOutfitIds
end

return getGrantedOutfitIds
