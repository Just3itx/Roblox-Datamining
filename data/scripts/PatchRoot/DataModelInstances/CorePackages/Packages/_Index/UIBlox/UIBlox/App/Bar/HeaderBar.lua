-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)

local _StyleTypes = require(scriptParentParent.Style.StyleTypes)
local _Fonts = require(scriptParentParent.Style.Fonts)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)
local ThreeSectionBar = require(scriptParentParentParent.Core.Bar.ThreeSectionBar)

local tbl1 = {
    barHeight = 48,
    title = "",
    isTitleCentered = true,
    isSecondary = false,
    isOnMedia = false,
    hasDivider = false
}

local function useHeaderBarStyle(tbl2, arg1)
    local tokens = arg1.Tokens
    local theme = arg1.Theme

    local backgroundStyle = tbl2.backgroundStyle
    local backgroundTransparency = tbl2.backgroundTransparency
    local isOnMedia = tbl2.isOnMedia
    local var1 = React.useMemo(function()
        if isOnMedia then
            return {}
        end

        local var1 = backgroundStyle or {
            Color3 = theme.BackgroundDefault.Color,
            Transparency = theme.BackgroundDefault.Transparency
        }

        if backgroundTransparency then
            var1.Transparency = backgroundTransparency
        end
        return var1
    end, {
        isOnMedia,
        backgroundStyle,
        backgroundTransparency,
        theme
    })
    local paddingTop = tbl2.paddingTop
    local paddingRight = tbl2.paddingRight
    local paddingBottom = tbl2.paddingBottom
    local paddingLeft = tbl2.paddingLeft
    local margin = tbl2.margin
    return {
        BackgroundStyle = var1,
        Padding = React.useMemo(function()
            local tbl3 = {
                Top = paddingTop or UDim.new(0, tokens.Size.Size_200),
                Right = paddingRight or UDim.new(0, tokens.Size.Size_500),
                Bottom = paddingBottom or UDim.new(0, tokens.Size.Size_200),
                Left = paddingLeft or UDim.new(0, tokens.Size.Size_500)
            }
            if margin then
                tbl3.Left = UDim.new(0, margin)
                tbl3.Right = UDim.new(0, margin)
            end

            return tbl3
        end, {
            paddingTop,
            paddingRight,
            paddingBottom,
            paddingLeft,
            margin,
            tokens
        })
    }
end

