-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local Components = FriendsMenu.Components
local FriendsMenuParent = FriendsMenu.Parent
local Context = FriendsMenu.Context
local Enums = FriendsMenu.Enums

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local Cryo = require(FriendsMenuParent.Cryo)
local SharedFlags = require(FriendsMenuParent.SharedFlags)
local GetFFlagEnableCommonFriendsMenu = SharedFlags.GetFFlagEnableCommonFriendsMenu
local GetFFlagFriendsMenuDummyLoadingFriendsFix = SharedFlags.GetFFlagFriendsMenuDummyLoadingFriendsFix

local Foundation = require(FriendsMenuParent.Foundation)
local useCursor = Foundation.Hooks.useCursor

local FriendThumbnail = require(Components.FriendThumbnail)
local FriendsMenuButton = require(Components.FriendsMenuButton)
local FriendInfo = require(Components.FriendInfo)
local FriendsMenuCheckbox = require(Components.FriendsMenuCheckbox)
local var1 = if GetFFlagEnableCommonFriendsMenu() then require(Context.InviteCallbackContext) else require(Context.InviteFriendContext)
local SelectedUsersContext = require(Context.SelectedUsersContext)

local FriendMenuType = require(Enums.FriendMenuType)

local useStyle = UIBlox.Core.Style.useStyle
local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)

local uDim2 = UDim2.new(1, 0, 0.5, 0)
local vector2 = Vector2.new(1, 0.5)

local function func1() end

local tbl1 = { sidePadding = 24, isFullRowActivatable = false, backgroundTransparency = nil }

return function(tbl2)
    local var2 = Cryo.Dictionary.join(tbl1, tbl2)
    local isHoverRow, var4 = React.useState(false)
    local theme = useStyle().Theme
    local friend = var2.friend
    assert(friend, "friend should be non-nil. Silence type checker.")
    local var5 = React.useContext(var1)
    local var6 = React.useContext(SelectedUsersContext)
    local sidePadding = var2.sidePadding

    local var7 = useCursor(Foundation.Enums.CursorType.RoundedSlot)

    local autoButtonColor = var2.isFullRowActivatable and not var2.isFetchingFriends

    local onInvite = React.useCallback(function()
        if var5 and var5.inviteSingleFriend and not friend.isLoadingPlaceholder then
            var5.inviteSingleFriend(friend.id, var2.layoutOrder)
        end
    end, {
        var5,
        var5.inviteSingleFriend,
        friend.id,
        friend.isLoadingPlaceholder,
        var2.layoutOrder
    })

    local var10 = React.useCallback(function()
        if var6.isFriendSelected(var2.friend.id) then
            var6.removeFriend(var2.friend.id, var2.friend.displayName)
            return
        end
        var6.addFriend(var2.friend.id, var2.friend.displayName)
    end, {
        var6.isFriendSelected,
        var6.removeFriend,
        var6.addFriend,
        var2.friend.id
    })

    local var11 = React.useCallback(function()
        if not autoButtonColor or GetFFlagFriendsMenuDummyLoadingFriendsFix() and friend.isLoadingPlaceholder then
            return
        end

        if var2.menuType ~= FriendMenuType.MultiSelect then
            onInvite()
        else
            var10()
        end
    end, {
        autoButtonColor,
        var2.menuType,
        onInvite,
        var10,
        friend.isLoadingPlaceholder
    })

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl3 = {
        Size = UDim2.new(1, 0, 0, 72),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = isHoverRow and theme.BackgroundOnHover.Color or theme.BackgroundDefault.Color,
        BackgroundTransparency = if isHoverRow then theme.BackgroundOnHover.Transparency elseif var2.backgroundTransparency then var2.backgroundTransparency else theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = var2.layoutOrder
    }

    if not var2.isFullRowActivatable then
        var7 = nil
    end

    tbl3.SelectionImageObject = var7
    tbl3[React.Event.MouseEnter] = function()
        if not var2.isFetchingFriends then
            var4(true)
        end
    end
    tbl3[React.Event.MouseLeave] = function()
        var4(false)
    end
    local activated = React.Event.Activated

    if GetFFlagFriendsMenuDummyLoadingFriendsFix() and friend.isLoadingPlaceholder or not autoButtonColor then
        var11 = func1
    end

    tbl3[activated] = var11

    tbl3.AutoButtonColor = autoButtonColor
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 12)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingRight = UDim.new(0, sidePadding),
            PaddingLeft = UDim.new(0, sidePadding),
            PaddingBottom = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 8)
        }),
        ThumbnailAndPresenceWrapper = React.createElement(FriendThumbnail, {
            friend = friend,
            isHoverRow = isHoverRow,
            size = UDim2.new(0, 56, 0, 56),
            position = UDim2.new(0, 0, 0.5, 0),
            anchorPoint = Vector2.new(0, 0.5),
            isFetchingFriends = var2.isFetchingFriends,
            LayoutOrder = 1
        }),
        UserInfo = React.createElement(FriendInfo, {
            position = UDim2.new(0, 56, 0, 0),
            size = UDim2.new(1, -134, 0, 0),
            friend = friend,
            isFetchingFriendsNames = var2.isFetchingFriendsNames,
            LayoutOrder = 2
        }),
        InviteButton = 0
    }
    local element

    if var2.menuType == FriendMenuType.MultiSelect then
        element = React.createElement(FriendsMenuCheckbox, {
            size = UDim2.new(0, 66, 0, 36),
            position = uDim2,
            anchorPoint = vector2,
            friend = friend,
            isDisabled = var2.isFetchingFriends,
            layoutOrder = 3,
            selectable = not var2.isFullRowActivatable and nil
        })
    else
        element = React.createElement(FriendsMenuButton, {
            size = UDim2.new(0, 66, 0, 36),
            position = uDim2,
            anchorPoint = vector2,
            friend = friend,
            onInvite = onInvite,
            isFullRowActivatable = var2.isFullRowActivatable,
            layoutOrder = 3
        })
    end

    tbl4.InviteButton = element
    return createElement(str1, tbl3, tbl4)
end
