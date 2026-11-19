-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Focusable = RoactGamepad.Focusable

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local withStyle = UIBlox.Style.withStyle
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local component_assetsCircle_17_stroke_1 = Images["component_assets/circle_17_stroke_1"]
local rect = Rect.new(8, 8, 8, 8)

local var1 = Roact.PureComponent:extend("AssetDescriptionTextBox")

var1.validateProps = t.strictInterface({
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    onAssetDescriptionUpdated = t.callback,
    descriptionTextBoxRef = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    assetType = t.optional(t.enum(Enum.AssetType)),
    defaultDescription = t.optional(t.string)
})

local function getStringLength(str1: string): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = utf8.len(utf8.nfcnormalize(str1))
    return if var2 == nil then 0 else var2
end

local function isDescriptionTooLong(str1: string, num1: number): boolean -- Luacid: unused: defined but never referenced
    return num1 < getStringLength(str1)
end

function var1.init(arg1)
    arg1:setState({
        lastValidDescription = "",
        assetDescription = arg1.props.defaultDescription or "",
        descriptionLength = 0,
        scrollingFrameHeight = 100,
        canvasHeight = 100,
        canvasPosition = 0,
        cursorPosition = 0,
        textBoxWidth = 100
    })

    arg1.wasInitiallyFocused = false

    function arg1.tryFocusTextBox()
        if arg1.wasInitiallyFocused then
            return
        end

        local value = arg1.props.descriptionTextBoxRef:getValue()
        if value and value:IsDescendantOf(game) then
            value:CaptureFocus()
            arg1.wasInitiallyFocused = true
        end
    end
end

function var1.calculateNeedsRescroll(tbl1, arg1, tbl2)
    if tbl1.state.cursorPosition == -1 then
        return
    end

    local var2 = (tbl1.state.assetDescription or ""):sub(1, tbl1.state.cursorPosition - 1)
    local var3 = tbl2.RelativeSize * arg1.Font.BaseSize
    local vector2 = Vector2.new(tbl1.state.textBoxWidth, 10000)
    local textSize = GetTextSize(var2, var3, arg1.Tokens.Typography.BodySmall.Font, vector2, { addTemporaryPadding = false })

    if textSize.Y > tbl1.state.scrollingFrameHeight + tbl1.state.canvasPosition then
        tbl1:setState({ canvasPosition = textSize.Y - tbl1.state.scrollingFrameHeight })
    elseif textSize.Y - var3 < tbl1.state.canvasPosition then
        tbl1:setState({ canvasPosition = textSize.Y - var3 })
    end
end

function var1.onTextChanged(tbl1, arg1, arg2, tbl2)
    local text = arg1.Text

    local lastValidDescription = tbl1.state.lastValidDescription

    if getStringLength(text) > 1000 then
        arg1.Text = lastValidDescription
        text = lastValidDescription
    else
        lastValidDescription = arg1.Text
    end

    local descriptionLength = getStringLength(text)
    local var2 = tbl2.RelativeSize * arg2.Font.BaseSize
    local vector2 = Vector2.new(tbl1.state.textBoxWidth, 10000)
    local tbl3 = {
        lastValidDescription = lastValidDescription,
        assetDescription = text,
        descriptionLength = descriptionLength,
        canvasHeight = math.max(
            100,
            GetTextSize(text, var2, arg2.Tokens.Typography.BodySmall.Font, vector2, { addTemporaryPadding = false }).Y
        )
    }
    tbl1:setState(tbl3)

    tbl1.props.onAssetDescriptionUpdated(text)
end

function var1.renderWithProviders(arg1, arg2, arg3)
    local font = arg2.Font
    local captionBody = font.CaptionBody
    local theme = arg2.Theme

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 1,
        Size = arg1.props.Size,
        Position = arg1.props.Position
    }
    local tbl2 = { TextboxContainer = 0, LengthDisplay = 0 }
    local createElement2 = Roact.createElement
    local var2 = ImageSetLabel
    local tbl3 = {
        BackgroundTransparency = 1,
        Image = component_assetsCircle_17_stroke_1,
        ImageColor3 = theme.UIDefault.Color,
        ImageTransparency = theme.UIDefault.Transparency,
        LayoutOrder = 1,
        ScaleType = Enum.ScaleType.Slice,
        Size = UDim2.new(1, 0, 1, -15),
        SliceCenter = rect
    }
    local tbl4 = { ScrollingFrame = 0 }

    local createElement3 = Roact.createElement
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        CanvasPosition = Vector2.new(0, arg1.state.canvasPosition),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 12,
        BorderSizePixel = 0
    }
    tbl5[Roact.Change.CanvasPosition] = function(arg4)
        arg1:setState({ canvasPosition = arg4.CanvasPosition.Y })
    end

    tbl5[Roact.Change.AbsoluteSize] = function(arg4)
        arg1:setState({ scrollingFrameHeight = arg4.AbsoluteSize.Y })

        arg1:calculateNeedsRescroll(arg2, captionBody)
    end
    local tbl6 = { Textbox = 0 }
    local createElement4 = Roact.createElement
    local textBox = Focusable.TextBox
    local tbl7 = {
        Text = arg1.state.assetDescription,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        FontFace = normalizeFontFace(arg2.Tokens.Typography.TitleLarge.Font),
        TextSize = font.BaseSize * captionBody.RelativeSize,
        PlaceholderColor3 = theme.PlaceHolder.Color,
        PlaceholderText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.AssetDescriptionPlaceholder"),
        Position = UDim2.fromOffset(6, 0),
        Size = UDim2.new(1, -24, 0, arg1.state.canvasHeight),
        MultiLine = true,
        TextColor3 = theme.TextDefault.Color,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        OverlayNativeInput = true,
        NextSelectionUp = arg1.props.NextSelectionUp,
        [Roact.Change.TextFits] = arg1.onTextFitsChanged,
        SelectionImageObject = arg3(CursorKind.InputFields),
        [Roact.Ref] = arg1.props.descriptionTextBoxRef,
        [Roact.Event.AncestryChanged] = arg1.tryFocusTextBox
    }
    tbl7[Roact.Change.Text] = function(arg4)
        arg1:onTextChanged(arg4, arg2, captionBody)
    end

    tbl7[Roact.Change.AbsoluteSize] = function(arg4)
        arg1:setState({ textBoxWidth = arg4.AbsoluteSize.X })

        arg1:calculateNeedsRescroll(arg2, captionBody)
    end

    tbl7[Roact.Change.CursorPosition] = function(arg4)
        arg1:setState({ cursorPosition = arg4.CursorPosition })

        arg1:calculateNeedsRescroll(arg2, captionBody)
    end

    tbl6.Textbox = createElement4(textBox, tbl7)
    tbl4.ScrollingFrame = createElement3("ScrollingFrame", tbl5, tbl6)
    tbl2.TextboxContainer = createElement2(var2, tbl3, tbl4)
    local element

    if arg1.state.descriptionLength / 1000 > 0.9 then
        element = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 15),
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.fromScale(1, 1),
            Text = arg1.state.descriptionLength .. "/" .. 1000,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = theme.TextDefault.Color,
            BackgroundTransparency = 1
        })
    else
        element = nil
    end

    tbl2.LengthDisplay = element
    return createElement(str1, tbl1, tbl2)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return withSelectionCursorProvider(function(arg3)
            return arg1:renderWithProviders(arg2, arg3)
        end)
    end)
end

function var1.didMount(arg1)
    arg1.tryFocusTextBox()
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        assetType = arg1.promptRequest.promptInfo.assetType
    }
end)(var1)
