-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local sortFriendsByCorrectedPresenceAndRank = require(CorePackages.Packages.LuaSocialLibrariesDeps).SocialLibraries.config({}).User.sortFriendsByCorrectedPresenceAndRank

local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Modules = CoreGui.RobloxGui.Modules
local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local Theme = require(Modules.Settings.Theme)
local Constants = require(ShareGame.Constants)
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents
local ConversationEntry = require(ShareGame.Components.ConversationEntry)
local InviteListEntry = require(ShareGame.Components.InviteListEntry)
local FriendsErrorPage = require(ShareGame.Components.FriendsErrorPage)
local InviteUserIdToPlaceId = require(ShareGame.Thunks.InviteUserIdToPlaceId)
local InviteUserIdToPlaceIdCustomized = require(ShareGame.Thunks.InviteUserIdToPlaceIdCustomized)
local NewInviteMenuExperimentManager = require(ShareGame.NewInviteMenuExperimentManager)
local LoadingFriendsPage = require(ShareGame.Components.LoadingFriendsPage)
local NoFriendsPage = require(ShareGame.Components.NoFriendsPage)
local PlayerSearchPredicate = require(CoreGui.RobloxGui.Modules.InGameMenu.Utility.PlayerSearchPredicate)

local GetFFlagAbuseReportAnalyticsHasLaunchData = require(Modules.Settings.Flags.GetFFlagAbuseReportAnalyticsHasLaunchData)
local GetFFlagEnableNewInviteMenu = require(Modules.Flags.GetFFlagEnableNewInviteMenu)
local GetFFlagEnableNewInviteSendEndpoint = require(Modules.Flags.GetFFlagEnableNewInviteSendEndpoint)

local UserModel = require(CorePackages.Workspace.Packages.UserLib).Models.UserModel

local httpRequest = require(Modules.Common.httpRequest)

local memoize = require(CorePackages.Workspace.Packages.AppCommonLib).memoize

local RetrievalStatus = require(CorePackages.Workspace.Packages.Http).Enum.RetrievalStatus

local GetFFlagInviteListRerank = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagInviteListRerank

local var1 = require(ShareGame.getTranslator)()

local Font = Theme.font(Enum.Font.SourceSans)
local GRAY3 = Constants.Color.GRAY3
local TextSize = Theme.textSize(19)

local tbl1 = {
    [UserModel.PresenceType.ONLINE] = 3,
    [UserModel.PresenceType.IN_GAME] = 2,
    [UserModel.PresenceType.IN_STUDIO] = 1,
    [UserModel.PresenceType.OFFLINE] = 0
}

local tbl2 = { SORT_BY_FREQUENCY = 1, SORT_BY_PRESENCE_AND_FREQUENCY = 2 }

local var4 = Roact.PureComponent:extend("ConversationList")
var4.defaultProps = { entryHeight = 62, entryPadding = 16 }

function var4.init(arg1)
    arg1.scrollingRef = Roact.createRef()
    function arg1.inviteUser(str1: string)
        return arg1.props.inviteUser(str1, arg1.props.analytics, arg1.props.trigger, arg1.props.inviteMessageId, arg1.props.launchData)
    end
end

function var4.render(arg1)
    local analytics = arg1.props.analytics
    local prop = arg1.props[Roact.Children] or {}

    local entryHeight = arg1.props.entryHeight
    local entryPadding = arg1.props.entryPadding

    local friends = arg1.props.friends
    local friendsRetrievalStatus = arg1.props.friendsRetrievalStatus
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size
    local zIndex = arg1.props.zIndex
    local topPadding = arg1.props.topPadding

    local invites = arg1.props.invites
    local inviteUser = arg1.props.inviteUser
    local searchText = arg1.props.searchText

    if GetFFlagEnableNewInviteSendEndpoint() then
        inviteUser = arg1.inviteUser
    end

    local fFlagEnableNewInviteMenu = GetFFlagEnableNewInviteMenu()

    prop.RowListLayout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, entryPadding)
    })

    local num1 = 0

    for i, user in ipairs(friends) do
        local visible = PlayerSearchPredicate(searchText, user.name, user.displayName)

        if fFlagEnableNewInviteMenu then
            local str1 = "User-" .. tostring(i)
            prop[str1] = Roact.createElement(InviteListEntry, {
                analytics = analytics,
                user = user,
                visible = visible,
                layoutOrder = i,
                inviteUser = inviteUser,
                inviteStatus = invites[user.id],
                isFullRowActivatable = UserInputService.GamepadEnabled,
                trigger = arg1.props.trigger,
                inviteMessageId = arg1.props.inviteMessageId,
                launchData = arg1.props.launchData
            })
        else
            local str1 = "User-" .. tostring(i)
            prop[str1] = Roact.createElement(ConversationEntry, {
                analytics = analytics,
                visible = visible,
                size = UDim2.new(1, 0, 0, entryHeight),
                layoutOrder = i,
                zIndex = zIndex,
                title = user.displayName,
                subtitle = "@" .. user.name,
                presence = user.presence,
                users = { user },
                inviteUser = inviteUser,
                inviteStatus = invites[user.id]
            })
        end

        if visible then
            num1 += 1
        end
    end

    if #friends == 0 or friendsRetrievalStatus == RetrievalStatus.Fetching then
        local var5 = LoadingFriendsPage

        if friendsRetrievalStatus == RetrievalStatus.Done then
            var5 = NoFriendsPage
        elseif friendsRetrievalStatus == RetrievalStatus.Failed then
            var5 = FriendsErrorPage
        end

        return Roact.createElement(
            var5,
            {
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder,
                Position = UDim2.new(0, 0, 0, topPadding),
                ZIndex = zIndex
            }
        )
    end

    if num1 == 0 then
        return Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            Font = Font,
            Size = UDim2.new(1, 0, 0, entryHeight),
            Text = var1:FormatByKey("Feature.SettingsHub.Label.InviteSearchNoResults"),
            TextColor3 = GRAY3,
            TextSize = TextSize,
            TextTransparency = 0.22,
            ZIndex = zIndex,
            Position = UDim2.new(0, 0, 0, topPadding)
        })
    end

    return Roact.createElement("ScrollingFrame", {
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        Size = size,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, topPadding),
        CanvasSize = if fFlagEnableNewInviteMenu then UDim2.new() else UDim2.new(0, 0, 0, num1 * (entryHeight + entryPadding)),
        AutomaticCanvasSize = if fFlagEnableNewInviteMenu then Enum.AutomaticSize.Y else nil,
        ScrollBarThickness = 0,
        ZIndex = zIndex,
        Selectable = false,
        [Roact.Ref] = arg1.scrollingRef
    }, prop)
