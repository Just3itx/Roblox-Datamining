-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local InteractiveAlert = require(BulkPurchaseAppParent.UIBlox).App.Dialog.Alert.InteractiveAlert
local useScreenSize = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).useScreenSize
local useCloseOnEscapeEffect = require(BulkPurchaseApp.Hooks.useCloseOnEscapeEffect)
local FFlagBulkPurchaseCloseOnEscape = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseCloseOnEscape)

local Scrim = require(script.Parent.Scrim)

local function AlertPrompt(tbl1)
    if FFlagBulkPurchaseCloseOnEscape then
        useCloseOnEscapeEffect("BulkPurchaseCloseAlertPrompt", tbl1.onDismiss)
    end

    local screenSize = useScreenSize()

    return React.createElement(
        Scrim,
        {},
        React.createElement(InteractiveAlert, {
            title = tbl1.title,
            bodyText = tbl1.bodyText,
            buttonStackInfo = {
                buttons = {{
                    props = {
                        onActivated = tbl1.onDismiss,
                        text = tbl1.dismissCTA
                    },
                    isDefaultChild = true
                }}
            },
            position = UDim2.fromScale(0.5, 0.5),
            screenSize = screenSize,
            middleContent = tbl1.middleContent
        })
    )
end

return AlertPrompt
