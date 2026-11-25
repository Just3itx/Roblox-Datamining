-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local getUpsellFlow = require(PurchasePrompt.NativeUpsell.getUpsellFlow)

local MarketplaceServiceEventConnector = require(script.Parent.MarketplaceServiceEventConnector)
local InputTypeManager = require(script.Parent.InputTypeManager)
local BrowserPurchaseFinishedConnector = require(script.Parent.BrowserPurchaseFinishedConnector)
local NativePurchaseFinishedConnector = require(script.Parent.NativePurchaseFinishedConnector)

local function EventConnections()
    local element = nil
    local upsellFlow = getUpsellFlow(UserInputService:GetPlatform())
    if upsellFlow == UpsellFlow.Web then
        element = Roact.createElement(BrowserPurchaseFinishedConnector)
    elseif upsellFlow == UpsellFlow.Mobile then
        element = Roact.createElement(NativePurchaseFinishedConnector)
    end

    local bool1 = UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne

    return Roact.createElement("Folder", {}, {
        MarketPlaceServiceEventConnector = Roact.createElement(MarketplaceServiceEventConnector),
        InputTypeManager = bool1 and Roact.createElement(InputTypeManager) or nil,
        UpsellFinishedConnector = element
    })
end

return EventConnections
