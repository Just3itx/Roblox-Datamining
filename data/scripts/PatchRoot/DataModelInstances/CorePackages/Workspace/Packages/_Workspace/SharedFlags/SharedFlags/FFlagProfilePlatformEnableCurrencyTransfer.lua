-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:11:12Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagEnableCurrencyTransferFlow = require(script.Parent.GetFFlagEnableCurrencyTransferFlow)

return game:DefineFastFlag("ProfilePlatformEnableCurrencyTransferV1", false) and GetFFlagEnableCurrencyTransferFlow()
