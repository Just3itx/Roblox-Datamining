-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local Display = require(CollectionViewsParent.Display)
local Signals = require(CollectionViewsParent.Signals)

local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)
local createCollectionLayoutStore = require(script.Parent.createCollectionLayoutStore)

local FFlagEnableHomePageSduiPrefetch = require(CollectionViewsParent.SharedFlags).FFlagEnableHomePageSduiPrefetch

local function createMainCollectionLayoutStore()
    local displayStore = Display.GetDisplayStore(false)

    local var1, setDefaultContentRegionWidth = Signals.createSignal(nil)

    local computed = Signals.createComputed(function(arg1)
        return var1(arg1) or displayStore.getViewportSize(arg1).X
    end)

    local getIsContainerMeasured = if FFlagEnableHomePageSduiPrefetch then Signals.createComputed(function(arg1): boolean
        local var3 = var1(arg1)
        return not (var3 == nil) and var3 > 0
    end) else nil

    local collectionLayoutStore = createCollectionLayoutStore(computed)
    return {
        getContainerWidth = collectionLayoutStore.getContainerWidth,
        getDesignSpaceContainerWidth = collectionLayoutStore.getDesignSpaceContainerWidth,
        getItemsPerRow = collectionLayoutStore.getItemsPerRow,
        getNumItemsForAllCategories = collectionLayoutStore.getNumItemsForAllCategories,
        getIsContainerMeasured = getIsContainerMeasured,
        setDefaultContentRegionWidth = setDefaultContentRegionWidth
    }
end

return createMainCollectionLayoutStore
