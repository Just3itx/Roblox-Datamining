-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local _NavigationType = require(scriptParentParent.Enums.NavigationType)
local _Signal = require(scriptParentParent.Signal)
local View = Foundation.View

local useCallback = React.useCallback
local useEffect = React.useEffect
local useSnapScrollController = require(scriptParentParent.Hooks.useSnapScrollController)
local useState = React.useState

return function(tbl1)
    local var1, var2 = useState(Vector2.new(0, 0))

    local var3 = tbl1.active == nil or tbl1.active
    local initialIndex = tbl1.initialIndex or 1
    local var4 = tbl1.itemAbsoluteSize or var1
    local windowSize = tbl1.windowSize or 3

    local var5, ref, var6, var8, var9 = useSnapScrollController(var3, initialIndex, var4, #tbl1.contents)

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    useEffect(function()
        if tbl1.onIndexChanged then
            tbl1.onIndexChanged(var5)
        end
    end, { var5, tbl1.onIndexChanged })

    local var11 = React.useMemo(function()
        return Cryo.List.map(tbl1.contents, function(arg1, layoutOrder)
            if not (layoutOrder < var5 - windowSize or var5 + windowSize < layoutOrder) then
                return tbl1.renderContent(arg1, layoutOrder)
            end

            return React.createElement(View, {
                key = `PLACEHOLDER-{layoutOrder}`,
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(var4.X, var4.Y),
                tag = "anchor-top-center bg-action-subtle position-top-center"
            })
        end)
    end, {
        var5,
        var4,
        tbl1.contents,
        tbl1.renderContent,
        windowSize
    })
    useEffect(function()
        if tbl1.scrollToIndexSignal then
            local connection = tbl1.scrollToIndexSignal:connect(var8)
            return function()
                connection:disconnect()
            end
        end
    end, { tbl1.scrollToIndexSignal, var8 })

    useEffect(function()
        if tbl1.triggerNavigationSignal then
            local connection = tbl1.triggerNavigationSignal:connect(var9)
            return function()
                connection:disconnect()
            end
        end
    end, { tbl1.triggerNavigationSignal, var9 })

    return React.createElement(View, {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        ref = ref,
        tag = "anchor-top-center bg-action-subtle position-top-center size-full"
    }, {
        MotionView = React.createElement(View, {
            LayoutOrder = 1,
            ref = var6,
            Size = UDim2.fromScale(1, #tbl1.contents),
            tag = "align-x-center anchor-top-center bg-action-subtle col no-clip position-top-center"
        }, var11)
    })
end
