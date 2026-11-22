-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LocalizationService = game:GetService("LocalizationService")
local GuiService = game:GetService("GuiService")

local Roact = require(scriptParentParentParent.Roact)

local RoactGamepad = require(scriptParentParentParent.RoactGamepad)
local Cryo = require(scriptParentParentParent.Cryo)

local UIBlox = require(scriptParentParentParent.UIBlox)
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local Images = UIBlox.App.ImageSet.Images
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local useStyleMetadata = UIBlox.Core.Style.useStyleMetadata
local Foundation = require(scriptParentParentParent.Foundation)
local ColorMode = Foundation.Enums.ColorMode
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameHorizontal = RoactFitComponents.FitFrameHorizontal
local FitTextLabel = RoactFitComponents.FitTextLabel
local FullscreenFrame = require(scriptParentParentParent.AppBlox).FullscreenFrame

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)
local formatNumber = require(scriptParentParent.Utility.formatNumber)
local Animator = require(scriptParentParent.Generic.Animator)

local getEnableCompensatingScrollingFrame = require(scriptParentParent.Flags.getEnableCompensatingScrollingFrame)

local getUserInputEventData = require(scriptParentParent.Utility.getUserInputEventData)

local RobuxPackage = require(scriptParent.RobuxPackage)
local FFlagBuyRobuxPageFitToViewport = require(scriptParentParent.Flags.FFlagBuyRobuxPageFitToViewport)

local var1 = Roact.Component:extend(script.Name)

local iconsCommonGoldrobux = Images["icons/common/goldrobux"]
local iconsLogoBlock = Images["icons/logo/block"]
local tbl1 = {
    Images["icons/graphic/robuxcoin1_xxlarge"],
    Images["icons/graphic/robuxcoin2_xxlarge"],
    Images["icons/graphic/robuxcoin3_xxlarge"],
    Images["icons/graphic/robuxcoin4_xxlarge"],
    Images["icons/graphic/robuxcoin5_xxlarge"],
    Images["icons/graphic/robuxcoin6_xxlarge"]
}

local iconsNavigationClose = Images["icons/navigation/close"]

function var1.init(arg1)
    arg1.state = { selectedPackage = nil, showMessageBanner = false }

    arg1.buttonRefs = RoactGamepad.createRefCache()
    arg1.scrollingFrameRef = Roact.createRef()
    if FFlagBuyRobuxPageFitToViewport then
        arg1.packageLayoutRef = Roact.createRef()
        local canvasSize, setCanvasSize = Roact.createBinding(UDim2.new())
        arg1.canvasSize = canvasSize
        arg1.setCanvasSize = setCanvasSize
        function arg1.updateCanvasSize()
            local current = arg1.scrollingFrameRef.current
            local current2 = arg1.packageLayoutRef.current
            if current and current2 and current.AbsoluteSize.X > 0 then
                arg1.setCanvasSize(UDim2.fromScale(current2.AbsoluteContentSize.X / current.AbsoluteSize.X, 0))
            end
        end
    end

    function arg1.getGamepadNextSelectionLeft(arg2)
        return arg2 > 1 and arg1.buttonRefs[arg2 - 1] or nil
    end

    function arg1.getGamepadNextSelectionRight(arg2)
        return arg2 < #arg1.buttonRefs and arg1.buttonRefs[arg2 + 1] or nil
    end

    function arg1.initSelectionChangedListener()
        if arg1.selectionListener ~= nil then
            arg1.selectionListener:Disconnect()
            arg1.selectionListener = nil
        end
        if arg1.selectionListener ~= nil then
            arg1.selectionListener:Disconnect()
            arg1.selectionListener = nil
        end

        arg1.selectionListener = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
            if arg1.state.selectedPackage == nil
                or GuiService.SelectedCoreObject == nil
                or arg1.state.selectedPackage ~= GuiService.SelectedCoreObject
            then
                arg1:setState({ selectedPackage = GuiService.SelectedCoreObject })
            end
        end)
    end
end

function var1.didMount(arg1)
    arg1.initSelectionChangedListener()
    if FFlagBuyRobuxPageFitToViewport and arg1.props.isConsoleSize then
        arg1.updateCanvasSize()
    end
end

function var1.didUpdate(tbl2, tbl3, _)
    local props = tbl2.props

    if tbl3.hasNativePurchaseSucceeded == props.hasNativePurchaseSucceeded or not props.hasNativePurchaseSucceeded then
        return
    end

    tbl2:setState({ showMessageBanner = true })
    task.delay(3, function()
        tbl2:setState({ showMessageBanner = false })
    end)
end

function var1.willUnmount(arg1)
    if arg1.selectionListener ~= nil then
        arg1.selectionListener:Disconnect()
        arg1.selectionListener = nil
    end
end

