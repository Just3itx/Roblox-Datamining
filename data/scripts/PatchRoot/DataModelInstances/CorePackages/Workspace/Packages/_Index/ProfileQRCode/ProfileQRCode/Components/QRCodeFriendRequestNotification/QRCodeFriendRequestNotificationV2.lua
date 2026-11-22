-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local React = require(ProfileQRCodeParent.React)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local Foundation = require(ProfileQRCodeParent.Foundation)
local Localization = require(ProfileQRCodeParent.Localization)
local UserTile = require(ProfileQRCodeParent.UserTile).UserTile
local LayoutMode = require(ProfileQRCodeParent.UserTile).LayoutMode

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle

local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local TextKeys = require(ProfileQRCode.Common.TextKeys)
local useLocalization = Localization.Hooks.useLocalization
local useLocalUserInfo = require(ProfileQRCode.Utils.useLocalUserInfo)
local useCombinedUserName = require(ProfileQRCode.Utils.useCombinedUserName)
local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local EventNames = require(ProfileQRCode.Analytics.EventNames)
local useTokens = Foundation.Hooks.useTokens

local FFlagProfileQrCodeDeprecateUserRedux = require(ProfileQRCode.Flags.FFlagProfileQrCodeDeprecateUserRedux)

return function(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({
        notificationRequest = TextKeys.NotificationRequestText,
        accept = "CommonUI.Controls.Action.Accept",
        dismiss = "CommonUI.Messages.Action.Dismiss"
    })

    local var3 = useStyle()
    local var4 = useLocalUserInfo(tbl1.userId)
    local var5 = useCombinedUserName(tbl1.userId)
    local text = if var5 ~= "" then var5 .. " @" .. (var4.username or (if FFlagProfileQrCodeDeprecateUserRedux then "" else nil)) elseif var4 then var4.displayName or var4.username or "" else ""
    local var7 = useAnalytics()

    local isDisabled, var9 = React.useState(false)

    React.useEffect(function()
        var9(false)
    end, { tbl1.userId })

    React.useEffect(function()
        var7.fireEvent(EventNames.QRPageFriendRequestBannerShown, { qrCodeBannerQueueSize = tbl1.notificationQueueSize })
    end, { tbl1.userId, var7.fireEvent, tbl1.notificationQueueSize })

    return React.createElement(View, {
        ZIndex = 2,
        tag = "col gap-medium size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium bg-surface-0",
        sizeConstraint = {
            MaxSize = Vector2.new(640, math.huge),
            MinSize = Vector2.new(0, 0)
        }
    }, {
        HeaderRow = React.createElement(View, {
            tag = "row align-y-top gap-medium size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            AvatarSlot = React.createElement(View, { tag = "no-flex auto-xy", LayoutOrder = 1 }, {
                UserTile = React.createElement(UserTile, {
                    userId = tbl1.userId,
                    layoutMode = LayoutMode.compact,
                    userPresenceType = Foundation.Enums.UserPresence.None,
                    avatarSize = UDim2.new(0, var1.Size.Size_1000, 0, var1.Size.Size_1000)
                })
            }),
            ContentColumn = React.createElement(View, {
                tag = "col fill gap-xsmall auto-y",
                LayoutOrder = 2
            }, {
                Username = React.createElement(StyledTextLabel, {
                    layoutOrder = 1,
                    text = text,
                    fontStyle = var3.Font.Header2,
                    colorStyle = var3.Theme.TextDefault,
                    size = UDim2.new(1, 0, 0, var1.Size.Size_500),
                    automaticSize = Enum.AutomaticSize.Y,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Center,
                    textWrapped = true
                }),
                Description = React.createElement(StyledTextLabel, {
                    layoutOrder = 2,
                    text = var2.notificationRequest,
                    fontStyle = var3.Font.Body,
                    colorStyle = var3.Theme.TextDefault,
                    size = UDim2.new(1, 0, 0, var1.Size.Size_700),
                    automaticSize = Enum.AutomaticSize.Y,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Center,
                    textWrapped = true,
                    lineHeight = 1
                }),
                ButtonRow = React.createElement(
                    View,
                    { tag = "row gap-small size-full-0 auto-y padding-top-large", LayoutOrder = 3 },
                    {
                        AcceptSlot = React.createElement(View, {
                            tag = "fill auto-xy",
                            LayoutOrder = 1
                        }, {
                            AcceptButton = React.createElement(Button, {
                                text = var2.accept,
                                variant = ButtonVariant.Emphasis,
                                size = InputSize.Small,
                                fillBehavior = FillBehavior.Fill,
                                isDisabled = isDisabled,
                                onActivated = function()
                                    var9(true)
                                    tbl1.onAccept(tbl1.userId)
                                end
                            })
                        }),
                        DismissSlot = React.createElement(View, {
                            tag = "fill auto-xy",
                            LayoutOrder = 2
                        }, {
                            DismissButton = React.createElement(Button, {
                                text = var2.dismiss,
                                variant = ButtonVariant.Standard,
                                size = InputSize.Small,
                                fillBehavior = FillBehavior.Fill,
                                onActivated = tbl1.onClose
                            })
                        })
                    }
                )
            })
        })
    })
end
