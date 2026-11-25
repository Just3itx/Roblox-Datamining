-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local View = Foundation.View
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

return React.memo(function(tbl1) -- name: SduiAssociatedItemsRow
    local layoutOrder = tbl1.layoutOrder
    local tbl2 = ({})
    for k, componentConfig in tbl1.items do
        local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)

        local str1 = `Item_${k}`
        tbl2[str1] = React.createElement(sduiComponentWrapper, {
            componentConfig = componentConfig,
            sduiContext = tbl1.sduiContext,
            parentAnalyticsContext = tbl1.analyticsContext,
            extraLocalProps = { index = k, layoutOrder = k },
            debugName = `AssociatedItemsRow-Item-${k}`
        })
    end

    return React.createElement(View, {
        tag = "col gap-medium size-full-0 auto-y",
        LayoutOrder = layoutOrder
    }, {
        ItemsScroll = React.createElement(
            "ScrollingFrame",
            {
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                ClipsDescendants = false,
                ElasticBehavior = Enum.ElasticBehavior.Always,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.X,
                Selectable = false
            },
            {
                ItemsRow = React.createElement(View, { tag = "row gap-small auto-xy size-full-0" }, tbl2)
            }
        ),
        Footer = tbl1.footerComponent
    })
end)
