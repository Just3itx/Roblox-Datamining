-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local UIBlox = require(ServerDrivenUiParent.UIBlox)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useLocalization = require(ServerDrivenUiParent.Localization).Hooks.useLocalization

local withStyle = UIBlox.Style.withStyle
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local LoadableImage = UIBlox.App.Loading.LoadableImage
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: SduiSearchAutocompleteSuggestion
    local var1 = useTokens()
    local bool1 = tbl1.isRich == true
    local bool2 = (tbl1.layoutOrder or 1) > 1
    local yOffset = if bool1 then var1.Size.Size_1600 else var1.Size.Size_1400
    local size1100 = var1.Size.Size_1100
    local size900 = var1.Size.Size_900
    local size600 = var1.Size.Size_600
    local var2, var3 = React.useState(false)
    local var4 = useLocalization({ category = "Feature.GameBadges.Label.Experience" })

    React.useEffect(function()
        if not var2 then
            return
        end

        local connection = UserInputService.InputEnded:Connect(function()
            var3(false)
        end)
        return function()
            connection:Disconnect()
        end
    end, { var2 })

    local function onInputBegan(_, arg1)
        if (arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1)
            and arg1.UserInputState == Enum.UserInputState.Begin
        then
            var3(true)
        end
    end

    return withSelectionCursorProvider(function(arg1)
        return withStyle(function(arg2)
            local createElement = React.createElement
            local str1 = "ImageButton"
            local tbl2 = {
                Image = "",
                BackgroundColor3 = if var2 then arg2.Theme.BackgroundOnPress.Color else arg2.Theme.BackgroundDefault.Color,
                BackgroundTransparency = if var2 then arg2.Theme.BackgroundOnPress.Transparency else 1,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                Size = UDim2.new(1, 0, 0, yOffset),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = tbl1.layoutOrder,
                Selectable = true,
                Active = true,
                SelectionImageObject = arg1(CursorKind.RoundedRectNoInset)
            }

            tbl2[React.Event.Activated] = function()
                if tbl1.onActivated then
                    tbl1.onActivated()
                end
            end
            tbl2[React.Event.InputBegan] = onInputBegan
            tbl2[React.Event.InputEnded] = function()
                var3(false)
            end
            tbl2[React.Tag] = "data-testid=--sdui-autocomplete-suggestion"
            local tbl3 = { Divider = 0, Container = 0 }
            local element

            if bool2 then
                element = React.createElement("Frame", {
                    BackgroundColor3 = arg2.Theme.Divider.Color,
                    BackgroundTransparency = arg2.Theme.Divider.Transparency,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, var1.Stroke.Standard),
                    [React.Tag] = "data-testid=--sdui-autocomplete-divider"
                })
            else
                element = nil
            end

            tbl3.Divider = element

            local createElement2 = React.createElement
            local str2 = "Frame"
            local tbl4 = {
                Position = if bool2 then UDim2.fromOffset(0, var1.Stroke.Standard) else nil,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                [React.Tag] = "data-testid=--sdui-autocomplete-container"
            }
            local tbl5 = {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 9)
                }),
                LeftSpacing = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(0, 0, 0, yOffset),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        LayoutOrder = 1
                    }
                ),
                SearchIcon = React.createElement(Foundation.Icon, {
                    name = "magnifying-glass",
                    size = size600,
                    style = {
                        Color3 = arg2.Theme.IconDefault.Color,
                        Transparency = arg2.Theme.IconDefault.Transparency
                    },
                    LayoutOrder = 2,
                    testId = "--sdui-autocomplete-search-icon"
                }),
                Content = 0,
                RichIcon = 0
            }

            local createElement3 = React.createElement
            local str3 = "Frame"
            local tbl6 = {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -(size600 + size1100 + 36 + var1.Padding.Small), 1, 0),
                LayoutOrder = 3
            }

            local tbl7 = {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 5)
                }),
                Title = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Text = tbl1.title,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                    TextSize = arg2.Font.BaseSize * arg2.Font.Body.RelativeSize,
                    TextColor3 = arg2.Theme.TextDefault.Color,
                    TextTransparency = arg2.Theme.TextDefault.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    [React.Tag] = "data-testid=--sdui-autocomplete-title"
                }),
                Category = 0
            }
            local element2

            if bool1 then
                element2 = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Text = var4.category,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font),
                    TextSize = arg2.Font.BaseSize * arg2.Font.CaptionBody.RelativeSize,
                    TextColor3 = arg2.Theme.TextMuted.Color,
                    TextTransparency = arg2.Theme.TextMuted.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    [React.Tag] = "data-testid=--sdui-autocomplete-category"
                })
            else
                element2 = nil
            end

            tbl7.Category = element2
            tbl5.Content = createElement3(str3, tbl6, tbl7)
            local element3

            if bool1 and tbl1.richIcon ~= nil then
                element3 = React.createElement("Frame", {
                    Size = UDim2.fromOffset(size1100, size1100),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    [React.Tag] = "data-testid=--sdui-autocomplete-rich-icon-container"
                }, {
                    Shadow = React.createElement("Frame", {
                        Size = UDim2.fromOffset(size900, size900),
                        Position = UDim2.fromOffset(var1.Size.Size_200, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = arg2.Theme.BackgroundOnHover.Color,
                        BackgroundTransparency = arg2.Theme.BackgroundOnHover.Transparency,
                        ZIndex = 10
                    }),
                    Border = React.createElement("Frame", {
                        Size = UDim2.fromOffset(size900, size900),
                        Position = UDim2.fromOffset(var1.Size.Size_50, var1.Size.Size_150),
                        BorderSizePixel = 0,
                        BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
                        BackgroundTransparency = arg2.Theme.BackgroundDefault.Transparency,
                        ZIndex = 11
                    }),
                    GameIcon = React.createElement(LoadableImage, {
                        Size = UDim2.fromOffset(size900, size900),
                        Position = UDim2.fromOffset(0, var1.Size.Size_200),
                        BackgroundTransparency = 1,
                        Image = tbl1.richIcon,
                        useShimmerAnimationWhileLoading = true,
                        ZIndex = 12
                    })
                })
            else
                element3 = nil
            end

            tbl5.RichIcon = element3
            tbl3.Container = createElement2(str2, tbl4, tbl5)
            return createElement(str1, tbl2, tbl3)
        end)
    end)
end)
