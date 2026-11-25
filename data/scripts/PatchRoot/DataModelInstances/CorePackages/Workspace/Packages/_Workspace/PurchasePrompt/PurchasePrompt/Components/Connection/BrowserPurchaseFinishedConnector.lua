-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local GuiService = game:GetService("GuiService")

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local retryAfterUpsell = require(PurchasePrompt.Thunks.retryAfterUpsell)
local connectToStore = require(PurchasePrompt.connectToStore)

local ExternalEventConnection = require(script.Parent.ExternalEventConnection)

return (connectToStore(nil, function(callback) -- name: mapDispatchToProps
    return {
        onBrowserWindowClosed = function()
            callback(retryAfterUpsell())
        end
    }
end)(function(arg1) -- name: BrowserPurchaseFinishedConnector
    local onBrowserWindowClosed = arg1.onBrowserWindowClosed

    return Roact.createElement(
        ExternalEventConnection,
        {
            event = GuiService.BrowserWindowClosed,
            callback = onBrowserWindowClosed
        }
    )
end))
