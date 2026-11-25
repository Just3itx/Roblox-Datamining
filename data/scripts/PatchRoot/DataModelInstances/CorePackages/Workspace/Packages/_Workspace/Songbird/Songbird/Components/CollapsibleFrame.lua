-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)
local ReactOtter = require(Songbird.Parent.ReactOtter)

local useBinding = React.useBinding
local useCallback = React.useCallback
local useEffect = React.useEffect
local usePrevious = ReactUtils.usePrevious
local useAnimatedBinding = ReactOtter.useAnimatedBinding

local tbl1 = { stiffness = 300, damping = 30, mass = 1 }

local function CollapsibleFrame(tbl2)
    local var1 = usePrevious(tbl2.isCollapsed)
    local maxSize, var3 = useBinding(Vector2.new(math.huge, math.huge))
    local alpha, var5 = useAnimatedBinding(if tbl2.isCollapsed then 0 else 1)

    local var6 = useCallback(function(arg1)
        var3(arg1.AbsoluteCanvasSize)
    end, {})

    useEffect(function()
        if var1 == nil then
            return
        end

        if not tbl2.isCollapsed and var1 then
            var5(ReactOtter.spring(1, tbl1))
            return
        end

        if tbl2.isCollapsed and not var1 then
            var5(ReactOtter.spring(0, tbl1))
        end
    end, { tbl2.isCollapsed, var1 })

    local var2 = React.joinBindings({ maxSize = maxSize, alpha = alpha }):map(function(tbl3): Vector2
        local y = math.max(tbl3.maxSize.Y * tbl3.alpha, 0)

        return Vector2.new(math.huge, y)
    end)

    local createElement = React.createElement
    local view = Foundation.View

    local tbl3 = {
        ScrollingFrame = React.createElement(
            "ScrollingFrame",
            {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.fromScale(0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.XY,
                ClipsDescendants = true,
                ScrollingEnabled = false,
                HorizontalScrollBarInset = Enum.ScrollBarInset.None,
                ScrollBarImageTransparency = 1,
                Selectable = false,
                [React.Change.AbsoluteCanvasSize] = var6
            },
            {
                Container = React.createElement(Foundation.View, { tag = "auto-y size-full-0" }, tbl2.children)
            }
        )
    }
    return createElement(view, { tag = "size-full clip", sizeConstraint = { MaxSize = var2 } }, tbl3)
end

return CollapsibleFrame
