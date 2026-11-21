-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local Responsive = require(CollectionViewsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local useAppPolicy = require(CollectionViewsParent.UniversalAppPolicy).useAppPolicy
local Signals = require(CollectionViewsParent.Signals)
local Display = require(CollectionViewsParent.Display)
local DiscoveryTypes = require(CollectionViewsParent.DiscoveryTypes)

local bool1 = game:DefineFastFlag("LuaAppFixComputedSideMarginResponsiveBreakpoint", false)

local CollectionLayoutCalculators = require(CollectionViews.CollectionLayoutCalculators)
local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)

local GAME_CAROUSEL_SIDE_COMPACT_PADDING = DiscoveryTypes.Constants.GAME_CAROUSEL_SIDE_COMPACT_PADDING
local GAME_CAROUSEL_SIDE_WIDE_PADDING = DiscoveryTypes.Constants.GAME_CAROUSEL_SIDE_WIDE_PADDING

local function useCollectionLayoutParamsComputed(arg1, num1: number?)
    local var1 = CollectionLayoutCalculators
    local var2 = useTokens()
    local var3 = usePreferredInput()
    local var4 = useAppPolicy(function(arg2)
        return arg2.useGridPageLayout()
    end)

    local var5, var6 = React.useMemo(function()
        return Signals.createSignal(false)
    end, {})
    var6((useBreakpointXOrSmaller(if bool1 then Responsive.Keys.Small else Responsive.Keys.Medium)))

    local var7 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var7 = Display.GetDisplayStore(arg2).getViewportSize(arg2)

            return var7 and var7.X or 0
        end)
    end, {})

    local var8, var9 = React.useMemo(function()
        local var8 = var7(false)
        return Signals.createSignal(var8)
    end, {})

    local var10 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            if num1 then
                return num1
            end

            if not var4 then
                return if var5(arg2) then GAME_CAROUSEL_SIDE_COMPACT_PADDING else GAME_CAROUSEL_SIDE_WIDE_PADDING
            end
            local var10 = var7(arg2)
            local var11 = var8(arg2)
            return var1.calculateSideMargin(var11, var2, var10)
        end)
    end, {
        var7,
        var8,
        var5,
        num1,
        var1,
        var2,
        var4
    })

    local var11 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var11 = var7(arg2)
            local var12 = var8(arg2)
            return var1.calculateColumnGap(var12, var2, var11)
        end)
    end, {
        var7,
        var8,
        var1,
        var2
    })
    local var12 = React.useCallback(function(arg2)
        return Signals.createComputed(function(arg3)
            local var12 = var8(arg3)
            local var13 = var10(arg3)
            local var14 = var11(arg3)

            return var1.calculateNumColumns(var12, var13, var14, arg2, var2)
        end)
    end, {
        var8,
        var10,
        var11,
        var1,
        var2
    })
    local var13 = React.useCallback(function(vector2: Vector2)
        local vector2X = vector2.X
        var9(vector2X)
    end, { var9 })

    React.useEffect(function()
        local connection = nil
        if arg1 then
            var13(arg1.AbsoluteSize)
            connection = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var13(arg1.AbsoluteSize)
            end)
        end
        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var13, arg1 })

    return (React.useCallback(function(arg2)
        return Signals.createComputed(function(arg3)
            local numColumns = var12(arg2)(arg3)
            local columnGap = var11(arg3)
            local sideMargin = var10(arg3)

            return {
                numColumns = numColumns,
                fractionalItemAmount = var1.calculateFractionalItemAmount(arg2, var3),
                columnGap = columnGap,
                sideMargin = sideMargin,
                verticalPadding = var1.calculateVerticalPadding(var2, arg2),
                maxTilesToShow = var1.calculateMaxTilesToShow(var3)
            }
        end)
    end, {
        var12,
        var11,
        var10,
        var3,
        var2,
        var1
    }))
end
return useCollectionLayoutParamsComputed
