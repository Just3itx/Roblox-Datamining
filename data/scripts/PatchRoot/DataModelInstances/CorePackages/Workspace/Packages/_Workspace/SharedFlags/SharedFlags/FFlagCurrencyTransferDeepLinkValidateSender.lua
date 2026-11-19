-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:30:42Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagEnableCurrencyTransferDeepLink = require(script.Parent.FFlagEnableCurrencyTransferDeepLink)

return game:DefineFastFlag("CurrencyTransferDeepLinkValidateSender", false) and FFlagEnableCurrencyTransferDeepLink
