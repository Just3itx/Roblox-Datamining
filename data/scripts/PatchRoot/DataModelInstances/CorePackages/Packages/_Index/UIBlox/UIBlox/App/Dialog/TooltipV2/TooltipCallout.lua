-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local _Types = require(scriptParent.Types)
local StyledTextLabel = require(scriptParentParentParent.Text.StyledTextLabel)
local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label
local Button = require(scriptParentParentParent.Button.Button)
local ButtonType = require(scriptParentParentParent.Button.Enum.ButtonType)
local StandardButtonSize = require(scriptParentParentParentParent.Core.Button.Enum.StandardButtonSize)

local KeyLabel = scriptParentParentParent.Menu.KeyLabel
local KeyLabel2 = require(KeyLabel.KeyLabel)
local _Types2 = require(KeyLabel.Types)
local getKeyLabelWidth = require(KeyLabel.Utilities).getKeyLabelWidth

local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local Constants = require(scriptParent.Constants)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local TooltipOrientation = require(scriptParentParent.Tooltip.Enum.TooltipOrientation)
local IconButton = require(scriptParentParentParentParent.App.Button.IconButton)
local IconSize = require(scriptParentParentParentParent.App.ImageSet.Enum.IconSize)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local function product(vector2: Vector2, vector2_2: Vector2): Vector2 -- Luacid: Inlined by compiler; 2 call sites recovered
    return Vector2.new(vector2.X * vector2_2.X, vector2.Y * vector2_2.Y)
end

function getOffsetPosition(vector2: Vector2, vector2_2: Vector2, orientation, num1: number)
    return vector2 + product(Constants.ORIENTATION_VECTOR[orientation], vector2_2 + Vector2.new(num1, num1))
end

local function vectorToPosition(vector2: Vector2): UDim2 -- Luacid: Inlined by compiler; 8 call sites recovered
    return UDim2.fromOffset(vector2.X, vector2.Y)
end

local function getContentAnchorPoint(orientation) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Vector2.new(0.5, 0.5) - 0.5 * Constants.ORIENTATION_VECTOR[orientation]
end

local function convertPadding(num1: number?, num2: number): UDim -- Luacid: Inlined by compiler; 6 call sites recovered
    return UDim.new(0, num1 or num2)
end

local function addOffsets(vector2: Vector2, tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return vector2 + Vector2.new(
        tbl1[TooltipOrientation.Left] + tbl1[TooltipOrientation.Right],
        tbl1[TooltipOrientation.Top] + tbl1[TooltipOrientation.Bottom]
    )
end

local function getHotkeysAndWidth(hotkeyCodes, num1: number, font)
    if not hotkeyCodes or #hotkeyCodes == 0 then
        return nil, num1
    end
    local tbl1 = {}
    local num2 = 0
    for layoutOrder, keyCode in ipairs(hotkeyCodes) do
        tbl1[layoutOrder] = React.createElement(KeyLabel2, { keyCode = keyCode, LayoutOrder = layoutOrder })

        num2 += getKeyLabelWidth(keyCode, font)
    end
    local xOffset = math.max(num2 + Constants.HOTKEY_PADDING * (#hotkeyCodes - 1), num1)
    tbl1.Layout = React.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, Constants.HOTKEY_PADDING)
    })
    return React.createElement("Frame", {
        Name = "Hotkeys",
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromOffset(xOffset, 0),
        LayoutOrder = 3
    }, tbl1), xOffset
end

