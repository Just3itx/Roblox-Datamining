-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize
local useCollectionLayoutParams = require(CollectionViews.useCollectionLayoutParams)
local FormFactor = require(CollectionViewsParent.FormFactor).Enums.FormFactor
local useSelector = require(CollectionViewsParent.RoactUtils).Hooks.RoactRodux.useSelector
local useAppPolicy = require(CollectionViewsParent.UniversalAppPolicy).useAppPolicy
local DiscoveryTypes = require(CollectionViewsParent.DiscoveryTypes)
local AppComposition = require(CollectionViewsParent.AppComposition)

local FFlagLuaAppCompositionAlways = require(CollectionViewsParent.SharedFlags).FFlagLuaAppCompositionAlways

local GAME_CAROUSEL_SIDE_COMPACT_PADDING = DiscoveryTypes.Constants.GAME_CAROUSEL_SIDE_COMPACT_PADDING
local GAME_CAROUSEL_SIDE_WIDE_PADDING = DiscoveryTypes.Constants.GAME_CAROUSEL_SIDE_WIDE_PADDING

local function usePageSideMargin(arg1, bool1: boolean?)
    local margin = AppComposition.useCompositionLayout().margin

    if FFlagLuaAppCompositionAlways then
        return margin
    end

    local var1 = useSelector(function(arg2)
        return arg2.FormFactor
    end)

    local tbl1 = if useAppPolicy(function(arg2)
        return arg2.useGridPageLayout()
    end) then nil else {
        sideMargin = if var1 == FormFactor.COMPACT then GAME_CAROUSEL_SIDE_COMPACT_PADDING else GAME_CAROUSEL_SIDE_WIDE_PADDING
    }

    local var2 = useCollectionLayoutParams(CollectionItemSize.Small, arg1, false, tbl1)

    return if bool1 then margin else var2.sideMargin
end

return usePageSideMargin
