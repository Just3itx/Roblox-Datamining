-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local AppBlox = require(SduiSharedContentParent.AppBlox)
local Foundation = require(SduiSharedContentParent.Foundation)
local reportUnifiedLoggingAction = require(SduiSharedContentParent.SduiCoreSystem).reportUnifiedLoggingAction

local ExpandableText = AppBlox.ExpandableText
local View = Foundation.View

return React.memo(function(arg1) -- name: SduiExpandableText
    local layoutOrder = arg1.layoutOrder

    local onExpandChanged = React.useCallback(function(isExpanded: boolean)
        if arg1.onExpandChanged then
            arg1.onExpandChanged(isExpanded)
        end

        reportUnifiedLoggingAction(
            arg1.sduiContext,
            {
                actionType = "ExpandableTextToggle",
                actionParams = { isExpanded = isExpanded }
            },
            arg1.analyticsContext
        )
    end, { arg1.onExpandChanged, arg1.analyticsContext, arg1.sduiContext })

    local tbl1 = {
        text = arg1.text,
        LayoutOrder = if arg1.headerComponent and arg1.text and arg1.text ~= "" then 2 else layoutOrder,
        compactNumberOfLines = arg1.compactNumberOfLines,
        fontStyle = arg1.fontStyle,
        textStyle = arg1.textStyle,
        pressedTextStyle = arg1.pressedTextStyle,
        expandedInitially = arg1.expandedInitially,
        avoidBlankLineClip = arg1.avoidBlankLineClip,
        onExpandChanged = onExpandChanged,
        selectable = arg1.selectable
    }

    if not arg1.headerComponent or not arg1.text or arg1.text == "" then
        return React.createElement(ExpandableText, tbl1)
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y col gap-large",
        LayoutOrder = layoutOrder
    }, {
        Header = React.cloneElement(arg1.headerComponent, { layoutOrder = 1 }),
        Content = React.createElement(ExpandableText, tbl1)
    })
end)
