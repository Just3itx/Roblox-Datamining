-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local QRCodeDisplay = require(ProfileQRCodeParent.QRCodeDisplay)
local React = require(ProfileQRCodeParent.React)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local UserLib = require(ProfileQRCodeParent.UserLib)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local LightTheme = UIBlox.App.Style.Themes.LightTheme
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local useLocalUserId = require(ProfileQRCodeParent.RobloxAppHooks).useLocalUserId
local useLocalUserInfo = require(ProfileQRCode.Utils.useLocalUserInfo)
local useStyle = UIBlox.Core.Style.useStyle

local FFlagProfileQrCodeDeprecateUserRedux = require(ProfileQRCode.Flags.FFlagProfileQrCodeDeprecateUserRedux)

local DisplayQRCode = QRCodeDisplay.DisplayQRCode
local getStandardSizeAvatarHeadShotRbxthumb = UserLib.Utils.getStandardSizeAvatarHeadShotRbxthumb

local GetFFlagLuaAppEnableOpenTypeSupport = require(ProfileQRCodeParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local component_assetsDropshadow_56_8 = Images["component_assets/dropshadow_56_8"]

return function(tbl1)
    local var1 = useLocalUserId()
    local var2 = useLocalUserInfo(var1)
    local var3 = useStyle()
    local image = if var1 then getStandardSizeAvatarHeadShotRbxthumb(var1) else nil
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BorderSizePixel = 0,
        BackgroundTransparency = LightTheme.BackgroundUIDefault.Transparency,
        BackgroundColor3 = LightTheme.BackgroundUIDefault.Color,
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, if tbl1.isSmallScreen then tbl1.padding / 2 else tbl1.padding),
            PaddingRight = UDim.new(0, tbl1.padding),
            PaddingBottom = UDim.new(0, if tbl1.isSmallScreen then tbl1.padding / 2 else tbl1.padding),
            PaddingLeft = UDim.new(0, tbl1.padding)
        }),
        QRCodeWrapper = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, tbl1.qrCodeLength, 0, tbl1.qrCodeLength),
                LayoutOrder = 1
            },
            {
                QRCode = React.createElement(DisplayQRCode, {
                    toEncode = tbl1.url,
                    ecLevel = QRCodeDisplay.ECLevels.EC_LEVEL_4,
                    sideLength = tbl1.qrCodeLength,
                    pixelColor = LightTheme.UIEmphasis.Color,
                    qrCodeRotation = 15
                }),
                PlayerAvatar = React.createElement("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = LightTheme.BackgroundUIDefault.Color,
                    BackgroundTransparency = LightTheme.BackgroundUIDefault.Transparency,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Rotation = 15,
                    Size = UDim2.fromOffset(44, 44),
                    ZIndex = 3
                }, {
                    Canvas = React.createElement("CanvasGroup", {
                        BackgroundColor3 = LightTheme.BackgroundUIDefault.Color,
                        BackgroundTransparency = LightTheme.BackgroundUIDefault.Transparency,
                        BorderSizePixel = 0,
                        ClipsDescendants = true,
                        Size = UDim2.fromScale(1, 1)
                    }, {
                        Avatar = React.createElement("ImageLabel", {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = LightTheme.BackgroundUIDefault.Color,
                            BackgroundTransparency = LightTheme.BackgroundUIDefault.Transparency,
                            BorderSizePixel = 0,
                            Image = image,
                            Position = UDim2.fromScale(0.5, 0.5),
                            Rotation = -15,
                            Size = UDim2.fromOffset(60, 60),
                            ZIndex = 2
                        })
                    }),
                    UIStroke = React.createElement("UIStroke", { Color = LightTheme.BackgroundUIDefault.Color, Thickness = 2 })
                }),
                BigShadow = React.createElement(ImageSetLabel, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, 70, 0, 70),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    Image = component_assetsDropshadow_56_8,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(28, 28, 29, 29),
                    ImageColor3 = var3.Theme.DropShadow.Color,
                    ImageTransparency = var3.Theme.DropShadow.Transparency
                })
            }
        ),
        Spacer1 = React.createElement(
            "Frame",
            {
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 10),
                LayoutOrder = 2
            }
        ),
        DisplayName = React.createElement(StyledTextLabel, {
            layoutOrder = 3,
            text = var2.displayName,
            fontStyle = var3.Font.SubHeader1,
            lineHeight = 1,
            colorStyle = LightTheme.TextEmphasis,
            automaticSize = Enum.AutomaticSize.Y,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            fluidSizing = false,
            richText = false,
            size = UDim2.new(1, 0, 0, 0)
        }),
        Username = React.createElement(StyledTextLabel, {
            size = UDim2.new(1, 0, 0, 0),
            layoutOrder = 4,
            text = "@" .. (if FFlagProfileQrCodeDeprecateUserRedux then var2.username or "" else var2.username),
            fontStyle = var3.Font.CaptionBody,
            lineHeight = 1,
            automaticSize = Enum.AutomaticSize.Y,
            colorStyle = LightTheme.TextEmphasis,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            fluidSizing = false,
            richText = false,
            openTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.05, 0) })
    }
    return createElement(str1, tbl2, tbl3)
end
