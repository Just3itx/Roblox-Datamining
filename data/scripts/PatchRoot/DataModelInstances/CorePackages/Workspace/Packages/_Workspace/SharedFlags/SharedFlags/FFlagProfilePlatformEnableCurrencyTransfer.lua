-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T15:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local GetFFlagEnableCurrencyTransferFlow = require(script.Parent.GetFFlagEnableCurrencyTransferFlow)

return game:DefineFastFlag("ProfilePlatformEnableCurrencyTransferV1", false) and GetFFlagEnableCurrencyTransferFlow()
