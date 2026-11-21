-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent
local Context = FriendsMenu.Context

local React = require(FriendsMenuParent.React)
local Checkbox = require(FriendsMenuParent.Foundation).Checkbox

local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)

local SelectedUsersContext = require(Context.SelectedUsersContext)

return function(tbl1)
    local var1 = React.useContext(SelectedUsersContext)

    local onActivated = React.useCallback(function()
        if var1.isFriendSelected(tbl1.friend.id) then
            var1.removeFriend(tbl1.friend.id)
            return
        end
        var1.addFriend(tbl1.friend.id, tbl1.friend.displayName)
    end, {
        var1.isFriendSelected(tbl1.friend.id),
        var1.removeFriend,
        var1.addFriend,
        tbl1.friend.id
    })

    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.XY,
        AnchorPoint = tbl1.anchorPoint,
        Position = tbl1.position,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, {
        CheckboxAlignment = React.createElement("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Center }),
        Button = React.createElement(Checkbox, {
            onActivated = onActivated,
            isChecked = var1.isFriendSelected(tbl1.friend.id),
            label = "",
            isDisabled = tbl1.isDisabled,
            Selectable = tbl1.selectable
        })
    })
end
