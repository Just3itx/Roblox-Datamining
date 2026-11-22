-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local React = require(ProfileQRCodeParent.React)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle
local TextKeys = require(ProfileQRCode.Common.TextKeys)
local useLocalization = require(ProfileQRCodeParent.Localization).Hooks.useLocalization
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local useLocalUserInfo = require(ProfileQRCode.Utils.useLocalUserInfo)
local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local EventNames = require(ProfileQRCode.Analytics.EventNames)

local iconsMenuScanqr = Images["icons/menu/scanqr"]
local iconsNavigationClose = Images["icons/navigation/close"]

return function(tbl1)
    local var1 = useLocalization({ notificationRequest = TextKeys.NotificationRequestText, acceptFriend = TextKeys.AcceptFriend })

    local var2 = useStyle()
    local var3 = useLocalUserInfo(tbl1.userId)
    local var4 = useAnalytics()

    local isDisabled, var6 = React.useState(false)

    React.useEffect(function()
        var4.fireEvent(EventNames.QRPageFriendRequestBannerShown, { qrCodeBannerQueueSize = tbl1.notificationQueueSize })
    end, { tbl1.userId })

    return React.createElement("Frame", {
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = var2.Theme.BackgroundUIDefault.Color,
        BackgroundTransparency = var2.Theme.BackgroundUIDefault.Transparency
    }, {
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingTop = UDim.new(0, 12)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        UIStroke = React.createElement(
            "UIStroke",
            {
                Color = var2.Theme.Divider.Color,
                Transparency = var2.Theme.Divider.Transparency,
                Thickness = 1
            }
        ),
        Layout = React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        ),
        UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(640, math.huge) }),
        UpperFrame = React.createElement("Frame", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BorderSizePixel = 0
        }, {
            UIPadding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 12) }),
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            QRCodeImageFrame = React.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 40, 0, 40),
                    BorderSizePixel = 0
                },
                {
                    QRImage = React.createElement(ImageSetLabel, {
                        Image = iconsMenuScanqr,
                        BackgroundTransparency = 1,
                        ImageTransparency = 0,
                        ImageColor3 = var2.Theme.TextEmphasis.Color,
                        Size = UDim2.new(0, 40, 0, 40)
                    })
                }
            ),
            TextFrame = React.createElement(
                "Frame",
                {
                    LayoutOrder = 2,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -72, 0, 0),
                    BorderSizePixel = 0
                },
                {
                    UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16) }),
                    Layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                    Username = React.createElement(StyledTextLabel, {
                        layoutOrder = 1,
                        text = var3.displayName,
                        fontStyle = var2.Font.Header2,
                        colorStyle = var2.Theme.TextDefault,
                        size = UDim2.new(1, 0, 0, 20),
                        automaticSize = Enum.AutomaticSize.Y,
                        textXAlignment = Enum.TextXAlignment.Left,
                        textYAlignment = Enum.TextYAlignment.Center,
                        textWrapped = true
                    }),
                    Spacer1 = React.createElement(
                        "Frame",
                        {
                            BorderSizePixel = 0,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 5),
                            LayoutOrder = 2
                        }
                    ),
                    Description = React.createElement(StyledTextLabel, {
                        layoutOrder = 3,
                        text = var1.notificationRequest,
                        fontStyle = var2.Font.Body,
                        colorStyle = var2.Theme.TextDefault,
                        size = UDim2.new(1, 0, 0, 28),
                        automaticSize = Enum.AutomaticSize.Y,
                        textXAlignment = Enum.TextXAlignment.Left,
                        textYAlignment = Enum.TextYAlignment.Center,
                        textWrapped = true,
                        lineHeight = 1
                    })
                }
            ),
            CloseButtonFrame = React.createElement(
                "Frame",
                {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 32, 0, 32),
                    BorderSizePixel = 0
                },
                {
                    CloseButton = React.createElement(IconButton, {
                        icon = iconsNavigationClose,
                        iconSize = IconSize.Medium,
                        onActivated = tbl1.onClose,
                        anchorPoint = Vector2.new(0.13, 0.13)
                    })
                }
            )
        }),
        AcceptButton = React.createElement(Button, {
            buttonType = ButtonType.PrimarySystem,
            layoutOrder = 2,
            standardSize = StandardButtonSize.Small,
            text = var1.acceptFriend,
            fontStyle = var2.Font.CaptionBody,
            isDisabled = isDisabled,
            onActivated = function()
                var6(true)
                tbl1.onAccept(tbl1.userId)
            end
        })
    })
end
