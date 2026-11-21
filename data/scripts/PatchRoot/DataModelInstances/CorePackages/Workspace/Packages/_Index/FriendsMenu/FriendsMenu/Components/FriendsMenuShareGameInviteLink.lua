-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local React = require(FriendsMenuParent.React)
local Foundation = require(FriendsMenuParent.Foundation)
local useLocalization = require(FriendsMenuParent.Localization).Hooks.useLocalization
local IconSize = Foundation.Enums.IconSize
local useDispatch = require(FriendsMenuParent.RoactUtils).Hooks.RoactRodux.useDispatch
local ReducerDependencies = require(FriendsMenuParent.NotificationsCommon).ReducerDependencies
local ShareLinksNetworking = ReducerDependencies.ShareLinksNetworking
local ShareLinksRodux = ReducerDependencies.ShareLinksRodux

local default = require(FriendsMenuParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local DeviceInfo = require(FriendsMenuParent.NotificationsCommon).DeviceInfo
local Throttle = require(FriendsMenuParent.NotificationsCommon).Throttle
local Popover = Foundation.Popover

local PopoverAlign = Foundation.Enums.PopoverAlign

return function(tbl1)
    local var1 = useDispatch()
    local var2 = DeviceInfo.isDesktopDevice()
    local isOpen, var4 = React.useState(false)
    local function func1()
        if var2 and isOpen then
            return
        end
        var1(ShareLinksNetworking.GenerateLink.API({ linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue() })):andThen(
            function(arg1)
                if arg1 and arg1.responseBody and arg1.responseBody.shortUrl and default then
                    default:shareUrl({ url = arg1.responseBody.shortUrl, context = "V1Menu" })
                end
            end
        ):catch(
            function(arg1)
                warn(arg1)
            end
        )
    end

    local var5 = useLocalization({
        copyLink = if var2 then "Feature.SocialShare.Label.CopyLinkToShareWithPeople" else "Feature.SocialShare.ShareWithPeopleYouKnow",
        copied = "Feature.SocialShare.Label.Copied"
    })

    return React.createElement(Foundation.View, {
        tag = "row size-full-1400 padding-x-xxlarge gap-medium align-y-center",
        LayoutOrder = tbl1.layoutOrder,
        onActivated = Throttle(function()
            func1()
            if var2 then
                var4(true)
                task.delay(2, function()
                    var4(false)
                end)
            end
        end)
    }, {
        PopoverRoot = React.createElement(Popover.Root, { isOpen = isOpen }, {
            ShareIconContainer = React.createElement(
                Foundation.View,
                {
                    tag = "col radius-circle bg-surface-300 align-x-center align-y-center",
                    Size = UDim2.fromOffset(56, 56)
                },
                {
                    ShareIcon = React.createElement(
                        Foundation.Icon,
                        {
                            name = if var2 then "icons/menu/link" else "icons/actions/share",
                            size = IconSize.Medium
                        }
                    )
                }
            ),
            PopoverAnchor = React.createElement(Popover.Anchor, nil, {
                LabelText = React.createElement(
                    Foundation.Text,
                    {
                        tag = "text-title-large size-full align-x-left text-align-x-left",
                        Text = var5.copyLink
                    }
                )
            }),
            Content = React.createElement(
                Popover.Content,
                {
                    tags = "size-full auto-y",
                    hasArrow = false,
                    align = PopoverAlign.End
                },
                {
                    CopiedPopoverText = React.createElement(
                        Foundation.Text,
                        {
                            tag = "auto-xy text-title-small text-align-x-center padding-medium",
                            Text = var5.copied
                        }
                    )
                }
            )
        })
    })
end
