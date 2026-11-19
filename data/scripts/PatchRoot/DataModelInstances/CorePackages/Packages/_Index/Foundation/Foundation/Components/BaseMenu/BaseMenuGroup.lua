-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BaseMenuContext = require(script.Parent.BaseMenuContext)
local BaseMenuDivider = require(script.Parent.BaseMenuDivider)
local BaseMenuTitleItem = require(script.Parent.BaseMenuTitleItem)
local View = require(Foundation.Components.View)

local tbl1 = {
    XSmall = "padding-xsmall",
    Small = "padding-small",
    Medium = "padding-small",
    Large = "padding-small"
}

local function BaseMenuGroup(tbl2)
    local var1 = React.useContext(BaseMenuContext)
    local layoutOrder = tbl2.LayoutOrder
    local createElement = React.createElement
    local fragment = React.Fragment
    local var2 = nil
    local tbl3 = {
        Divider = if layoutOrder == 1 then nil else React.createElement(BaseMenuDivider, { LayoutOrder = layoutOrder * 2 - 1 }),
        Group = React.createElement(
            View,
            {
                LayoutOrder = layoutOrder * 2,
                tag = `col gap-xxsmall size-full-0 auto-y {tbl1[var1.size]}`
            },
            {
                Title = if tbl2.title then React.createElement(
                    BaseMenuTitleItem,
                    {
                        text = tbl2.title,
                        size = var1.size,
                        menuHasLeading = tbl2.menuHasLeading,
                        menuHasCheck = tbl2.menuHasCheck
                    }
                ) else nil,
                Items = React.createElement(React.Fragment, nil, tbl2.children)
            }
        )
    }
    return createElement(fragment, var2, tbl3)
end

return BaseMenuGroup
