-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local Signals = require(CollectionViewsParent.Signals)
local Display = require(CollectionViewsParent.Display)

local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize

local function createColumnSpanCollectionLayoutStore(arg1, arg2, arg3)
    local getPlatformScale = Display.GetDisplayStore(false).getPlatformScale

    local getIsContainerMeasured = Signals.createComputed(function(arg4): boolean
        return arg3(arg4) > 0
    end)

    local getContainerWidth = Signals.createComputed(function(arg4)
        local var1 = arg3(arg4)

        if var1 > 0 then
            return var1
        end

        return arg1.getContainerWidth(arg4) * arg2(arg4)
    end)

    local getDesignSpaceContainerWidth = Signals.createComputed(function(arg4)
        return getContainerWidth(arg4) / getPlatformScale(arg4)
    end)

    local getItemsPerRow = ({})

    for _, value in {
        CollectionItemSize.XSmall,
        CollectionItemSize.Small,
        CollectionItemSize.Medium,
        CollectionItemSize.Large,
        CollectionItemSize.XLarge
    } do
        local var1 = arg1.getItemsPerRow[value]
        getItemsPerRow[value] = Signals.createComputed(function(arg4): number
            return math.max(1, math.floor(var1(arg4) * arg2(arg4) + 1e-6))
        end)
    end

    return {
        getContainerWidth = getContainerWidth,
        getDesignSpaceContainerWidth = getDesignSpaceContainerWidth,
        getItemsPerRow = getItemsPerRow,
        getNumItemsForAllCategories = Signals.createComputed(function(arg4)
            local result = ({})
            for value, value2 in getItemsPerRow do
                result[value] = value2(arg4)
            end
            return result
        end),
        getIsContainerMeasured = getIsContainerMeasured
    }
end

return createColumnSpanCollectionLayoutStore
