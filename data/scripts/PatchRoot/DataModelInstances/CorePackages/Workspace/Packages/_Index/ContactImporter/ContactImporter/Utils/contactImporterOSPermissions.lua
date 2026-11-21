-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Parent.ContactImporter.Common.Constants)
local engineFeature = game:GetEngineFeature(Constants.UNIVERSAL_APP_CONTACT_IMPORTER_STORAGE_KEYS)

local module = {}

function module.getLastOSPermissionSettings(_, arg1): boolean
    if not engineFeature then
        return true
    end

    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_LAST_CONTACTS_OS_PERMISSIONS)
    end)

    return if success then result == "true" else false
end

function module.updateOSPermissionSettings(_, arg1, arg2)
    if not engineFeature then
        return
    end

    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_LAST_CONTACTS_OS_PERMISSIONS, tostring(arg2))
        arg1:Flush()
    end)
end

return module
