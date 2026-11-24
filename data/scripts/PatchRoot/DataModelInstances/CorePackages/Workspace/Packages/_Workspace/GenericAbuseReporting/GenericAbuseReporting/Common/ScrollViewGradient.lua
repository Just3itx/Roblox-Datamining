-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReporting.Parent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local View = Foundation.View
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local useLayerCollector = require(GenericAbuseReportingParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector

return (React.forwardRef(function(tbl1, ref)
    local scrollingFrameRef = React.useRef(nil)
    local var2, var3 = React.useState(Vector2.zero)
    local var4, var5 = React.useState(Vector2.zero)
    local var6, var7 = React.useState(true)
    local var8, var9 = React.useState(false)
    local absoluteSize = useLayerCollector().absoluteSize

    React.useLayoutEffect(function()
        if not scrollingFrameRef.current then
            return function() end
        end

        var3(scrollingFrameRef.current.AbsoluteCanvasSize)
        var5(scrollingFrameRef.current.AbsoluteWindowSize)
        local connection = scrollingFrameRef.current:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
            var3(scrollingFrameRef.current.AbsoluteCanvasSize)
        end)
        local connection2 = scrollingFrameRef.current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
            var5(scrollingFrameRef.current.AbsoluteWindowSize)
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { scrollingFrameRef.current, absoluteSize })

    React.useEffect(function()
        if not scrollingFrameRef.current then
            return function() end
        end

        local connection = scrollingFrameRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            local canvasPosition = scrollingFrameRef.current.CanvasPosition
            if var2.Y == var4.Y then
                var7(true)
                var9(true)
            elseif canvasPosition.Y <= 0 then
                var7(true)
            elseif canvasPosition.Y >= var2.Y - var4.Y then
                var9(true)
            else
                var7(false)
                var9(false)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, {
        scrollingFrameRef.current,
        absoluteSize,
        var2,
        var4
    })
    return React.createElement(View, { tag = "size-full" }, {
        TopGradient = React.createElement(
            View,
            {
                Size = UDim2.new(1, -15, 0, tbl1.gradientHeight),
                tag = if var6 then nil else "bg-surface-300",
                ZIndex = 2
            },
            {
                UIGradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
                })
            }
        ),
        BottomGradient = React.createElement(View, {
            Position = UDim2.new(0, 0, 1, -tbl1.gradientHeight),
            Size = UDim2.new(1, -15, 0, tbl1.gradientHeight),
            tag = if var8 then nil else "bg-surface-300",
            ZIndex = 2
        }, {
            UIGradient = React.createElement("UIGradient", {
                Rotation = 270,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
            })
        }),
        ScrollView = React.createElement(ScrollView, {
            Size = tbl1.Size or UDim2.new(1, 0, 1, 0),
            ZIndex = tbl1.ZIndex,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromOffset(0, 0),
                scrollBarVisibility = ScrollBarVisibility.Always,
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            scrollingFrameRef = scrollingFrameRef,
            ref = ref
        }, tbl1.children)
    })
end))
