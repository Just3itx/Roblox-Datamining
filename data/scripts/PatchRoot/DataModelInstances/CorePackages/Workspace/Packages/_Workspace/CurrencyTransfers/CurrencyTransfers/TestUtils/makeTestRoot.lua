-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local LocalizationService = game:GetService("LocalizationService")

local React = require(CurrencyTransfersParent.React)
local TransferContext = require(CurrencyTransfers.Contexts.TransferContext)
local Foundation = require(CurrencyTransfersParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local Localization = require(CurrencyTransfersParent.AppLocales).Localization
local LocalizationProvider = require(CurrencyTransfersParent.Localization).LocalizationProvider

return function(tbl1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)
    return function(arg1)
        return React.createElement(LocalizationProvider, { localization = localization }, { React.createElement(
                FoundationProvider,
                {
                    colorMode = Foundation.Enums.ColorMode.Dark
                },
                { React.createElement(TransferContext.Provider, { value = tbl1.transferStore }, arg1.children) }
            ) })
    end
end
