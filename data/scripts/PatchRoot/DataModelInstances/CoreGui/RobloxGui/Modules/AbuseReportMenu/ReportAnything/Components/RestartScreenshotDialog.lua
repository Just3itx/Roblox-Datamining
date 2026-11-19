-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local React = require(CorePackages.Packages.React)

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local HeaderBar = UIBlox.App.Bar.HeaderBar

local useStyle = UIBlox.Core.Style.useStyle
local scriptParentParent = script.Parent.Parent
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Divider = require(scriptParentParent.Components.Divider)

local function RestartScreenshotDialog(tbl1)
    local var1 = useStyle()
    local theme = var1.Theme
    local font = var1.Font
    local yOffset, yOffset2, yOffset3

    if tbl1.isSmallPortraitMode then
        yOffset = 260
        yOffset2 = 84
        yOffset3 = 100
    else
        yOffset = 180
        yOffset2 = 48
        yOffset3 = 50
    end

    local xOffset = if tbl1.isSmallPortraitMode then 343 else 480
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(0, xOffset, 0, yOffset),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        ZIndex = 5
    }
    local tbl3 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        HeaderAndContent = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Header = React.createElement(HeaderBar, {
                backgroundTransparency = 1,
                barHeight = 48,
                renderLeft = function() end,
                renderRight = function() end,
                title = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.RetakeScene"),
                LayoutOrder = 1
            }),
            Divider = React.createElement(Divider, { LayoutOrder = 2 }),
            Description = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, -yOffset2 - 1),
                    BackgroundTransparency = 1,
                    LayoutOrder = 3
                },
                {
                    Padding = React.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, 8),
                        PaddingBottom = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 16),
                        PaddingRight = UDim.new(0, 16)
                    }),
                    TextBody = React.createElement("TextLabel", {
                        Text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Message.RetakeScene"),
                        FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                        LayoutOrder = 3,
                        TextColor3 = theme.TextEmphasis.Color,
                        TextTransparency = theme.TextEmphasis.Transparency,
                        TextSize = 16,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        Size = UDim2.new(1, 0, 0, yOffset3),
                        BackgroundTransparency = 1
                    })
                }
            )
        }),
        Footer = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, yOffset2),
        Position = UDim2.new(0, 0, 1, -yOffset2),
        BorderSizePixel = 0,
        LayoutOrder = 4
    }

    local tbl5 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 16),
            PaddingRight = UDim.new(0, 16)
        }),
        ActionButtons = React.createElement(ButtonStack, {
            forcedFillDirection = if tbl1.isSmallPortraitMode then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = tbl1.isSmallPortraitMode
                        and {
                            onActivated = tbl1.onCancel,
                            text = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Cancel"),
                            size = UDim2.new(1, 0, 0, 28),
                            fontStyle = font.Body2
                        }
                        or {
                            onActivated = tbl1.onCancel,
                            text = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Cancel")
                        }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = tbl1.isSmallPortraitMode
                        and {
                            onActivated = tbl1.onRestart,
                            text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.BackToExperience"),
                            size = UDim2.new(1, 0, 0, 28),
                            fontStyle = font.Body2
                        }
                        or {
                            onActivated = tbl1.onRestart,
                            text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.BackToExperience")
                        }
                }
            }
        })
    }
    tbl3.Footer = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return RestartScreenshotDialog
