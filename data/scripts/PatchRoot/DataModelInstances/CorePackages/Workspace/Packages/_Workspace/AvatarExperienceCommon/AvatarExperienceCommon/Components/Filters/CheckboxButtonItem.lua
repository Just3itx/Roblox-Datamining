-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Cryo = require(AvatarExperienceCommonParent.Cryo)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local Checkbox = Foundation.Checkbox
local FoundationText = Foundation.Text
local View = Foundation.View
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens
local UIBlox = require(AvatarExperienceCommonParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Focusable = require(AvatarExperienceCommonParent.RoactGamepad).Focusable

local ExpandingFrame = require(script.Parent.ExpandingFrame)
local FFlagAXCatalogSpecialFeaturesFilter = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXCatalogSpecialFeaturesFilter

local function CheckboxButtonItem(tbl1)
    local var1 = useTokens()
    local var2 = useStyle()
    local onActivated = React.useCallback(function()
        if tbl1.onActivated then
            tbl1.onActivated(tbl1.id)
        end
    end, { tbl1.onActivated, tbl1.id })

    local yOffset = tbl1.itemHeight or var1.Size.Size_900

    local ref = React.useRef(nil)

    local var5, var6 = React.useBinding(yOffset)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local var7 = yOffset
        if arg1 then
            var7 += arg1.AbsoluteSize.Y
        end
        if not tbl1.hideDivider then
            var7 += if FFlagAXCatalogSpecialFeaturesFilter then 1 else var1.Size.Size_50
        end
        var6(var7)
        if tbl1.onHeightChanged then
            tbl1.onHeightChanged(var7)
        end
    end, {
        yOffset,
        tbl1.hideDivider,
        var6,
        tbl1.onHeightChanged
    })
    React.useEffect(function()
        onAbsoluteSizeChanged(ref.current)
    end, {})

    local var8 = tbl1.expandedView and tbl1.isSelected == true
    local element

    if FFlagAXCatalogSpecialFeaturesFilter and not tbl1.hideDivider then
        element = React.createElement(
            "Frame",
            {
                LayoutOrder = 3,
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                Line = React.createElement("Frame", {
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -12, 0, 0),
                    Size = UDim2.new(1, -24, 1, 0),
                    BackgroundColor3 = var1.Color.Stroke.Emphasis.Color3,
                    BackgroundTransparency = var1.Color.Stroke.Emphasis.Transparency,
                    BorderSizePixel = 0
                })
            }
        )
    else
        element = nil
    end

    local createElement = React.createElement
    local str1 = "Frame"

    local tbl2 = {
        Size = var5:map(function(yOffset2: number?): UDim2
            return UDim2.new(1, 0, 0, yOffset2)
        end),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        ref = tbl1.frameRef,
        NextSelectionLeft = tbl1.NextSelectionLeft,
        NextSelectionRight = tbl1.NextSelectionRight,
        NextSelectionUp = tbl1.NextSelectionUp,
        NextSelectionDown = tbl1.NextSelectionDown
    }

    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Right
        }),
        Contents = 0,
        ExpandingFrame = 0,
        Divider = 0
    }
    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = {
        Size = if FFlagAXCatalogSpecialFeaturesFilter then UDim2.new(1, 0, 0, yOffset) else nil,
        tag = if FFlagAXCatalogSpecialFeaturesFilter then "row items-center" else "size-full row items-center padding-left-large padding-y-medium padding-right-none",
        padding = FFlagAXCatalogSpecialFeaturesFilter
            and {
                left = UDim.new(0, 24),
                top = UDim.new(0, 12),
                bottom = UDim.new(0, 12),
                right = UDim.new(0, 12)
            }
            or nil,
        LayoutOrder = 1,
        ref = tbl1.defaultChildRef,
        NextSelectionDown = if var8 then ref else nil,
        SelectionImageObject = tbl1.SelectionImageObject
    }
    local tbl5 = { ClickableTextArea = 0, RightContent = 0 }
    local createElement3 = React.createElement
    local str2 = "TextButton"
    local tbl6 = {
        Size = if FFlagAXCatalogSpecialFeaturesFilter then UDim2.new(1, -24, 1, 0) else UDim2.new(1, -var1.Size.Size_400 - var1.Size.Size_400, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        Active = not tbl1.isDisabled,
        [React.Event.Activated] = if tbl1.isDisabled then nil else onActivated,
        LayoutOrder = 1
    }
    local tbl7 = {
        CustomViewFrame = tbl1.customView
            and React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    tag = "gui-object-defaults",
                    LayoutOrder = 1
                },
                {
                    CustomView = tbl1.customView
                }
            ),
        TitleText = 0
    }
    local var10 = tbl1.text and not tbl1.customView

    if var10 then
        if FFlagAXCatalogSpecialFeaturesFilter then
            var10 = React.createElement(StyledTextLabel, {
                size = UDim2.new(1, 0, 1, 0),
                colorStyle = if tbl1.isSelected then var2.Theme.TextEmphasis else var2.Theme.TextDefault,
                fontStyle = var2.Font.Header2,
                text = tbl1.text,
                layoutOrder = 1,
                textXAlignment = Enum.TextXAlignment.Left
            })
        else
            var10 = React.createElement(FoundationText, {
                Size = UDim2.new(1, 0, 1, 0),
                Text = tbl1.text,
                LayoutOrder = 1,
                tag = "text-title-medium content-default text-align-x-left auto-y"
            })
        end
    end

    tbl7.TitleText = var10
    tbl5.ClickableTextArea = createElement3(str2, tbl6, tbl7)
    local element2

    if FFlagAXCatalogSpecialFeaturesFilter then
        element2 = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(var1.Size.Size_600, var1.Size.Size_600),
                BackgroundTransparency = 1,
                LayoutOrder = 3
            },
            {
                UIScale = React.createElement("UIScale", { Scale = 24 / var1.Size.Size_600 }),
                Checkbox = React.createElement(Focusable[Checkbox], {
                    label = "",
                    isChecked = tbl1.isSelected,
                    isDisabled = tbl1.isDisabled,
                    onActivated = onActivated,
                    size = InputSize.Medium
                })
            }
        )
    else
        element2 = React.createElement(Focusable[Checkbox], {
            label = "",
            isChecked = tbl1.isSelected,
            isDisabled = tbl1.isDisabled,
            onActivated = onActivated,
            size = InputSize.Medium,
            LayoutOrder = 3
        })
    end

    tbl5.RightContent = element2
    tbl3.Contents = createElement2(var9, tbl4, tbl5)

    tbl3.ExpandingFrame = tbl1.expandedView
        and React.createElement(Focusable[ExpandingFrame], {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, tbl1.expandedViewHeight or 0),
            isExpanded = tbl1.isSelected == true,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            ref = ref,
            NextSelectionUp = tbl1.defaultChildRef
        }, {
            ExpandedView = tbl1.expandedView
        })

    tbl3.Divider = element
    return createElement(str1, tbl2, tbl3)
end

return React.forwardRef(function(arg1, frameRef)
    return React.createElement(CheckboxButtonItem, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
