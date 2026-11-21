-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Components = FriendsMenu.Components
local Context = FriendsMenu.Context
local Enums = FriendsMenu.Enums
local FriendsMenuParent = FriendsMenu.Parent

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local FriendRow = require(Components.FriendRow)
local EmptyFriendsList = require(Components.EmptyFriendsList)
local FriendsListMsg = require(Components.FriendsListMsg)
local FriendsListContext = require(Context.FriendsListContext)
local _FriendMenuType = require(Enums.FriendMenuType)
local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView
local FFlagUpdateInvitesToUsePaginatedFriends = require(FriendsMenu.Flags.FFlagUpdateInvitesToUsePaginatedFriends)
local FriendsMenuShareGameInviteLink = require(Components.FriendsMenuShareGameInviteLink)
local bool1 = game:DefineFastFlag("EnableFriendsMenuShareGameInviteLink3", false)
local useAppPolicy = require(FriendsMenuParent.UniversalAppPolicy).useAppPolicy

return function(tbl1)
    local var1 = React.useContext(FriendsListContext)
    local friends = var1.friends
    local isFetchingFriends = var1.isFetchingFriends
    local isFetchingFriendsNames = isFetchingFriends or var1.friendsNames and var1.friendsNames.loading
    local isFriendsListFetchFailed = var1.isFriendsListFetchFailed
    local hasFriends = var1.hasFriends
    local scrollingFrameRef = React.useRef(nil)
    local var4, var5 = React.useState(0)

    React.useEffect(function()
        if not UserInputService.GamepadEnabled or tbl1.disableListFocus then
            return
        end

        local current = scrollingFrameRef.current
        local var6 = nil
        if current then
            var6 = current:FindFirstAncestorOfClass("ScreenGui")
            if var6 and var6.Enabled and GuiService.SelectedCoreObject == nil then
                if not tbl1.disableSelectionParentManagement then
                    GuiService:AddSelectionParent(tbl1.parentComponentName, current)
                end
                for _, selectedCoreObject in ipairs(current:GetChildren()) do
                    if selectedCoreObject:IsA("ImageButton") and selectedCoreObject.LayoutOrder == 1 then
                        GuiService.SelectedCoreObject = selectedCoreObject
                    end
                end
            end
        end

        return function()
            if GuiService.SelectedCoreObject
                and var6
                and (GuiService.SelectedCoreObject.Parent == nil or var6:IsAncestorOf(GuiService.SelectedCoreObject))
            then
                GuiService.SelectedCoreObject = nil
            end

            if not tbl1.disableSelectionParentManagement then
                GuiService:RemoveSelectionGroup(tbl1.parentComponentName)
            end
        end
    end, { friends, tbl1.disableListFocus, tbl1.disableSelectionParentManagement })

    local var6 = useAppPolicy(function(arg1)
        return arg1.getExperienceInviteShareLinkEnabled()
    end)

    local bool2 = bool1

    if bool2 then
        if tbl1.parentComponentName == "GameInviteModal" and game.GameId > 0 then
            local isCoreScript = tbl1.gameDetailsData and tbl1.gameDetailsData.isCoreScript

            if isCoreScript then
                if tbl1.gameDetailsData.serverType ~= "StandardServer" then
                    var6 = false
                end
            else
                var6 = isCoreScript
            end
        else
            var6 = false
        end
    else
        var6 = bool2
    end

    local var7 = React.useMemo(function()
        local result = ({})
        result.RowListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        })
        for layoutOrder, friend in ipairs(friends) do
            local str1 = "User-" .. tostring(friend.id)
            result[str1] = React.createElement(FriendRow, {
                friend = friend,
                layoutOrder = layoutOrder,
                isFullRowActivatable = (UserInputService.GamepadEnabled or tbl1.isFullRowActivatable) == true,
                menuType = tbl1.menuType,
                sidePadding = tbl1.sidePadding,
                backgroundTransparency = tbl1.backgroundTransparency,
                isFetchingFriends = isFetchingFriends,
                isFetchingFriendsNames = isFetchingFriendsNames
            })
        end
        return result
    end, { friends })

    if isFriendsListFetchFailed then
        var7 = var6
            and {
                InviteLink = React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 0 }),
                FriendsListMsg = React.createElement(FriendsListMsg, { msgType = "errorFriendsList" })
            }
            or React.createElement(FriendsListMsg, { msgType = "errorFriendsList" })
    elseif isFetchingFriends then
        if var6 then
            var7.InviteLink = React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 0 })
        end
    elseif hasFriends then
        if #friends > 0 then
            if var6 then
                var7.InviteLink = React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 0 })
            end
        else
            var7 = var6
                and {
                    InviteLink = React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 0 }),
                    FriendsListMsg = React.createElement(FriendsListMsg, { msgType = "noResultFriendsList" })
                }
                or React.createElement(FriendsListMsg, { msgType = "noResultFriendsList" })
        end
    else
        var7 = var6
            and {
                InviteLink = React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 0 }),
                EmptyFriendsList = React.createElement(EmptyFriendsList)
            }
            or React.createElement(EmptyFriendsList)
    end

    local createElement = React.createElement
    local var8 = VerticalScrollView

    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        size = tbl1.size,
        useAutomaticCanvasSize = true,
        canvasSizeY = UDim.new(1, 0),
        selectable = false,
        scrollingFrameRef = scrollingFrameRef,
        [React.Change.CanvasPosition] = FFlagUpdateInvitesToUsePaginatedFriends and function(arg1)
            if arg1.CanvasPosition.Y / (arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y) >= 0.8
                and var4 < arg1.AbsoluteCanvasSize.Y
            then
                var5(arg1.AbsoluteCanvasSize.Y)
                var1.fetchMoreFriends()
            end
        end or nil
    }

    return createElement(var8, tbl2, var7)
end
