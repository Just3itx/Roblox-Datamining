-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local React = require(AmpUpsellParent.React)
local RoactRodux = require(AmpUpsellParent.RoactRodux)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local AnalyticsService = require(AmpUpsell.Analytics.AnalyticsService)
local sendButtonClickEvent = require(AmpUpsell.Analytics.sendButtonClickEvent)
local AppScreens = require(AmpUpsell.Common.AppScreens)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle

function AccountSettingsUpsell(tbl1)
    local onCloseModal = tbl1.onCloseModal
    local onCloseModal2 = tbl1.onCloseModal
    local localizationStrings = tbl1.localizationStrings
    local featureName = tbl1.featureName
    local var1 = useLocalization(localizationStrings)
    local var2 = useStyle()
    local var3 = if tbl1.analyticsService then tbl1.analyticsService else AnalyticsService.EventStream

    local content = React.createElement(PartialPageModal, {
        title = var1.title,
        screenSize = tbl1.screenSize,
        onCloseClicked = function()
            sendButtonClickEvent(var3, AppScreens.AccountSettingsUpsell, featureName, "CloseModal")
            onCloseModal()
        end,
        buttonStackProps = {
            forcedFillDirection = Enum.FillDirection.Horizontal,
            buttonHeight = 48,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        isDisabled = false,
                        onActivated = function()
                            sendButtonClickEvent(var3, AppScreens.AccountSettingsUpsell, featureName, "Cancelled")

                            onCloseModal2()
                        end,
                        text = var1.buttonCancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = false,
                        onActivated = function()
                            sendButtonClickEvent(var3, AppScreens.AccountSettingsUpsell, featureName, "OpenAccountSettings")

                            tbl1.openAccountSettings(var1.buttonSettings)
                        end,
                        text = var1.buttonSettings
                    }
                }
            }
        }
    }, {
        ViewFrame = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1
        }, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
            Text = React.createElement(StyledTextLabel, {
                fontStyle = var2.Font.Body,
                colorStyle = var2.Theme.TextEmphasis,
                size = UDim2.new(1, 0, 0, 0),
                fluidSizing = false,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Center,
                automaticSize = Enum.AutomaticSize.Y,
                text = var1.message
            })
        })
    })

    return React.createElement("ImageButton", {
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 1, 0),
        ImageTransparency = 1,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, {
        Overlay = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            },
            { Content = content }
        )
    })
end

AccountSettingsUpsell = RoactRodux.connect(function(arg1, _)
    return {
        screenSize = arg1.ScreenSize
    }
end)(AccountSettingsUpsell)

return AccountSettingsUpsell
