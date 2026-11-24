-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local Components = GameInvite.Components
local Context = GameInvite.Context
local GameInviteParent = GameInvite.Parent

local FriendsMenu = require(GameInviteParent.FriendsMenu)
local React = require(GameInviteParent.React)
local DeviceInfo = require(GameInviteParent.NotificationsCommon).DeviceInfo
local RoactUtils = require(GameInviteParent.RoactUtils)

local FriendsMenuFriendsList = FriendsMenu.FriendsMenuFriendsList
local InviteFriendContext = FriendsMenu.InviteFriendContext
local FriendsMenuContextWrapper = FriendsMenu.FriendsMenuContextWrapper
local FriendsMenuSearch = FriendsMenu.FriendsMenuSearch
local FriendMenuType = FriendsMenu.FriendMenuType

local GameInviteAnalyticsManager = require(GameInvite.analytics.GameInviteAnalyticsManager)
local GameInviteTitle = require(Components.GameInviteTitle)
local GameInviteRewardsBanner = require(Components.GameInviteRewardsBanner)
local GameInviteCustomText = require(Components.GameInviteCustomText)

local GameInviteFriendsListContainer = require(Components.GameInviteFriendsList.GameInviteFriendsListContainer)
local GameInviteConstants = require(GameInvite.GameInviteConstants)

local GameInviteModalLayoutContext = require(Context.GameInviteModalLayoutContext)
local GameDetailsContext = require(Context.GameDetailsContext)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local GetFFlagEnableCommonFriendsMenu = require(GameInviteParent.SharedFlags).GetFFlagEnableCommonFriendsMenu
local GetFFlagEnableGameInviteRewardsBanner = require(GameInviteParent.SharedFlags).GetFFlagEnableGameInviteRewardsBanner
local var1 = require(GameInviteParent.Loggers).Logger:new(script.Name)
local GetRewardMetadata = require(GameInvite.Requests.GetRewardMetadata)
local FFlagGameInviteInExpUserListRenderer = require(GameInvite.Flags.FFlagGameInviteInExpUserListRenderer)

local SidePadding = GameInviteConstants.Layout.SidePadding
local TitleHeight = GameInviteConstants.Layout.TitleHeight

local function func1(tbl1)
    local var2 = React.useContext(GameInviteModalLayoutContext)
    local gameDetailsData = React.useContext(GameDetailsContext)
    local rewardMetadata, var5 = React.useState(nil)
    if GetFFlagEnableGameInviteRewardsBanner() then
        React.useEffect(function()
            if not (game.GameId > 0) then
                return
            end

            GetRewardMetadata():andThen(function(arg1)
                if arg1.responseBody and arg1.responseBody.name and arg1.responseBody.description then
                    var5(arg1.responseBody)
                end
            end):catch(function(arg1)
                var1:error(`Error fetching reward metadata: {arg1}`)
            end)
        end, {})
    end

    local var6 = useSelector(function(arg1)
        return arg1.TopBar
    end)

    local var7 = DeviceInfo.isConsole()
    local bool1 = var2.modalMode == "compact"
    local promptMessage = gameDetailsData.promptMessage
    local var8 = promptMessage and #promptMessage > 0

    local var9 = TitleHeight + 12

    local bool2 = not (bool1 or var7)

    if bool2 then
        var9 += 48
    end
    if var8 then
        var9 += 48
    end

    local yOffset = TitleHeight
    if not gameDetailsData.isCoreScript and var6 and var6.statusBarHeight and var6 then
        var9 += var6.statusBarHeight
        yOffset += var6.statusBarHeight
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }

    local tbl3 = {
        UIPadding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, 12),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        TitleContainer = React.createElement(
            "Frame",
            {
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                LayoutOrder = 0,
                Size = UDim2.new(1, 0, 0, yOffset)
            },
            {
                GameInviteTitle = React.createElement(
                    GameInviteTitle,
                    {
                        layoutOrder = 0,
                        size = UDim2.new(1, 0, 0, TitleHeight),
                        hideCloseButton = tbl1.hideCloseButton
                    }
                )
            }
        ),
        SearchBox = bool2
            and React.createElement(
                "Frame",
                {
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, 36)
                },
                {
                    UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, SidePadding), PaddingRight = UDim.new(0, SidePadding) }),
                    UIListLayout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, 12),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Top
                    }),
                    FriendsMenuSearch = React.createElement(FriendsMenuSearch, {
                        layoutOrder = 1,
                        size = UDim2.new(1, 0, 0, 36),
                        focusElement = false,
                        onFocus = function()
                            GameInviteAnalyticsManager:onSearchFocused()
                        end
                    })
                }
            )
            or nil,
        CustomTextContainer = var8
            and React.createElement(
                GameInviteCustomText,
                {
                    layoutOrder = 2,
                    size = UDim2.new(1, 0, 0, 36),
                    promptMessage = promptMessage
                }
            )
            or nil,
        RewardsBanner = if GetFFlagEnableGameInviteRewardsBanner() and rewardMetadata ~= nil then React.createElement(GameInviteRewardsBanner, { layoutOrder = 2, rewardMetadata = rewardMetadata }) or nil else nil,
        FriendsList = 0
    }

    local element

    if FFlagGameInviteInExpUserListRenderer and gameDetailsData.trigger == GameInviteConstants.Triggers.GameMenu then
        element = React.createElement(GameInviteFriendsListContainer, { layoutOrder = 3, size = UDim2.new(1, 0, 1, -var9) })
    else
        element = React.createElement(FriendsMenuFriendsList, {
            layoutOrder = 3,
            size = UDim2.new(1, 0, 1, -var9),
            parentComponentName = GameInviteConstants.ParentComponentName,
            menuType = FriendMenuType.SingleSelect,
            gameDetailsData = gameDetailsData,
            disableSelectionParentManagement = tbl1.disableSelectionParentManagement
        })
    end

    tbl3.FriendsList = element
    return createElement(str1, tbl2, tbl3)
end

return function(tbl1)
    local var2 = if GetFFlagEnableCommonFriendsMenu() then React.useContext(InviteFriendContext) else {
        inviteSingleFriend = function() end,
        getMaxRecipientRowNum = function() end
    }

    if not GetFFlagEnableCommonFriendsMenu() then
        return (React.createElement(func1, tbl1))
    end

    return (React.createElement(FriendsMenuContextWrapper, {
        inviteSingleFriend = var2.inviteSingleFriend,
        inviteMultiFriends = function() end,
        isLoadingCustomParams = tbl1.isLoadingCustomParams
    }, {
        GameInviteContent = React.createElement(func1, tbl1)
    }))
end
