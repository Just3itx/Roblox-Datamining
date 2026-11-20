-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local Modules = game:GetService("CoreGui").RobloxGui.Modules

local Roact = require(CorePackages.Packages.Roact)

local Theme = require(Modules.Settings.Theme)

local ShareGame = Modules.Settings.Pages.ShareGame

local ConversationDetails = require(ShareGame.Components.ConversationDetails)
local ConversationThumbnail = require(ShareGame.Components.ConversationThumbnail)

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local InviteButton = require(ShareGame.Components.InviteButton)

local InviteStatus = require(ShareGame.Constants).InviteStatus

local var1 = Roact.PureComponent:extend("ConversationEntry")

function var1.init(arg1)
    arg1.eventStream = EventStream.new(RbxAnalyticsService)

    function arg1.onInvite()
        local inviteStatus = arg1.props.inviteStatus
        if inviteStatus and inviteStatus ~= InviteStatus.Failed then
            return
        end

        local analytics = arg1.props.analytics
        local users = arg1.props.users
        local inviteUser = arg1.props.inviteUser

        if #users ~= 1 then
            return
        end

        local function func1(arg2)
            if not arg2 then
                return
            end

            local tbl1 = {}
            for _, user in pairs(users) do
                table.insert(tbl1, user.id)
            end

            local localPlayer = Players.LocalPlayer
            analytics:onActivatedInviteSent(localPlayer.UserId, arg2.conversationId, tbl1)
        end

        inviteUser(users[1].id):andThen(func1, function() end)
    end
end

function var1.render(arg1)
    local visible = arg1.props.visible
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local size = arg1.props.size
    local subtitle = arg1.props.subtitle
    local title = arg1.props.title
    local users = arg1.props.users
    local inviteStatus = arg1.props.inviteStatus

    local presence = arg1.props.presence

    return Roact.createElement("ImageButton", {
        Visible = visible,
        Selectable = true,
        BackgroundColor3 = Theme.color("PlayerRowFrame"),
        BackgroundTransparency = Theme.transparency("PlayerRowFrame", 1),
        ImageTransparency = 0,
        ScaleType = Enum.ScaleType.Stretch,
        SliceCenter = Rect.new(),
        Size = size,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        [Roact.Event.Activated] = arg1.onInvite
    }, {
        UICorner = Roact.createElement("UICorner", { CornerRadius = Theme.MenuContainerCornerRadius }) or nil,
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12)
        }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        }),
        Thumbnail = Roact.createElement(
            ConversationThumbnail,
            {
                users = users,
                size = UDim2.new(0, 32, 0, 32),
                layoutOrder = 0,
                zIndex = zIndex
            }
        ),
        Details = Roact.createElement(ConversationDetails, {
            title = title,
            subtitle = subtitle,
            presence = presence,
            size = UDim2.new(1, -125, 1, 0),
            layoutOrder = 1,
            zIndex = zIndex
        }),
        InviteButton = Roact.createElement(InviteButton, {
            size = UDim2.new(0, 69, 1, 0),
            layoutOrder = 2,
            zIndex = zIndex,
            onInvite = arg1.onInvite,
            inviteStatus = inviteStatus
        })
    })
end

return var1
