-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local withStyle = UIBlox.Core.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local iconsImageUnavailable = Images["icons/imageUnavailable"]
local component_assetsCircle_17 = Images["component_assets/circle_17"]
local rect = Rect.new(8, 8, 9, 9)

local var1 = Roact.PureComponent:extend("MenuHeader")

var1.validateProps = t.strictInterface({ gameName = t.string, layoutOrder = t.integer, height = t.numberPositive })

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local element

        if game.GameId == 0 then
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = component_assetsCircle_17,
                SliceCenter = rect,
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.fromOffset(80, 80),
                ImageColor3 = arg2.Theme.PlaceHolder.Color,
                ImageTransparency = arg2.Theme.PlaceHolder.Transparency
            }, {
                PlaceholderIcon = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(44, 44),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Image = iconsImageUnavailable,
                    ImageColor3 = arg2.Theme.UIDefault.Color,
                    ImageTransparency = arg2.Theme.UIDefault.Transparency,
                    AnchorPoint = Vector2.new(0.5, 0.5)
                })
            })
        else
            local image = ("rbxthumb://type=GameIcon&id=%d&w=%d&h=%d"):format(game.GameId, 128, 128)

            element = Roact.createElement(
                "ImageLabel",
                {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(80, 80),
                    Image = image
                }
            )
        end
        return Roact.createElement(
            "Frame",
            {
                LayoutOrder = arg1.props.layoutOrder,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, arg1.props.height)
            },
            {
                ContentsFrame = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1)
                }, {
                    Layout = Roact.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 20)
                    }),
                    Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20) }),
                    GameIcon = element,
                    TextFrame = Roact.createElement(
                        "Frame",
                        {
                            LayoutOrder = 2,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -100, 1, 0)
                        },
                        {
                            TextLabel = Roact.createElement("TextLabel", {
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, -45),
                                Position = UDim2.fromOffset(0, 25),
                                FontFace = normalizeFontFace(arg2.Tokens.Typography.HeadingSmall.Font),
                                Text = arg1.props.gameName,
                                TextSize = font.BaseSize * font.Header1.RelativeSize,
                                TextColor3 = theme.TextEmphasis.Color,
                                TextTransparency = theme.TextEmphasis.TextTransparency,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Top,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextWrapped = true
                            })
                        }
                    )
                }),
                Divider = Roact.createElement("Frame", {
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.fromScale(0, 1),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundTransparency = theme.Divider.Transparency,
                    BackgroundColor3 = theme.Divider.Color
                })
            }
        )
    end)
end
return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        gameName = arg1.gameInfo.name
    }
end, nil)(var1)
