-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local UserListPeekView = require(script.Parent.UserListPeekView)
local AppFormFactor = require(UserList.Common.Enums).AppFormFactor
local View = require(UserListParent.Foundation).View
local useListFormFactor = require(UserList.Hooks.useListFormFactor)
local _Types = require(UserList.Common.Types)

local tbl1 = {
    position = UDim2.fromScale(0, 0),
    size = UDim2.fromScale(1, 1),
    anchorPoint = Vector2.new(0, 0)
}

local function UserListViewAdaptor(tbl2)
    local var1 = useListFormFactor()
    local bool1 = var1.formFactor == AppFormFactor.Compact
    local bool2 = not bool1 and tbl2.wideModePeekViewLayout ~= nil
    local var2 = React.useMemo(function()
        return if bool2 then tbl2.wideModePeekViewLayout else tbl1
    end, { var1.formFactor, tbl2.wideModePeekViewLayout })

    if not (bool1 or bool2) then
        return nil
    end

    return React.createElement(View, {
        Size = var2.size,
        Position = var2.position,
        AnchorPoint = var2.anchorPoint
    }, {
        UserListPeekView = React.createElement(UserListPeekView, {
            users = tbl2.users,
            title = tbl2.title,
            onLoadMore = tbl2.onLoadMore,
            onUserSelected = tbl2.onUserSelected,
            hasMore = tbl2.hasMore
        })
    })
end

return UserListViewAdaptor
