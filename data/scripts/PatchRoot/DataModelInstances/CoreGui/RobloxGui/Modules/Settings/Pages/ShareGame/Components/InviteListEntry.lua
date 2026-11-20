-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local ShareGame = Modules.Settings.Pages.ShareGame

local OpenTypeSupport = require(CorePackages.Packages.UIBlox).Utility.OpenTypeSupport

local Constants = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants
local Theme = require(Modules.Settings.Theme)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents
local Constants2 = require(ShareGame.Constants)
local PresenceUtil = require(ShareGame.PresenceUtil)
local SingleUserThumbnail = require(ShareGame.Components.SingleUserThumbnail)
local InviteButton = require(ShareGame.Components.InviteButton)
local InviteStatus = Constants2.InviteStatus
local ThrottleFunctionCall = require(ShareGame.ThrottleFunctionCall)

local GetFFlagAbuseReportAnalyticsHasLaunchData = require(Modules.Settings.Flags.GetFFlagAbuseReportAnalyticsHasLaunchData)
local GetFFlagEnableNewInviteSendEndpoint = require(Modules.Flags.GetFFlagEnableNewInviteSendEndpoint)
local GetFFlagThrottleInviteSendEndpoint = require(Modules.Flags.GetFFlagThrottleInviteSendEndpoint)
local GetFIntThrottleInviteSendEndpointDelay = require(Modules.Flags.GetFIntThrottleInviteSendEndpointDelay)

local GetFFlagLuaAppEnableOpenTypeSupport = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local rect = Rect.new(10, 10, 10, 10)

return function(tbl1)
    local user = tbl1.user
    local var1 = React.useCallback(function()
        local inviteUser = tbl1.inviteUser
        local inviteStatus = tbl1.inviteStatus
        local analytics = tbl1.analytics
        if inviteStatus and inviteStatus ~= InviteStatus.Failed then
            return
        end

        local function func1(arg1)
            if not arg1 then
                return
            end

            local tbl2 = { user.id }
            if Players.LocalPlayer and arg1 then
                local localPlayer = Players.LocalPlayer
                analytics:onActivatedInviteSent(localPlayer.UserId, arg1.conversationId, tbl2)
            end
        end

        if not GetFFlagEnableNewInviteSendEndpoint() then
            inviteUser(user.id):andThen(func1, function() end)

            return
        end

        local bool1 = not (tbl1.launchData == nil) and tbl1.launchData ~= ""
        local trigger = tbl1.trigger
        local sendInvite = GameInviteEvents.SendInvite
        local tbl2 = {
            recipient = user.id,
            isLaunchDataProvided = 0
        }

        if not GetFFlagAbuseReportAnalyticsHasLaunchData() then
            bool1 = nil
        end

        tbl2.isLaunchDataProvided = bool1
        analytics:sendEvent(trigger, sendInvite, tbl2)

        inviteUser(user.id, analytics, tbl1.trigger, tbl1.inviteMessageId, tbl1.launchData):andThen(func1, function() end)
    end, {
        tbl1.inviteUser,
        tbl1.inviteStatus,
        tbl1.analytics,
        user
    })

    if GetFFlagThrottleInviteSendEndpoint() then
        var1 = React.useCallback(ThrottleFunctionCall(GetFIntThrottleInviteSendEndpointDelay(), var1), { var1 })
    end

    if not tbl1.visible then
        return
    end

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 60),
        ScaleType = Enum.ScaleType.Stretch,
        SliceCenter = rect,
        BackgroundColor3 = Theme.color("PlayerRowFrame"),
        BackgroundTransparency = Theme.transparency("PlayerRowFrame", 1),
        ImageTransparency = 0.85,
        LayoutOrder = tbl1.layoutOrder,
        [ReactRoblox.Event.Activated] = if tbl1.isFullRowActivatable then var1 else nil
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = Theme.MenuContainerCornerRadius }),
        Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 16), PaddingLeft = UDim.new(0, 8) }),
        Thumbnail = React.createElement(
            SingleUserThumbnail,
            {
                user = user,
                size = UDim2.new(0, 44, 0, 44),
                position = UDim2.new(0, 0, 0.5, 0),
                anchorPoint = Vector2.new(0, 0.5)
            }
        ),
        UserInfo = 0,
        InviteButton = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Position = UDim2.new(0, 44, 0, 0),
        Size = UDim2.new(1, -118, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl5 = {
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 8) }),
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 4)
        }),
        DisplayNameWrapper = React.createElement("Frame", {
            Size = UDim2.new(0, 0, 0, 16),
            BackgroundTransparency = 1
        }, {
            PresenceIconLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }),
            Icon = PresenceUtil.GetIcon(user.presence),
            DisplayName = React.createElement("TextLabel", {
                Size = UDim2.new(0, 0, 0, 16),
                Text = user.displayName,
                TextSize = 16,
                TextColor3 = Constants.COLORS.WHITE,
                Font = AppFonts.default:getMedium(),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 2
            })
        }),
        Username = React.createElement("TextLabel", {
            Size = UDim2.new(0, 0, 0, 16),
            Text = "@" .. user.name,
            TextSize = 16,
            TextColor3 = Constants.COLORS.PUMICE,
            Font = AppFonts.default:getDefault(),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            OpenTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
        })
    }
    tbl3.UserInfo = createElement2(str2, tbl4, tbl5)

    tbl3.InviteButton = React.createElement(InviteButton, {
        size = UDim2.new(0, 66, 0, 36),
        position = UDim2.new(1, 0, 0.5, 0),
        anchorPoint = Vector2.new(1, 0.5),
        onInvite = var1,
        inviteStatus = tbl1.inviteStatus
    })
    return createElement(str1, tbl2, tbl3)
end
