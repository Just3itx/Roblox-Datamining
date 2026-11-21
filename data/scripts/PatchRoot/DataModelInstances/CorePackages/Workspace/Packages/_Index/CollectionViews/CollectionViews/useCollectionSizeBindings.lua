-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)

local calculateItemWidth = require(CollectionViews.calculateItemWidth)
local useStore = require(CollectionViewsParent.RoactUtils).Hooks.RoactRodux.useStore

local function getItemSize(num1: number, num2: number, num3: number, num4: number, num5: number, func1: (...any) -> (...any), num6: number?): Vector2 -- Luacid: Inlined by compiler; 1 call site recovered
    local itemWidth = calculateItemWidth(num1, num2, num3, num4, num5, num6)
    local y = func1(itemWidth)
    return Vector2.new(itemWidth, y)
end

local function useCollectionSizeBindings(num1: number, num2: number, num3: number, num4: number, func1: (...any) -> (...any), callback: ((...any) -> (...any))?, num5: number?)
    local var1 = useStore()
    local var2, var3 = React.useBinding(Vector2.zero)
    if var2:getValue() == Vector2.zero then
        var3(var1:getState().ScreenSize)
    end

    local var4, var5 = React.useBinding(getItemSize(num1, num2, num3, var2:getValue() and var2:getValue().X or 0, num4, func1, num5))

    local var6, var7 = React.useState(nil)
    local var8 = React.useCallback(function(arg1)
        local absoluteSize = arg1.AbsoluteSize
        if absoluteSize.X == 0 then
            return
        end

        if callback then
            callback(absoluteSize)
        end
        var3(absoluteSize)

        local vector2 = getItemSize(num1, num2, num3, absoluteSize and absoluteSize.X or 0, num4, func1, num5)

        var5(vector2)
    end, {
        num1,
        num2,
        num3,
        num4,
        func1,
        callback,
        num5
    })

    React.useEffect(function()
        if var6 then
            var8(var6)
        end
    end, { var8, var6 })

    return var4, var2, var8, var7
end

return useCollectionSizeBindings
