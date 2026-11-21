-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local Signals = require(CollectionViewsParent.Signals)
local Display = require(CollectionViewsParent.Display)

local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize
local CollectionBreakpointConfig = require(script.Parent.CollectionBreakpointConfig)
local resolveBreakpoint = CollectionBreakpointConfig.resolveBreakpoint
local getItemsPerRow = CollectionBreakpointConfig.getItemsPerRow

local function createCollectionLayoutStore(getContainerWidth, arg1)
    local getPlatformScale = Display.GetDisplayStore(false).getPlatformScale

    local getIsContainerMeasured = Signals.createComputed(function(arg2): boolean
        return getContainerWidth(arg2) > 0
    end)

    local var1 = if arg1 then Signals.createComputed(function(arg2)
        local containerWidth = getContainerWidth(arg2)
        if containerWidth > 0 then
            return containerWidth
        end
        return arg1.getContainerWidth(arg2)
    end) else getContainerWidth

    local getDesignSpaceContainerWidth = Signals.createComputed(function(arg2)
        return var1(arg2) / getPlatformScale(arg2)
    end)

    local computed3 = Signals.createComputed(function(arg2)
        return resolveBreakpoint(getDesignSpaceContainerWidth(arg2))
    end)

    local tbl1 = ({})

    for _, value in {
        CollectionItemSize.XSmall,
        CollectionItemSize.Small,
        CollectionItemSize.Medium,
        CollectionItemSize.Large,
        CollectionItemSize.XLarge
    } do
        tbl1[value] = Signals.createComputed(function(arg2)
            return getItemsPerRow(computed3(arg2), value)
        end)
    end

    return {
        getContainerWidth = var1,
        getDesignSpaceContainerWidth = getDesignSpaceContainerWidth,
        getItemsPerRow = tbl1,
        getNumItemsForAllCategories = Signals.createComputed(function(arg2)
            local result = ({})
            for value, value2 in tbl1 do
                result[value] = value2(arg2)
            end
            return result
        end),
        getIsContainerMeasured = getIsContainerMeasured
    }
end

return createCollectionLayoutStore
