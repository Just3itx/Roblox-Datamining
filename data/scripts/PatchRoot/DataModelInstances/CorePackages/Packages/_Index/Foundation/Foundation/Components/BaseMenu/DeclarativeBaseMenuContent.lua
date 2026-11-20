-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local BaseMenuGroup = require(script.Parent.BaseMenuGroup)
local BaseMenuItem = require(script.Parent.BaseMenuItem)

local function DeclarativeBaseMenuContent(tbl1)
    local var1 = React.useMemo(function()
        local var1 = Dash.get(tbl1.items, { 1, "items" })
        local var2 = Dash.get(tbl1.items, { 1, "id" })
        return if var1 and not var2 then tbl1.items else {{
            items = tbl1.items
        }}
    end, { tbl1.items })

    local tbl2 = ({})
    local bool1 = false
    for value, value2 in var1 do
        local bool2 = false
        for _, item in value2.items do
            if not bool2 and (item.leading ~= nil or item.icon ~= nil) then
                bool2 = true
            end

            if not bool1 and item.isChecked == true then
                bool1 = true
            end
        end
        tbl2[value] = bool2
    end

    return React.createElement(React.Fragment, nil, Dash.map(var1, function(arg1, num1: number)
        local menuHasLeading = tbl2[num1]
        return React.createElement(
            BaseMenuGroup,
            {
                key = num1,
                LayoutOrder = num1,
                title = arg1.title,
                menuHasLeading = menuHasLeading,
                menuHasCheck = bool1
            },
            Dash.map(arg1.items, function(arg2, layoutOrder)
                return React.createElement(
                    BaseMenuItem,
                    {
                        LayoutOrder = layoutOrder,
                        key = arg2.id,
                        icon = arg2.icon,
                        leading = arg2.leading,
                        trailing = arg2.trailing,
                        isChecked = arg2.isChecked,
                        isDisabled = arg2.isDisabled,
                        text = arg2.text,
                        onActivated = arg2.onActivated,
                        id = arg2.id,
                        testId = if arg2.items then "--foundation-menu-submenu-item" else "--foundation-menu-item",
                        ref = arg2.ref,
                        menuHasLeading = menuHasLeading,
                        menuHasCheck = bool1
                    },
                    if arg2.items then React.createElement(DeclarativeBaseMenuContent, { items = arg2.items }) else nil
                )
            end)
        )
    end))
end

return React.memo(DeclarativeBaseMenuContent)
