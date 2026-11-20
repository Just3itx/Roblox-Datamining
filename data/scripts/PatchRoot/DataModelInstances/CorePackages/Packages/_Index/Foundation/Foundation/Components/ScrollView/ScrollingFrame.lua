-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local _Types = require(Foundation.Components.Types)
local withDefaults = require(Foundation.Utility.withDefaults)
local withGuiObjectProps = require(Foundation.Utility.withGuiObjectProps)

local useCursor = require(Foundation.Providers.Cursor.useCursor)
local useStyleTags = require(Foundation.Providers.Style.useStyleTags)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Visibility = require(Foundation.Enums.Visibility)

local ControlState = require(Foundation.Enums.ControlState)

local tbl1 = { frequency = 2 }

local tbl2 = { scrollBarVisibility = "Auto" }

return React.memo(React.forwardRef(function(tbl3, ref) -- name: ScrollingFrame
    local var1 = withDefaults(tbl3, tbl2)
    local var2 = withGuiObjectProps({ selection = var1.selection }, {})
    local var3 = useTokens()
    local var4 = useStyleTags(tbl3.tag)
    local shift400 = var3.Color.Shift.Shift_400

    local scrollBarThickness = React.useMemo(function()
        return if var1.scrollBarVisibility == Visibility.None then 0 else var3.Size.Size_150
    end, { var1.scrollBarVisibility })
    local var6 = useCursor()

    local var7 = React.useRef(nil)
    local scrollBarImageTransparency, var9 = ReactOtter.useAnimatedBinding(1)
    local var10 = React.useCallback(function(bool1: boolean, num1: number?)
        if var7.current then
            task.cancel(var7.current)
        end

        if bool1 then
            var9(ReactOtter.spring(shift400.Transparency, tbl1))
        end

        if num1 ~= nil then
            var7.current = task.delay(num1, function()
                var9(ReactOtter.spring(1, tbl1))
            end)
        end
    end, { shift400 })

    React.useEffect(function()
        if var1.scrollBarVisibility == "None" then
            var10(false, 0)
        elseif var1.scrollBarVisibility == "Always" then
            var10(true)
        else
            var10(
                var1.controlState == ControlState.Hover
                    or var1.controlState == ControlState.Selected
                    or var1.controlState == ControlState.Pressed,
                if var1.controlState == ControlState.Default then 0 else nil
            )
        end
    end, { var1.scrollBarVisibility, var1.controlState })

    local createElement = React.createElement

    local tbl4 = {
        AutomaticCanvasSize = var1.AutomaticCanvasSize,
        CanvasSize = var1.CanvasSize,
        ClipsDescendants = var1.ClipsDescendants,
        ScrollingDirection = var1.ScrollingDirection,
        ScrollingEnabled = var1.ScrollingEnabled,
        ScrollBarImageColor3 = shift400.Color3,
        ScrollBarImageTransparency = scrollBarImageTransparency,
        ScrollBarThickness = scrollBarThickness,
        VerticalScrollBarInset = var1.VerticalScrollBarInset,
        HorizontalScrollBarInset = var1.HorizontalScrollBarInset,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = var1.AutomaticSize,
        Size = UDim2.fromScale(1, 1),
        Selectable = var2.Selectable,
        NextSelectionUp = var2.NextSelectionUp,
        NextSelectionDown = var2.NextSelectionDown,
        NextSelectionLeft = var2.NextSelectionLeft,
        NextSelectionRight = var2.NextSelectionRight,
        SelectionImageObject = var2.SelectionImageObject or var6,
        SelectionOrder = var2.SelectionOrder,
        [React.Change.CanvasPosition] = var1.scrollBarVisibility == "Auto" and function(arg1)
            var10(true, 3)
            if var1.onCanvasPositionChanged then
                var1.onCanvasPositionChanged(arg1)
            end
        end or var1.onCanvasPositionChanged,
        [React.Change.AbsoluteCanvasSize] = var1.onAbsoluteCanvasSizeChanged,
        [React.Change.AbsoluteWindowSize] = var1.onAbsoluteWindowSizeChanged,
        ref = ref,
        [React.Tag] = var4
    }

    return createElement("ScrollingFrame", tbl4, var1.children)
end))
