-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)
local useLocalization = require(UserListParent.Localization).Hooks.useLocalization

local Enums = Foundation.Enums
local View = Foundation.View
local Button = Foundation.Button
local InputSize = Enums.InputSize

local function UserListFooter(tbl1)
    local var1 = useLocalization({ showMore = "Feature.Friends.Action.ViewMore" })

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y padding-top-medium padding-bottom-medium",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            ShowMoreButton = if tbl1.hasMore and tbl1.onLoadMore then React.createElement(
                Button,
                {
                    size = InputSize.Small,
                    onActivated = tbl1.onLoadMore,
                    text = var1.showMore,
                    fillBehavior = Enums.FillBehavior.Fill
                }
            ) else nil
        }
    )
end

return UserListFooter
