-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local _LocalizationService = game:GetService("LocalizationService")
local ContextActionService = game:GetService("ContextActionService")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local useDesignTokens = require(CorePackages.Workspace.Packages.Style).useDesignTokens
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local TopBar = script:FindFirstAncestor("TopBar")
local default = require(TopBar.Analytics).default

local _MenuNavigationPromptTokenMapper = require(TopBar.TokenMappers.MenuNavigationPromptTokenMapper)

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local tbl1 = {
    ButtonSelect = "CoreScripts.InGameMenu.Label.ViewButton",
    ButtonTouchpad = "CoreScripts.InGameMenu.Label.TouchpadButton",
    ButtonShare = "CoreScripts.InGameMenu.Label.ShareButton"
}

local function HeaderArea()
    local menuNavigationPrompt = useDesignTokens().LuaApps.MenuNavigationPrompt
    local typography = menuNavigationPrompt.Typography
    local menuNavigationPromptColor = menuNavigationPrompt.Color
    local space = menuNavigationPrompt.Space

    local var1 = useLocalization({ HeaderText = "CoreScripts.InGameMenu.EducationalPopup.UINavigation.Title" })

    return React.createElement(
        "Frame",
        {
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = 0,
            BackgroundTransparency = 1
        },
        {
            Header = React.createElement("TextLabel", {
                Text = var1.HeaderText,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(typography.header.Font),
                TextSize = typography.header.FontSize,
                TextColor3 = menuNavigationPromptColor.textColor.Color3,
                Size = UDim2.fromOffset(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }),
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, space.titlePadding),
                PaddingBottom = UDim.new(0, space.titlePadding),
                PaddingLeft = UDim.new(0, space.bodyPadding),
                PaddingRight = UDim.new(0, space.bodyPadding)
            })
        }
    )
end

local function GamepadImageArea()
    local menuNavigationPrompt = useDesignTokens().LuaApps.MenuNavigationPrompt
    local typography = menuNavigationPrompt.Typography
    local menuNavigationPromptColor = menuNavigationPrompt.Color
    local menuNavigationPromptSize = menuNavigationPrompt.Size
    local space = menuNavigationPrompt.Space

    local stringForKeyCode = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonSelect)
    local buttonLabelText = tbl1[stringForKeyCode] or "CoreScripts.InGameMenu.Label.ViewButton"
    local var2 = useLocalization({ ButtonLabelText = buttonLabelText })

    local contentId = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect)

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            AutomaticSize = Enum.AutomaticSize.XY
        },
        {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, space.iconPadding)
            }),
            ButtonLabelGroup = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    LayoutOrder = 0
                },
                {
                    Layout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, space.iconPadding)
                    }),
                    Icon = React.createElement("ImageLabel", {
                        LayoutOrder = 0,
                        BackgroundTransparency = 1,
                        Image = contentId,
                        Size = UDim2.fromOffset(menuNavigationPromptSize.iconSize, menuNavigationPromptSize.iconSize)
                    }),
                    ControllerButtonLabel = React.createElement("TextLabel", {
                        Text = var2.ButtonLabelText,
                        LayoutOrder = 100,
                        BackgroundTransparency = 1,
                        FontFace = normalizeFontFace(typography.label.Font),
                        TextSize = typography.label.FontSize,
                        TextColor3 = menuNavigationPromptColor.textColor.Color3,
                        Size = UDim2.fromOffset(0, 0),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextYAlignment = Enum.TextYAlignment.Center
                    })
                }
            ),
            ControllerImage = React.createElement("ImageLabel", {
                Image = "rbxasset://textures/ui/Gamepad/ControllerSelect.png",
                Size = UDim2.fromScale(1, 1),
                LayoutOrder = 100,
                BackgroundTransparency = 1
            }, {
                UIAspectRatioConstraint = React.createElement(
                    "UIAspectRatioConstraint",
                    {
                        AspectRatio = menuNavigationPromptSize.imageWidth / menuNavigationPromptSize.imageHeight
                    }
                ),
                UISizeConstraint = React.createElement("UISizeConstraint", {
                    MaxSize = Vector2.new(menuNavigationPromptSize.imageWidth, menuNavigationPromptSize.imageHeight),
                    MinSize = Vector2.new(menuNavigationPromptSize.imageWidth * 0.5, menuNavigationPromptSize.imageHeight * 0.5)
                })
            })
        }
    )
