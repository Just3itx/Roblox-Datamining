-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    ["jest.config"] = script["jest.config"],
    SduiSettingsPage = require(script.SduiSettingsPage),
    fetchSettingsPage = require(script.fetchSettingsPage),
    SduiUserSettingsRegister = require(script.SduiUserSettingsRegister),
    registerUserSettingsActions = require(script.registerUserSettingsActions)
}

function module.getSduiUpdateUserSettingsAction()
    return require(script.SduiUpdateUserSettingsAction)
end

return module
