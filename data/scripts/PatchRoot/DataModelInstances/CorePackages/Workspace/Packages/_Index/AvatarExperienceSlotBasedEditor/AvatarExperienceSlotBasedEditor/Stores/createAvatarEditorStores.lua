-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local FFlagAXEnableInventorySearch = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXEnableInventorySearch

local _createCategoryInventoryStore = require(script.Parent.Parent.Stores.createCategoryInventoryStore)
local createInventorySearchStore = require(script.Parent.Parent.Stores.createInventorySearchStore)
local createSortAndFiltersStore = require(script.Parent.Parent.Stores.createSortAndFiltersStore)
local _createThumbnailLatencyStore = require(script.Parent.Parent.Stores.createThumbnailLatencyStore)

local function createAvatarEditorStores()
    return {
        categoryInventoryStores = {},
        sortAndFiltersStore = createSortAndFiltersStore(),
        thumbnailLatencyStores = {},
        inventorySearchStore = if FFlagAXEnableInventorySearch then createInventorySearchStore() else nil
    }
end

return createAvatarEditorStores
