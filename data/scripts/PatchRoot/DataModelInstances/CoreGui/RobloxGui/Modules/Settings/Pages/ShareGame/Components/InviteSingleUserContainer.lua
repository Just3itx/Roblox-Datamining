-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Modules = CoreGui.RobloxGui.Modules
local renderWithCoreScriptsStyleProvider = require(Modules.Common.renderWithCoreScriptsStyleProvider)
local ShareGame = Modules.Settings.Pages.ShareGame
local COLORS = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants.COLORS
local Constants = require(ShareGame.Constants)
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents
local InviteStatus = Constants.InviteStatus
local var1 = require(ShareGame.getTranslator)()

local httpRequest = require(Modules.Common.httpRequest)

local InviteUserIdToPlaceId = require(ShareGame.Thunks.InviteUserIdToPlaceId)
local RetrievalStatus = require(CorePackages.Workspace.Packages.Http).Enum.RetrievalStatus
local InviteUserIdToPlaceIdCustomized = require(ShareGame.Thunks.InviteUserIdToPlaceIdCustomized)
local ThrottleFunctionCall = require(ShareGame.ThrottleFunctionCall)

local SingleUserThumbnail = require(ShareGame.Components.SingleUserThumbnail)

local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local UserProfileStore = require(CorePackages.Workspace.Packages.UserProfiles).Stores.UserProfileStore

local LoadingModal = require(ShareGame.Components.LoadingModal)

local GetFFlagAbuseReportAnalyticsHasLaunchData = require(Modules.Settings.Flags.GetFFlagAbuseReportAnalyticsHasLaunchData)
local GetFFlagEnableNewInviteSendEndpoint = require(Modules.Flags.GetFFlagEnableNewInviteSendEndpoint)

local FFlagFixPromptGameInviteUIMissingDisplayName = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFixPromptGameInviteUIMissingDisplayName
local GetFFlagThrottleInviteSendEndpoint = require(Modules.Flags.GetFFlagThrottleInviteSendEndpoint)
local GetFIntThrottleInviteSendEndpointDelay = require(Modules.Flags.GetFIntThrottleInviteSendEndpointDelay)
local GetFFlagSingleUserInvitePageKeybind = require(Modules.Settings.Flags.GetFFlagSingleUserInvitePageKeybind)