end

local function handleBinding(arg1)
    if GetFFlagEnableNewInviteMenu() and not UserInputService.GamepadEnabled then
        return
    end

    local value = arg1.scrollingRef:getValue()
    if not value or not value:FindFirstAncestorOfClass("ScreenGui").Enabled or GuiService.SelectedCoreObject ~= nil then
        return
    end

    GuiService:AddSelectionParent("invitePrompt", value)
    for _, selectedCoreObject in ipairs(value:GetChildren()) do
        if selectedCoreObject:IsA("GuiObject") and selectedCoreObject.LayoutOrder == 1 then
            GuiService.SelectedCoreObject = selectedCoreObject
            return
        end
    end
end

var4.didUpdate = handleBinding

if GetFFlagEnableNewInviteSendEndpoint() then
    function var4.didMount(arg1)
        if arg1.props.analytics and arg1.props.trigger == Constants.Triggers.GameMenu then
            local isLaunchDataProvided = not (arg1.props.launchData == nil) and arg1.props.launchData ~= ""
            arg1.props.analytics:sendEvent(
                arg1.props.trigger,
                GameInviteEvents.ModalOpened,
                GetFFlagAbuseReportAnalyticsHasLaunchData() and {
                    isLaunchDataProvided = isLaunchDataProvided
                } or nil
            )
        end

        handleBinding(arg1)
    end
else
    var4.didMount = handleBinding
end

local var5 = memoize(function(arg1)
    local result = {}
    local function friendPreference(arg2, arg3): boolean
        local var5 = tbl1[arg2.presence]
        local var6 = tbl1[arg3.presence]

        if var5 == var6 then
            return arg2.name:lower() < arg3.name:lower()
        end

        return var6 < var5
    end

    for _, value in pairs(arg1) do
        if value.isFriend then
            result[#result + 1] = value
        end
    end

    table.sort(result, friendPreference)

    return result
end)

local var6 = memoize(function(arg1)
    local result = {}
    for _, value in pairs(arg1) do
        if value.isFriend then
            result[#result + 1] = value
        end
    end

    table.sort(result, sortFriendsByCorrectedPresenceAndRank)

    return result
end)

local var7 = memoize(function(arg1)
    local result = {}
    local function friendPreference(arg2, arg3): boolean
        local num1 = tonumber(arg2.friendFrequentRank) or 0
        local num2 = tonumber(arg3.friendFrequentRank) or 0

        if num1 == num2 then
            return arg2.name:lower() < arg3.name:lower()
        end

        return num1 < num2
    end

    for _, value in pairs(arg1) do
        if value.isFriend then
            result[#result + 1] = value
        end
    end

    table.sort(result, friendPreference)

    return result
end)

local function _() -- Luacid: unused: defined but never referenced
    local inviteListSortOrder = NewInviteMenuExperimentManager.default:getInviteListSortOrder() or 0

    return if inviteListSortOrder == 1 then var7 elseif inviteListSortOrder == 2 then var6 else var5
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local var8 = var5

    if GetFFlagInviteListRerank() then
        local inviteListSortOrder = NewInviteMenuExperimentManager.default:getInviteListSortOrder() or 0

        if inviteListSortOrder == tbl2.SORT_BY_FREQUENCY then
            var8 = var7
        elseif inviteListSortOrder == tbl2.SORT_BY_PRESENCE_AND_FREQUENCY then
            var8 = var6
        else
            var8 = var5
        end
    end

    return {
        friends = var8(arg1.Users),
        friendsRetrievalStatus = arg1.Friends.retrievalStatus[tostring(Players.LocalPlayer.UserId)],
        invites = arg1.Invites
    }
end, function(arg1)
    return {
        inviteUser = function(str1: string, arg2, str2: string, str3: string?, str4: string?)
            local var8 = httpRequest(HttpRbxApiService)
            local str5 = tostring(game.PlaceId)

            if GetFFlagEnableNewInviteSendEndpoint() then
                return arg1(InviteUserIdToPlaceIdCustomized(var8, str1, str5, arg2, str2, str3, str4))
            end

            return arg1(InviteUserIdToPlaceId(var8, str1, str5))
        end
    }
end)(var4)