function var1.getScale(arg1): number
    return if arg1.props.isConsoleSize then 1 else 0.65
end

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            BannerText = { key = "IAPExperience.BuyRobux.Banner.Text" },
            BannerTitle = { key = "IAPExperience.BuyRobux.Banner.Title" },
            SuccessfulMessage = { key = "IAPExperience.BuyRobux.Alert.SuccessfulMessage" }
        },
        render = function(tbl2)
            return withSelectionCursorProvider(function(arg2)
                return arg1:renderWithLocale(tbl2, arg2)
            end)
        end
    })
end

function var1.movePackageToAttentionArea(tbl2, arg1)
    if not getEnableCompensatingScrollingFrame() then
        return
    end

    local current = tbl2.scrollingFrameRef.current
    if current == nil or arg1 == nil then
        return
    end
    local absoluteSizeX = current.AbsoluteSize.X
    local var2 = 48 * tbl2:getScale()

    if not FFlagBuyRobuxPageFitToViewport or not tbl2.props.isConsoleSize then
        local x = arg1.AbsolutePosition.X - var2
        if x < 0 or absoluteSizeX < arg1.AbsolutePosition.X + arg1.AbsoluteSize.X + var2 then
            current.CanvasPosition = Vector2.new(x, 0)
            tbl2:reportScrollingFrameCompensationHappened()
        end

        return
    end

    local var3 = arg1.AbsolutePosition.X - current.AbsolutePosition.X - var2
    local var4 = var3 + arg1.AbsoluteSize.X + 2 * var2
    local canvasPositionX = current.CanvasPosition.X
    if var3 < 0 then
        current.CanvasPosition = Vector2.new(canvasPositionX + var3, 0)
        tbl2:reportScrollingFrameCompensationHappened()
        return
    end

    if absoluteSizeX < var4 then
        current.CanvasPosition = Vector2.new(canvasPositionX + var4 - absoluteSizeX, 0)
        tbl2:reportScrollingFrameCompensationHappened()
    end
end

function var1.reportScrollingFrameCompensationHappened(arg1)
    local props = arg1.props
    if not props.onAnalyticEvent then
        return
    end

    local userInputEventData = getUserInputEventData(props.analyticId, "", "BuyRobux", "ScrollingFrame", "Compensated")

    props.onAnalyticEvent("UserPurchaseFlow", userInputEventData)
end

