-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")
local UserInputService = game:GetService("UserInputService")
local InputUiParent = script:FindFirstAncestor("InputUi").Parent
local React = require(InputUiParent.React)

local UIBlox = require(InputUiParent.UIBlox)
local normalizeFontFace = require(InputUiParent.Foundation).Utility.normalizeFontFace

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useLocalization = require(InputUiParent.Localization).Hooks.useLocalization
local useDesignTokens = require(InputUiParent.Style).useDesignTokens
local _GamepadDisconnectTokenMapper = require(script.Parent.GamepadDisconnectTokenMapper)

local engineFeature = game:GetEngineFeature("GamepadMessageKeyEngineFeature")

return function(arg1)
    local var1 = useDesignTokens()
    local color3 = var1.Color.Content.Emphasis.Color3
    local emphasisTransparency = var1.Color.Content.Emphasis.Transparency

    local gamepadDisconnect = var1.LuaApps.GamepadDisconnect
    local designWidth = gamepadDisconnect.designWidth
    local imageWidth = gamepadDisconnect.imageWidth
    local imageHeight = gamepadDisconnect.imageHeight
    local textContainerWidth = gamepadDisconnect.textContainerWidth
    local horizontalInnerPadding = gamepadDisconnect.horizontalInnerPadding
    local verticalPadding = gamepadDisconnect.verticalPadding
    local var2

    if engineFeature then
        local item = MemStorageService:GetItem("GamepadDisconnectMessageKey")
        var2 = if item == "" then "Feature.GamepadDisconnect.Label.MessageGeneric" else item
    else
        var2 = "Feature.GamepadDisconnect.Label.Message"
    end

    local var3 = useLocalization({ title = "Feature.GamepadDisconnect.Label.Title", message = var2 })

    local str1 = string.format(var3.message, arg1.username, UserInputService:GetStringForKeyCode(Enum.KeyCode.A))

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true
    }, {
        Modal = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, -verticalPadding * 2),
            BackgroundTransparency = var1.Color.OverMedia.OverMedia_0.Transparency,
            BackgroundColor3 = var1.Color.OverMedia.OverMedia_0.Color3,
            BorderSizePixel = 0
        }, {
            Content = React.createElement("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.new(1, 0, 0, imageHeight),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(horizontalInnerPadding / designWidth, 0)
                }),
                ControllerImage = React.createElement("ImageLabel", {
                    Image = "rbxasset://textures/ui/Gamepad/Controller.png",
                    Size = UDim2.new(imageWidth / designWidth, 0, 0, imageHeight),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    ScaleType = Enum.ScaleType.Fit
                }, {
                    UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = imageWidth / imageHeight }),
                    UISizeConstraint = React.createElement(
                        "UISizeConstraint",
                        {
                            MaxSize = Vector2.new(imageWidth, imageHeight),
                            MinSize = Vector2.new(imageWidth * 0.5, imageHeight * 0.5)
                        }
                    )
                }),
                TextContainer = React.createElement("Frame", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(textContainerWidth / designWidth, 0, 0, imageHeight),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                }, {
                    UIListLayout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, var1.Size.Size_800)
                    }),
                    TitleRow = React.createElement(
                        "Frame",
                        {
                            AutomaticSize = Enum.AutomaticSize.Y,
                            Size = UDim2.fromScale(1, 0),
                            BackgroundTransparency = 1,
                            LayoutOrder = 1
                        },
                        {
                            UIListLayout = React.createElement("UIListLayout", {
                                FillDirection = Enum.FillDirection.Horizontal,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                Padding = UDim.new(24 / textContainerWidth, 0)
                            }),
                            Icon = React.createElement(ImageSetLabel, {
                                Image = Images["icons/menu/about_large"],
                                BackgroundTransparency = 1,
                                LayoutOrder = 1,
                                Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200)
                            }),
                            Title = React.createElement("TextLabel", {
                                Text = var3.title,
                                BackgroundTransparency = 1,
                                TextColor3 = color3,
                                TextTransparency = emphasisTransparency,
                                TextSize = var1.Typography.HeadingLarge.FontSize,
                                FontFace = normalizeFontFace(var1.Typography.HeadingLarge.Font),
                                LayoutOrder = 2,
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                        }
                    ),
                    Message = React.createElement("TextLabel", {
                        Text = str1,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        Size = UDim2.fromOffset(0, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = color3,
                        TextTransparency = emphasisTransparency,
                        TextSize = var1.Typography.TitleLarge.FontSize,
                        FontFace = normalizeFontFace(var1.Typography.TitleLarge.Font),
                        LayoutOrder = 2,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })
            })
        })
    })
end
