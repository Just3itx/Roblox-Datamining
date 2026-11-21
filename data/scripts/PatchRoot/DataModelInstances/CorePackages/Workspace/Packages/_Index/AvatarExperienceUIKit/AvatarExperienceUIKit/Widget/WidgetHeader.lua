-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local normalizeFontFace = require(AvatarExperienceUIKitParent.Foundation).Utility.normalizeFontFace
local useLocalization = require(AvatarExperienceUIKitParent.Localization).Hooks.useLocalization
local UIBlox = require(AvatarExperienceUIKitParent.UIBlox)
local IconWithTooltip = require(AvatarExperienceUIKitParent.AppBlox).IconWithTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens

local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXWidgetHeaderTreatEmptyTextAsNil = AvatarExperienceFlags.FFlagAXWidgetHeaderTreatEmptyTextAsNil
local FFlagAXCatalogItemInformationPopover = AvatarExperienceFlags.FFlagAXCatalogItemInformationPopover
local FFlagAXWidgetHeaderFlexLayout = AvatarExperienceFlags.FFlagAXWidgetHeaderFlexLayout

local function nonEmptyOrNil(str1: string?): string? -- Luacid: Inlined by compiler; 3 call sites recovered
    return if str1 == nil or str1 == "" then nil else str1
end

local function WidgetHeader(tbl1)
    local var1, var2 = React.useBinding(Vector2.new())
    local var3 = useDesignTokens()
    local var4 = useLocalization(
        {
            title = tbl1.titleKey,
            description = tbl1.descriptionKey,
            seeAllButtonText = "Feature.Catalog.ActionSeeAll"
        }
    )
    local var5, var6

    if FFlagAXWidgetHeaderTreatEmptyTextAsNil then
        var5 = nonEmptyOrNil(tbl1.titleText) or nonEmptyOrNil(var4.title)
        var6 = nonEmptyOrNil(tbl1.descriptionText)

        if not var6 then
            var6 = var4.description

            if var6 == nil or var6 == "" then
                var6 = nil
            end
        end
    else
        if tbl1.titleText then
            var5 = tbl1.titleText
        else
            var5 = var4.title
        end

        if tbl1.descriptionText then
            var6 = tbl1.descriptionText
        else
            var6 = var4.description
        end
    end
    local bool1 = FFlagAXCatalogItemInformationPopover

    if bool1 then
        if tbl1.informationPopoverText == nil or tbl1.informationPopoverText == "" then
            bool1 = false
        else
            bool1 = tbl1.onInformationIconActivated ~= nil
        end
    end

    local element

    if var5 then
        local createElement = React.createElement
        local str1 = "TextLabel"
        local tbl2 = {
            LayoutOrder = 1,
            Text = var5,
            FontFace = normalizeFontFace(var3.Typography.HeadingSmall.Font),
            TextSize = var3.Typography.HeadingSmall.FontSize,
            LineHeight = var3.Typography.HeadingSmall.LineHeight,
            TextColor3 = var3.Color.Content.Emphasis.Color3,
            TextTransparency = var3.Color.Content.Emphasis.Transparency,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Size = if bool1 then UDim2.fromOffset(0, 0) else UDim2.fromScale(1, 0),
            AutomaticSize = if bool1 then Enum.AutomaticSize.XY else Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        }
        local tbl3 = {
            UIFlexItem = if bool1 then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }) else nil,
            UISizeConstraint = if FFlagAXWidgetHeaderFlexLayout or not tbl1.seeAllCallback then nil else React.createElement("UISizeConstraint", {
                MinSize = var1:map(function(vector2: Vector2): Vector2
                    return Vector2.new(0, vector2.Y)
                end)
            })
        }

        element = createElement(str1, tbl2, tbl3)
    else
        element = nil
    end

    if var5 then
        if bool1 then
            element = React.createElement("Frame", {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, var3.Size.Size_100)
                }),
                Title = element,
                InformationIcon = React.createElement("Frame", {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                }, {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.None }),
                    Icon = React.createElement(IconWithTooltip, {
                        tooltipOrientation = TooltipOrientation.Right,
                        hoverText = tbl1.informationPopoverText,
                        onActivateTooltip = tbl1.onInformationIconActivated,
                        triggerPointName = "CatalogItemInformationTooltip",
                        supportTenFootUi = true,
                        supportVR = true
                    })
                })
            })
        end
    else
        element = nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { UIListLayout = 0, TitleDescriptionFrame = 0, SeeAll = 0 }
    local element2

    if FFlagAXWidgetHeaderFlexLayout then
        element2 = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var3.Size.Size_300)
        })
    else
        element2 = nil
    end

    tbl3.UIListLayout = element2
    local var7

    if var5 or var6 then
        local createElement2 = React.createElement
        local str2 = "Frame"

        local tbl4 = {
            LayoutOrder = if FFlagAXWidgetHeaderFlexLayout then 1 else nil,
            Size = if FFlagAXWidgetHeaderFlexLayout then UDim2.new(1, 0, 0, 0) elseif tbl1.seeAllCallback then var1:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, 0 - (vector2.X + var3.Size.Size_300), 0, 0)
            end) else UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl5 = {
            UIFlexItem = if FFlagAXWidgetHeaderFlexLayout then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }) else nil,
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var3.Size.Size_100)
            }),
            Title = element,
            Description = 0
        }
        local element3

        if var6 then
            element3 = React.createElement("TextLabel", {
                LayoutOrder = 2,
                Text = var6,
                FontFace = normalizeFontFace(var3.Typography.BodyLarge.Font),
                TextSize = var3.Typography.BodyLarge.FontSize,
                TextColor3 = var3.Color.Content.Default.Color3,
                TextTransparency = var3.Color.Content.Default.Transparency,
                TextTruncate = Enum.TextTruncate.SplitWord,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
        else
            element3 = nil
        end

        tbl5.Description = element3
        var7 = createElement2(str2, tbl4, tbl5)
    else
        var7 = nil
    end

    tbl3.TitleDescriptionFrame = var7
    local element3

    if FFlagAXWidgetHeaderFlexLayout and tbl1.seeAllCallback then
        element3 = React.createElement(Button, {
            buttonType = ButtonType.Secondary,
            layoutOrder = 2,
            text = var4.seeAllButtonText,
            fitContent = true,
            standardSize = StandardButtonSize.XSmall,
            onActivated = tbl1.seeAllCallback,
            buttonRef = tbl1.seeAllRef,
            NextSelectionDown = tbl1.NextSelectionDown,
            NextSelectionUp = tbl1.NextSelectionUp
        })
    elseif tbl1.seeAllCallback then
        local createElement2 = React.createElement
        local var8 = Button
        local tbl4 = {
            buttonType = ButtonType.Secondary,
            anchorPoint = Vector2.new(1, 0),
            position = UDim2.fromScale(1, 0),
            text = var4.seeAllButtonText,
            fitContent = true,
            standardSize = StandardButtonSize.XSmall,
            onActivated = tbl1.seeAllCallback,
            buttonRef = tbl1.seeAllRef
        }

        tbl4[React.Change.AbsoluteSize] = function(arg1)
            var2(arg1.AbsoluteSize)
        end
        tbl4.NextSelectionDown = tbl1.NextSelectionDown
        tbl4.NextSelectionUp = tbl1.NextSelectionUp
        element3 = createElement2(var8, tbl4)
    else
        element3 = nil
    end

    tbl3.SeeAll = element3
    return createElement(str1, tbl2, tbl3)
end

return WidgetHeader
