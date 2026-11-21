-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent

local React = require(CollectionViewsParent.React)
local Cryo = require(CollectionViewsParent.Cryo)
local UIBlox = require(CollectionViewsParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local useDesignTokens = require(CollectionViewsParent.Style).useDesignTokens
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local normalizeFontFace = require(CollectionViewsParent.Foundation).Utility.normalizeFontFace
local IconWithTooltip = require(CollectionViewsParent.AppBlox).IconWithTooltip
local Responsive = require(CollectionViewsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local checkAndFormatPossibleLink = require(CollectionViews.checkAndFormatPossibleLink)
local _SeeAllButtonType_Legacy = require(CollectionViews.SeeAllButtonType_Legacy)

local SharedFlags = require(CollectionViewsParent.SharedFlags)
local FFlagLuaAppSortHeaderAnchorTag = SharedFlags.FFlagLuaAppSortHeaderAnchorTag
local FFlagSduiComponentsUseFoundationTokens = SharedFlags.FFlagSduiComponentsUseFoundationTokens

local iconsActionsTruncationCollapse_small = Images["icons/actions/truncationCollapse_small"]
local iconsActionsCycleRight = Images["icons/actions/cycleRight"]

local tbl1 = {
    AutomaticSize = Enum.AutomaticSize.Y,
    Size = UDim2.new(1, 0, 0, 0),
    tooltipSupportsVR = true,
    tooltipSupportsTenFootUi = true
}

local function HeaderButton(tbl2)
    local var1 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local size400 = var1.Size.Size_400
    local emphasis = var1.Color.Content.Emphasis
    local image = tbl2.image
    return React.createElement(ImageSetLabel, {
        Size = tbl2.Size or UDim2.new(0, size400, 0, size400),
        BackgroundTransparency = 1,
        Image = image,
        ImageColor3 = emphasis.Color3,
        ImageTransparency = emphasis.Transparency,
        LayoutOrder = tbl2.LayoutOrder,
        Rotation = tbl2.Rotation,
        AnchorPoint = tbl2.AnchorPoint,
        Position = tbl2.Position
    })
end

return React.memo(function(tbl2) -- name: CollectionHeader
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2, var3 = React.useBinding(0)
    local var4 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.X)
    end, {})

    local var5 = usePreferredInput()
    local var6 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local var7 = var1.titleTypography or var6.Typography.HeadingSmall
    local var8 = var1.titleColor or var6.Color.Content.Emphasis

    local var9 = var1.subtitleTypography or var6.Typography.BodySmall

    local textSize = var1.subtitleTypography and var1.subtitleTypography.FontSize or 17.64 * var6.Stroke.Standard
    local var11 = var1.subtitleColor or var6.Color.Content.Default

    local size50 = var6.Size.Size_50

    local size300 = var6.Size.Size_300

    local bool1 = not not (not var1.hideButton and var5 ~= Responsive.Input.Directional and var1.onActivate)

    local size700 = var6.Size.Size_700

    local size100 = var6.Size.Size_100

    local size500 = var6.Size.Size_500

    local bool2 = var1.tooltipInfoText ~= nil

    local var12 = if bool1 then size500 else 0

    local var13 = if bool2 then size700 + size300 else 0

    local var14 = if bool2 then var13 else 0
    local bool3 = not (var1.subtitle == nil) and var1.subtitle ~= ""
    local var15, var16 = checkAndFormatPossibleLink(var1.subtitle)
    local var17 = if var1.onActivateSubtitle then var1.onActivateSubtitle else var1.onActivate

    if var1.onActivateSubtitle then
        var15 = true
    end

    local var18 = var15 and not (var1.hideSubtitleChevron or bool1)
    local size250 = var6.Size.Size_250
    local var19 = if var18 then size250 else 0

    local var20 = var15 and var17 ~= nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Position = var1.Position,
        AutomaticSize = var1.AutomaticSize,
        Size = var1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = var1.LayoutOrder,
        ZIndex = var1.ZIndex,
        [React.Tag] = if FFlagLuaAppSortHeaderAnchorTag then var1.headerTag else nil,
        [React.Change.AbsoluteSize] = var4
    }
    local tbl4 = { LeftContentFrame = 0, IconWithTooltip = 0 }
    local createElement2 = React.createElement
    local str2 = if bool1 then "TextButton" else "Frame"
    local tbl5 = {
        Text = if bool1 then "" else nil,
        Size = UDim2.new(1, -var14, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        AnchorPoint = var1.AnchorPoint,
        BorderSizePixel = 0,
        AutoButtonColor = not bool1 and nil,
        [React.Event.Activated] = if bool1 then var1.onActivate else nil,
        Active = bool1,
        Selectable = bool1
    }
    local tbl6 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, size50),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        TitleContainer = 0,
        SubtitleFrame = 0
    }
    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl8 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, size100),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Title = 0,
        SeeAllButton = 0
    }
    local title = var1.title
    local element

    if typeof(title) == "string" then
        element = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = var1.title,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, 0, 0, 0),
            FontFace = normalizeFontFace(var7.Font),
            TextSize = var7.FontSize,
            TextTransparency = var8.Transparency,
            TextColor3 = var8.Color3,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", {
                MaxSize = var2:map(function(num1: number)
                    local x = num1 - var12 - var13
                    if x > 0 then
                        return Vector2.new(x, math.huge)
                    end
                    return nil
                end)
            })
        })
    elseif typeof(var1.title) == "function" then
        element = var1.title()
    else
        element = nil
    end

    tbl8.Title = element

    tbl8.SeeAllButton = bool1
        and React.createElement(
            HeaderButton,
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(size500, size500),
                image = iconsActionsCycleRight
            }
        )
        or nil
    tbl6.TitleContainer = createElement3(str3, tbl7, tbl8)
    local var21

    if bool3 then
        local createElement4 = React.createElement
        local str4 = if var20 then "TextButton" else "Frame"
        local tbl9 = {
            LayoutOrder = 2,
            Text = if var20 then "" else nil,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutoButtonColor = not var20 and nil
        }
        local activated = React.Event.Activated

        if not var20 then
            var17 = nil
        end

        tbl9[activated] = var17
        tbl9.Active = var20
        tbl9.Selectable = var20

        var21 = createElement4(str4, tbl9, {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var6.Size.Size_50),
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            Subtitle = React.createElement("TextLabel", {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Text = var16,
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.new(0, 0, 0, 0),
                FontFace = normalizeFontFace(var9.Font),
                TextSize = textSize,
                TextTransparency = var8.Transparency,
                TextColor3 = var11.Color3,
                TextWrapped = false,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = var15
            }, {
                UISizeConstraint = React.createElement("UISizeConstraint", {
                    MaxSize = var2:map(function(num1: number)
                        local x = num1 - var19
                        if x > 0 then
                            return Vector2.new(x, math.huge)
                        end
                        return nil
                    end)
                })
            }),
            SubtitleLinkArrow = var18
                and React.createElement(
                    "Frame",
                    {
                        LayoutOrder = 2,
                        Size = UDim2.fromOffset(var19, var19),
                        BackgroundTransparency = 1,
                        ClipsDescendants = true
                    },
                    {
                        Icon = React.createElement(HeaderButton, {
                            image = iconsActionsTruncationCollapse_small,
                            Size = UDim2.new(1, var6.Size.Size_50, 1, var6.Size.Size_50),
                            Rotation = 90,
                            Position = UDim2.fromScale(0.5, 0.5),
                            AnchorPoint = Vector2.new(0.5, 0.5)
                        })
                    }
                )
                or nil
        })
            or nil
    else
        var21 = nil
    end

    tbl6.SubtitleFrame = var21
    tbl4.LeftContentFrame = createElement2(str2, tbl5, tbl6)
    local element2

    if bool2 then
        element2 = React.createElement(IconWithTooltip, {
            tooltipOrientation = TooltipOrientation.Bottom,
            hoverText = var1.tooltipInfoText,
            triggerPointName = "IconWithTooltip",
            onActivateTooltip = var1.onActivateInfoIcon,
            supportVR = var1.tooltipSupportsVR,
            supportTenFootUi = var1.tooltipSupportsTenFootUi,
            size = UDim2.new(0, size700, 0, size700),
            position = if bool3 then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 0.5, 0),
            anchorPoint = if bool3 then Vector2.new(1, 0) else Vector2.new(1, 0.5)
        })
            or nil
    else
        element2 = nil
    end

    tbl4.IconWithTooltip = element2
    return createElement(str1, tbl3, tbl4)
end)
