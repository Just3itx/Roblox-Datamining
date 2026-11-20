-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints

game:DefineFastFlag("EnableLeaveGameUpsellEntrypoint", false)

return function()
    return GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints() and game:GetFastFlag("EnableLeaveGameUpsellEntrypoint")
end
