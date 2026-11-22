-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local withStyle = UIBlox.Core.Style.withStyle

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)
local ModelViewport = require(scriptParentParent.Generic.ModelViewport)

local iconsStatusImageunavailable = Images["icons/status/imageunavailable"]

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0)
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
            PurchaseSucceededTitle = {
                key = "IAPExperience.PurchaseSuccess.Title.PurchaseSucceeded"
            },
            YouOwnText = {
                key = "IAPExperience.PurchaseSuccess.Text.YouOwn",
                params = {
                    name = arg1.props.itemName
                }
            },
            BalanceNow = { key = "IAPExperience.PurchaseSuccess.Text.BalanceNow" },
            BackToGameButtonText = { key = "IAPExperience.PurchaseSuccess.Action.BackToGame" },
            EquipText = { key = "IAPExperience.PurchaseSuccess.Action.Equip" },
            BackToShopText = { key = "IAPExperience.PurchaseSuccess.Action.BackToShop" }
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

        local youOwnText = tbl2.YouOwnText

        local balanceNow = tbl2.BalanceNow
        local str1 = utf8.char(57346)
        local balance = props.balance
        local var2 = youOwnText .. " " .. balanceNow:gsub("{robux}", str1 .. tostring(balance))

        local buttonStackInfo = tbl1.props.equipActivated
            and {
                buttons = {
                    {
                        props = {
                            onActivated = props.doneActivated,
                            text = tbl2.BackToShopText,
                            inputIcon = props.cancelControllerIcon
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = props.equipActivated,
                            text = tbl2.EquipText,
                            inputIcon = props.confirmControllerIcon
                        }
                    }
                }
            }
            or {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.doneActivated,
                        text = tbl2.BackToGameButtonText,
                        inputIcon = props.confirmControllerIcon
                    }
                }}
            }
        local element

        if props.itemIcon then
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, 85, 0, 85),
                ScaleType = Enum.ScaleType.Stretch,
                Image = props.itemIcon,
                ImageTransparency = 0
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, IconSize.Large, 0, IconSize.Large),
                ScaleType = Enum.ScaleType.Stretch,
                Image = iconsStatusImageunavailable,
                ImageColor3 = theme.UIDefault.Color,
                ImageTransparency = theme.UIDefault.Transparency
            })
        end

        if props.model then
            element = Roact.createElement(
                ModelViewport,
                {
                    model = props.model,
                    Position = UDim2.fromOffset(5, 5),
                    Size = UDim2.fromOffset(85, 85)
                }
            )
        end
        return Roact.createElement(InteractiveAlert, {
            screenSize = props.screenSize,
            position = props.position,
            anchorPoint = props.anchorPoint,
            title = tbl2.PurchaseSucceededTitle,
            middleContent = function()
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 24),
                    [Roact.Ref] = tbl1.contentRef,
                    [Roact.Change.AbsoluteSize] = tbl1.changeContentSize
                }, {
                    ItemIconFrame = Roact.createElement(FitFrameVertical, {
                        LayoutOrder = 0,
                        BackgroundTransparency = 1,
                        width = UDim.new(1, 0),
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }, { ItemIcon = element }),
                    YouOwnText = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        TextWrapped = true,
                        width = FitTextLabel.Width.FitToText,
                        maximumWidth = tbl1.state.contentSize.X,
                        Font = font.Body.Font,
                        Text = var2,
                        TextSize = font.BaseSize * font.Body.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    })
                })
            end,
            buttonStackInfo = buttonStackInfo
        })
    end)
end

return var1
