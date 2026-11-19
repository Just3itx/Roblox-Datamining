-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local AspectRatio = require(Foundation.Components.AspectRatio)
local CornerRadius = require(Foundation.Components.CornerRadius)
local Padding = require(Foundation.Components.Padding)

local getTestIdTag = require(Foundation.Utility.getTestIdTag)

local _Types = require(Foundation.Components.Types)

local function GuiObjectChildren(arg1)
    local testId = arg1.testId
    local tbl1 = {
        Children = React.createElement(React.Fragment, {}, arg1.children),
        AspectRatio = if arg1.aspectRatio == nil then nil else React.createElement(
            AspectRatio,
            {
                value = arg1.aspectRatio,
                testId = if testId then `{testId}--aspect-ratio` else nil
            }
        ),
        CornerRadius = if arg1.cornerRadius == nil then nil else React.createElement(
            CornerRadius,
            {
                value = arg1.cornerRadius,
                testId = if testId then `{testId}--corner-radius` else nil
            }
        ),
        FlexItem = 0,
        ListLayout = 0,
        SizeConstraint = 0,
        Padding = 0,
        Scale = 0,
        Stroke = 0
    }
    local element3

    if arg1.flexItem == nil then
        element3 = nil
    else
        element3 = React.createElement("UIFlexItem", {
            FlexMode = arg1.flexItem.FlexMode,
            GrowRatio = arg1.flexItem.GrowRatio,
            ShrinkRatio = arg1.flexItem.ShrinkRatio,
            ItemLineAlignment = arg1.flexItem.ItemLineAlignment,
            [React.Tag] = getTestIdTag(testId, "flex-item")
        })
    end

    tbl1.FlexItem = element3
    local element4

    if arg1.layout == nil or arg1.layout.FillDirection == nil then
        element4 = nil
    else
        element4 = React.createElement("UIListLayout", {
            FillDirection = arg1.layout.FillDirection,
            ItemLineAlignment = arg1.layout.ItemLineAlignment,
            HorizontalAlignment = arg1.layout.HorizontalAlignment,
            HorizontalFlex = arg1.layout.HorizontalFlex,
            VerticalAlignment = arg1.layout.VerticalAlignment,
            VerticalFlex = arg1.layout.VerticalFlex,
            Padding = arg1.layout.Padding,
            SortOrder = arg1.layout.SortOrder,
            Wraps = arg1.layout.Wraps,
            [React.Tag] = getTestIdTag(testId, "list-layout")
        })
    end

    tbl1.ListLayout = element4
    local element5 = if arg1.sizeConstraint == nil then nil else React.createElement("UISizeConstraint", {
        MaxSize = arg1.sizeConstraint.MaxSize,
        MinSize = arg1.sizeConstraint.MinSize,
        [React.Tag] = getTestIdTag(testId, "size-constraint")
    })
    tbl1.SizeConstraint = element5
    local element6 = if arg1.padding == nil then nil else React.createElement(Padding, { value = arg1.padding, testId = if testId then `{testId}--padding` else nil })
    tbl1.Padding = element6
    local element7 = if arg1.scale == nil then nil else React.createElement("UIScale", { Scale = arg1.scale, [React.Tag] = getTestIdTag(testId, "scale") })
    tbl1.Scale = element7
    local element8

    if arg1.stroke == nil then
        element8 = nil
    else
        element8 = React.createElement("UIStroke", {
            Color = arg1.stroke.Color,
            Thickness = arg1.stroke.Thickness,
            Transparency = arg1.stroke.Transparency,
            LineJoinMode = arg1.stroke.LineJoinMode,
            BorderStrokePosition = arg1.stroke.BorderStrokePosition,
            [React.Tag] = getTestIdTag(testId, "stroke")
        })
    end

    tbl1.Stroke = element8
    return tbl1
end

return GuiObjectChildren
