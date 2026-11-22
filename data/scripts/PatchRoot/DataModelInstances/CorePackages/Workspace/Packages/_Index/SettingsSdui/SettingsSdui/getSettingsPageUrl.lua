-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSduiParent = script:FindFirstAncestor("SettingsSdui").Parent

local Url = require(SettingsSduiParent.Http).Url
local var1 = require(SettingsSduiParent.UrlBuilder).UrlBuilder.new(
    {
        base = Url.APIS_URL,
        path = "account-management-api/v1/usersettings/menu"
    }
)

local function getSettingsPageUrl()
    return var1()
end

return getSettingsPageUrl
