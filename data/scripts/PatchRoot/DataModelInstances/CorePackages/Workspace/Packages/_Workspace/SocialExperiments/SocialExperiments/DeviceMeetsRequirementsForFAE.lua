-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:41:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent
local SystemInfoProtocol = require(SocialExperimentsParent.SystemInfoProtocol).SystemInfoProtocol
local FFlagTestDeviceForFAEUpsell = require(script.Parent.FFlagTestDeviceForFAEUpsell)
local str1 = game:DefineFastString("FAEUpsellDeviceNamePipeDenyList", "")
local str2 = game:DefineFastString("FAEUpsellSystemVersionPipeDenyList", "")

local var1 = nil
local function deviceMeetsRequirementsForFAE()
    if not FFlagTestDeviceForFAEUpsell then
        return true
    end
    if var1 ~= nil then
        return var1
    end
    local success, result = pcall(function()
        local tbl1 = { SystemInfoProtocol.InfoNames.DEVICE_NAME, SystemInfoProtocol.InfoNames.SYSTEM_VERSION, SystemInfoProtocol.InfoNames.BASE_OS }

        local systemInfo = SystemInfoProtocol.default:getSystemInfo(tbl1)
        local deviceName = systemInfo.deviceName or "Unknown"

        if typeof(deviceName) == "string" then
            for value in str1:gmatch("([^|]+)") do
                if deviceName:lower():find(value:lower()) then
                    var1 = false
                    return var1
                end
            end
        end

        local var2 = (systemInfo.baseOs or "UnknownOS") .. ":" .. (systemInfo.systemVersion or "UnknownVersion")

        if typeof(var2) == "string" then
            for value in str2:gmatch("([^|]+)") do
                if var2:lower():find(value:lower()) then
                    var1 = false
                    return var1
                end
            end
        end
        var1 = true
        return var1
    end)
    return not success or result
end

return deviceMeetsRequirementsForFAE
