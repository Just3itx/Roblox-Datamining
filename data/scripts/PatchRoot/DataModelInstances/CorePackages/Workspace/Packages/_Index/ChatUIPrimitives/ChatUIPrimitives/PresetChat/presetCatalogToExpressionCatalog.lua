-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ChatUIPrimitivesParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
local _Types = require(script.Parent.Types)
local _Types2 = require(script.Parent.Parent.UniversalMessage.Types)
local presetMessageToContent = require(script.Parent.presetMessageToContent)

local function accessLevelToStatus(accessLevel): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if accessLevel == "Enabled" then "enabled" else "disabled"
end

local function presetCategoryToExpressionCategory(arg1)
    local items = {}
    for _, value in if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then arg1.contents else arg1.messages do
        local var1 = presetMessageToContent.presetMessageToExpressionItem(value)
        if var1 ~= nil then
            table.insert(items, var1)
        end
    end
    return {
        categoryId = arg1.categoryId,
        name = arg1.name,
        items = items
    }
end

local function presetCategoryGroupToExpressionGroup(arg1)
    local categories = {}
    for _, value in arg1.categories do
        table.insert(categories, (presetCategoryToExpressionCategory(value)))
    end
    return {
        categoryGroupId = arg1.categoryGroupId,
        name = arg1.name,
        categories = categories
    }
end

local function presetCatalogToExpressionCatalog(arg1)
    local categoryGroups = {}
    for _, categoryGroup in arg1.categoryGroups do
        table.insert(categoryGroups, (presetCategoryGroupToExpressionGroup(categoryGroup)))
    end
    return {
        status = accessLevelToStatus(arg1.accessLevel),
        categoryGroups = categoryGroups,
        version = arg1.version
    }
end

return presetCatalogToExpressionCatalog
