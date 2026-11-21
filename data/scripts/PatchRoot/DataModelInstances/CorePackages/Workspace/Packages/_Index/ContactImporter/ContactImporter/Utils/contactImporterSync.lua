-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Parent.ContactImporter.Common.Constants)

local engineFeature = game:GetEngineFeature(Constants.UNIVERSAL_APP_CONTACT_IMPORTER_STORAGE_KEYS)
local getFIntContactImporterSyncMinHours = require(script.Parent.Parent.Flags.getFIntContactImporterSyncMinHours)

local module = {}

function module.updateSyncTimestamp(_, arg1, str1: string, num1: number)
    if not engineFeature then
        return
    end
    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_CONTACTS_SYNC)
    end)
    if not success then
        return
    end

    local str2 = ""

    if result == "" then
        str2 = str1 .. ":" .. tostring(num1)
    else
        local bool1 = false

        for value in string.gmatch(result or "", "([^,]+)") do
            local tbl1 = string.split(value, ":")
            local str3 = tbl1[1]
            local num2 = tonumber(tbl1[2]) or 0
            if str3 == str1 then
                num2 = num1
                bool1 = true
            end

            local str4 = str3 .. ":" .. tostring(num2)
            if str2 ~= "" then
                str2 ..= "," .. str4
            else
                str2 = str4
            end
        end

        if not bool1 then
            str2 ..= "," .. str1 .. ":" .. tostring(num1)
        end
    end
    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_CONTACTS_SYNC, str2)
        arg1:Flush()
    end)
end

function module.shouldSyncContacts(_, arg1, str1: string, num1: number): boolean
    if not engineFeature then
        return true
    end
    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_CONTACTS_SYNC)
    end)
    if not success then
        return true
    end
    local num2 = 0
    for value in string.gmatch(result or "", "([^,]+)") do
        local tbl1 = string.split(value, ":")
        if tbl1[1] == str1 then
            num2 = tonumber(tbl1[2])
            break
        end
    end

    return getFIntContactImporterSyncMinHours() * 3600000 <= num1 - num2
end

return module
