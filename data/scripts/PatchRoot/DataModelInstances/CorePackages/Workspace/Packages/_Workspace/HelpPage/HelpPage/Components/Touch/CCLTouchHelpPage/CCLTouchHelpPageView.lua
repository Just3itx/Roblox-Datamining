-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HelpPage = script:FindFirstAncestor("HelpPage")
local HelpPageParent = HelpPage.Parent
local React = require(HelpPageParent.React)
local _ActionText = require(HelpPage.Components.Common.ActionText)
local DiagramLayoutView = require(HelpPage.Components.Common.DiagramLayoutView)
local TouchControlList = require(HelpPage.Components.Touch.TouchControlList)
local TouchDeviceMock = require(HelpPage.Components.Touch.TouchDeviceMock)
local TouchHelpPage = require(HelpPage.Components.Touch.TouchHelpPage)

local function CCLTouchHelpPageView(tbl1)
    if not tbl1.abilitiesAvailable then
        return React.createElement(TouchHelpPage)
    end
    local textVariant = if tbl1.layout.columnWidth == 0.5 then "title-large" else "label-small"

    return React.createElement(DiagramLayoutView, {
        layout = tbl1.layout,
        testId = "Touch",
        diagramTestId = "TouchDiagram",
        onSizeChanged = tbl1.onSizeChanged,
        onLeftSizeChanged = tbl1.onLeftSizeChanged,
        onRightSizeChanged = tbl1.onRightSizeChanged,
        left = React.createElement(
            TouchControlList,
            {
                controls = tbl1.leftControls,
                layoutOrderReversed = false,
                showIconBackground = false,
                textVariant = textVariant
            }
        ),
        right = React.createElement(
            TouchControlList,
            {
                controls = tbl1.rightControls,
                layoutOrderReversed = true,
                textVariant = textVariant
            }
        ),
        renderDiagram = function(vector2: Vector2)
            return React.createElement(TouchDeviceMock, {
                centerControl = tbl1.centerControl,
                slots = tbl1.slots,
                layout = tbl1.mockLayout,
                scale = vector2.X / tbl1.mockLayout.size.X
            })
        end
    })
end

return CCLTouchHelpPageView
