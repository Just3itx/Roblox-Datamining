-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)

local VerticalUserListSection = require(UserList.Components.VerticalUserList).VerticalUserListSection
local HorizontalUserList = require(UserList.Components.HorizontalUserList).HorizontalUserList
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

return React.memo(function(tbl1) -- name: UserListLayoutAdaptor
    local var1 = if tbl1.layoutMode == Enums.LayoutMode.Vertical then VerticalUserListSection else HorizontalUserList
    local var2 = table.clone(tbl1)
    var2.layoutMode = nil

    return React.createElement(var1, var2)
end)