local function useRenderLeft(tbl2, arg1)
    return React.useMemo(function()
        local title = tbl2.title
        local renderLeft = tbl2.renderLeft
        local isTitleCentered = tbl2.isTitleCentered
        local isSecondary = tbl2.isSecondary
        local shouldHideSecondaryLeftItem = tbl2.shouldHideSecondaryLeftItem
        local bool1 = renderLeft == nil or renderLeft == React.None
        local tokens = arg1.Tokens

        local renderLeft2 = tbl2.renderLeft
        if bool1 and string.len(title) > 0 then
            return function(arg2)
                local var1 = Cryo.Dictionary.join(arg2.children, {
                    TextPadding = React.createElement(
                        "UIPadding",
                        {
                            PaddingTop = UDim.new(0, tokens.Size.Size_50),
                            PaddingBottom = UDim.new(0, tokens.Size.Size_50)
                        }
                    )
                })
                return React.createElement(React.Fragment, nil, {
                    Text = React.createElement(GenericTextLabel, {
                        fluidSizing = true,
                        Text = title,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        fontStyle = tokens.Typography.HeadingLarge,
                        colorStyle = tokens.Color.Content.Emphasis
                    }, var1)
                })
            end
        end

        if not isSecondary or shouldHideSecondaryLeftItem or not (string.len(title) > 0) then
            if not (isSecondary or isTitleCentered) then
                local headingSmall = tokens.Typography.HeadingSmall
                local fontSize = headingSmall.FontSize

                renderLeft2 = function()
                    local createElement = React.createElement
                    local fragment = React.Fragment
                    local var1 = nil
                    local tbl3 = { LeftFrame = 0 }
                    local createElement2 = React.createElement
                    local str1 = "Frame"
                    local tbl4 = {
                        Selectable = false,
                        Size = UDim2.new(1, 0, 0, fontSize),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    }

                    local tbl5 = {
                        Layout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, tokens.Size.Size_300)
                        }),
                        Left = React.createElement("Frame", {
                            LayoutOrder = 1,
                            Selectable = false,
                            Size = UDim2.fromOffset(0, 0),
                            BorderSizePixel = 0,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY
                        }, {
                            LeftContent = if renderLeft then renderLeft() else nil
                        }),
                        TextLabel = React.createElement(GenericTextLabel, {
                            LayoutOrder = 2,
                            Selectable = false,
                            ClipsDescendants = true,
                            Text = title,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            TextWrapped = false,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            fontStyle = headingSmall,
                            colorStyle = tokens.Color.Content.Emphasis
                        }, {
                            TextPadding = React.createElement(
                                "UIPadding",
                                {
                                    PaddingTop = UDim.new(0, tokens.Size.Size_50),
                                    PaddingBottom = UDim.new(0, tokens.Size.Size_50)
                                }
                            )
                        })
                    }
                    tbl3.LeftFrame = createElement2(str1, tbl4, tbl5)
                    return createElement(fragment, var1, tbl3)
                end
            end

            return renderLeft2
        end

        local theme = arg1.Theme
        local font = arg1.Font
        local header2 = font.Header2
        local yOffset = header2.RelativeSize * font.BaseSize

        return function()
            local createElement = React.createElement
            local fragment = React.Fragment
            local var1 = nil
            local tbl3 = { Text = 0 }
            local createElement2 = React.createElement
            local str1 = "Frame"
            local tbl4 = {
                Size = UDim2.new(1, 0, 0, yOffset),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }

            local tbl5 = {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 12)
                }),
                Left = React.createElement("Frame", {
                    LayoutOrder = 1,
                    Selectable = false,
                    Size = UDim2.fromOffset(0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY
                }, {
                    LeftContent = if renderLeft then renderLeft() else nil
                }),
                Divider = React.createElement("Frame", {
                    LayoutOrder = 2,
                    Selectable = false,
                    BackgroundColor3 = theme.Divider.Color,
                    BackgroundTransparency = theme.Divider.Transparency,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, 1, 1, 0)
                }),
                TextLabel = React.createElement(GenericTextLabel, {
                    LayoutOrder = 3,
                    Selectable = false,
                    ClipsDescendants = true,
                    Text = title,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    fontStyle = header2,
                    colorStyle = theme.TextEmphasis
                })
            }
            tbl3.Text = createElement2(str1, tbl4, tbl5)
            return createElement(fragment, var1, tbl3)
        end
    end, {
        tbl2.title,
        tbl2.isTitleCentered,
        tbl2.renderLeft,
        tbl2.isSecondary,
        tbl2.shouldHideSecondaryLeftItem,
        arg1
    })
end

