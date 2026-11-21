-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local useDesignTokens = require(CollectionViewsParent.Style).useDesignTokens
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local usePreferredInput = require(CollectionViewsParent.Responsive).usePreferredInput
local Display = require(CollectionViewsParent.Display)

local useStore = require(CollectionViewsParent.RoactUtils).Hooks.RoactRodux.useStore

local CollectionLayoutCalculators = require(CollectionViews.CollectionLayoutCalculators)
local calculateItemWidth = require(CollectionViews.calculateItemWidth)
local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)

local FFlagLuaAppLayoutParamsInContext = require(CollectionViewsParent.SharedFlags).FFlagLuaAppLayoutParamsInContext
local FFlagSduiComponentsUseFoundationTokens = require(CollectionViewsParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens

local bool1 = game:DefineFastFlag("LuaAppUseDisplayStoreForCollectionLayoutParams", false)

local function useCollectionLayoutParams(bool2: boolean?, arg1, bool3: boolean?, tbl1, arg2, vector2: Vector2?)
    local var1 = useStore()
    local var2 = if bool1 then Display.GetDisplayStore(false).getViewportSize(false) or Vector2.new(0, 0) else var1:getState().ScreenSize or Vector2.new(0, 0)
    local var3 = arg2 or CollectionLayoutCalculators
    local sideMargin = if tbl1 then tbl1.sideMargin or nil else nil
    local columnGap = if tbl1 then tbl1.columnGap or nil else nil
    local numColumns = if tbl1 then tbl1.numColumns or nil else nil
    local fractionalItemAmount = if tbl1 then tbl1.fractionalItemAmount or nil else nil
    local loadMoreThreshold = if tbl1 then tbl1.loadMoreThreshold or nil else nil
    local verticalPadding = tbl1 and tbl1.verticalPadding or nil
    local var4 = if FFlagLuaAppLayoutParamsInContext or FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local var5 = usePreferredInput()

    local var6 = verticalPadding or var3.calculateVerticalPadding(var4, bool2)
    local maxTilesToShow = var3.calculateMaxTilesToShow(var5)

    local var7 = React.useRef(nil)
    if var7.current == nil then
        var7.current = vector2 or var2
    end
    local currentX = var7.current.X

    local var8, var9 = React.useState(function()
        return sideMargin or var3.calculateSideMargin(currentX, var4, var2.X)
    end)
    local var10, var11 = React.useState(function()
        return columnGap or var3.calculateColumnGap(currentX, var4, var2.X)
    end)
    local var12, var13 = React.useState(function()
        return fractionalItemAmount or var3.calculateFractionalItemAmount(bool2, var5)
    end)
    local var14, var15 = React.useState(function()
        return numColumns or var3.calculateNumColumns(currentX, var8, var10, bool2, var4)
    end)
    local var16, var17 = React.useState(function()
        return loadMoreThreshold or var3.calculateLoadMoreThreshold(currentX)
    end)

    local itemWidth, var19 = React.useState(function()
        if bool3 then
            return calculateItemWidth(var14, var10, var8, currentX, var12)
        end
        return 1
    end)

    local var20 = React.useCallback(function(vector2_2: Vector2)
        local vector22X = vector2_2.X
        local var20 = if bool1 then Display.GetDisplayStore(false).getViewportSize(false) and Display.GetDisplayStore(false).getViewportSize(false).X or 0 else var1:getState().ScreenSize and var1:getState().ScreenSize.X or 0
        local var21 = sideMargin or var3.calculateSideMargin(vector22X, var4, var20)
        var9(var21)

        local var22 = columnGap or var3.calculateColumnGap(vector22X, var4, var20)
        var11(var22)

        local var23 = numColumns or var3.calculateNumColumns(vector22X, var21, var22, bool2, var4)

        var15(var23)

        local var24 = fractionalItemAmount or var3.calculateFractionalItemAmount(bool2, var5)
        var13(var24)

        local var25 = loadMoreThreshold or var3.calculateLoadMoreThreshold(vector22X)
        var17(var25)

        var7.current = vector2_2
        if bool3 then
            local itemWidth = calculateItemWidth(var23, var22, var21, vector22X, var24)

            var19(itemWidth)
        end
    end, {
        bool2,
        bool3,
        columnGap,
        sideMargin,
        numColumns,
        fractionalItemAmount,
        loadMoreThreshold,
        var4,
        var1
    })

    React.useEffect(function()
        local connection = nil
        if arg1 then
            var20(arg1.AbsoluteSize)
            connection = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var20(arg1.AbsoluteSize)
            end)
        end
        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var20, arg1 })

    return {
        numColumns = var14,
        fractionalItemAmount = var12,
        columnGap = var10,
        sideMargin = var8,
        verticalPadding = var6,
        maxTilesToShow = maxTilesToShow,
        itemWidth = itemWidth,
        loadMoreThreshold = var16
    }
end

return useCollectionLayoutParams
