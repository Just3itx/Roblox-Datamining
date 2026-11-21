-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Types = require(ChatUIPrimitives.Types)

local function isNearBottom(arg1): boolean -- Luacid: unused: defined but never referenced
    local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
    local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
    return absoluteCanvasSizeY <= absoluteWindowSizeY
        or arg1.CanvasPosition.Y / (absoluteCanvasSizeY - absoluteWindowSizeY) >= 0.9
end

return React.memo(function(tbl1) -- name: BottomLockedScrollView
    local scrollingFrameRef = React.useRef(nil)
    local var2 = React.useRef(true)

    local onScroll = tbl1.onScroll
    local onCanvasPositionChanged = React.useCallback(function(arg1)
        local var3 = var2
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        var3.current = absoluteCanvasSizeY <= absoluteWindowSizeY
            or arg1.CanvasPosition.Y / (absoluteCanvasSizeY - absoluteWindowSizeY) >= 0.9

        if onScroll and not var2.current then
            onScroll()
        end
    end, { onScroll })

    local onAbsoluteCanvasSizeChanged = React.useCallback(function(arg1)
        if var2.current then
            arg1.CanvasPosition = Vector2.new(0, 2 ^ 53)
        end
    end, {})

    React.useEffect(function()
        local current = scrollingFrameRef.current
        if current then
            current.CanvasPosition = Vector2.new(0, 2 ^ 53)
        end
    end, {})

    local children = tbl1.children
    local var5 = tbl1.contentPadding
        and {
            paddedContent = React.createElement(
                Foundation.View,
                {
                    tag = "auto-y",
                    Size = UDim2.fromScale(1, 0),
                    padding = tbl1.contentPadding
                },
                tbl1.children
            )
        }
        or children

    return React.createElement(Foundation.ScrollView, {
        tag = "fill",
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        scrollingFrameRef = scrollingFrameRef,
        scrollBarVisibility = "Auto",
        selection = tbl1.selectableRows and { Selectable = false } or nil,
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0, 0)
        },
        onCanvasPositionChanged = onCanvasPositionChanged,
        onAbsoluteCanvasSizeChanged = onAbsoluteCanvasSizeChanged
    }, var5)
end)
