-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local FFlagLuaAppSduiGameTileFeedback = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback

local function SduiButton(tbl1)
    return React.createElement(Foundation.Button, {
        ref = if FFlagLuaAppSduiGameTileFeedback then tbl1.buttonRef else nil,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Selectable = tbl1.selectable,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        cursor = tbl1.cursorType,
        fillBehavior = tbl1.fillBehavior,
        icon = tbl1.icon,
        inputDelay = tbl1.inputDelay,
        isDisabled = tbl1.isDisabled,
        isLoading = tbl1.isLoading,
        onActivated = tbl1.onActivated,
        size = tbl1.size,
        tag = tbl1.tag,
        testId = tbl1.testId,
        text = tbl1.text,
        variant = tbl1.variant,
        width = tbl1.width
    })
end

return SduiButton
