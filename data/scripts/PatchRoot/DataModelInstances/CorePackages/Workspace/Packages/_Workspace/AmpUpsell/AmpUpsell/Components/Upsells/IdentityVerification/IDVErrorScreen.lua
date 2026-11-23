-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local React = require(AmpUpsellParent.React)
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector

local function IDVErrorScreen(tbl1)
    local errorTitle = tbl1.errorTitle
    local errorDescription = tbl1.errorDescription
    local onClose = tbl1.onClose
    local buttonText = tbl1.buttonText
    local var1 = useStyle()
    local screenSize = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    return React.createElement(PartialPageModal, {
        title = errorTitle,
        screenSize = screenSize,
        onCloseClicked = function()
            onClose()
        end,
        bottomPadding = 20,
        buttonStackProps = {
            forcedFillDirection = Enum.FillDirection.Horizontal,
            buttonHeight = 48,
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    isDisabled = false,
                    onActivated = function()
                        onClose()
                    end,
                    text = buttonText
                }
            }}
        }
    }, {
        ViewFrame = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1
        }, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 20)
            }),
            ImageIcon = React.createElement(ImageSetLabel, {
                Size = UDim2.new(0, IconSize.XXLarge, 0, IconSize.XXLarge),
                ScaleType = Enum.ScaleType.Fit,
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Image = Images["icons/graphic/error_xlarge"],
                ImageTransparency = var1.Theme.SystemPrimaryDefault.Transparency
            }),
            ErrorText = React.createElement(StyledTextLabel, {
                text = errorDescription,
                fontStyle = var1.Font.CaptionBody,
                colorStyle = var1.Theme.TextEmphasis,
                size = UDim2.new(1, 0, 0, 0),
                lineHeight = 1,
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = Enum.TextXAlignment.Center,
                textYAlignment = Enum.TextYAlignment.Center,
                automaticSize = Enum.AutomaticSize.XY,
                layoutOrder = 2
            })
        })
    })
end

return IDVErrorScreen
