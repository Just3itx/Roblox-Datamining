-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local function SduiText(tbl1)
    return React.createElement(Foundation.Text, {
        AnchorPoint = tbl1.anchorPoint,
        AutomaticSize = tbl1.automaticSize,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        RichText = tbl1.richText,
        Rotation = tbl1.rotation,
        Size = tbl1.size,
        SizeConstraint = tbl1.sizeConstraint,
        Text = tbl1.text,
        TextTruncate = tbl1.textTruncate,
        TextWrapped = tbl1.textWrapped,
        TextXAlignment = tbl1.textXAlignment,
        TextYAlignment = tbl1.textYAlignment,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        aspectRatio = tbl1.aspectRatio,
        backgroundStyle = tbl1.backgroundStyle,
        cornerRadius = tbl1.cornerRadius,
        cursor = tbl1.cursorType,
        fontStyle = tbl1.fontStyle,
        isDisabled = tbl1.isDisabled,
        onActivated = tbl1.onActivated,
        onSecondaryActivated = tbl1.onSecondaryActivated,
        padding = tbl1.padding,
        scale = tbl1.scale,
        selection = tbl1.selectable ~= nil and {
            Selectable = tbl1.selectable
        } or nil,
        tag = tbl1.tag,
        testId = tbl1.testId,
        textStyle = tbl1.textStyle
    }, tbl1.children)
end

return SduiText