end

local function Body(tbl2)
    local menuNavigationPrompt = useDesignTokens().LuaApps.MenuNavigationPrompt
    local typography = menuNavigationPrompt.Typography
    local menuNavigationPromptColor = menuNavigationPrompt.Color
    local menuNavigationPromptSize = menuNavigationPrompt.Size
    local space = menuNavigationPrompt.Space

    local stringForKeyCode = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonSelect)
    local _ = tbl1[stringForKeyCode] or "CoreScripts.InGameMenu.Label.ViewButton"

    local var1 = useLocalization({
        OkText = "CoreScripts.InGameMenu.Ok",
        Description = "CoreScripts.InGameMenu.EducationalPopup.UINavigation.Description"
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = 200,
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1
    }
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, space.bodyPadding)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, space.bodyPadding),
            PaddingRight = UDim.new(0, space.bodyPadding),
            PaddingTop = UDim.new(0, space.bodyPadding),
            PaddingBottom = UDim.new(0, space.bodyPadding)
        }),
        GamepadImageArea = React.createElement(GamepadImageArea),
        ImageDescription = React.createElement("TextLabel", {
            Text = var1.Description,
            LayoutOrder = 100,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(typography.caption.Font),
            TextSize = typography.caption.FontSize,
            TextColor3 = menuNavigationPromptColor.textColor.Color3,
            TextWrapped = true,
            LineHeight = typography.caption.LineHeight,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        }),
        ConfirmationButton = React.createElement(Button, {
            buttonType = ButtonType.PrimarySystem,
            layoutOrder = 200,
            size = UDim2.new(1, 0, 0, menuNavigationPromptSize.buttonHeight),
            text = var1.OkText,
            onActivated = tbl2.onDismissed,
            icon = if tbl2.selectButtonDismissesGamepadNavigationDialog then UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect) else nil
        })
    }
    return createElement(str1, tbl3, tbl4)
end

local function GamepadNavigationDialog(tbl2)
    local menuNavigationPrompt = useDesignTokens().LuaApps.MenuNavigationPrompt
    local menuNavigationPromptColor = menuNavigationPrompt.Color
    local menuNavigationPromptSize = menuNavigationPrompt.Size
    local space = menuNavigationPrompt.Space
    local radius = menuNavigationPrompt.Radius

    React.useEffect(function()
        default:onShowGamepadNavigationDialog()
        ContextActionService:BindCoreAction("ConfirmBindComponentMapperTokenModule", function(_, userInputState, _)
            if userInputState == Enum.UserInputState.End then
                tbl2.onDismissed()
            end
        end, false, if tbl2.selectButtonDismissesGamepadNavigationDialog then Enum.KeyCode.ButtonSelect else Enum.KeyCode.ButtonA)

        return function()
            default:onDismissGamepadNavigationDialog()
            ContextActionService:UnbindCoreAction("ConfirmBindComponentMapperTokenModule")
        end
    end)

    return React.createElement("Frame", {
        BackgroundColor3 = menuNavigationPromptColor.backgroundUiColor.Color3,
        BackgroundTransparency = menuNavigationPromptColor.backgroundUiColor.Transparency,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(menuNavigationPromptSize.promptWidth / menuNavigationPromptSize.displayWidth, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, radius.cornerRadius) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        HeaderArea = React.createElement(HeaderArea),
        Separator = React.createElement("Frame", {
            LayoutOrder = 100,
            Size = UDim2.new(1, -2 * space.bodyPadding, 0, 1),
            BackgroundColor3 = menuNavigationPromptColor.separatorColor.Color3,
            BackgroundTransparency = menuNavigationPromptColor.separatorColor.Transparency,
            BorderSizePixel = 0
        }),
        Body = React.createElement(Body, tbl2),
        UISizeConstraint = React.createElement("UISizeConstraint", {
            MaxSize = Vector2.new(math.huge, math.huge),
            MinSize = Vector2.new(menuNavigationPromptSize.imageWidth + 2 * space.bodyPadding, 1)
        })
    })
end

return GamepadNavigationDialog
