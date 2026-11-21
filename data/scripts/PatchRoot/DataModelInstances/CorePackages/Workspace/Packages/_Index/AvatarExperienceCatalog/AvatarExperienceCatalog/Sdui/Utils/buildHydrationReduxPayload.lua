-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local _AvatarExperienceRodux = require(AvatarExperienceCatalogParent.AvatarExperienceRodux)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function buildHydrationReduxPayload(tbl1, tbl2)
    local hydrationReduxPayload = ({})

    for _, value in tbl1 do
        local type = value.type
        local id = tostring(value.id)
        if not hydrationReduxPayload[type] then
            hydrationReduxPayload[type] = {}
        end
        local var1 = table.clone(value)
        var1.id = id
        hydrationReduxPayload[type][id] = var1
    end

    for _, value in tbl2 do
        local type = value.type
        local id = tostring(value.id)
        if not hydrationReduxPayload[type] then
            hydrationReduxPayload[type] = {}
        end
        if hydrationReduxPayload[type][id] then
            continue
        end

        hydrationReduxPayload[type][id] = { id = id, type = type, failedToHydrate = true }
    end

    return hydrationReduxPayload
end

return buildHydrationReduxPayload
