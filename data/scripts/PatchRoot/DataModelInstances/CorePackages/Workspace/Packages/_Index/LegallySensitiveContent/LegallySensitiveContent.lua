-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local userSettingsService = require(script.Services.userSettingsService)

return {
    ["jest.config"] = script["jest.config"],
    ConsentName = require(script.Enums.ConsentName),
    UserSetting = require(script.Enums.UserSetting),
    useLegallySensitiveContentAndActions = require(script.useTranslatedLegallySensitiveContentAndActions),
    updateUserSettings = userSettingsService.updateUserSettings,
    updateUserSettingV2 = userSettingsService.updateUserSettingV2
}
