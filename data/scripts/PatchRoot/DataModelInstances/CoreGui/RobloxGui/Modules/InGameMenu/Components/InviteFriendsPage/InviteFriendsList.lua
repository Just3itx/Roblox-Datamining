-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local RoactGamepad = require(CorePackages.Packages.RoactGamepad)

local scriptParentParentParent = script.Parent.Parent.Parent

local PlayerLabelV2 = require(scriptParentParentParent.Components.PlayerLabelV2)
local GetFFlagIGMGamepadSelectionHistory = require(scriptParentParentParent.Flags.GetFFlagIGMGamepadSelectionHistory)

local Divider = require(scriptParentParentParent.Components.Divider)
local SendInviteButton = require(script.Parent.SendInviteButton)
local SearchBox = require(script.Parent.SearchBox)
local BarOnTopScrollingFrame = require(scriptParentParentParent.Components.BarOnTopScrollingFrame)
local PlayerSearchPredicate = require(scriptParentParentParent.Utility.PlayerSearchPredicate)
local FocusHandler = require(scriptParentParentParent.Components.Connection.FocusHandler)
local RootedConnection = require(scriptParentParentParent.Components.Connection.RootedConnection)

local Constants = require(scriptParentParentParent.Resources.Constants)
local InviteStatus = Constants.InviteStatus

local InviteUserToPlaceId = require(scriptParentParentParent.Thunks.InviteUserToPlaceId)

local str1 = tostring(game.PlaceId)

local var1 = Roact.PureComponent:extend("InviteFriendsList")

var1.validateProps = t.strictInterface({
    friends = t.array(t.strictInterface({ IsOnline = t.boolean, Id = t.integer, Username = t.string, DisplayName = t.string })),
    invitesState = t.table,
    shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.boolean) or nil else nil,
    dispatchInviteUserToPlaceId = t.callback,
    canCaptureFocus = t.boolean,
    searchBoxRef = t.table
})

function var1.init(arg1)
    arg1.playerRefs = RoactGamepad.createRefCache()

    arg1.state = { searchText = "" }

    arg1.inviteAnimationInProgress = {}
end

function var1.renderListEntries(arg1)
    local friends = arg1.props.friends

    local friendsLen = #friends
    local num1 = 1

    local tbl1 = {}
    local num2 = 0

    tbl1.ListLayout = Roact.createElement(
        "UIListLayout",
        {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Right
        }
    )
    for k, friend in pairs(friends) do
        local str2 = tostring(friend.Id)
        local userInviteStatus = arg1.props.invitesState[str2]
        local var3 = PlayerSearchPredicate(arg1.state.searchText, friend.Username, friend.DisplayName)

        if var3 then
            num2 += 1
        end

        local var4 = "friend_" .. k
        local createElement = Roact.createElement
        local var5 = PlayerLabelV2
        local tbl2 = {
            username = nil,
            username = friend.Username,
            displayName = friend.DisplayName,
            userId = friend.Id,
            isOnline = friend.IsOnline,
            isSelected = false,
            LayoutOrder = num1,
            Visible = var3,
            [Roact.Ref] = arg1.playerRefs[k]
        }
        function tbl2.onActivated()
            local bool1 = userInviteStatus == InviteStatus.Pending
            local bool2 = userInviteStatus == InviteStatus.Success
            local var6 = arg1.inviteAnimationInProgress[friend.Id]
            if not (bool1 or bool2 or var6) then
                arg1.props.dispatchInviteUserToPlaceId(str2, str1)
            end
        end
        local tbl3 = {
            InviteButton = Roact.createElement(SendInviteButton, {
                userInviteStatus = userInviteStatus,
                onActivated = function()
                    arg1.props.dispatchInviteUserToPlaceId(str2, str1)
                end,
                animationBegun = function()
                    arg1.inviteAnimationInProgress[friend.Id] = true
                end,
                animationEnded = function()
                    arg1.inviteAnimationInProgress[friend.Id] = nil
                end
            })
        }

        tbl1[var4] = createElement(var5, tbl2, tbl3)

        num1 += 1

        if not (k < friendsLen) then
            continue
        end

        local str3 = "divider_" .. num1
        tbl1[str3] = Roact.createElement(Divider, { LayoutOrder = num1, Size = UDim2.new(1, -104, 0, 1), Visible = var3 })

        num1 += 1
    end

    return tbl1, num2
end

function var1.render(arg1)
    local var2, var3 = arg1:renderListEntries()

    local friendsList = Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        SearchBox = Roact.createElement(SearchBox, {
            Size = UDim2.new(1, -48, 0, 36),
            Position = UDim2.new(0.5, 0, 0, 8),
            AnchorPoint = Vector2.new(0.5, 0),
            searchUpdated = function(searchText)
                arg1:setState({ searchText = searchText })
            end,
            searchCleared = function()
                arg1:setState({ searchText = "" })

                if arg1.props.canCaptureFocus then
                    GuiService.SelectedCoreObject = arg1.props.searchBoxRef:getValue()
                end
            end,
            itemRef = arg1.props.searchBoxRef
        }),
        List = Roact.createElement(
            BarOnTopScrollingFrame,
            {
                Position = UDim2.new(0, 0, 0, 64),
                Size = UDim2.new(1, 0, 1, -64),
                CanvasSize = UDim2.new(1, 0, 0, var3 * 72)
            },
            var2
        )
    })

    local shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then arg1.props.shouldForgetPreviousSelection else nil

    return Roact.createElement(RootedConnection, {
        render = function(arg2)
            return Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canCaptureFocus and arg2,
                shouldForgetPreviousSelection = shouldForgetPreviousSelection,
                didFocus = GetFFlagIGMGamepadSelectionHistory() and function(selectedCoreObject)
                    GuiService.SelectedCoreObject = selectedCoreObject or arg1:getFirstVisiblePlayerRef() or arg1.props.searchBoxRef:getValue()
                end or function()
                    GuiService.SelectedCoreObject = arg1:getFirstVisiblePlayerRef() or arg1.props.searchBoxRef:getValue()
                end
            }, { FriendsList = friendsList })
        end
    })
end

function var1.getFirstVisiblePlayerRef(arg1)
    local friends = arg1.props.friends
    for k, friend in pairs(friends) do
        if PlayerSearchPredicate(arg1.state.searchText, friend.Username, friend.DisplayName) then
            return arg1.playerRefs[k]:getValue()
        end
    end
    return nil
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then arg1.menuPage == Constants.MainPagePageKey or arg1.currentZone == 0 else nil
    return {
        invitesState = arg1.invites,
        shouldForgetPreviousSelection = shouldForgetPreviousSelection
    }
end, function(callback)
    return {
        dispatchInviteUserToPlaceId = function(arg1, arg2)
            callback(InviteUserToPlaceId(arg1, arg2))
        end
    }
end)(var1)
