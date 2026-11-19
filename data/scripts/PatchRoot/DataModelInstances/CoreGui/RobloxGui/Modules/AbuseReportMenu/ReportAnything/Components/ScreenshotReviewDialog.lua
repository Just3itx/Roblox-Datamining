-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local React = require(CorePackages.Packages.React)

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local Button = UIBlox.App.Button.Button
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize

local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)
local Divider = require(scriptParentParent.Components.Divider)
local RestartScreenshotDialog = require(scriptParentParent.Components.RestartScreenshotDialog)
local _ReportAnythingAnalytics = require(scriptParentParent.Utility.ReportAnythingAnalytics)

local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local usePreferredInput = Responsive.usePreferredInput

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function ScreenshotReviewDialogSmallPortraitModeHeaderRight(arg1)
    local var1, var2 = React.useState(0)
    local var3 = React.useCallback(function(arg2)
        var2(arg2.AbsoluteSize.X)
    end, { var2 })
    local onActivated = React.useCallback(function()
        arg1.setShowRestartDialog(true)
    end, { arg1.setShowRestartDialog })

    local createElement = React.createElement
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl2 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Text = React.createElement("TextLabel", {
            LayoutOrder = -1,
            Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.SceneCaptured"),
            Font = arg1.font.Header2.Font,
            TextColor3 = arg1.theme.TextEmphasis.Color,
            TextTransparency = arg1.theme.TextEmphasis.Transparency,
            TextSize = 20,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Size = UDim2.new(0, arg1.viewportUISafeAreaWidth - var1 - 50, 1, 0),
            BackgroundTransparency = 1
        }),
        RetakeButton = React.createElement(Button, {
            buttonType = ButtonType.Secondary,
            text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.Retake"),
            fitContent = true,
            standardSize = StandardButtonSize.XSmall,
            onActivated = onActivated,
            [React.Change.AbsoluteSize] = var3
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

local function ScreenshotReviewDialog(tbl1)
    local bool1 = usePreferredInput() == Responsive.Input.Directional

    if not RobloxTranslator then
        return nil
    end

    local yOffset = if tbl1.isSmallPortraitMode then 104 else 60

    local onActivated = React.useCallback(function()
        tbl1.reportAnythingAnalytics.incrementPreviewBack()
        tbl1.onBack()
    end, { tbl1.onBack, tbl1.reportAnythingAnalytics })

    local var1 = React.useCallback(function()
        tbl1.reportAnythingAnalytics.incrementPreviewAttach()
        tbl1.onSkip()
    end, { tbl1.onSkip, tbl1.reportAnythingAnalytics })

    local var3, var4 = React.useState(false)

    local var2 = React.useCallback(function()
        tbl1.reportAnythingAnalytics.incrementRetake()
        var4(true)
    end, { var4, tbl1.reportAnythingAnalytics })

    local onRestart = React.useCallback(function()
        tbl1.reportAnythingAnalytics.setRetakeAbandon()
        tbl1.onRestart()
    end, { tbl1.onRestart, tbl1.reportAnythingAnalytics })

    local var5 = React.useCallback(function()
        tbl1.reportAnythingAnalytics.incrementHighlightScene()
        tbl1.onNextPage()
    end, { tbl1.onNextPage, tbl1.reportAnythingAnalytics })

    local var8 = useStyle()
    local theme = var8.Theme
    local font = var8.Font
    local uDim2 = if tbl1.viewportUISafeAreaHeight >= 800 then UDim2.new(0, 800, 0, 800) else UDim2.new(1, 0, 1, 0)
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Selectable = false,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundColor3 = theme.Overlay.Color,
        BackgroundTransparency = theme.Overlay.Transparency,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 10,
        Text = "",
        [React.Event.Activated] = onActivated
    }
    local tbl3 = { Container = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = 0,
        Position = 0,
        AnchorPoint = 0,
        BorderSizePixel = 0,
        BackgroundColor3 = 0,
        BackgroundTransparency = 0,
        ZIndex = 10
    }

    if tbl1.isSmallPortraitMode then
        uDim2 = UDim2.new(1, 0, 1, 0)
    end

    tbl4.Size = uDim2
    tbl4.Position = UDim2.fromScale(0.5, 0.5)
    tbl4.AnchorPoint = Vector2.new(0.5, 0.5)

    tbl4.BackgroundColor3 = theme.Overlay.Color

    local tbl5 = {
        RestartDialog = var3
            and React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }, {
                FocusNavigationCoreScriptsWrapper = React.createElement(
                    FocusRoot,
                    {
                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                        isIsolated = true,
                        isAutoFocusRoot = true
                    },
                    {
                        DialogBody = React.createElement(RestartScreenshotDialog, {
                            ZIndex = 3,
                            isSmallPortraitMode = tbl1.isSmallPortraitMode,
                            onCancel = function()
                                var4(false)
                            end,
                            onRestart = onRestart
                        })
                    }
                )
            }),
        RestartDialogMask = var3
            and React.createElement(ImageSetButton, {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 0.2,
                BackgroundColor3 = theme.BackgroundUIDefault.Color,
                Active = true,
                AutoButtonColor = false,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = Assets.Images.RoundedRect.Image,
                ImageColor3 = theme.BackgroundUIDefault.Color,
                ImageTransparency = 1,
                ScaleType = Assets.Images.RoundedRect.ScaleType,
                SliceCenter = Assets.Images.RoundedRect.SliceCenter
            }, {}),
        ScreenshotDialog = 0
    }

    local createElement3 = React.createElement
    local var9 = ImageSetButton
    local tbl6 = {
        Active = true,
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Assets.Images.RoundedRect.Image,
        ImageColor3 = theme.BackgroundUIDefault.Color,
        ImageTransparency = theme.BackgroundUIDefault.Transparency,
        ScaleType = Assets.Images.RoundedRect.ScaleType,
        SliceCenter = Assets.Images.RoundedRect.SliceCenter
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        HeaderAndContent = 0,
        Footer = 0
    }

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        Size = UDim2.new(1, 0, 1, -yOffset),
        BackgroundTransparency = 1
    }
    local tbl9 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Header = 0,
        Divider = 0,
        ScreenshotBody = 0
    }
    local createElement5 = React.createElement
    local str4 = "Frame"
    local tbl10 = {
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 48)
    }

    local tbl11 = {
        Bar = React.createElement(HeaderBar, {
            backgroundTransparency = 1,
            barHeight = 48,
            margin = 12,
            renderLeft = function()
                return React.createElement(
                    IconButton,
                    {
                        iconSize = IconSize.Medium,
                        icon = Images["icons/navigation/pushBack"],
                        onActivated = onActivated
                    }
                )
            end,
            renderRight = function()
                if tbl1.isSmallPortraitMode then
                    return React.createElement(
                        ScreenshotReviewDialogSmallPortraitModeHeaderRight,
                        {
                            onActivated = var2,
                            font = font,
                            theme = theme,
                            viewportUISafeAreaWidth = tbl1.viewportUISafeAreaWidth
                        }
                    )
                end

                return React.createElement(Button, {
                    buttonType = ButtonType.Secondary,
                    text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.Retake"),
                    fitContent = true,
                    standardSize = StandardButtonSize.XSmall,
                    onActivated = var2
                })
            end,
            title = if tbl1.isSmallPortraitMode then nil else RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.SceneCaptured"),
            isSecondary = tbl1.isSmallPortraitMode
        })
    }

    tbl9.Header = createElement5(str4, tbl10, tbl11)

    tbl9.Divider = React.createElement(Divider, { LayoutOrder = 2 })

    local createElement6 = React.createElement
    local tbl12 = {
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 1, -60),
        ZIndex = 10
    }
    local tbl13 = {
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 16) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        ScreenshotContainer = 0,
        Description = 0
    }
    local createElement7 = React.createElement
    local tbl14 = {
        Size = UDim2.new(1, 0, 1, -32),
        BackgroundTransparency = 2,
        LayoutOrder = 1
    }

    local tbl15 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 16),
            PaddingRight = UDim.new(0, 16)
        }),
        Screenshot = 0
    }
    local createElement8 = React.createElement
    local tbl16 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 2,
        BorderMode = Enum.BorderMode.Outline,
        BorderColor3 = Color3.fromRGB(255, 255, 255),
        LayoutOrder = 1
    }
    local tbl17 = {
        UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = tbl1.imageAspectRatio }),
        ScreenshotImage = React.createElement(ImageSetButton, {
            Active = true,
            Selectable = not bool1,
            Size = UDim2.fromScale(1, 1),
            Image = tbl1.screenshot,
            ZIndex = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Fit,
            SliceCenter = Assets.Images.RoundedRect.SliceCenter,
            [React.Event.Activated] = var5
        })
    }
    tbl15.Screenshot = createElement8("Frame", tbl16, tbl17)
    tbl13.ScreenshotContainer = createElement7("Frame", tbl14, tbl15)

    tbl13.Description = React.createElement("TextLabel", {
        Text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Message.ProblemNotInScene"),
        FontFace = normalizeFontFace(var8.Tokens.Typography.HeadingSmall.Font),
        LayoutOrder = 2,
        TextColor3 = theme.TextEmphasis.Color,
        TextTransparency = theme.TextEmphasis.Transparency,
        TextSize = if tbl1.isSmallPortraitMode then 12 else 20,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextWrapped = true,
        Size = UDim2.new(1, -24, 0, if tbl1.isSmallPortraitMode then 24 else 40),
        BackgroundTransparency = 1
    })
    tbl9.ScreenshotBody = createElement6("Frame", tbl12, tbl13)
    tbl7.HeaderAndContent = createElement4(str3, tbl8, tbl9)

    local createElement9 = React.createElement
    local str5 = "Frame"
    local tbl18 = {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 0, yOffset),
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        LayoutOrder = 4
    }
    local tbl19 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        ),
        Container = 0
    }
    local createElement10 = React.createElement
    local str6 = "Frame"
    local tbl20 = {
        Size = if tbl1.isSmallPortraitMode then UDim2.new(1, 0, 1, 0) else UDim2.new(0, if tbl1.isSmallPortraitMode then 400 else 612, 1, 0),
        BackgroundTransparency = 1
    }

    local tbl21 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 16),
            PaddingRight = UDim.new(0, 16)
        }),
        ActionButtons = React.createElement(ButtonStack, {
            forcedFillDirection = if tbl1.isSmallPortraitMode then Enum.FillDirection.Vertical else nil,
            marginBetween = 8,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = var1,
                        text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.AttachScreenshot")
                    }
                },
                not bool1
                    and {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = var5,
                            text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.HighlightScene")
                        }
                    }
                    or nil
            }
        })
    }
    tbl19.Container = createElement10(str6, tbl20, tbl21)
    tbl7.Footer = createElement9(str5, tbl18, tbl19)
    tbl5.ScreenshotDialog = createElement3(var9, tbl6, tbl7)
    tbl3.Container = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return ScreenshotReviewDialog
