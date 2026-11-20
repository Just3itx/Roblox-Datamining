-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local React = require(AmpV2WizardParent.React)

local useScreenSize = require(AmpV2WizardParent.RobloxAppHooks).useScreenSize
local useLocalization = require(AmpV2WizardParent.Localization).Hooks.useLocalization

local UIBlox = require(AmpV2WizardParent.UIBlox)
local Foundation = require(AmpV2WizardParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local ButtonType = UIBlox.App.Button.Enum.ButtonType

local function AuthorizationLoadingModal(tbl1)
    local onCancel = tbl1.onCancel

    local screenSize = useScreenSize()

    local var2 = useLocalization({
        title = "Amp.FAEUpsell.Modal.Loading.Title",
        bodyText = "Amp.FAEUpsell.Modal.Loading.Text",
        cancelBtn = "Amp.FAEUpsell.Modal.Loading.ButtonCancel"
    })

    local middleContent = React.useCallback(function()
        return React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 80),
            BackgroundTransparency = 1
        }, {
            Spinner = React.createElement(
                Loading,
                {
                    size = IconSize.Medium,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            )
        })
    end, {})

    return React.createElement(InteractiveAlert, {
        screenSize = screenSize,
        title = var2.title,
        bodyText = var2.bodyText,
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.Secondary,
                props = {
                    onActivated = onCancel,
                    text = var2.cancelBtn
                }
            }}
        },
        middleContent = middleContent
    })
end

return AuthorizationLoadingModal
