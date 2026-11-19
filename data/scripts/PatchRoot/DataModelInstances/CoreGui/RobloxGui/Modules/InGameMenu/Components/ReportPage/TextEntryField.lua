-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local Cryo = InGameMenuDependencies.Cryo

local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Images = UIBlox.App.ImageSet.Images

local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent
local Assets = require(scriptParentParentParent.Resources.Assets)

local FillCircle = require(script.Parent.FillCircle)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = Foundation.Image

local var3 = Roact.PureComponent:extend("TextEntryField")

local component_assetsCircle_17 = Images["component_assets/circle_17"]

var3.validateProps = t.strictInterface({
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

function var3.init(arg1)
    arg1.textBoxRef = arg1.props.textBoxRef or Roact.createRef()

    arg1.state = {
        textBoxWidth = 100,
        scrollingFrameHeight = 100,
        canvasPosition = 0,
        cursorPosition = 0
    }
end

function var3.calculateNeedsRescroll(arg1, arg2, arg3)
    arg1:setState(function(arg4, arg5)
        if arg4.cursorPosition == -1 then
            return nil
        end
        local var4 = arg5.text:sub(1, arg4.cursorPosition - 1)
        local var5 = arg3.RelativeSize * arg2.Font.BaseSize
        local vector2 = Vector2.new(arg5.textBoxWidth, 10000)
        local textSize = GetTextSize(var4, var5, arg2.Tokens.Typography.BodyLarge.Font, vector2, { addTemporaryPadding = false })

        if textSize.Y > arg4.scrollingFrameHeight + arg4.canvasPosition then
            return {
                canvasPosition = textSize.Y - arg4.scrollingFrameHeight
            }
        end

        if textSize.Y - var5 < arg4.canvasPosition then
            return {
                canvasPosition = textSize.Y - var5
            }
        end

        return nil
    end)
end

function var3.renderWithSelectionCursor(arg1, arg2)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                TextDefault = {
                    Color = tokens.Color.Content.Default.Color3,
                    Transparency = tokens.Color.Content.Default.Transparency
                },
                BackgroundMuted = {
                    Color = tokens.Color.Surface.Surface_200.Color3,
                    Transparency = tokens.Color.Surface.Surface_200.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Body = {
                    Font = tokens.Typography.BodyLarge.Font,
                    RelativeSize = tokens.Typography.BodyLarge.FontSize
                }
            }
        }
    end, function(arg3)
        local textDefault = arg3.Theme.TextDefault
        local body = arg3.Font.Body

        local textSize = GetTextSize(
            arg1.props.text,
            body.RelativeSize * arg3.Font.BaseSize,
            arg3.Tokens.Typography.BodyLarge.Font,
            Vector2.new(arg1.state.textBoxWidth, 10000),
            { addTemporaryPadding = false }
        )

        local imageRectSize = component_assetsCircle_17.ImageRectSize
        local imageRectOffset = component_assetsCircle_17.ImageRectOffset
        local imageRectSizeX = imageRectSize.X
        local y = imageRectSizeX / 2

        local tbl1 = { ScrollingFrame = 0, BottomBar = 0 }
        local createElement = Roact.createElement
        local tbl2 = {
            Size = UDim2.new(1, -24, 1, -44),
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
        tbl2[Roact.Change.CanvasPosition] = function(arg4)
            arg1:setState({ canvasPosition = arg4.CanvasPosition.Y })
        end

        tbl2[Roact.Change.AbsoluteSize] = function(arg4)
            arg1:setState({
                scrollingFrameHeight = arg4.AbsoluteSize.Y
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end
        local tbl3 = { TextBox = 0 }
        local createElement2 = Roact.createElement
        local tbl4 = {
            Size = nil,
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
            SelectionImageObject = arg2(var2.InputFields),
            [Roact.Ref] = arg1.textBoxRef
        }
        tbl4[Roact.Change.Text] = function(arg4)
            if utf8.len(utf8.nfcnormalize(arg4.Text)) > arg1.props.maxTextLength then
                arg4.Text = string.sub(arg4.Text, 1, utf8.offset(arg4.Text, arg1.props.maxTextLength + 1) - 1)
                return
            end
            arg1.props.textChanged(arg4.Text)
            arg1:setState({
                cursorPosition = arg4.CursorPosition
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl4[Roact.Change.AbsoluteSize] = function(arg4)
            arg1:setState({
                textBoxWidth = arg4.AbsoluteSize.X
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl4[Roact.Change.CursorPosition] = function(arg4)
            arg1:setState({
                cursorPosition = arg4.CursorPosition
            }, function()
                arg1:calculateNeedsRescroll(arg3, body)
            end)
        end

        tbl3.TextBox = createElement2("TextBox", tbl4, {
            PlaceholderText = Roact.createElement(ThemedTextLabel, {
                themeKey = "TextDefault",
                fontKey = "Body",
                Text = arg1.props.PlaceholderText,
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Visible = arg1.props.text == ""
            })
        })
        tbl1.ScrollingFrame = createElement("ScrollingFrame", tbl2, tbl3)

        tbl1.BottomBar = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = component_assetsCircle_17.Image,
            ImageColor3 = arg3.Theme.BackgroundMuted.Color,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Slice,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(1, 0, 0, 32),
            SliceCenter = Rect.new(y - 1, 0, y + 1, 1),
            SliceScale = 1 / Images.ImagesResolutionScale,
            ImageRectSize = Vector2.new(imageRectSizeX, y),
            ImageRectOffset = imageRectOffset + Vector2.new(0, y)
        }, {
            TextAmmountIndicator = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -10, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                Size = UDim2.new(0, 20, 0, 20)
            }, { Roact.createElement(FillCircle, {
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    fillFraction = utf8.len(utf8.nfcnormalize(arg1.props.text)) / (arg1.props.maxTextLength - 10),
                    largerCircleFraction = (arg1.props.maxTextLength - 20) / arg1.props.maxTextLength,
                    popCircleFraction = 1,
                    shakeCircleFraction = arg1.props.maxTextLength / (arg1.props.maxTextLength - 10),
                    BackgroundColor = arg3.Theme.BackgroundMuted.Color
                }) })
        })

        if FFlagCoreUiMigrateUIBloxToFoundation then
            return Roact.createElement(Image, {
                Image = Assets.Images.RoundedRectImageKey,
                imageStyle = {
                    Color3 = arg3.Theme.BackgroundMuted.Color,
                    Transparency = arg3.Theme.BackgroundMuted.Transparency
                },
                Position = arg1.props.Position,
                Size = arg1.props.Size,
                LayoutOrder = arg1.props.LayoutOrder,
                slice = {
                    center = Rect.new(8, 8, 9, 9)
                }
            }, tbl1)
        end

        return Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = Assets.Images.RoundedRect.Image,
            ImageColor3 = arg3.Theme.BackgroundMuted.Color,
            ImageTransparency = arg3.Theme.BackgroundMuted.Transparency,
            Position = arg1.props.Position,
            ScaleType = Assets.Images.RoundedRect.ScaleType,
            Size = arg1.props.Size,
            SliceCenter = Assets.Images.RoundedRect.SliceCenter,
            LayoutOrder = arg1.props.LayoutOrder
        }, tbl1)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didUpdate(arg1, arg2, _)
    if not arg1.props.enabled and arg2.enabled then
        if arg1.textBoxRef.current and arg1.textBoxRef.current:IsFocused() then
            arg1.textBoxRef.current:ReleaseFocus()
        end
    elseif arg1.props.enabled and not arg2.enabled and arg1.props.autoFocusOnEnabled and arg1.textBoxRef.current then
        arg1.textBoxRef.current:CaptureFocus()
    end
end

return Roact.forwardRef(function(arg1, textBoxRef)
    return Roact.createElement(var3, Cryo.Dictionary.join(arg1, { textBoxRef = textBoxRef }))
end)