local UIBlox = require(CorePackages.Packages.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local useStyle = UIBlox.Core.Style.useStyle

local black = Color3.fromRGB(41, 41, 41)

local function func1(arg1)
    local user = arg1.friends[tostring(arg1.inviteUserId)]
    local var2 = user and arg1.invites[user.id]

    local var3 = useStyle()
    local var4, var5 = React.useState(false)

    local var6 = if FFlagFixPromptGameInviteUIMissingDisplayName then React.useMemo(function()
        return UserProfileStore.get().fetchNamesByUserIds({ tostring(arg1.inviteUserId) })
    end, { arg1.inviteUserId }) else nil

    local var7 = if FFlagFixPromptGameInviteUIMissingDisplayName then React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var7 = var6(arg2)
            local var8 = var7 and var7.data and var7.data[1]
            local names = var8 and var8.names
            local var9

            if names then
                var9 = names.getCombinedName(arg2)
                if var9 == "" then
                    var9 = names.getUsername(arg2)
                end
            else
                var9 = ""
            end

            return {
                name = var9,
                isFetching = var7 == nil or var7.status == "fetching"
            }
        end)
    end, { var6 }) else nil

    local var8 = if FFlagFixPromptGameInviteUIMissingDisplayName then SignalsReact.useSignalState(var7) else nil

    React.useEffect(function()
        if arg1.promptMessage and arg1.analytics then
            arg1.analytics:sendEvent(Constants.Triggers.DeveloperSingle, GameInviteEvents.CustomTextShown)
        end
    end, {})

    local var9 = React.useCallback(function()
        arg1.closePage()
        if arg1.onAfterClosePage then
            arg1.onAfterClosePage()
        end
    end, { arg1.closePage, arg1.onAfterClosePage })

    local onActivated = React.useCallback(function()
        arg1.analytics:sendEvent(Constants.Triggers.DeveloperSingle, GameInviteEvents.CancelInvite)
        var9()
    end, { var9 })

    local var11 = React.useCallback(function()
        var5(true)
        local inviteUser = arg1.inviteUser
        local analytics = arg1.analytics
        if var2 and var2 ~= InviteStatus.Failed then
            return
        end

        local bool1 = not (arg1.launchData == nil) and arg1.launchData ~= ""
        local developerSingle = Constants.Triggers.DeveloperSingle
        local sendInvite = GameInviteEvents.SendInvite
        local tbl1 = {
            recipient = user.id,
            isLaunchDataProvided = 0
        }

        if not GetFFlagAbuseReportAnalyticsHasLaunchData() then
            bool1 = nil
        end

        tbl1.isLaunchDataProvided = bool1
        analytics:sendEvent(developerSingle, sendInvite, tbl1)

        local function func1(arg2)
            var5(false)
            if not arg2 then
                return
            end

            local tbl2 = { user.id }
            if Players.LocalPlayer and arg2.conversationId then
                local localPlayer = Players.LocalPlayer
                analytics:onActivatedInviteSent(localPlayer.UserId, arg2.conversationId, tbl2)
            end

            var9()
        end

        local id = user.id
        inviteUser(tostring(id), analytics, arg1.inviteMessageId, arg1.launchData):andThen(func1, var9)
    end, {
        arg1.inviteUser,
        arg1.inviteMessageId,
        arg1.launchData,
        arg1.analytics,
        var5,
        var2,
        user,
        var9
    })

    if GetFFlagSingleUserInvitePageKeybind() then
        React.useEffect(function()
            if not arg1.isVisible then
                return nil
            end

            ContextActionService:BindCoreAction("ProductPurchaseConfirmButtonBind", function(_, userInputState, _)
                if userInputState == Enum.UserInputState.Begin then
                    var11()
                end
            end, false, Enum.KeyCode.ButtonA)
            ContextActionService:BindCoreAction("ProductPurchaseCancelButtonBind", function(_, userInputState, _)
                if userInputState == Enum.UserInputState.Begin then
                    onActivated()
                end
            end, false, Enum.KeyCode.ButtonB)
            return function()
                ContextActionService:UnbindCoreAction("ProductPurchaseConfirmButtonBind")
                ContextActionService:UnbindCoreAction("ProductPurchaseCancelButtonBind")
            end
        end, { arg1.isVisible, var11, onActivated })
    end

    if GetFFlagThrottleInviteSendEndpoint() then
        var11 = React.useCallback(ThrottleFunctionCall(GetFIntThrottleInviteSendEndpointDelay(), var11), { var11 })
    end

    if not user then
        if arg1.friendsRetrievalStatus == RetrievalStatus.Done or arg1.friendsRetrievalStatus == RetrievalStatus.Failed then
            var9()
        end

        return
    end

    if FFlagFixPromptGameInviteUIMissingDisplayName and var8.name == "" and var8.isFetching then
        return React.createElement(LoadingModal)
    end

    local displayName = if FFlagFixPromptGameInviteUIMissingDisplayName then if var8.name ~= "" then var8.name else user.displayName or "" else user.displayName
    local isDisabled = var2 and var2 ~= InviteStatus.Failed
    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundColor3 = black,
        BackgroundTransparency = 0.1
    }, {
        SizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(442, math.huge), MinSize = Vector2.new(0, 0) }),
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, 24),
                PaddingRight = UDim.new(0, 24),
                PaddingBottom = UDim.new(0, 24)
            }
        ),
        Header = React.createElement(StyledTextLabel, {
            fontStyle = var3.Font.Header1,
            colorStyle = var3.Theme.TextEmphasis,
            text = var1:FormatByKey("Feature.SettingsHub.Heading.InviteUser", { DisplayName = displayName }),
            size = UDim2.new(1, 0, 0, 48),
            textXAlignment = Enum.TextXAlignment.Center
        }),
        Divider = React.createElement("Frame", {
            Position = UDim2.new(0, 0, 0, 48),
            Size = UDim2.new(1, 0, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = COLORS.GRAPHITE
        }),
        Wrapper = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, 0, 0, 56),
            BackgroundTransparency = 1
        }, {
            ListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 24)
            }),
            Thumbnail = React.createElement(
                SingleUserThumbnail,
                {
                    user = user,
                    size = UDim2.new(0, 95, 0, 95),
                    layoutOrder = 1,
                    square = true,
                    backgroundTransparency = 1
                }
            ),
            TextBody = React.createElement(StyledTextLabel, {
                fontStyle = var3.Font.Header2,
                colorStyle = var3.Theme.TextEmphasis,
                text = arg1.promptMessage or var1:FormatByKey("Feature.SettingsHub.Label.DefaultInviteMessage", { DisplayName = displayName }),
                textXAlignment = Enum.TextXAlignment.Center,
                automaticSize = Enum.AutomaticSize.Y,
                size = UDim2.new(1, 0, 0, 0),
                layoutOrder = 2
            }),
            ButtonWrapper = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 48),
                    LayoutOrder = 3,
                    BackgroundTransparency = 1
                },
                {
                    CancelButton = React.createElement(Button, {
                        buttonType = ButtonType.Secondary,
                        size = UDim2.new(0.5, -12, 1, 0),
                        text = var1:FormatByKey("Feature.SettingsHub.Action.Cancel"),
                        onActivated = onActivated,
                        isDisabled = var4
                    }),
                    InviteButton = React.createElement(Button, {
                        buttonType = ButtonType.PrimarySystem,
                        size = UDim2.new(0.5, -12, 1, 0),
                        position = UDim2.new(0.5, 12, 0, 0),
                        text = var1:FormatByKey(if isDisabled then "Feature.SettingsHub.Label.Invited" else "Feature.SettingsHub.Action.InviteFriend"),
                        onActivated = var11,
                        isLoading = var4,
                        isDisabled = isDisabled
                    })
                }
            )
        })
    })
end
return RoactRodux.connect(function(arg1)
    local tbl1 = {
        friends = arg1.Users,
        friendsRetrievalStatus = Players.LocalPlayer and arg1.Friends.retrievalStatus[tostring(Players.LocalPlayer.UserId)],
        invites = arg1.Invites
    }
    return tbl1
end, function(func2: (...any) -> (...any))
    return {
        inviteUser = function(str1: string, arg1, str2: string?, str3: string?)
            local var2 = httpRequest(HttpRbxApiService)
            local str4 = tostring(game.PlaceId)

            if GetFFlagEnableNewInviteSendEndpoint() then
                return func2(InviteUserIdToPlaceIdCustomized(var2, str1, str4, arg1, Constants.Triggers.DeveloperSingle, str2, str3))
            end

            return func2(InviteUserIdToPlaceId(var2, str1, str4))
        end
    }
end)(function(arg1)
    return renderWithCoreScriptsStyleProvider({ SingleUserInvite = React.createElement(func1, arg1) })
end)