function var1.renderWithLocale(tbl2, tbl3, arg1)
    local props = tbl2.props
    local isConsoleSize = FFlagBuyRobuxPageFitToViewport and props.isConsoleSize

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local scrollingEnabled = props.robuxPackages ~= nil
        local num1 = if props.robuxPackages == nil then 6 else #props.robuxPackages

        local textSize = 32 * tbl2:getScale()

        local tbl4 = {
            LeadingPadding = not isConsoleSize
                and Roact.createElement(
                    "Frame",
                    {
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        LayoutOrder = 0,
                        Size = UDim2.new(0, 80 * tbl2:getScale(), 0, 1)
                    }
                ),
            RobuxPackageChildren = Roact.createElement("UIListLayout", {
                [Roact.Ref] = if isConsoleSize then tbl2.packageLayoutRef else nil,
                [Roact.Change.AbsoluteContentSize] = if isConsoleSize then tbl2.updateCanvasSize else nil,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = if isConsoleSize then Enum.VerticalAlignment.Top else Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16 * tbl2:getScale())
            }),
            TrailingPadding = not isConsoleSize
                and Roact.createElement("Frame", {
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    LayoutOrder = num1 + 1,
                    Size = UDim2.new(0, 80 * tbl2:getScale(), 0, 1)
                })
        }

        for layoutOrder = 1, num1 do
            local num2 = layoutOrder + 1
            local createElement = Roact.createElement
            local var3 = RobuxPackage
            local tbl5 = {
                layoutOrder = layoutOrder,
                scale = tbl2:getScale(),
                fitToViewport = if isConsoleSize then true else nil,
                selected = not (tbl2.state.selectedPackage == nil) and tbl2.state.selectedPackage == tbl2.buttonRefs[layoutOrder]:getValue(),
                packageId = if scrollingEnabled then props.robuxPackages[layoutOrder].packageId else tostring(layoutOrder),
                robuxAmount = if scrollingEnabled then props.robuxPackages[layoutOrder].robuxAmount else nil,
                currencyAmountStr = if scrollingEnabled then props.robuxPackages[layoutOrder].currencyAmountStr else nil,
                robuxMoreAmount = if scrollingEnabled then props.robuxPackages[layoutOrder].robuxMoreAmount else nil,
                robuxImage = tbl1[layoutOrder],
                forwardRef = tbl2.buttonRefs[layoutOrder],
                nextSelectionLeft = tbl2.getGamepadNextSelectionLeft(layoutOrder),
                nextSelectionRight = tbl2.getGamepadNextSelectionRight(layoutOrder),
                onActivated = 0,
                onSelect = 0,
                onHover = 0
            }
            function tbl5.onActivated(str1: string?)
                props.robuxPackageActivated(str1)
            end
            function tbl5.onSelect(arg3)
                tbl2:movePackageToAttentionArea(arg3:getValue())
            end
            function tbl5.onHover(arg3, bool2: boolean)
                if bool2 then
                    if tbl2.state.selectedPackage ~= arg3:getValue() then
                        tbl2:setState({ selectedPackage = arg3:getValue() })
                    end
                else
                    tbl2:setState({ selectedPackage = "" })
                end
            end

            tbl4[num2] = createElement(var3, tbl5)
        end

        local tbl5 = {
            BuyRobuxPageBackground = Roact.createElement("Frame", {
                BackgroundTransparency = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                Visible = tbl2.props.showBackground,
                ZIndex = 0
            }, {
                BackgroundImage = Roact.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    ImageTransparency = 0,
                    Image = if props.themeName == ColorMode.Dark then "rbxasset://textures/AvatarEditorImages/AvatarEditor.png" else "rbxasset://textures/AvatarEditorImages/AvatarEditor_LightTheme.png",
                    Size = UDim2.new(1, 0, 1, 0)
                }),
                Backdrop = Roact.createElement("Frame", {
                    BackgroundTransparency = if props.themeName == ColorMode.Dark then 0.5 else 0.7,
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0)
                })
            }),
            CloseButton = Roact.createElement(
                ImageSetButton,
                {
                    Position = if isConsoleSize then UDim2.new(0, 48, 1, -36) else UDim2.new(0, 48 * tbl2:getScale(), 0, 48 * tbl2:getScale()),
                    AnchorPoint = Vector2.new(0, 0),
                    Size = UDim2.new(0, 36, 0, 36),
                    Image = iconsNavigationClose,
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.7,
                    BorderSizePixel = 0,
                    SelectionImageObject = arg1(CursorKind.RoundedRect),
                    Visible = tbl2.props.showCloseButton,
                    [Roact.Event.Activated] = props.onPageClose
                },
                {
                    UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 16 * tbl2:getScale()) })
                }
            ),
            MessageBannerAnimator = Roact.createElement(Animator, {
                shouldAnimate = props.shouldAnimate,
                shouldShow = tbl2.state.showMessageBanner,
                animateDown = true,
                ZIndex = 10,
                renderChildren = function()
                    return Roact.createElement("Frame", {
                        AnchorPoint = Vector2.new(0, 0),
                        BackgroundTransparency = 0,
                        BackgroundColor3 = if props.themeName == ColorMode.Dark then Color3.fromRGB(17, 18, 20) else Color3.fromRGB(198, 203, 206),
                        Position = UDim2.fromOffset(48 * tbl2:getScale(), 40 * tbl2:getScale()),
                        Size = UDim2.new(1, -96 * tbl2:getScale(), 0, textSize * 2)
                    }, {
                        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 16 * tbl2:getScale()) }),
                        Icon = Roact.createElement(ImageSetLabel, {
                            AnchorPoint = Vector2.new(0, 0.5),
                            BackgroundTransparency = 1,
                            LayoutOrder = 1,
                            Image = iconsLogoBlock,
                            ImageColor3 = theme.TextEmphasis.Color,
                            ImageTransparency = 0,
                            Position = UDim2.fromOffset(24 * tbl2:getScale(), textSize),
                            Size = UDim2.fromOffset(36 * tbl2:getScale(), 36 * tbl2:getScale())
                        }),
                        AlertMessage = Roact.createElement(FitTextLabel, {
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.fromOffset(80 * tbl2:getScale(), textSize),
                            LayoutOrder = 2,
                            width = FitTextLabel.Width.FitToText,
                            Text = tbl3.SuccessfulMessage,
                            Font = font.Header1.Font,
                            TextColor3 = theme.TextEmphasis.Color,
                            TextTransparency = theme.TextEmphasis.Transparency,
                            TextSize = textSize,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BackgroundTransparency = 1
                        })
                    })
                end
            }),
            RobuxBalanceFrame = 0,
            BannerFrame = 0,
            RobuxPackageTilesFrame = 0
        }

        local createElement = Roact.createElement
        local var3 = FitFrameHorizontal
        local tbl6 = {
            Position = if isConsoleSize then UDim2.new(0.95, 0, 1, -textSize) else UDim2.new(1, -96 * tbl2:getScale(), 0, 48 * tbl2:getScale()),
            AnchorPoint = Vector2.new(1, 0),
            height = UDim.new(0, textSize),
            contentPadding = UDim.new(0, 4),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            BackgroundTransparency = 1
        }

        local tbl7 = {
            Icon = Roact.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(textSize + 15 * tbl2:getScale(), textSize + 15 * tbl2:getScale()),
                Image = iconsCommonGoldrobux,
                ImageTransparency = 0
            }),
            BalanceText = Roact.createElement(FitTextLabel, {
                LayoutOrder = 2,
                width = FitTextLabel.Width.FitToText,
                Text = if props.robuxBalance then formatNumber(LocalizationService.RobloxLocaleId, props.robuxBalance) else "",
                Font = font.Header1.Font,
                TextColor3 = if props.showBackground then Color3.new(255, 255, 255) else theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                TextSize = textSize,
                BackgroundTransparency = 1
            })
        }
        tbl5.RobuxBalanceFrame = createElement(var3, tbl6, tbl7)

        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl8 = {
            Position = if isConsoleSize then nil else UDim2.fromOffset(96 * tbl2:getScale(), 146 * tbl2:getScale()),
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = if isConsoleSize then 1 else nil,
            BackgroundTransparency = 1
        }

        local tbl9 = {
            UIPadding = isConsoleSize
                and Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) }),
            Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 36 * tbl2:getScale())
            }),
            BannerTitle = Roact.createElement("TextLabel", {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextXAlignment = Enum.TextXAlignment.Left,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.HeadingLarge.Font),
                Text = tbl3.BannerTitle,
                TextSize = 46 * tbl2:getScale(),
                TextColor3 = if props.showBackground then Color3.new(255, 255, 255) else theme.TextEmphasis.Color
            }),
            BannerText = Roact.createElement("TextLabel", {
                LayoutOrder = if isConsoleSize then 2 else 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = if isConsoleSize then true else nil,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.HeadingSmall.Font),
                Text = tbl3.BannerText,
                TextSize = 38 * tbl2:getScale(),
                TextColor3 = if props.showBackground then Color3.new(255, 255, 255) else theme.TextEmphasis.Color
            })
        }
        tbl5.BannerFrame = createElement2(str1, tbl8, tbl9)

        tbl5.RobuxPackageTilesFrame = Roact.createElement("ScrollingFrame", {
            Position = if isConsoleSize then nil else UDim2.new(0, 0, 0, 310 * tbl2:getScale()),
            Size = if isConsoleSize then UDim2.fromScale(1, 0.85) else UDim2.new(1, 0, 0, 615 * tbl2:getScale()),
            LayoutOrder = if isConsoleSize then 1 else nil,
            AutomaticSize = Enum.AutomaticSize.None,
            CanvasSize = if isConsoleSize then tbl2.canvasSize else UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = if isConsoleSize then Enum.AutomaticSize.None else Enum.AutomaticSize.X,
            ScrollingEnabled = scrollingEnabled,
            ScrollingDirection = Enum.ScrollingDirection.X,
            ScrollBarImageTransparency = 1,
            ScrollBarThickness = 0,
            Selectable = false,
            BackgroundTransparency = 1,
            [Roact.Ref] = tbl2.scrollingFrameRef,
            [Roact.Change.AbsoluteSize] = if isConsoleSize then tbl2.updateCanvasSize else nil
        }, tbl4)

        if isConsoleSize then
            tbl5.Content = Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1
            }, {
                BottomPadding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0.07, 0) }),
                UIListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 10)
                    }
                ),
                TopBar = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 0.1),
                        BackgroundTransparency = 1,
                        LayoutOrder = 0
                    },
                    {
                        CloseButton = tbl5.CloseButton,
                        RobuxBalanceFrame = tbl5.RobuxBalanceFrame
                    }
                ),
                BannerFrame = tbl5.BannerFrame,
                RobuxList = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 0),
                        LayoutOrder = 3,
                        BackgroundTransparency = 1
                    },
                    {
                        UIFlexItem = Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                        UIListLayout = Roact.createElement(
                            "UIListLayout",
                            {
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder
                            }
                        ),
                        UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) }),
                        TopPadding = Roact.createElement("Frame", { Size = UDim2.fromScale(0, 0.1), LayoutOrder = 0, BackgroundTransparency = 1 }),
                        RobuxPackageTilesFrame = tbl5.RobuxPackageTilesFrame
                    }
                )
            })
            tbl5.CloseButton = nil
            tbl5.RobuxBalanceFrame = nil
            tbl5.BannerFrame = nil
            tbl5.RobuxPackageTilesFrame = nil
        end

        return Roact.createElement(
            FullscreenFrame,
            {
                BackgroundColor3 = theme.BackgroundDefault.Color,
                BackgroundTransparency = 0
            },
            tbl5
        )
    end)
end

return function(arg1)
    local themeName = useStyleMetadata().ThemeName

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { themeName = themeName }))
end
