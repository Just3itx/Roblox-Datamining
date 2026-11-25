-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local View = Foundation.View
local Icon = Foundation.Icon
local Image = Foundation.Image
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: SduiAttributionRow
    local layoutOrder = tbl1.layoutOrder
    local zIndex = tbl1.zIndex
    local position = tbl1.position
    local size = tbl1.size

    local var1 = useTokens()

    local var2 = tbl1.titleFontStyle or var1.Typography.TitleMedium
    local var3 = tbl1.subtitleFontStyle or var1.Typography.BodyMedium

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "row size-full-0 auto-y align-y-center align-x-left gap-medium",
        ZIndex = zIndex,
        Position = position,
        LayoutOrder = layoutOrder,
        Active = tbl1.onActivated ~= nil,
        onActivated = tbl1.onActivated,
        selection = { Selectable = false },
        Size = size or UDim2.new(1, 0, 0, var1.Size.Size_1000),
        testId = tbl1.testId,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
    }
    local tbl3 = {
        Image = tbl1.image
            and React.createElement(Image, {
                tag = "radius-medium",
                Image = tbl1.image,
                Size = tbl1.imageSize or UDim2.new(0, var1.Size.Size_1000, 0, var1.Size.Size_1000),
                LayoutOrder = 1
            }),
        TextContainer = 0,
        RightButtonContent = 0
    }

    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = { LayoutOrder = 2, tag = "col auto-xy fill" }

    local tbl5 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title,
            TextWrapped = tbl1.titleTextWrap,
            TextTruncate = tbl1.titleTextTruncate or Enum.TextTruncate.SplitWord,
            textStyle = tbl1.titleTextColor or var1.DarkMode.Content.Emphasis,
            fontStyle = tbl1.titleFontStyle or var2,
            tag = "auto-xy text-align-x-left",
            Size = tbl1.textContainerSize or UDim2.new(1, 0, 0, var1.Size.Size_500)
        }),
        SubtitleContainer = 0,
        Caption = 0
    }
    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = {
        LayoutOrder = 2,
        Size = tbl1.textContainerSize or UDim2.new(1, 0, 0, var1.Size.Size_500),
        onActivated = tbl1.subtitleOnActivated,
        tag = {
            ["row size-full-0 auto-y"] = true,
            ["align-y-center gap-xsmall"] = tbl1.subtitleIconName ~= nil
        }
    }
    local tbl7 = {
        Subtitle = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.subtitle,
            onActivated = tbl1.subtitleOnActivated,
            fontStyle = tbl1.subtitleFontStyle or var3,
            textStyle = tbl1.subtitleTextColor or var1.DarkMode.Content.Emphasis,
            TextWrapped = tbl1.subtitleTextWrap,
            TextTruncate = tbl1.subtitleTextTruncate or Enum.TextTruncate.SplitWord,
            tag = "auto-xy text-align-x-left"
        }),
        Icon = 0
    }
    local element

    if tbl1.subtitleIconName and tbl1.subtitleBackgroundIconName then
        local createElement4 = React.createElement
        local var7 = View
        local tbl8 = { LayoutOrder = 2, tag = "auto-xy" }

        local tbl9 = {
            BackgroundIcon = React.createElement(Icon, {
                size = if tbl1.subtitleIconSize then tbl1.subtitleIconSize else nil,
                name = tbl1.subtitleBackgroundIconName,
                style = if tbl1.subtitleBackgroundIconStyle then tbl1.subtitleBackgroundIconStyle else var1.Color.System.Emphasis
            }),
            ForegroundIcon = React.createElement(Icon, {
                size = if tbl1.subtitleIconSize then tbl1.subtitleIconSize else nil,
                variant = if tbl1.subtitleIconVariant then tbl1.subtitleIconVariant else nil,
                name = tbl1.subtitleIconName,
                style = tbl1.subtitleIconStyle
            })
        }
        element = createElement4(var7, tbl8, tbl9)
    elseif tbl1.subtitleIconName then
        element = React.createElement(Icon, {
            LayoutOrder = 2,
            size = if tbl1.subtitleIconSize then tbl1.subtitleIconSize else nil,
            name = tbl1.subtitleIconName,
            variant = if tbl1.subtitleIconVariant then tbl1.subtitleIconVariant else nil,
            style = if tbl1.subtitleIconStyle then tbl1.subtitleIconStyle else var1.Color.System.Emphasis
        })
    else
        element = nil
    end

    tbl7.Icon = element
    tbl5.SubtitleContainer = createElement3(var6, tbl6, tbl7)
    local element2

    if tbl1.caption then
        element2 = React.createElement(FoundationText, {
            LayoutOrder = 3,
            Text = tbl1.caption,
            textStyle = tbl1.captionTextColor or var1.Color.Content.Default,
            fontStyle = tbl1.captionFontStyle or var1.Typography.CaptionBody,
            tag = "auto-xy text-align-x-left text-truncate-split-word",
            Size = tbl1.textContainerSize
        })
    else
        element2 = nil
    end

    tbl5.Caption = element2
    tbl3.TextContainer = createElement2(var5, tbl4, tbl5)

    tbl3.RightButtonContent = tbl1.rightButtonContent
        and React.createElement(View, { LayoutOrder = 3, tag = "auto-xy row" }, { ButtonContent = tbl1.rightButtonContent })
    return createElement(var4, tbl2, tbl3)
end)
