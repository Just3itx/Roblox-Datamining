-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)
local engineFeature = game:GetEngineFeature(Constants.UNIVERSAL_APP_CONTACT_IMPORTER_STORAGE_KEYS)

local module = {}

function module.clearLocalStorage(_, arg1)
    if not engineFeature then
        return
    end
    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_OPTED_IN_USERS, "")
        arg1:Flush()
    end)
end

function module.addUserToLocalStorage(_, arg1, arg2)
    if not engineFeature then
        return
    end

    local success, result = pcall(function()
        return arg1:GetItem(Constants.LOCAL_STORAGE_KEY_OPTED_IN_USERS)
    end)
    if not success then
        return
    end

    local tbl1 = { arg2 }
    if result ~= nil and result ~= "" then
        local num1 = #tbl1 + 1

        for value in string.gmatch(result, "([^,]+)") do
            if value == arg2 then
                return
            end
            tbl1[num1] = value
            num1 += 1
        end
    end
    local var1 = table.concat(tbl1, ","):gsub("%s+", "")
    pcall(function()
        arg1:SetItem(Constants.LOCAL_STORAGE_KEY_OPTED_IN_USERS, var1)
        arg1:Flush()
    end)
end

return module
