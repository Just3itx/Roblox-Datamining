-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local IconButton = Foundation.IconButton

local function func1() end

return React.memo(function(tbl1) -- name: SduiIconButton
    if not (tbl1.icon and tbl1.icon.name) then
        return nil
    end

    return React.createElement(IconButton, {
        icon = tbl1.icon,
        isCircular = tbl1.isCircular,
        width = tbl1.width,
        size = tbl1.size,
        variant = tbl1.variant,
        onActivated = tbl1.onActivated or func1,
        LayoutOrder = tbl1.layoutOrder,
        AnchorPoint = tbl1.anchorPoint,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        isDisabled = tbl1.isDisabled,
        testId = tbl1.testId
    })
end)
