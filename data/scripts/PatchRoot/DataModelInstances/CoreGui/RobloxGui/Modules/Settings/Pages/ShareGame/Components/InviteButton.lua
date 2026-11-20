-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable
local Constants = require(ShareGame.Constants)
local RectangleButton = require(ShareGame.Components.RectangleButton)
local Theme = require(RobloxGui.Modules.Settings.Theme)

local Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
local TextSize = Theme.textSize(19)
local InviteStatus = Constants.InviteStatus

local tbl1 = {
    [InviteStatus.Success] = "Feature.SettingsHub.Label.Invited",
    [InviteStatus.Moderated] = "Feature.SettingsHub.Label.Moderated",
    [InviteStatus.Pending] = "Feature.SettingsHub.Label.Sending"
}

local var3 = require(ShareGame.getTranslator)()

local var4 = Roact.PureComponent:extend("InviteButton")

function var4.render(arg1)
    local anchorPoint = arg1.props.anchorPoint
    local position = arg1.props.position
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local onInvite = arg1.props.onInvite

    local inviteStatus = arg1.props.inviteStatus

    if not inviteStatus or inviteStatus == InviteStatus.Failed then
        local var5 = Immutable.Set(arg1.props, "onClick", function()
            onInvite()
        end)

        return Roact.createElement(RectangleButton, var5, {
            InviteText = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Font = Font,
                Text = var3:FormatByKey("Feature.SettingsHub.Action.InviteFriend"),
                TextSize = TextSize,
                TextColor3 = Constants.Color.WHITE,
                ZIndex = zIndex
            })
        })
    end
    local var5 = tbl1[inviteStatus] or "Feature.SettingsHub.Label.Moderated"

    return Roact.createElement("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = anchorPoint,
        Position = position,
        Size = size,
        Font = Font,
        Text = var3:FormatByKey(var5),
        TextSize = TextSize,
        TextColor3 = Constants.Color.WHITE,
        TextXAlignment = Enum.TextXAlignment.Center,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex
    })
end

return var4
