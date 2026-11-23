-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local View = require(UserListParent.Foundation).View
local _Types = require(UserList.Common.Types)
local Enums = require(UserList.Common.Enums)
local useCompactTileHeight = require(UserList.Common.useCompactTileHeight)
local Cryo = require(UserListParent.Cryo)

local CollectionViews = require(UserListParent.CollectionViews)
local CollectionCarousel = CollectionViews.CollectionCarousel
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local usePageSideMargin = CollectionViews.usePageSideMargin
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize

local useEntities = require(UserList.Hooks.useEntities)
local useEntitySelectionHandler = require(UserList.Hooks.useEntitySelectionHandler)
local useRenderEntity = require(UserList.Hooks.useRenderEntity)

local useIsWideMode = require(UserListParent.SocialCommon).Hooks.useIsWideMode

local bool1 = game:DefineFastFlag("AdjustHorizontalUserListSizeForMobile", false)
local FFlagLuaAppCompositionAlways = require(UserListParent.SharedFlags).FFlagLuaAppCompositionAlways
local FFlagUserListRowSelectionOriginSource = require(UserList.Flags.FFlagUserListRowSelectionOriginSource)

local function HorizontalUserList(tbl1)
    local var1 = FFlagLuaAppCompositionAlways or tbl1.appCompositionEnabled
    local var2, containerRef = React.useState(nil)
    local var4 = React.useRef(nil)
    local scrollingFrameRef = tbl1.scrollingFrameRef or var4

    local var6 = useIsWideMode()
    local var7 = if bool1 then if var6 then CollectionItemSize.Small else CollectionItemSize.Medium else CollectionItemSize.Small
    local var8 = if FFlagLuaAppCompositionAlways then nil else usePageSideMargin(var2)

    if var1 then
        var8 = nil
    end
    local var9 = useCollectionLayoutParams(var7, var2, true, { sideMargin = var8 })

    local var10 = useCompactTileHeight()
    local getItemHeight = React.useCallback(function(_: number)
        return var10
    end, { var10 })

    local var12 = useEntities(tbl1.entities)
    local onActivated = useEntitySelectionHandler(
        tbl1.onRowSelected,
        if FFlagUserListRowSelectionOriginSource then tbl1.rowSelectionConfig else nil
    )

    local var14 = useRenderEntity({
        entitiesMap = var12.entitiesMap,
        onActivated = onActivated,
        renderRow = tbl1.renderRow,
        layoutMode = Enums.LayoutMode.Horizontal,
        configs = tbl1.listConfigs
    })

    local renderItem = React.useCallback(function(str1: string, num1: number, uDim2: UDim2, _: number?)
        return var14(str1, num1, uDim2), str1
    end, { var14 })

    local items = React.useMemo(function()
        local result = {}
        for _, value in tbl1.entities do
            table.insert(result, value.id)
        end
        return result
    end, { tbl1.entities })

    local join = Cryo.Dictionary.join
    local tbl2 = {}
    local var17 = tbl1.collectionCarouselConfigs or {}
    local tbl3 = {
        title = if tbl1.header then tbl1.header.title or nil else nil,
        onActivateHeader = if tbl1.header then tbl1.header.onTitleActivated or nil else nil,
        containerRef = containerRef,
        scrollingFrameRef = scrollingFrameRef,
        items = items,
        renderItem = renderItem,
        getItemHeight = getItemHeight,
        collectionItemSize = 0,
        numColumns = 0,
        fractionalItemAmount = 0,
        columnGap = 0,
        sideMargin = 0,
        maxItemsToShow = 0,
        scrollingEnabledOverride = 0
    }

    if not var1 then
        var7 = nil
    end

    tbl3.collectionItemSize = var7
    tbl3.numColumns = if var1 then nil else var9.numColumns
    tbl3.fractionalItemAmount = if var1 then nil else var9.fractionalItemAmount
    tbl3.columnGap = if var1 then nil else var9.columnGap
    tbl3.sideMargin = if var1 then nil else var9.sideMargin
    tbl3.maxItemsToShow = var9.maxTilesToShow
    tbl3.scrollingEnabledOverride = tbl1.scrollEnabled
    local var18 = join(tbl2, var17, tbl3)

    return React.createElement(
        View,
        {
            tag = "size-0-full auto-x row",
            LayoutOrder = tbl1.layoutOrder
        },
        { React.createElement(CollectionCarousel, var18) }
    )
end

return HorizontalUserList