local function HeaderBar(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local tokens = var2.Tokens

    local title = var1.title
    local renderCenter = var1.renderCenter
    local renderRight = var1.renderRight
    local isTitleCentered = var1.isTitleCentered
    local isSecondary = var1.isSecondary
    local onHeaderActivated = var1.onHeaderActivated
    local contentPaddingRight = var1.contentPaddingRight
    local automaticHeight = var1.automaticHeight
    local isOnMedia = var1.isOnMedia
    local zIndex = var1.zIndex
    local hasDivider = var1.hasDivider
    local bool1 = var1.renderLeft == nil or var1.renderLeft == React.None

    local renderLeft = useRenderLeft(var1, var2)

    local var3 = React.useMemo(function()
        local func1 = renderCenter

        if not func1 and not bool1 and not isSecondary and isTitleCentered then
            local headingSmall = tokens.Typography.HeadingSmall
            local fontSize = headingSmall.FontSize
            func1 = function()
                return React.createElement(GenericTextLabel, {
                    Selectable = false,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, 0, 0, fontSize),
                    Text = title,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    fontStyle = headingSmall,
                    colorStyle = tokens.Color.Content.Emphasis
                }, {
                    TextPadding = React.createElement(
                        "UIPadding",
                        {
                            PaddingTop = UDim.new(0, tokens.Size.Size_50),
                            PaddingBottom = UDim.new(0, tokens.Size.Size_50)
                        }
                    )
                })
            end
        end

        return func1
    end, {
        renderCenter,
        bool1,
        isSecondary,
        isTitleCentered,
        tokens,
        title
    })
    local estimatedCenterWidth = React.useMemo(function()
        if renderLeft and renderCenter and renderRight then
            return 0
        end

        if renderCenter or bool1 or isSecondary or not isTitleCentered then
            return math.huge
        end

        local headingSmall = tokens.Typography.HeadingSmall
        local fontSize = headingSmall.FontSize
        return GetTextSize(title, fontSize, headingSmall.Font, Vector2.new(math.huge, math.huge)).X
    end, {
        title,
        isTitleCentered,
        bool1,
        renderLeft,
        renderCenter,
        renderRight,
        isSecondary,
        tokens
    })
    local var4 = React.useMemo(function()
        if contentPaddingRight then
            return contentPaddingRight
        elseif bool1 then
            return UDim.new(0, 0)
        end

        return UDim.new(0, tokens.Size.Size_600)
    end, { contentPaddingRight, bool1, tokens })

    local tbl3 = useHeaderBarStyle(var1, var2)
    local backgroundStyle = tbl3.BackgroundStyle
    local padding = tbl3.Padding
    local yOffset = if isOnMedia then var1.barHeight + tokens.Size.Size_1000 else var1.barHeight
    local var7 = if automaticHeight then 0 else math.max(0, var1.barHeight - padding.Top.Offset - padding.Bottom.Offset)
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Selectable = false,
        Size = UDim2.new(1, 0, 0, yOffset),
        BorderSizePixel = 0,
        BackgroundColor3 = backgroundStyle.Color3,
        BackgroundTransparency = backgroundStyle.Transparency,
        AutomaticSize = if automaticHeight then Enum.AutomaticSize.Y else nil,
        ZIndex = zIndex
    }
    local tbl5 = {
        Gradient = 0,
        OnMediaExtendedHeight = 0,
        Bar = 0,
        HeaderClickArea = 0,
        BottomDivider = 0
    }
    local element

    if isOnMedia then
        element = React.createElement("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new(
                { ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) }
            ),
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 1) })
        })
    else
        element = nil
    end

    tbl5.Gradient = element

    tbl5.OnMediaExtendedHeight = if isOnMedia then React.createElement("UIPadding", { PaddingBottom = UDim.new(0, tokens.Size.Size_1000) }) else nil

    tbl5.Bar = React.createElement("Frame", {
        Selectable = false,
        Size = UDim2.fromScale(1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }, {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingTop = padding.Top,
                PaddingRight = padding.Right,
                PaddingBottom = padding.Bottom,
                PaddingLeft = padding.Left
            }
        ),
        ThreeSectionBar = React.createElement(ThreeSectionBar, {
            BackgroundTransparency = 1,
            barHeight = var7,
            automaticHeight = automaticHeight,
            renderLeft = renderLeft,
            renderCenter = var3,
            renderRight = renderRight,
            estimatedCenterWidth = estimatedCenterWidth,
            sectionSpacing = tokens.Size.Size_300,
            contentPaddingRight = var4
        })
    })
    local element2 = if onHeaderActivated then React.createElement("TextButton", {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        Selectable = false,
        [React.Event.Activated] = onHeaderActivated,
        ZIndex = 0
    }) else nil
    tbl5.HeaderClickArea = element2
    local element3

    if hasDivider then
        element3 = React.createElement("Frame", {
            Selectable = false,
            Size = UDim2.new(1, 0, 0, tokens.Stroke.Standard),
            Position = UDim2.new(0, 0, 1, -tokens.Stroke.Standard),
            BackgroundColor3 = tokens.Color.Stroke.Emphasis.Color3,
            BackgroundTransparency = tokens.Color.Stroke.Emphasis.Transparency,
            BorderSizePixel = 0,
            ZIndex = 1
        })
    else
        element3 = nil
    end

    tbl5.BottomDivider = element3
    return createElement(str1, tbl4, tbl5)
end

return HeaderBar
