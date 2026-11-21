-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Parent.ContactImporter.Common.Constants)

local engineFeature = game:GetEngineFeature(Constants.UNIVERSAL_APP_CONTACT_IMPORTER_STORAGE_KEYS)

local module = {}

function module.addSeenCount(_, arg1, str1: string)
    if not engineFeature then
        return
    end
    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_MODAL_DISPLAY_COUNT)
    end)
    if not success then
        return
    end

    local str2 = ""

    if result == "" then
        str2 = str1 .. ":1"
    else
        local bool1 = false

        for value in string.gmatch(result or "", "([^,]+)") do
            local tbl1 = string.split(value, ":")
            local str3 = tbl1[1]
            local num1 = tonumber(tbl1[2]) or 0
            if str3 == str1 then
                num1 += 1
                bool1 = true
            end
            local str4 = str3 .. ":" .. tostring(num1)
            if str2 ~= "" then
                str2 ..= "," .. str4
            else
                str2 = str4
            end
        end

        if not bool1 then
            str2 ..= "," .. str1 .. ":1"
        end
    end
    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_MODAL_DISPLAY_COUNT, str2)
        arg1:Flush()
    end)
end

function module.updateTimestamp(_, arg1, str1: string, num1: number)
    if not engineFeature then
        return
    end

    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_MODAL_TIMESTAMP)
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
            local str4 = tbl1[2]
            if str3 == str1 then
                str4 = tostring(num1)
                bool1 = true
            end

            local str5 = str3 .. ":" .. tostring(str4)
            if str2 ~= "" then
                str2 ..= "," .. str5
            else
                str2 = str5
            end
        end
        if not bool1 then
            str2 ..= "," .. str1 .. ":" .. tostring(num1)
        end
    end
    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_MODAL_TIMESTAMP, str2)
        arg1:Flush()
    end)
end

return module
