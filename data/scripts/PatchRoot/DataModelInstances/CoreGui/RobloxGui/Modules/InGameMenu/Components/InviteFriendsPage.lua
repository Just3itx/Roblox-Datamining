-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local RoactRodux = InGameMenuDependencies.RoactRodux
local Cryo = InGameMenuDependencies.Cryo

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)
local Promise = require(scriptParentParent.Utility.Promise)
local withLocalization = require(scriptParentParent.Localization.withLocalization)

local Page = require(scriptParentParent.Components.Page)
local ThemedTextLabel = require(scriptParentParent.Components.ThemedTextLabel)
local PageNavigationWatcher = require(scriptParentParent.Components.PageNavigationWatcher)
local FocusHandler = require(scriptParentParent.Components.Connection.FocusHandler)
local RootedConnection = require(scriptParentParent.Components.Connection.RootedConnection)

local InviteFriendsList = require(script.InviteFriendsList)
local AddFriendsNow = require(script.AddFriendsNow)
local LoadingFriendsError = require(script.LoadingFriendsError)

local GetFFlagIGMGamepadSelectionHistory = require(scriptParentParent.Flags.GetFFlagIGMGamepadSelectionHistory)

local var1 = Roact.PureComponent:extend("InviteFriendsPage")

var1.validateProps = t.strictInterface({
    pageTitle = t.string,
    canCaptureFocus = t.optional(t.boolean),
    PlayersService = t.union(t.Instance, t.table),
    menuPage = GetFFlagIGMGamepadSelectionHistory() and t.string or nil
})

var1.defaultProps = { PlayersService = Players }

function var1.init(arg1)
    arg1.backButtonRef = Roact.createRef()
    arg1.searchBoxRef = Roact.createRef()

    arg1.state = {
        loadingFriends = true,
        loadingFriendsError = false,
        friends = {}
    }
end

function var1.renderLoadingPage(_)
    return withLocalization({ loading = "CoreScripts.InGameMenu.InviteFriends.Loading" })(function(arg1)
        return Roact.createElement(
            ThemedTextLabel,
            {
                Size = UDim2.new(1, 0, 1, 0),
                Text = arg1.loading,
                fontKey = "Header1",
                themeKey = "TextEmphasis"
            }
        )
    end)
end

function var1.renderError(arg1)
    return Roact.createElement(LoadingFriendsError, {
        onRetry = function()
            arg1:setState({ loadingFriends = true, loadingFriendsError = false })

            arg1:loadFriends()
        end,
        canCaptureFocus = arg1.props.canCaptureFocus
    })
end

function var1.renderNoFriends(arg1)
    return Roact.createElement(AddFriendsNow, { canCaptureFocus = arg1.props.canCaptureFocus })
end

local function sortFriends(arg1, arg2)
    if arg1.IsOnline == arg2.IsOnline then
        return arg1.Username:lower() < arg2.Username:lower()
    end

    return arg1.IsOnline and not arg2.IsOnline
end

function var1.renderFriends(arg1)
    return Roact.createElement(
        InviteFriendsList,
        {
            friends = arg1.state.friends,
            canCaptureFocus = arg1.props.canCaptureFocus,
            searchBoxRef = arg1.searchBoxRef
        }
    )
end

function var1.render(arg1)
    local state = arg1.state
    local tbl1 = {
        Watcher = Roact.createElement(PageNavigationWatcher, {
            desiredPage = "InviteFriends",
            onNavigateTo = function()
                arg1:loadFriends()
            end
        })
    }

    if state.loadingFriends then
        tbl1.Loading = arg1:renderLoadingPage()
    elseif state.loadingFriendsError then
        tbl1.ErrorLoading = arg1:renderError()
    elseif #state.friends == 0 then
        tbl1.NoFriends = arg1:renderNoFriends()
    else
        tbl1.FriendsList = arg1:renderFriends()
    end

    return Roact.createElement(RootedConnection, {
        render = function(arg2)
            return Roact.createElement(FocusHandler, {
                shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() and arg1.props.menuPage ~= "InviteFriends" then true else nil,
                isFocused = arg1.props.canCaptureFocus and state.loadingFriends and arg2,
                didFocus = function()
                    GuiService.SelectedCoreObject = arg1.backButtonRef:getValue()
                end
            }, {
                Page = Roact.createElement(
                    Page,
                    {
                        pageTitle = arg1.props.pageTitle,
                        buttonRef = arg1.backButtonRef,
                        NextSelectionDown = arg1.searchBoxRef
                    },
                    tbl1
                )
            })
        end
    })
end

function var1.didMount(arg1)
    arg1.mounted = true
    arg1:loadFriends()
end

function var1.loadFriends(arg1)
    Promise.new(function(callback, callback2)
        coroutine.wrap(function()
            local localPlayer = arg1.props.PlayersService.LocalPlayer
            local success, result = pcall(function()
                return arg1.props.PlayersService:GetFriendsAsync(localPlayer.UserId)
            end)

            if not success then
                callback2("Error loading friends")
                return
            end

            local tbl1 = ({})

            repeat
                for _, value in ipairs(result:GetCurrentPage()) do
                    local num1 = #tbl1 + 1
                    tbl1[num1] = {
                        IsOnline = value.IsOnline,
                        Id = value.Id,
                        Username = value.Username,
                        DisplayName = value.DisplayName,
                        itemRef = nil
                    }
                end

                if result.IsFinished then
                    local var2 = Cryo.List.sort(tbl1, sortFriends)
                    callback(var2)
                    return
                end
            until not pcall(function()
                result:AdvanceToNextPageAsync()
            end)

            callback2("Error loading friends")
        end)()
    end):andThen(function(friends)
        if arg1.mounted then
            arg1:setState({ loadingFriends = false, friends = friends })
        end
    end):catch(function()
        if arg1.mounted then
            arg1:setState({ loadingFriends = false, loadingFriendsError = true })
        end
    end)
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return RoactRodux.connect(function(arg1, _)
    local isMenuOpen

    if arg1.menuPage == "InviteFriends" then
        isMenuOpen = arg1.isMenuOpen

        if isMenuOpen then
            if arg1.displayOptions.inputType == Constants.InputType.Gamepad then
                isMenuOpen = not arg1.respawn.dialogOpen and arg1.currentZone == 1
            else
                isMenuOpen = false
            end
        end
    else
        isMenuOpen = false
    end
    return {
        canCaptureFocus = isMenuOpen,
        menuPage = GetFFlagIGMGamepadSelectionHistory() and arg1.menuPage or nil
    }
end)(var1)
