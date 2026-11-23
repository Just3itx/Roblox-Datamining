-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local React = require(AmpUpsellParent.React)

local useScreenSize = require(AmpUpsellParent.RobloxAppHooks).useScreenSize
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local UIBlox = require(AmpUpsellParent.UIBlox)
local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local ButtonType = UIBlox.App.Button.Enum.ButtonType

local authButtonClick = require(AmpUpsellParent.AuthAnalytics).Events.authButtonClick

local function FAELoadingModal(tbl1)
    local onCancel = tbl1.onCancel
    local sessionId = tbl1.sessionId
    local entryPointEventCtx = tbl1.entryPointEventCtx

    local screenSize = useScreenSize()

    local var2 = useLocalization({
        title = "Amp.FAEUpsell.Modal.Loading.Title",
        bodyText = "Amp.FAEUpsell.Modal.Loading.Text",
        cancelBtn = "Amp.FAEUpsell.Modal.Loading.ButtonCancel"
    })

    local onActivated = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "faeLoadingCancel", sessionId)
        onCancel()
    end, { onCancel, sessionId, entryPointEventCtx })

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
                    onActivated = onActivated,
                    text = var2.cancelBtn
                }
            }}
        },
        middleContent = middleContent
    })
end

return FAELoadingModal
