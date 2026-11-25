-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)

local Accordion = Foundation.Accordion

return React.memo(function(tbl1) -- name: SduiAccordionItem
    local icon = React.useMemo(function()
        return if tbl1.icon and tbl1.iconVariant then {
            name = tbl1.icon,
            variant = tbl1.iconVariant
        } else tbl1.icon
    end, { tbl1.icon, tbl1.iconVariant })

    return React.createElement(Accordion.Item, {
        id = tbl1.index or tbl1.layoutOrder or 1,
        text = tbl1.text or "",
        description = tbl1.description,
        icon = icon,
        hasDivider = tbl1.hasDivider,
        isExpanded = tbl1.isExpanded,
        LayoutOrder = tbl1.layoutOrder
    }, tbl1.content)
end)
