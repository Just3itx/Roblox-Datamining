-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local Alert = require(scriptParent.Alert)
local AlertType = require(scriptParent.Enum.AlertType)

local FitFrameOnAxis = require(scriptParentParentParentParentParent.FitFrame).FitFrameOnAxis

local num1 = 272
local num2 = 400

local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local GetTextHeight = require(scriptParentParentParentParent.Core.Text.GetTextHeight)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local ButtonStack = require(scriptParentParentParent.Button.ButtonStack)

local var1 = Roact.PureComponent:extend("InteractiveAlert")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    screenSize = t.Vector2,
    onMounted = t.optional(t.callback),
    onAbsoluteSizeChanged = t.optional(t.callback),
    title = t.string,
    titleIcon = t.optional(t.union(t.table, t.string)),
    titleContent = t.optional(t.callback),
    bodyText = t.optional(t.string),
    richText = t.optional(t.boolean),
    middleContent = t.optional(t.callback),
    buttonStackInfo = ButtonStack.validateProps,
    footerText = t.optional(t.string),
    footerContent = t.optional(t.callback),
    onCloseClicked = t.optional(t.callback),
    bottomMargin = t.optional(t.number),
    defaultChildRef = t.optional(t.union(t.table, t.callback)),
    isMiddleContentFocusable = t.optional(t.boolean),
    isFooterContentFocusable = t.optional(t.boolean),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = { bottomMargin = 24 }

function var1.render(arg1)
    return withStyle(function(arg2)
        num1 = arg2.Tokens.Size.Size_400 * 17
        num2 = arg2.Tokens.Size.Size_1000 * 10
        local theme = arg2.Theme
        local font = arg2.Font
        local fontFromFontStyle = GetFontFromFontStyle(font.Body)

        local textSize = font.BaseSize * font.Body.RelativeSize

        local titleContent = arg1.props.titleContent
        local var2 = arg1.props.titleIcon and function()
            return Roact.createElement(FitFrameOnAxis, {
                BackgroundTransparency = 1,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                margin = { top = 12, bottom = 0, left = 0, right = 0 },
                minimumSize = UDim2.new(1, 0, 0, 0)
            }, {
                Icon = Roact.createElement(ImageSetComponent.Label, {
                    BackgroundTransparency = 1,
                    Image = arg1.props.titleIcon,
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    Size = UDim2.new(0, 48, 0, 48)
                })
            })
        end or titleContent

        local num3 = math.clamp(arg1.props.screenSize.X - 48, num1, num2) - 48

        local footerContent = arg1.props.footerContent
        if arg1.props.footerText then
            local var3 = font.BaseSize * font.Footer.RelativeSize
            local textHeight = arg1.props.footerText
                and GetTextHeight(
                    arg1.props.footerText,
                    GetFontFromFontStyle(font.Footer),
                    font.BaseSize * font.Footer.RelativeSize,
                    num3,
                    100
                )
                or 0

            footerContent = function()
                return Roact.createElement(GenericTextLabel, {
                    BackgroundTransparency = 1,
                    colorStyle = theme.TextDefault,
                    fontStyle = font.Footer,
                    LayoutOrder = 4,
                    Text = arg1.props.footerText,
                    TextSize = var3,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Size = UDim2.new(1, 0, 0, textHeight)
                })
            end
        end

        local textHeight = arg1.props.bodyText and GetTextHeight(arg1.props.bodyText, fontFromFontStyle, textSize, num3, 200) or 0

        local middleContent = arg1.props.middleContent
        local var3 = arg1.props.bodyText and function()
            return Roact.createElement(
                FitFrameOnAxis,
                {
                    BackgroundTransparency = 1,
                    contentPadding = UDim.new(0, 12),
                    LayoutOrder = 2,
                    minimumSize = UDim2.new(1, 0, 0, 0)
                },
                {
                    BodyText = Roact.createElement(GenericTextLabel, {
                        BackgroundTransparency = 1,
                        colorStyle = theme.TextDefault,
                        fontStyle = font.Body,
                        LayoutOrder = 1,
                        Text = arg1.props.bodyText,
                        RichText = arg1.props.richText,
                        TextSize = textSize,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Size = UDim2.new(1, 0, 0, textHeight)
                    }),
                    CustomContent = arg1.props.middleContent
                        and Roact.createElement(
                            FitFrameOnAxis,
                            {
                                BackgroundTransparency = 1,
                                LayoutOrder = 2,
                                minimumSize = UDim2.new(1, 0, 0, 0)
                            },
                            {
                                Content = arg1.props.middleContent()
                            }
                        )
                }
            )
        end or middleContent

        return Roact.createElement(Alert, {
            anchorPoint = arg1.props.anchorPoint,
            alertType = AlertType.Interactive,
            margin = {
                top = 0,
                bottom = arg1.props.bottomMargin,
                left = 24,
                right = 24
            },
            maxWidth = num2,
            minWidth = num1,
            buttonStackInfo = arg1.props.buttonStackInfo,
            middleContent = var3,
            isMiddleContentFocusable = arg1.props.isMiddleContentFocusable,
            onMounted = arg1.props.onMounted,
            onAbsoluteSizeChanged = arg1.props.onAbsoluteSizeChanged,
            position = arg1.props.position,
            screenSize = arg1.props.screenSize,
            title = arg1.props.title,
            titleContent = var2,
            footerContent = footerContent,
            isFooterContentFocusable = arg1.props.isFooterContentFocusable,
            onCloseClicked = arg1.props.onCloseClicked,
            defaultChildRef = arg1.props.defaultChildRef,
            isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
        })
    end)
end

return var1
