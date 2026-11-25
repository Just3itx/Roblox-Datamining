-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Signals = require(SduiSharedContentParent.Signals)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)
local View = require(SduiSharedContentParent.Foundation).View
local CollectionViews = require(SduiSharedContentParent.CollectionViews)
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local CollectionLayoutStoreContext = CollectionViews.CollectionLayoutStoreContext
local createColumnSpanCollectionLayoutStore = CollectionViews.createColumnSpanCollectionLayoutStore
local getMainCollectionLayoutStore = CollectionViews.getMainCollectionLayoutStore
local useCollectionLayout = CollectionViews.useCollectionLayout

local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local getCollectionSlotsLayout = require(script.Parent.getCollectionSlotsLayout)

local function LayoutSlot(tbl1)
    local var1, var2 = React.useMemo(function()
        return Signals.createSignal(0)
    end, {})
    local var3, var4 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize.X)
        var4(arg1.AbsoluteSize.Y)
    end, { var2 })

    local getColumnFraction = tbl1.getColumnFraction
    local value = React.useMemo(function()
        if getColumnFraction then
            return createColumnSpanCollectionLayoutStore(tbl1.parentStore, getColumnFraction, var1)
        end
        return tbl1.parentStore
    end, { tbl1.parentStore, getColumnFraction, var1 })

    local name = tbl1.name
    local verticalOverflow = tbl1.verticalOverflow
    local function getSlotLayout(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
        return arg1[name]
    end

    local slot = React.createElement(
        View,
        {
            Position = tbl1.layoutBinding:map(function(arg1)
                local position = getSlotLayout(arg1).position

                if verticalOverflow then
                    return position + UDim2.fromOffset(0, verticalOverflow)
                end

                return position
            end),
            Size = tbl1.layoutBinding:map(function(arg1)
                return getSlotLayout(arg1).size
            end),
            tag = tbl1.tag,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            testId = `--sdui-collection-slots-layout-{name}`
        },
        {
            Provider = React.createElement(CollectionLayoutStoreContext.Provider, { value = value }, tbl1.children)
        }
    )
    if not verticalOverflow then
        return React.createElement(View, {
            Position = tbl1.layoutBinding:map(function(arg1)
                return getSlotLayout(arg1).clipPosition
            end),
            Size = tbl1.layoutBinding:map(function(arg1)
                return getSlotLayout(arg1).clipSize
            end),
            tag = tbl1.clipTag,
            testId = `--sdui-collection-slots-layout-{name}-clip`
        }, { Slot = slot })
    end

    return React.createElement(View, {
        Position = tbl1.layoutBinding:map(function(arg1)
            return getSlotLayout(arg1).clipPosition
        end),
        Size = tbl1.layoutBinding:map(function(arg1): UDim2
            return UDim2.fromScale(getSlotLayout(arg1).clipSize.X.Scale, 0)
        end),
        tag = "col auto-y",
        testId = `--sdui-collection-slots-layout-{name}-overflow`
    }, {
        Box = React.createElement(View, {
            Size = var3:map(function(yOffset: number): UDim2
                return UDim2.new(1, 0, 0, yOffset)
            end)
        }, {
            Clip = React.createElement(View, {
                Position = UDim2.fromOffset(0, -verticalOverflow),
                Size = var3:map(function(num1: number): UDim2
                    return UDim2.new(1, 0, 0, num1 + 2 * verticalOverflow)
                end),
                tag = tbl1.overflowClipTag,
                testId = `--sdui-collection-slots-layout-{name}-clip`
            }, { Slot = slot })
        })
    })
end

local function cloneSlotElement(arg1, extraLocalProps) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 then
        return (React.cloneElement(arg1, { extraLocalProps = extraLocalProps }))
    end

    return nil
end

return React.memo(function(tbl1) -- name: SduiCollectionSlotsLayout
    local var1, var2 = React.useBinding(Vector2.zero)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})
    local ref = React.useCallback(function(arg1)
        if arg1 then
            var2(arg1.AbsoluteSize)
        end
    end, {})

    local var5 = if tbl1.leadingCollectionItemSize and CollectionItemSize[tbl1.leadingCollectionItemSize] then tbl1.leadingCollectionItemSize else CollectionItemSize.Small
    local var6 = if tbl1.trailingCollectionItemSize and CollectionItemSize[tbl1.trailingCollectionItemSize] then tbl1.trailingCollectionItemSize else CollectionItemSize.Small
    local parentStore = React.useContext(CollectionLayoutStoreContext) or getMainCollectionLayoutStore(false)
    local var8 = useCollectionLayout(var5)
    local var9 = useCollectionLayout(var6)
    local itemsPerRow = var8.itemsPerRow
    local itemsPerRow2 = var9.itemsPerRow
    local gutter = var8.gutter
    local carouselPeek = var8.carouselPeek or 0
    local margin = var8.margin

    local bool1 = tbl1.leading ~= nil
    local bool2 = tbl1.trailing ~= nil
    local var10 = if bool1 then math.floor(tbl1.leadingColumns or 0) else 0
    local var11 = if bool2 then math.floor(tbl1.trailingColumns or 0) else 0
    local var12 = var10 / itemsPerRow + var11 / itemsPerRow2
    local num1 = 1 / math.max(itemsPerRow, itemsPerRow2)
    if bool1 or bool2 then
        if bool1 and not (var10 >= 1) or bool2 and not (var11 >= 1) then
            bool2 = false
        else
            bool2 = var12 <= 1 - num1 + 1e-6
        end
    end

    local layoutBinding = var1:map(function(vector2: Vector2)
        return getCollectionSlotsLayout(vector2.X, {
            leadingColumns = if bool2 then var10 else 0,
            leadingNumColumns = itemsPerRow,
            trailingColumns = if bool2 then var11 else 0,
            trailingNumColumns = itemsPerRow2,
            columnGap = gutter,
            sideMargin = 0,
            fractionalItemAmount = 0,
            carouselPeek = carouselPeek,
            bleed = margin,
            hoverOverflow = if tbl1.enableHoverOverflow then gutter / 2 else 0
        })
    end)

    local getColumnFraction = React.useCallback(function(arg1)
        return var10 / parentStore.getItemsPerRow[var5](arg1)
    end, { parentStore, var5, var10 })
    local var3 = React.useCallback(function(arg1)
        return var11 / parentStore.getItemsPerRow[var6](arg1)
    end, { parentStore, var6, var11 })
    local var16 = React.useCallback(function(arg1)
        return 1 - getColumnFraction(arg1) - var3(arg1)
    end, { getColumnFraction, var3 })

    local var17 = React.useMemo(function()
        local function getExtraLocalProps(sideMargin: number?)
            return {
                appCompositionEnabled = true,
                scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
                startRow = tbl1.startRow,
                numUpdatesToDelayImpressions = tbl1.numUpdatesToDelayImpressions,
                index = tbl1.index,
                selectionOrderBase = tbl1.selectionOrderBase,
                sideMargin = sideMargin,
                pageSideMargin = if bool2 then nil else tbl1.pageSideMargin,
                shouldUseFrameBoundsForImpressions = if bool2 then true else nil,
                respectClipAncestors = if bool2 then true else nil
            }
        end
        return {
            leading = if bool2 then cloneSlotElement(tbl1.leading, (getExtraLocalProps(0))) else nil,
            content = cloneSlotElement(tbl1.content, (getExtraLocalProps(nil))),
            trailing = if bool2 then cloneSlotElement(tbl1.trailing, (getExtraLocalProps(0))) else nil
        }
    end, {
        tbl1.leading,
        tbl1.content,
        tbl1.trailing,
        bool2,
        tbl1.scrollViewPositionChangedSignal,
        tbl1.verticalScrollingFrameRef,
        tbl1.startRow,
        tbl1.numUpdatesToDelayImpressions,
        tbl1.index,
        tbl1.selectionOrderBase,
        tbl1.pageSideMargin
    })

    local tbl2 = { Row = 0 }
    local createElement = React.createElement
    local var18 = View
    local tbl3 = {
        tag = "size-full-0 auto-y",
        ref = ref,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl4 = {
        Leading = if bool2 and var10 > 0 then React.createElement(LayoutSlot, {
            name = "leading",
            layoutBinding = layoutBinding,
            parentStore = parentStore,
            getColumnFraction = getColumnFraction,
            clipTag = "clip",
            tag = "col align-y-center"
        }, {
            Item = var17.leading
        }) else nil,
        Content = 0,
        Trailing = 0
    }

    local createElement2 = React.createElement
    local func1 = LayoutSlot
    local tbl5 = {
        name = "content",
        layoutBinding = layoutBinding,
        parentStore = parentStore,
        getColumnFraction = 0,
        clipTag = 0,
        overflowClipTag = 0,
        tag = "col auto-y",
        verticalOverflow = 0
    }

    if not bool2 then
        var16 = nil
    end

    tbl5.getColumnFraction = var16
    tbl5.clipTag = if bool2 then "auto-y clip" else "auto-y"
    tbl5.overflowClipTag = if bool2 then "clip" else nil

    tbl5.verticalOverflow = if tbl1.enableHoverOverflow then 500 else nil
    tbl4.Content = createElement2(func1, tbl5, { Item = var17.content })
    tbl4.Trailing = if bool2 and var11 > 0 then React.createElement(LayoutSlot, {
        name = "trailing",
        layoutBinding = layoutBinding,
        parentStore = parentStore,
        getColumnFraction = var3,
        clipTag = "clip",
        tag = "col align-y-center"
    }, {
        Item = var17.trailing
    }) else nil
    tbl2.Row = createElement(var18, tbl3, tbl4)

    return React.createElement(View, {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId or "--sdui-collection-slots-layout"
    }, tbl2)
end)
