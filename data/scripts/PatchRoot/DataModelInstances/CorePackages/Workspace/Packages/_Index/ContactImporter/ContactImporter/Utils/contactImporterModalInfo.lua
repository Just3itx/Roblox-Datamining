-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Parent.ContactImporter.Common.Constants)

local getFIntContactImporterModalDisplayMaxCount = require(script.Parent.Parent.Flags.getFIntContactImporterModalDisplayMaxCount)

local getFIntContactImporterModalDisplayMinDays = require(script.Parent.Parent.Flags.getFIntContactImporterModalDisplayMinDays)

local engineFeature = game:GetEngineFeature(Constants.UNIVERSAL_APP_CONTACT_IMPORTER_STORAGE_KEYS)

local module = {}

function module.isUserOptedInLocalStorage(_, arg1, arg2)
    if not engineFeature then
        return false
    end

    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_OPTED_IN_USERS)
    end)

    if success then
        for value in string.gmatch(result or "", "([^,]+)") do
            if arg2 == value then
                return true
            end
        end
    end
    return false
end

function module.shouldUserSeeModalPotentiallyAgain(_, arg1, arg2): boolean
    if not engineFeature then
        return true
    end

    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_MODAL_DISPLAY_COUNT)
    end)
    if not success then
        return true
    end
    local num1 = 0

    for value in string.gmatch(result or "", "([^,]+)") do
        local tbl1 = string.split(value, ":")
        if tbl1[1] == arg2 then
            num1 = tonumber(tbl1[2]) or 0
            break
        end
    end

    if num1 <= getFIntContactImporterModalDisplayMaxCount() then
        return true
    end

    local success2, result2 = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_MODAL_TIMESTAMP)
    end)
    if not success2 then
        return true
    end
    local num2 = 0

    for value in string.gmatch(result2 or "", "([^,]+)") do
        local tbl1 = string.split(value, ":")
        if tbl1[1] == arg2 then
            num2 = tonumber(tbl1[2]) or 0
            break
        end
    end

    local var1 = getFIntContactImporterModalDisplayMinDays() * 86400000
    return DateTime.now().UnixTimestampMillis >= num2 + var1
end

return module
