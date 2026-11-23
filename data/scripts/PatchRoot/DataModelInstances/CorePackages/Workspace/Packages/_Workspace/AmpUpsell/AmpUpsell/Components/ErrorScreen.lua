-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local AnalyticsService = require(AmpUpsell.Analytics.AnalyticsService)
local UIBlox = require(AmpUpsellParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local sendButtonClickEvent = require(AmpUpsell.Analytics.sendButtonClickEvent)

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function ErrorScreen(tbl1)
    local onRetry = tbl1.onRetry
    local onCancel = tbl1.onCancel
    local featureName = tbl1.featureName
    local var1 = useLocalization({
        title = "Amp.ErrorScreen.Title",
        bodyText = "Amp.ErrorScreen.BodyText",
        buttonRetry = "Amp.ErrorScreen.Retry",
        buttonCancel = "Amp.ErrorScreen.Cancel"
    })
    local var2 = if tbl1.analyticsService then tbl1.analyticsService else AnalyticsService.EventStream
    local screenSize = useSelector(selectScreenSize)

    return React.createElement(InteractiveAlert, {
        anchorPoint = Vector2.new(0.5, 0.5),
        position = UDim2.new(0.5, 0, 0.5, 0),
        screenSize = screenSize,
        title = var1.title,
        bodyText = var1.bodyText,
        buttonStackInfo = {
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        isDisabled = false,
                        onActivated = function()
                            sendButtonClickEvent(var2, "AmpErrorScreen", featureName, "Cancel")
                            onCancel()
                        end,
                        text = var1.buttonCancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = false,
                        onActivated = function()
                            sendButtonClickEvent(var2, "AmpErrorScreen", featureName, "Retry")
                            onRetry()
                        end,
                        text = var1.buttonRetry
                    }
                }
            }
        }
    })
end

return ErrorScreen
