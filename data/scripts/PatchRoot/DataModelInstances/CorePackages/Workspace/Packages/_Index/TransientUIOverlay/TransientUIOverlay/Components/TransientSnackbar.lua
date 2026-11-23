-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TransientUIOverlay = script:FindFirstAncestor("TransientUIOverlay")
local TransientUIOverlayParent = TransientUIOverlay.Parent

local Foundation = require(TransientUIOverlayParent.Foundation)
local React = require(TransientUIOverlayParent.React)

local FoundationProvider = Foundation.FoundationProvider
local Snackbar = Foundation.Snackbar
local View = Foundation.View
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local _Types = require(TransientUIOverlay.Types)

local function TransientSnackbar(arg1)
    local var1 = useTokens()
    local var2 = usePreferences()

    local snackbar = React.createElement(Snackbar, {
        title = arg1.title,
        icon = arg1.icon,
        action = arg1.actionText and {
            text = arg1.actionText,
            onActivated = arg1.onAction or function() end
        } or nil,
        LayoutOrder = 1,
        testId = "transient-snackbar"
    })

    local anchor = React.createElement(View, {
        Position = UDim2.new(0.5, 0, 1, -var1.Padding.XLarge),
        tag = "anchor-bottom-center auto-xy",
        testId = "transient-snackbar-anchor"
    }, { Snackbar = snackbar })

    if arg1.colorMode == nil then
        return anchor
    end

    return (React.createElement("Folder", nil, {
        Provider = React.createElement(FoundationProvider, {
            colorMode = arg1.colorMode,
            device = arg1.device,
            preferences = {
                preferredTextSize = var2.preferredTextSize,
                preferredTransparency = var2.preferredTransparency,
                reducedMotion = var2.reducedMotion
            }
        }, { Anchor = anchor })
    }))
end
return TransientSnackbar
