-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParentParent.Core
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local Images = require(scriptParentParentParent.ImageSet.Images)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local Controllable = require(Core.Control.Controllable)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local CloseButtonIcon = require(script.Parent.Enum.CloseButtonIcon)

local var1 = Roact.PureComponent:extend("ModalTitle")

var1.validateProps = t.strictInterface({
    title = t.string,
    position = t.optional(t.UDim2),
    anchor = t.optional(t.Vector2),
    closeButtonIcon = t.optional(CloseButtonIcon.isEnumValue),
    onCloseClicked = t.optional(t.callback),
    titleBackgroundImageProps = t.optional(t.strictInterface({ image = t.string, imageHeight = t.number, text = t.optional(t.string) })),
    onTitleSizeChanged = t.optional(t.callback)
})

var1.defaultProps = {
    title = "",
    position = UDim2.new(0.5, 0, 0, 0),
    anchor = Vector2.new(0.5, 0),
    closeButtonIcon = CloseButtonIcon.Close
}

function var1.GetHeight(_): number
    return 48
end

local function getCloseButtonIcon(closeButtonIcon): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if closeButtonIcon == CloseButtonIcon.Close then "icons/navigation/close" elseif closeButtonIcon == CloseButtonIcon.Back then "icons/actions/cycleLeft" else nil
end

local function renderBackgroundImage(titleBackgroundImageProps, arg1, tbl1: {TitleText: any})
    local text = titleBackgroundImageProps.text

    local var2 = text and #text > 0
    local var3 = text and #text > 0

    local yOffset = math.clamp(titleBackgroundImageProps.imageHeight, 48, 261)

    if var2 then
        yOffset += 8
        tbl1 = Cryo.Dictionary.join(tbl1, { UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }) })
    end

    if text and #text > 0 then
        tbl1 = Cryo.Dictionary.join(tbl1, {
            BackgroundText = Roact.createElement(GenericTextLabel, {
                Size = UDim2.new(1, 0, 1, -56),
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 48),
                fontStyle = arg1.Font.Body,
                colorStyle = arg1.Theme.TextEmphasis,
                RichText = true,
                Text = text,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 2
            })
        })
    end

    if var3 then
        tbl1 = Cryo.Dictionary.join(tbl1, {
            BackgroundTextShadow = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, if var2 then -8 else 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 0,
                ZIndex = 1
            }, {
                UIGradient = Roact.createElement("UIGradient", {
                    Color = ColorSequence.new(Color3.new(0, 0, 0)),
                    Transparency = NumberSequence.new(
                        { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.25), NumberSequenceKeypoint.new(1, 1) }
                    ),
                    Rotation = 90
                })
            })
        })
    end

    local element = Roact.createElement(ImageSetComponent.Label, {
        AnchorPoint = Vector2.new(0, 0),
        Size = UDim2.new(1, 0, 0, yOffset),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Crop,
        BorderSizePixel = 0,
        Image = titleBackgroundImageProps.image,
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }, tbl1)

    if var2 then
        element = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 0, yOffset - 8),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        }, { TitleBackground = element })
    end

    return element
end

function var1.render(arg1)
    local titleBackgroundImageProps = arg1.props.titleBackgroundImageProps

    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local textSize = font.BaseSize * font.Header1.RelativeSize

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundTransparency = 1,
            [Roact.Change.AbsoluteSize] = arg1.props.onTitleSizeChanged
        }
        local tbl2 = { CloseButton = 0, Title = 0, Underline = 0 }
        local var3

        if arg1.props.onCloseClicked then
            local createElement2 = Roact.createElement
            local var4 = Controllable
            local tbl3 = {
                controlComponent = {
                    component = ImageSetComponent.Button,
                    props = {
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0, 32, 0.5, 0),
                        Size = UDim2.new(0, 48, 0, 48),
                        [Roact.Event.Activated] = arg1.props.onCloseClicked
                    },
                    children = {
                        InputFillImage = Roact.createElement(ImageSetComponent.Label, {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 36, 0, 36),
                            Image = Images[getCloseButtonIcon(arg1.props.closeButtonIcon)],
                            ImageColor3 = theme.IconEmphasis.Color,
                            ImageTransparency = theme.IconEmphasis.Transparency,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        })
                    }
                },
                onStateChanged = 0
            }

            function tbl3.onStateChanged(...) end

            var3 = createElement2(var4, tbl3) or nil
        else
            var3 = nil
        end

        tbl2.CloseButton = var3

        tbl2.Title = Roact.createElement(
            GenericTextLabel,
            {
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, -104, 1, 0),
                colorStyle = theme.TextEmphasis,
                fontStyle = font.Header1,
                LayoutOrder = 1,
                Text = arg1.props.title,
                TextSize = textSize,
                TextWrapped = true,
                TextTruncate = Enum.TextTruncate.AtEnd
            },
            {
                Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) })
            }
        )
        tbl2.Underline = not titleBackgroundImageProps
            and Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = theme.Divider.Color,
                BackgroundTransparency = theme.Divider.Transparency,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 1)
            })
        local titleText = createElement(str1, tbl1, tbl2)

        if titleBackgroundImageProps then
            return (renderBackgroundImage(titleBackgroundImageProps, arg2, { TitleText = titleText }))
        end

        return titleText
    end)
end

return var1
