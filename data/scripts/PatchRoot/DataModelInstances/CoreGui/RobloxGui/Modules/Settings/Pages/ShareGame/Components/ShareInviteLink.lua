-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")

local default = require(CorePackages.Workspace.Packages.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local ReducerDependencies = require(CorePackages.Workspace.Packages.NotificationsCommon).ReducerDependencies
local Constants = require(ShareGame.Constants)
local ShareButton = require(ShareGame.Components.ShareButton)
local var1 = require(ShareGame.getTranslator)()
local ShareInviteLinkMapDispatchToProps = require(ShareGame.Components.ShareInviteLinkMapDispatchToProps)
local ShareInviteLinkMapStateToProps = require(ShareGame.Components.ShareInviteLinkMapStateToProps)
local ShareLinksRodux = ReducerDependencies.ShareLinksRodux
local NetworkStatus = ReducerDependencies.RoduxNetworking.Enum.NetworkStatus
local Theme = require(RobloxGui.Modules.Settings.Theme)

local GetFFlagEnableNewInviteMenu = require(RobloxGui.Modules.Flags.GetFFlagEnableNewInviteMenu)

local var2 = Roact.PureComponent:extend("ShareInviteLink")

local Offset = 12
local Offset2 = 8
local xOffset = 69
if GetFFlagEnableNewInviteMenu() then
    Offset = 16
    Offset2 = 12
    xOffset = 66
end

local smokyGrey = Color3.fromRGB(79, 84, 95)
local var3 = var1:FormatByKey("Feature.SocialShare.Action.Share")
local var4 = var1:FormatByKey("Feature.SocialShare.Label.Copied")

local platform = UserInputService:GetPlatform()

var2.defaultProps = {
    externalContentSharingProtocol = default,
    isDesktopClient = platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.UWP
}

function var2.init(arg1)
    arg1.state = { showCopiedText = false }

    function arg1.displayShareSheet(tbl1)
        local props = arg1.props
        if not props.externalContentSharingProtocol then
            return
        end

        props.externalContentSharingProtocol:shareUrl({ url = tbl1.shortUrl, context = "V1Menu" })

        if not props.isDesktopClient then
            return
        end

        arg1:setState({ showCopiedText = true })

        task.delay(1, function()
            arg1:setState({ showCopiedText = false })
        end)
    end
end

function var2.didUpdate(arg1, arg2)
    local props = arg1.props

    if arg2.shareInviteLink ~= nil or arg1.props.shareInviteLink == nil then
        return
    end

    local linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue()
    local linkId = arg1.props.shareInviteLink.linkId

    arg1.props.analytics:linkGenerated({ linkType = linkType, linkId = linkId })

    arg1.displayShareSheet(props.shareInviteLink)
end

function var2.render(arg1)
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local deviceLayout = arg1.props.deviceLayout
    local zIndex = arg1.props.zIndex
    local var5 = Constants.LayoutSpecific[deviceLayout]

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = size,
        Position = arg1.props.position,
        LayoutOrder = layoutOrder,
        BackgroundColor3 = Theme.color("PlayerRowFrame", smokyGrey),
        BackgroundTransparency = Theme.transparency("PlayerRowFrame", 0),
        ZIndex = zIndex,
        BorderSizePixel = 0
    }

    local tbl2 = {
        Corner = Roact.createElement("UICorner", { CornerRadius = Theme.MenuContainerCornerRadius }),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, Offset),
            PaddingRight = UDim.new(0, Offset),
            PaddingTop = UDim.new(0, Offset2),
            PaddingBottom = UDim.new(0, Offset2)
        }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Title = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 0,
            Text = var1:FormatByKey("Feature.SocialShare.Label.ShareServerLink"),
            Size = UDim2.new(1, -xOffset, 1, 0),
            TextSize = Theme.textSize(var5.PAGE_TITLE_TEXT_SIZE, "ShareLinkTitle"),
            TextColor3 = Constants.Color.WHITE,
            Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
        }),
        ShareButton = Roact.createElement(ShareButton, {
            size = UDim2.new(0, xOffset, 1, 0),
            layoutOrder = 1,
            onShare = function()
                local props = arg1.props

                arg1.props.analytics:onShareButtonClick()
                if arg1.props.shareInviteLink == nil then
                    arg1.props.fetchShareInviteLink()
                    return
                end
                arg1.displayShareSheet(props.shareInviteLink)
            end,
            text = if arg1.state.showCopiedText then var4 else var3,
            isEnabled = not (arg1.props.fetchShareInviteLinkNetworkStatus == NetworkStatus.Fetching) and not arg1.state.showCopiedText
        })
    }

    return createElement(str1, tbl1, tbl2)
end

return (RoactRodux.connect(ShareInviteLinkMapStateToProps, ShareInviteLinkMapDispatchToProps)(var2))
