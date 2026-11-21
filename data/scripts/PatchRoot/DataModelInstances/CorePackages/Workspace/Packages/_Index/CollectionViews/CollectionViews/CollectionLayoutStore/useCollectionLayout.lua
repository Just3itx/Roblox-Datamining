-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local Foundation = require(CollectionViewsParent.Foundation)
local React = require(CollectionViewsParent.React)
local SignalsReact = require(CollectionViewsParent.SignalsReact)
local AppComposition = require(CollectionViewsParent.AppComposition)

local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize
local CollectionLayoutStoreContext = require(CollectionViews.CollectionLayoutStore.CollectionLayoutStoreContext)
local getMainCollectionLayoutStore = require(CollectionViews.CollectionLayoutStore.getMainCollectionLayoutStore)

local function useCollectionLayout(arg1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = arg1 or CollectionItemSize.Small

    local var3 = AppComposition.useCompositionLayout()
    local var4 = React.useContext(CollectionLayoutStoreContext) or getMainCollectionLayoutStore(false)

    local itemsPerRow = SignalsReact.useSignalState(var4.getItemsPerRow[var2])

    return React.useMemo(function()
        return {
            margin = var3.margin,
            gutter = var3.gutter,
            carouselPeek = var3.carouselPeek,
            verticalGap = var1.Gap.Large,
            itemsPerRow = itemsPerRow,
            getContainerWidth = var4.getContainerWidth,
            getDesignSpaceContainerWidth = var4.getDesignSpaceContainerWidth
        }
    end, {
        var3,
        itemsPerRow,
        var1,
        var4
    })
end
return useCollectionLayout