return React.forwardRef(function(arg1, ref) -- name: TooltipWithRef
    assert(arg1.headerText or arg1.bodyText, "Must supply either header or body")
    assert(
        not (arg1.renderCustomComponents and arg1.buttonProps),
        "renderCustomComponents and buttonProps are not compatible"
    )

    local var1, var2 = React.useState(Vector2.zero)
    local var3 = useStyle()

    local textXAlignment = arg1.textAlignment or Enum.TextXAlignment.Left
    local horizontalAlignment = Enum.HorizontalAlignment[textXAlignment.Name]

    local theme = var3.Theme
    local font = var3.Font
    local settings = var3.Settings

    local baseSize = font.BaseSize
    local captionHeader = font.CaptionHeader
    local var6 = baseSize * captionHeader.RelativeSize

    local x = Constants.MAX_WIDTH - (arg1.PaddingLeft or Constants.DEFAULT_PADDING) - (arg1.PaddingRight or Constants.DEFAULT_PADDING)
    local vector2 = Vector2.new(x, math.huge)

    local num1 = 0
    local var7

    if arg1.headerText then
        local vector2_2 = Vector2.new(x, 2 * var6)
        local var8 = if arg1.onClose then vector2_2 - Vector2.new(Constants.CLOSE_BUTTON_SIZE, 0) else vector2_2
        var7 = GetTextSize(arg1.headerText, var6, captionHeader.Font, var8):Min(vector2_2)
        num1 = math.max(num1, var7.X)
    else
        var7 = nil
    end

    local fontStyle = if UIBloxConfig.enableTooltipV2BodyFontFix then font.BodySmall else font.CaptionBody
    local textSize

    if arg1.bodyText then
        textSize = GetTextSize(arg1.bodyText, baseSize * fontStyle.RelativeSize, fontStyle.Font, vector2)
        num1 = math.max(num1, textSize.X)
    else
        textSize = nil
    end

    if arg1.minContentWidth then
        num1 = math.max(num1, arg1.minContentWidth)
    end

    local hotkeys, xOffset = getHotkeysAndWidth(arg1.hotkeyCodes, num1, font)

    local var10 = nil
    if arg1.renderCustomComponents then
        var10 = {
            Content = arg1.renderCustomComponents(xOffset),
            SizeConstraint = React.createElement("UISizeConstraint", { MaxSize = vector2 })
        }
    elseif arg1.buttonProps then
        local var11 = LuauPolyfill.Object.assign(
            {},
            arg1.buttonProps,
            {
                buttonType = ButtonType.PrimarySystem,
                standardSize = StandardButtonSize.XSmall,
                fontStyle = captionHeader
            }
        )
        var10 = {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                }
            ),
            SizeContraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(0, 28) }),
            Button = React.createElement(Button, var11)
        }
    end

    local customContent = var10
        and React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, xOffset, 0, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 4,
            Name = if arg1.renderCustomComponents then "CustomComponents" else "ButtonFrame"
        }, var10)
    local element2

    if hotkeys and customContent then
        element2 = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, xOffset, 0, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 3
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = convertPadding(arg1.listPadding, Constants.DEFAULT_LIST_PADDING),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Hotkeys = hotkeys,
            CustomContent = customContent
        })
    else
        element2 = hotkeys or customContent
    end

    local var11 = if arg1.useLargeDropShadow then Constants.DropShadow.Large else Constants.DropShadow.Small
    local var12 = Constants.OPPOSITE_ORIENTATION[arg1.orientation]
    local var13 = addOffsets(var1, var11.OFFSET)

    local var14 = table.clone(var11.OFFSET)

    local var15 = Constants.CONTENT_TO_CARET_TIP - var14[var12]
    local num2 = math.max(0, var15)

    var14[var12] += num2
    local vector2_2 = Vector2.new(var14[TooltipOrientation.Left], var14[TooltipOrientation.Top])

    local vector2_3 = Vector2.zero:Max(Constants.ORIENTATION_VECTOR[arg1.orientation] * num2)
    local var16 = vector2_2 + product(var1, (getContentAnchorPoint(arg1.orientation))) - arg1.contentOffsetVector + Constants.ORIENTATION_VECTOR[var12] * Constants.CONTENT_TO_CARET_CENTER
    local var17 = addOffsets(var1, var14)
    local num3 = math.floor(arg1.distanceOffset + 0.5)
    local var18 = getOffsetPosition(
        arg1.triggerPointCenter,
        arg1.triggerPointRadius,
        arg1.orientation,
        Constants.CARET_DISTANCE + math.min(0, var15) + num3
    ) + arg1.contentOffsetVector

    local backgroundUiDefault = theme.BackgroundUIDefault
    local var19 = arg1.backgroundColor or backgroundUiDefault.Color
    local var20 = (arg1.backgroundTransparency or backgroundUiDefault.Transparency) * settings.PreferredTransparency

    local createElement = React.createElement
    local str1 = "CanvasGroup"
    local tbl1 = {
        GroupTransparency = arg1.transparency,
        Position = vectorToPosition(var18),
        Size = vectorToPosition(var17),
        AnchorPoint = getContentAnchorPoint(arg1.orientation),
        BackgroundTransparency = if arg1.canvasBackground then arg1.canvasBackground.Transparency else 1,
        BackgroundColor3 = if arg1.canvasBackground then arg1.canvasBackground.Color else nil,
        BorderSizePixel = 0
    }
    local tbl2 = {
        Caret = React.createElement(Label, {
            Image = Constants.CARET_IMAGE,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = vectorToPosition(var16),
            BackgroundTransparency = 1,
            Size = Constants.CARET_SIZE,
            Rotation = Constants.CARET_ROTATION[arg1.orientation],
            ImageColor3 = var19,
            ImageTransparency = var20,
            ZIndex = 2
        }),
        DropShadow = React.createElement(Label, {
            Image = var11.IMAGE,
            ImageColor3 = theme.DropShadow.Color,
            ImageTransparency = theme.DropShadow.Transparency,
            BackgroundTransparency = 1,
            Position = vectorToPosition(vector2_3),
            Size = vectorToPosition(var13),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = var11.SLICE_CENTER,
            ZIndex = 1
        }),
        Box = 0,
        CloseButton = 0
    }

    local createElement2 = React.createElement
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = vectorToPosition(vector2_2),
        BackgroundColor3 = var19,
        BackgroundTransparency = var20
    }
    tbl3[React.Change.AbsoluteSize] = function(arg2)
        var2(arg2.AbsoluteSize)
        if arg1.onContentSizeChanged then
            arg1.onContentSizeChanged(arg2.AbsoluteSize)
        end
    end
    tbl3.ref = ref
    tbl3.ZIndex = 2
    tbl2.Box = createElement2("Frame", tbl3, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = horizontalAlignment,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = convertPadding(arg1.listPadding, Constants.DEFAULT_LIST_PADDING)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = convertPadding(arg1.PaddingTop, Constants.DEFAULT_PADDING),
            PaddingBottom = convertPadding(arg1.PaddingBottom, Constants.DEFAULT_PADDING),
            PaddingLeft = convertPadding(arg1.PaddingLeft, Constants.DEFAULT_PADDING),
            PaddingRight = convertPadding(arg1.PaddingRight, Constants.DEFAULT_PADDING)
        }),
        Corner = React.createElement("UICorner", { CornerRadius = Constants.CORNER_RADIUS }),
        Header = arg1.headerText
            and React.createElement(StyledTextLabel, {
                text = arg1.headerText,
                fontStyle = captionHeader,
                colorStyle = theme.TextEmphasis,
                textYAlignment = Enum.TextYAlignment.Center,
                textXAlignment = textXAlignment,
                textTruncate = Enum.TextTruncate.AtEnd,
                layoutOrder = 1,
                size = vectorToPosition(var7),
                fluidSizing = false,
                richText = arg1.enableHeaderRichText,
                lineHeight = 1
            }),
        Body = arg1.bodyText
            and React.createElement(StyledTextLabel, {
                text = arg1.bodyText,
                fontStyle = fontStyle,
                colorStyle = theme.TextEmphasis,
                textYAlignment = Enum.TextYAlignment.Center,
                textXAlignment = textXAlignment,
                textTruncate = Enum.TextTruncate.None,
                layoutOrder = 2,
                size = vectorToPosition(textSize),
                fluidSizing = false,
                richText = arg1.enableBodyRichText,
                lineHeight = 1
            }),
        Additional = element2
    })
    local element3

    if arg1.onClose == nil then
        element3 = false
    else
        element3 = React.createElement("Frame", {
            BackgroundTransparency = 1,
            ZIndex = 3,
            Size = UDim2.fromOffset(Constants.CLOSE_BUTTON_SIZE, Constants.CLOSE_BUTTON_SIZE),
            Position = UDim2.new(1, -(Constants.CLOSE_BUTTON_SIZE + Constants.CLOSE_BUTTON_PADDING * 2), 0, Constants.CLOSE_BUTTON_SIZE / 2)
        }, {
            Button = React.createElement(IconButton, {
                backgroundTransparency = 1,
                icon = Images["icons/navigation/close"],
                iconSize = IconSize.Small,
                size = UDim2.new(1, 0, 1, 0),
                onActivated = arg1.onClose
            })
        })
    end

    tbl2.CloseButton = element3
    return createElement(str1, tbl1, tbl2)
end)
