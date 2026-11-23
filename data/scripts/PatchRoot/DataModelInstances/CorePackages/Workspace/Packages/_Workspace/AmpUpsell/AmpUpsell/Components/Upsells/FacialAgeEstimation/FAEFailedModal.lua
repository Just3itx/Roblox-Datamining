-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local React = require(AmpUpsellParent.React)

local useScreenSize = require(AmpUpsellParent.RobloxAppHooks).useScreenSize
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local UIBlox = require(AmpUpsellParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local ButtonType = UIBlox.App.Button.Enum.ButtonType

local authButtonClick = require(AmpUpsellParent.AuthAnalytics).Events.authButtonClick

local function FAEFailedModal(tbl1)
    local onClose = tbl1.onClose
    local onRetry = tbl1.onRetry
    local sessionId = tbl1.sessionId
    local entryPointEventCtx = tbl1.entryPointEventCtx

    local screenSize = useScreenSize()

    local var2 = useLocalization({
        title = "Amp.FAEUpsell.Modal.Failed.Title",
        bodyText = "Amp.FAEUpsell.Modal.Failed.Text",
        closeBtn = "Amp.FAEUpsell.Modal.Failed.ButtonClose",
        retryBtn = "Amp.FAEUpsell.Modal.Failed.ButtonRetry"
    })

    local onActivated = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "faeFailedClose", sessionId)
        onClose()
    end, { onClose, sessionId, entryPointEventCtx })

    local var1 = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "faeFailedRetry", sessionId)
        onRetry()
    end, { onRetry, sessionId, entryPointEventCtx })

    return React.createElement(InteractiveAlert, {
        screenSize = screenSize,
        title = var2.title,
        bodyText = var2.bodyText,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        buttonType = ButtonType.Secondary,
                        onActivated = onActivated,
                        text = var2.closeBtn
                    }
                },
                {
                    buttonType = ButtonType.PrimaryContextual,
                    props = {
                        onActivated = var1,
                        text = var2.retryBtn
                    }
                }
            }
        }
    })
end

return FAEFailedModal
