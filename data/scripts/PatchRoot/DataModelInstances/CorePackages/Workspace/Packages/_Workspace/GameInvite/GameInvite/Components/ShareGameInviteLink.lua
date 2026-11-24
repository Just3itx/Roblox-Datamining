-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local UIBlox = require(GameInviteParent.UIBlox)
local RoactUtils = require(GameInviteParent.RoactUtils)
local Throttle = require(GameInviteParent.NotificationsCommon).Throttle
local ReducerDependencies = require(GameInviteParent.NotificationsCommon).ReducerDependencies

local default = require(GameInviteParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local LocalizationHelper = require(GameInviteParent.NotificationsCommon).LocalizationHelper
local GameInviteAnalyticsManager = require(GameInvite.analytics.GameInviteAnalyticsManager)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local RoduxNetworking = ReducerDependencies.RoduxNetworking
local ShareLinksNetworking = ReducerDependencies.ShareLinksNetworking
local ShareLinksRodux = ReducerDependencies.ShareLinksRodux
local NetworkStatus = RoduxNetworking.Enum.NetworkStatus
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

local LinkButton = UIBlox.App.Button.LinkButton
local useStyle = UIBlox.Core.Style.useStyle

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images

game:DefineFastFlag("generateGameInviteShareLinkOnClick", false)

local iconsActionsShare = Images["icons/actions/share"]
local iconsMenuLink = Images["icons/menu/link"]

local tbl1 = {
    copied = "Feature.SocialShare.Label.Copied",
    copyLink = "Feature.SocialShare.Action.CopyLink"
}

return function(tbl2)
    local var1, var2 = React.useState(false)

    local var3 = useSelector(function<T>(arg1: T): T
        return arg1
    end)
    local var4 = useStyle()
    local var5 = useDispatch()
    local localizedStrings = getLocalizedStrings(tbl1)

    local shareInviteLink = var3.ShareLinks.Invites.ShareInviteLink

    local function func1()
        var5(ShareLinksNetworking.GenerateLink.API({ linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue() })):andThen(
            function(arg1)
                local linkId = arg1.responseBody.linkId
                GameInviteAnalyticsManager:linkGenerated(
                    {
                        linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue(),
                        linkId = linkId
                    }
                )

                if game:GetFastFlag("generateGameInviteShareLinkOnClick")
                    and arg1
                    and arg1.responseBody
                    and arg1.responseBody.shortUrl
                    and default
                then
                    default:shareUrl({ url = arg1.responseBody.shortUrl, context = "V1Menu" })
                end
            end
        )
    end

    React.useEffect(function()
        if not (game:GetFastFlag("generateGameInviteShareLinkOnClick") or shareInviteLink) then
            func1()
        end
    end, {})

    local status = ShareLinksNetworking.GenerateLink.getStatus(
        var3,
        {
            linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue()
        }
    )
    local onActivated = Throttle(function()
        local linkId = if shareInviteLink then shareInviteLink.linkId else nil
        GameInviteAnalyticsManager:onShareButtonClick(linkId)
        if shareInviteLink then
            if default then
                default:shareUrl({ url = shareInviteLink.shortUrl, context = "V1Menu" })
            end
        else
            func1()
        end

        if tbl2.isDesktop then
            var2(true)
            task.delay(1, function()
                var2(false)
            end)
        end
    end)

    if not tbl2.isDesktop then
        return React.createElement(ImageSetButton, {
            LayoutOrder = tbl2.layoutOrder,
            BackgroundTransparency = 1,
            Size = tbl2.size,
            [React.Event.Activated] = onActivated,
            Image = iconsActionsShare,
            ImageColor3 = var4.Theme.IconEmphasis.Color,
            ImageTransparency = var4.Theme.IconEmphasis.Transparency,
            BorderSizePixel = 0
        })
    end

    if not tbl2.isFullSize then
        return React.createElement(ImageSetButton, {
            LayoutOrder = tbl2.layoutOrder,
            BackgroundTransparency = 1,
            Size = tbl2.size,
            [React.Event.Activated] = onActivated,
            Image = iconsMenuLink,
            ImageColor3 = var4.Theme.IconEmphasis.Color,
            ImageTransparency = var4.Theme.IconEmphasis.Transparency,
            BorderSizePixel = 0
        })
    end

    return React.createElement(
        "Frame",
        {
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = tbl2.size,
            LayoutOrder = tbl2.layoutOrder
        },
        {
            LinkButton = React.createElement(LinkButton, {
                isDisabled = status == NetworkStatus.Fetching or var1,
                isLoading = false,
                onActivated = onActivated,
                size = tbl2.size,
                text = var1 and localizedStrings.copied or localizedStrings.copyLink
            })
        }
    )
end
