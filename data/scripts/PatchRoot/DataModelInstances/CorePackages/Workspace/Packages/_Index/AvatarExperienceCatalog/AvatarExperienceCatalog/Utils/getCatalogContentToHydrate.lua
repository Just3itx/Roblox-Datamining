-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum

local FFlagAXMigrateAllTabToSduiDev = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMigrateAllTabToSduiDev

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function getCatalogContentToHydrate(tbl1, arg1, num1: number?)
    local catalogContentToHydrate = {}
    if not tbl1 or #tbl1 == 0 then
        return catalogContentToHydrate
    end

    local num2 = if num1 ~= nil then math.min(num1, #tbl1) else #tbl1
    local tbl2 = ({})

    for i = 1, num2 do
        local var1 = tbl1[i]
        local type = var1.type

        local var2 = tbl2[type]
        if var2 == nil then
            if arg1 and arg1[type] then
                var2 = arg1[type]
            else
                var2 = false
            end
            tbl2[type] = var2
        end

        local var3 = if var2 then var2[var1.id] else nil
        local bool1 = type == ItemTypeEnum.Look and not FFlagAXMigrateAllTabToSduiDev

        if bool1 or not var3 then
            table.insert(catalogContentToHydrate, var1)
        end
    end

    return catalogContentToHydrate
end

return getCatalogContentToHydrate
