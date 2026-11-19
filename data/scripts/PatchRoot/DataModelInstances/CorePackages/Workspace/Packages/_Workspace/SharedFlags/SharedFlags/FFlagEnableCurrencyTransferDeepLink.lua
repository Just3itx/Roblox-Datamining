-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:41:05Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagEnableCurrencyTransferFlow = require(script.Parent.GetFFlagEnableCurrencyTransferFlow)

return game:DefineFastFlag("EnableCurrencyTransferDeepLink", false) and GetFFlagEnableCurrencyTransferFlow()
