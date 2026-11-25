-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)
local SharedFlags = require(SduiSharedContentParent.SharedFlags)
local FFlagSduiViewContainerRefEnabled = SharedFlags.FFlagSduiViewContainerRefEnabled
local FFlagSduiViewStateLayerAffordance = SharedFlags.FFlagSduiViewStateLayerAffordance

return React.memo(function(tbl1) -- name: SduiView
    return React.createElement(Foundation.View, {
        ref = if FFlagSduiViewContainerRefEnabled then tbl1.containerRef else nil,
        AnchorPoint = tbl1.anchorPoint,
        AutomaticSize = tbl1.automaticSize,
        ClipsDescendants = tbl1.clipsDescendants,
        GroupTransparency = tbl1.groupTransparency,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Rotation = tbl1.rotation,
        Size = tbl1.size,
        SizeConstraint = tbl1.sizeConstraint,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        aspectRatio = tbl1.aspectRatio,
        backgroundStyle = tbl1.backgroundStyle,
        cornerRadius = tbl1.cornerRadius,
        cursor = tbl1.cursorType,
        isDisabled = tbl1.isDisabled,
        onActivated = tbl1.onActivated,
        onSecondaryActivated = tbl1.onSecondaryActivated,
        padding = tbl1.padding,
        scale = tbl1.scale,
        selection = tbl1.selectable ~= nil and {
            Selectable = tbl1.selectable
        } or nil,
        selectionGroup = tbl1.selectionGroup,
        stateLayer = FFlagSduiViewStateLayerAffordance and tbl1.stateLayerAffordance ~= nil and {
            affordance = tbl1.stateLayerAffordance
        }
            or nil,
        tag = tbl1.tag,
        testId = tbl1.testId
    }, tbl1.children)
end)
