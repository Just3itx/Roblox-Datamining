-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View

return React.memo(function(arg1) -- name: DiagramLayoutView
    local layout = arg1.layout
    local var1 = Foundation.Hooks.useTokens()
    local xOffset = if layout.columnWidth ~= 0.5 then 0 else -var1.Gap.XXLarge
    local createElement = React.createElement
    local var2 = View
    local tbl1 = {
        tag = "size-full-0 auto-y",
        padding = {
            top = layout.topPadding,
            bottom = layout.bottomPadding
        },
        onAbsoluteSizeChanged = arg1.onSizeChanged,
        testId = arg1.testId
    }
    local tbl2 = {
        LeftColContainer = React.createElement(View, {
            tag = {
                ["auto-y"] = layout.columnWidth ~= nil,
                ["auto-xy"] = layout.columnWidth == nil
            },
            Size = if layout.columnWidth then UDim2.new(layout.columnWidth, xOffset, 0, 0) else nil,
            padding = {
                top = layout.columnTopPadding
            },
            AnchorPoint = layout.leftAnchor,
            Position = layout.leftPosition,
            scale = layout.columnScale,
            testId = if arg1.testId then arg1.testId .. "LeftColumn" else nil,
            onAbsoluteSizeChanged = arg1.onLeftSizeChanged
        }, {
            LeftCol = arg1.left
        }),
        ImageComponentContainer = React.createElement(
            View,
            {
                tag = "anchor-top-center",
                Position = UDim2.new(0.5, 0, 0, layout.diagramOffsetY or 0),
                Size = UDim2.fromOffset(layout.diagramSize.X, layout.diagramSize.Y),
                testId = arg1.diagramTestId
            },
            {
                ImageComponent = if arg1.renderDiagram then arg1.renderDiagram(layout.diagramSize) else arg1.diagram
            }
        ),
        RightColContainer = React.createElement(View, {
            tag = {
                ["auto-y"] = layout.columnWidth ~= nil,
                ["auto-xy"] = layout.columnWidth == nil
            },
            Size = if layout.columnWidth then UDim2.new(layout.columnWidth, xOffset, 0, 0) else nil,
            padding = {
                top = layout.columnTopPadding
            },
            AnchorPoint = layout.rightAnchor,
            Position = layout.rightPosition,
            scale = layout.columnScale,
            testId = if arg1.testId then arg1.testId .. "RightColumn" else nil,
            onAbsoluteSizeChanged = arg1.onRightSizeChanged
        }, {
            RightCol = arg1.right
        })
    }
    return createElement(var2, tbl1, tbl2)
end)
