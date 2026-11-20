-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local util = scriptParentParent.util
local ParseContentIds = require(util.ParseContentIds)

local flags = scriptParentParent.flags
local getFFlagUGCValidateEmptySurfaceAppearance = require(flags.getFFlagUGCValidateEmptySurfaceAppearance)

local module = {}

local function findSurfaceAppearances(arg1, bool1: boolean)
    local tbl1 = {}
    local tbl2 = {}

    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    for _, descendant in descendants do
        if not descendant:IsA("SurfaceAppearance") then
            continue
        end

        local propertyValue = UGCValidationService:GetPropertyValue(descendant, "TexturePack")

        if if propertyValue then ParseContentIds.tryGetAssetIdFromContentId(propertyValue) else nil then
            table.insert(tbl1, descendant)
        elseif getFFlagUGCValidateEmptySurfaceAppearance() then
            local emissiveMaskContent

            if descendant.ColorMap and descendant.ColorMap ~= ""
                or descendant.MetalnessMap and descendant.MetalnessMap ~= ""
                or descendant.NormalMap and descendant.NormalMap ~= ""
                or descendant.RoughnessMap and descendant.RoughnessMap ~= ""
            then
                emissiveMaskContent = true
            else
                emissiveMaskContent = descendant.EmissiveMaskContent

                if emissiveMaskContent then
                    if descendant.EmissiveMaskContent.SourceType == Enum.ContentSourceType.Uri then
                        emissiveMaskContent = descendant.EmissiveMaskContent.Uri and descendant.EmissiveMaskContent.Uri ~= ""
                    else
                        emissiveMaskContent = false
                    end
                end
            end

            if emissiveMaskContent or not bool1 then
                table.insert(tbl2, descendant)
            end
        else
            table.insert(tbl2, descendant)
        end
    end

    return tbl1, tbl2
end

function module.findSurfaceAppearancesMissingTexturePacks(arg1, bool1: boolean)
    local _, tbl1 = findSurfaceAppearances(arg1, bool1)
    return tbl1
end

function module.findSurfaceAppearancesWithTexturePacks(arg1)
    return (findSurfaceAppearances(arg1, false))
end

return module
