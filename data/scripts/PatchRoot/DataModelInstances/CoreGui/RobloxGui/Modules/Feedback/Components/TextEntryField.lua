-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _TextService = game:GetService("TextService")
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local t = require(CorePackages.Packages.t)

local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)
local ThemedTextLabel = require(scriptParentParent.Components.PortedComponents.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider

local var1 = Roact.PureComponent:extend("TextEntryField")

var1.validateProps = t.strictInterface({
    enabled = t.boolean,
    text = t.string,
    textChanged = t.callback,
    maxTextLength = t.integer,
    autoFocusOnEnabled = t.boolean,
    PlaceholderText = t.string,
    LayoutOrder = t.optional(t.integer),
    Size = t.UDim2,
    Position = t.optional(t.UDim2),
    textBoxRef = t.optional(t.table)
})

function var1.init(arg1)
    arg1.textBoxRef = arg1.props.textBoxRef or Roact.createRef()

    arg1.state = {
        textBoxWidth = 100,
        scrollingFrameHeight = 100,
        canvasPosition = 0,
        cursorPosition = 0
    }
end

function var1.calculateNeedsRescroll(arg1, arg2, arg3)
    arg1:setState(function(arg4, arg5)
        if arg4.cursorPosition == -1 then
            return nil
        end

        local var2 = arg5.text:sub(1, arg4.cursorPosition - 1)
        local var3 = arg3.RelativeSize * arg2.Font.BaseSize
        local vector2 = Vector2.new(arg5.textBoxWidth, 10000)
        local textSize = GetTextSize(var2, var3, arg2.Tokens.Typography.BodyLarge.Font, vector2, { addTemporaryPadding = false })

        if textSize.Y > arg4.scrollingFrameHeight + arg4.canvasPosition then
            return {
                canvasPosition = textSize.Y - arg4.scrollingFrameHeight
            }
        end

        if textSize.Y - var3 < arg4.canvasPosition then
            return {
                canvasPosition = textSize.Y - var3
            }
        end

        return nil
    end)
end

function var1.renderWithSelectionCursor(arg1, arg2)
    return withStyle(function(arg3)
        local textDefault = arg3.Theme.TextDefault
        local body = arg3.Font.Body

        local vector2 = Vector2.new(arg1.state.textBoxWidth, 10000)
        local textSize = GetTextSize(
            arg1.props.text,
            body.RelativeSize * arg3.Font.BaseSize,
            arg3.Tokens.Typography.BodyLarge.Font,
            vector2,
            { addTemporaryPadding = false }
        )

        local createElement = Roact.createElement
        local var2 = ImageSetLabel
        local tbl1 = {
            BackgroundTransparency = 1,
            Image = Assets.Images.RoundedRect.Image,
            ImageColor3 = arg3.Theme.BackgroundMuted.Color,
            ImageTransparency = arg3.Theme.BackgroundMuted.Transparency,
            Position = arg1.props.Position,
            ScaleType = Assets.Images.RoundedRect.ScaleType,
            Size = arg1.props.Size,
            SliceCenter = Assets.Images.RoundedRect.SliceCenter,
            LayoutOrder = arg1.props.LayoutOrder
        }
        local tbl2 = { ScrollingFrame = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, -24, 1, -14),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 7),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(1, -24, 0, textSize.Y),
            ScrollBarThickness = 8,
            VerticalScrollBarInset = Enum.ScrollBarInset.Always,
            CanvasPosition = Vector2.new(0, arg1.state.canvasPosition),
            Selectable = false
        }
        tbl3[Roact.Change.CanvasPosition] = function(arg4)
            arg1:setState({ canvasPosition = arg4.CanvasPosition.Y })
        end

        tbl3[Roact.Change.AbsoluteSize] = function(arg4)
            arg1:setState({
                scrollingFrameHeight = arg4.AbsoluteSize.Y
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end
        local tbl4 = { TextBox = 0 }
        local createElement3 = Roact.createElement
        local tbl5 = {
            Size = UDim2.new(1, -2, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Text = arg1.props.text,
            ClearTextOnFocus = false,
            TextEditable = arg1.props.enabled,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextColor3 = textDefault.Color,
            TextTransparency = textDefault.Transparency,
            FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
            TextSize = body.RelativeSize * arg3.Font.BaseSize,
            TextWrapped = true,
            MultiLine = true,
            SelectionImageObject = arg2(CursorKind.InputFields),
            [Roact.Ref] = arg1.textBoxRef
        }
        tbl5[Roact.Change.Text] = function(arg4)
            local success, result = pcall(function(): (number?, number?)
                return utf8.len(utf8.nfcnormalize(arg4.Text))
            end)
            if not success or arg1.props.maxTextLength < result then
                arg4.Text = arg1.props.text
                return
            end
            arg1.props.textChanged(arg4.Text)
            arg1:setState({
                cursorPosition = arg4.CursorPosition
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl5[Roact.Change.AbsoluteSize] = function(arg4)
            arg1:setState({
                textBoxWidth = arg4.AbsoluteSize.X
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl5[Roact.Change.CursorPosition] = function(arg4)
            arg1:setState({
                cursorPosition = arg4.CursorPosition
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl4.TextBox = createElement3("TextBox", tbl5, {
            PlaceholderText = Roact.createElement(ThemedTextLabel, {
                themeKey = "TextDefault",
                fontKey = "Body",
                Text = arg1.props.PlaceholderText,
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                TextTransparency = 0.5,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Visible = arg1.props.text == ""
            })
        })
        tbl2.ScrollingFrame = createElement2("ScrollingFrame", tbl3, tbl4)
        return createElement(var2, tbl1, tbl2)
    end)
end

function var1.render(arg1)
    return withSelectionCursorProvider(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var1.didUpdate(arg1, arg2)
    if not arg1.props.enabled and arg2.enabled then
        if arg1.textBoxRef.current and arg1.textBoxRef.current:IsFocused() then
            arg1.textBoxRef.current:ReleaseFocus()
        end
    elseif arg1.props.enabled and not arg2.enabled and arg1.props.autoFocusOnEnabled and arg1.textBoxRef.current then
        arg1.textBoxRef.current:CaptureFocus()
    end
end

return Roact.forwardRef(function(arg1, textBoxRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { textBoxRef = textBoxRef }))
end)
