-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountSettingsPage = require(script.AccountSettingsPage)
local openAccountSettings = require(script.openAccountSettings)

local module = {
    ["jest.config"] = script["jest.config"],
    Page = AccountSettingsPage,
    openAccountSettings = openAccountSettings
}
function module.registerAccountSettingsEntryPointsActions()
    require(script.Sdui.registerAccountSettingsEntryPointsActions)()
end

module.Demo = {
    openAccountSettingsQrCode = function(arg1, arg2)
        openAccountSettings(arg1, arg2, { internal = { presentation = "QrCode" } })
    end
}

return module
