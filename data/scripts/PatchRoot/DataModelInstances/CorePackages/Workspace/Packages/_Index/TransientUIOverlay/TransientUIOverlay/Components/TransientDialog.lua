-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TransientUIOverlay = script:FindFirstAncestor("TransientUIOverlay")
local TransientUIOverlayParent = TransientUIOverlay.Parent

local Foundation = require(TransientUIOverlayParent.Foundation)
local React = require(TransientUIOverlayParent.React)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local FoundationProvider = Foundation.FoundationProvider
local EnumsOrientation = Foundation.Enums.Orientation
local usePreferences = Foundation.Hooks.usePreferences

local _Types = require(TransientUIOverlay.Types)

local GetTransientUIOverlayStore = require(TransientUIOverlay.Stores.GetTransientUIOverlayStore)

local function TransientDialog(arg1)
    local var1 = usePreferences()

    local actions = {}
    local primaryActionText = arg1.primaryActionText
    local onPrimaryActivated = arg1.onPrimaryActivated
    if primaryActionText ~= nil and onPrimaryActivated ~= nil then
        table.insert(actions, {
            text = primaryActionText,
            variant = ButtonVariant.Emphasis,
            onActivated = function()
                GetTransientUIOverlayStore(false).clearDialog()
                onPrimaryActivated()
            end
        })
    end
    table.insert(actions, {
        text = arg1.secondaryActionText,
        variant = ButtonVariant.Standard,
        onActivated = function()
            GetTransientUIOverlayStore(false).clearDialog()
            arg1.onSecondaryActivated()
        end
    })

    local dialog = React.createElement(Dialog.Root, {
        disablePortal = false,
        hasBackdrop = true,
        onClose = arg1.onClose ~= nil and function()
            GetTransientUIOverlayStore(false).clearDialog()
            arg1.onClose()
        end or nil,
        size = DialogSize.Small,
        testId = "transient-ui-dialog"
    }, {
        Title = React.createElement(Dialog.Title, { text = arg1.title, LayoutOrder = 1 }),
        Content = if arg1.body == nil then nil else React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Body = React.createElement(Dialog.Text, { Text = arg1.body, LayoutOrder = 1 })
            }
        ),
        Actions = React.createElement(Dialog.Actions, { orientation = EnumsOrientation.Horizontal, LayoutOrder = 3, actions = actions })
    })

    if arg1.colorMode == nil then
        return dialog
    end

    return (React.createElement("Folder", nil, {
        Provider = React.createElement(FoundationProvider, {
            colorMode = arg1.colorMode,
            device = arg1.device,
            preferences = {
                preferredTextSize = var1.preferredTextSize,
                preferredTransparency = var1.preferredTransparency,
                reducedMotion = var1.reducedMotion
            }
        }, { Dialog = dialog })
    }))
end
return TransientDialog
