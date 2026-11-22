-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local FitFrameVertical = require(scriptParentParentParent.RoactFitComponents).FitFrameVertical

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withStyle = UIBlox.Core.Style.withStyle

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local ProductDetails = require(scriptParent.ProductDetails)

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0),
        footerSize = Vector2.new(0, 0)
    }

    function arg1.changeContentSize(arg2)
        if arg1.state.contentSize ~= arg2.AbsoluteSize then
            arg1:setState({ contentSize = arg2.AbsoluteSize })
        end
    end
end

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            InsufficientRobuxTitle = {
                key = "IAPExperience.InsufficientRobux.Title.InsufficientRobux"
            },
            YouNeed = { key = "IAPExperience.InsufficientRobux.Text.YouNeed" },
            RobuxStore = { key = "IAPExperience.InsufficientRobux.Action.RobuxStore" },
            ButtonCancel = { key = "IAPExperience.InsufficientRobux.Action.Cancel" }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    local props = tbl1.props

    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        local var2 = Color3.new(
            math.round(theme.TextEmphasis.Color.R * 255),
            math.round(theme.TextEmphasis.Color.G * 255),
            math.round(theme.TextEmphasis.Color.B * 255)
        )

        local var3 = props.itemRobuxCost - props.balanceAmount
        local str1 = string.format("<font color=\"rgb(%s)\">%s%s</font>", tostring(var2), utf8.char(57346), tostring(var3))

        local var4 = tbl2.YouNeed:gsub("{robux}", str1)

        return Roact.createElement(InteractiveAlert, {
            screenSize = props.screenSize,
            position = props.position,
            anchorPoint = props.anchorPoint,
            title = tbl2.InsufficientRobuxTitle,
            middleContent = function()
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 15),
                    [Roact.Ref] = tbl1.contentRef,
                    [Roact.Change.AbsoluteSize] = tbl1.changeContentSize
                }, {
                    ProductDetails = Roact.createElement(ProductDetails, {
                        layoutOrder = 1,
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost
                    }),
                    Underline = Roact.createElement("Frame", {
                        LayoutOrder = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = theme.Divider.Color,
                        BackgroundTransparency = theme.Divider.Transparency,
                        Size = UDim2.new(1, 0, 0, 1)
                    }),
                    AdditionalBuyText = Roact.createElement("TextLabel", {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, tbl1.state.contentSize.X, 0, 0),
                        RichText = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = true,
                        FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                        Text = var4,
                        TextSize = font.BaseSize * font.Body.RelativeSize,
                        TextColor3 = theme.TextDefault.Color,
                        TextTransparency = theme.TextDefault.Transparency
                    })
                })
            end,
            buttonStackInfo = {
                buttons = {
                    {
                        props = {
                            onActivated = props.cancelPurchaseActivated,
                            text = tbl2.ButtonCancel,
                            inputIcon = props.cancelControllerIcon
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = props.robuxStoreActivated,
                            text = tbl2.RobuxStore,
                            inputIcon = props.acceptControllerIcon
                        }
                    }
                }
            }
        })
    end)
end

return var1
