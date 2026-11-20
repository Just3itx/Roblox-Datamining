-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local RobloxGui = CoreGui:WaitForChild("RobloxGui", math.huge)

local Constants = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants
local Modules = CoreGui.RobloxGui.Modules
local ShareGame = Modules.Settings.Pages.ShareGame
local Promise = require(CorePackages.Packages.Promise)
local Utility = require(RobloxGui.Modules.Settings.Utility)

local GetFFlagEnableNewInviteMenu = require(Modules.Flags.GetFFlagEnableNewInviteMenu)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local RoactAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).RoactAppPolicy

local httpRequest = require(Modules.Common.httpRequest)

local Header = require(ShareGame.Components.Header)
local ConversationList = require(ShareGame.Components.ConversationList)
local Constants2 = require(ShareGame.Constants)
local ShareInviteLink = require(ShareGame.Components.ShareInviteLink)
local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription

local BackButton = require(ShareGame.Components.BackButton)

local SetGameInfoCreated = require(ShareGame.Actions.SetGameInfoCreated)

local num1 = 10
local yOffset = 44
if GetFFlagEnableNewInviteMenu() then
    num1 = 16
    yOffset = 52
end

local var1 = Roact.PureComponent:extend("ShareGamePageFrame")

local ErrorToaster = require(ShareGame.Components.ErrorToaster)

function var1.init(arg1)
    arg1.state = { serverType = nil }
end

function var1.shouldShowInviteLink(arg1, arg2): boolean
    return not not (arg1.props.experienceInviteShareLinkEnabled
        and arg1.state.serverType == Constants.STANDARD_SERVER
        and Utility:IsExperienceOlderThanOneWeek(arg2))
end

function var1.didMount(arg1)
    arg1.props.fetchGameInfo()
    if arg1.state.serverType ~= nil then
        return
    end

    Promise.try(function()
        return RobloxReplicatedStorage:WaitForChild("GetServerType", math.huge):InvokeServer()
    end):andThen(function(serverType)
        arg1:setState({ serverType = serverType })
    end)
end

function var1.render(arg1)
    local analytics = arg1.props.analytics
    local deviceLayout = arg1.props.deviceLayout
    local zIndex = arg1.props.zIndex
    local closePage = arg1.props.closePage
    local searchAreaActive = arg1.props.searchAreaActive
    local searchText = arg1.props.searchText

    local var2 = Constants2.LayoutSpecific[deviceLayout]
    local headerHeight = var2.HEADER_HEIGHT
    local bool1 = deviceLayout == Constants2.DeviceLayout.DESKTOP
    local iconType = not bool1 and BackButton.IconType.Arrow or BackButton.IconType.None
    local toggleSearchIcon = not bool1

    local isVisible = arg1.props.isVisible
    local var4 = arg1:shouldShowInviteLink(arg1.props.gameInfo)
    local num2 = 0
    local yOffset2

    if var4 then
        num2 -= yOffset
        yOffset2 = 10
    else
        yOffset2 = 0
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        ZIndex = zIndex,
        AutoLocalize = false
    }, {
        toasterPortal = Roact.createElement(Roact.Portal, { target = CoreGui }, { Toaster = Roact.createElement(ErrorToaster) }),
        Header = Roact.createElement(Header, {
            deviceLayout = deviceLayout,
            size = UDim2.new(1, 0, 0, headerHeight),
            position = UDim2.new(0, 0, 0, -headerHeight),
            layoutOrder = 0,
            zIndex = zIndex,
            closePage = closePage,
            searchAreaActive = searchAreaActive,
            toggleSearchIcon = toggleSearchIcon,
            iconType = iconType,
            analytics = analytics
        }),
        ShareInviteLink = if var4 then Roact.createElement(ShareInviteLink, {
            position = UDim2.new(0, 0, 0, yOffset2),
            analytics = analytics,
            deviceLayout = deviceLayout,
            size = UDim2.new(1, 0, 0, yOffset),
            layoutOrder = 1,
            zIndex = zIndex
        })
            or nil else nil,
        ConversationList = Roact.createElement(ConversationList, {
            analytics = analytics,
            size = UDim2.new(1, 0, 1, var2.EXTEND_BOTTOM_SIZE - num1 + num2),
            topPadding = var4 and num1 + yOffset + yOffset2 or num1,
            layoutOrder = if var4 then 2 else 1,
            zIndex = zIndex,
            searchText = searchText,
            isVisible = isVisible,
            trigger = "GameMenu"
        })
    })
end

local var2 = RoactRodux.connect(function(arg1)
    return {
        gameInfo = arg1.GameInfo
    }
end, function(callback)
    return {
        fetchGameInfo = function()
            local var2 = httpRequest(HttpRbxApiService)
            GetGameNameAndDescription(var2, game.GameId):andThen(function(arg1)
                callback(SetGameInfoCreated(arg1.Created))
            end)
        end
    }
end)(var1)

return (RoactAppPolicy.connect(function(arg1)
    return {
        experienceInviteShareLinkEnabled = arg1.getExperienceInviteShareLinkEnabled()
    }
end)(var2))
