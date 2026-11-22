-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitFrameHorizontal = RoactFitComponents.FitFrameHorizontal
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local iconsCommonRobux = Images["icons/common/robux"]

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            title = { key = "IAPExperience.InsufficientRobux.Title.InsufficientRobux" },
            dontHaveEnough = { key = "IAPExperience.InsufficientRobux.Text.DontHaveEnough" },
            currentBalance = { key = "IAPExperience.InsufficientRobux.Text.CurrentBalance" },
            cancel = { key = "IAPExperience.InsufficientRobux.Action.Cancel" },
            buyRobux = { key = "IAPExperience.InsufficientRobux.Action.BuyRobux" }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    return withStyle(function(arg1)
        local font = arg1.Font
        local theme = arg1.Theme
        local textSize = font.BaseSize * font.Body.RelativeSize

        return Roact.createElement(InteractiveAlert, {
            screenSize = tbl1.props.screenSize,
            title = tbl2.title,
            bodyText = tbl2.dontHaveEnough,
            buttonStackInfo = {
                buttons = {
                    {
                        props = {
                            onActivated = tbl1.props.closePrompt,
                            text = tbl2.cancel
                        },
                        isDefaultChild = true
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = tbl1.props.buyRobux,
                            text = tbl2.buyRobux
                        }
                    }
                }
            },
            middleContent = function()
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    margin = RoactFitComponents.Rect.quad(10, 0, 10, 0),
                    contentPadding = UDim.new(0, 30),
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }, {
                    CurrentBalanceLabel = Roact.createElement(FitTextLabel, {
                        width = FitTextLabel.Width.FitToText,
                        BackgroundTransparency = 1,
                        Font = font.Body.Font,
                        Text = tbl2.currentBalance,
                        TextColor3 = theme.TextDefault.Color,
                        TextTransparency = theme.TextDefault.Transparency,
                        TextSize = textSize,
                        LayoutOrder = 0
                    }),
                    RobuxAmount = Roact.createElement(FitFrameHorizontal, {
                        height = UDim.new(1, 0),
                        contentPadding = UDim.new(0, 10),
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        BackgroundTransparency = 1,
                        LayoutOrder = 1
                    }, {
                        Icon = Roact.createElement(ImageSetLabel, {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            Size = UDim2.fromOffset(textSize, textSize),
                            Image = iconsCommonRobux,
                            ImageColor3 = theme.TextDefault.Color,
                            ImageTransparency = theme.TextDefault.Transparency
                        }),
                        Text = Roact.createElement(FitTextLabel, {
                            LayoutOrder = 2,
                            width = FitTextLabel.Width.FitToText,
                            Text = tbl1.props.robuxBalance,
                            Font = font.Body.Font,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency,
                            TextSize = textSize,
                            BackgroundTransparency = 1
                        })
                    })
                })
            end
        })
    end)
end

return var1
