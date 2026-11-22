-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View

local function FontSizeTouchArea(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        ref = tbl1.touchAreaRef,
        tag = "size-full",
        testId = "font-size-slider-touch-area",
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        DragDetector = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            SelectionModeDragSpeed = UDim2.new(),
            [React.Event.DragStart] = tbl1.onDragStarted,
            [React.Event.DragContinue] = tbl1.onDrag
        })
    }
    return createElement(var1, tbl2, tbl3)
end

return FontSizeTouchArea
