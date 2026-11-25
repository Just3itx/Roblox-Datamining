-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperiments = script:FindFirstAncestor("SocialExperiments")
local SocialExperimentsParent = SocialExperiments.Parent

local SystemInfoProtocol = require(SocialExperimentsParent.SystemInfoProtocol).SystemInfoProtocol

local _DeviceGateFeature = require(SocialExperiments.DeviceGateFeature)

local tbl1 = {}
local tbl2 = {}

return function(tbl3)
    if tbl1[tbl3.featureName] == nil then
        tbl1[tbl3.featureName] = tbl3.enabled
    end

    if tbl1[tbl3.featureName] then
        if tbl2[tbl3.featureName] == nil then
            local _success, _result = pcall(function()
                local tbl4 = { SystemInfoProtocol.InfoNames.DEVICE_NAME, SystemInfoProtocol.InfoNames.SYSTEM_VERSION, SystemInfoProtocol.InfoNames.BASE_OS }

                local systemInfo = SystemInfoProtocol.default:getSystemInfo(tbl4)
                local deviceName = systemInfo.deviceName or "UnknownDeviceName"
                if typeof(deviceName) == "string" then
                    for value in tbl3.deviceNameBlackListString:gmatch("([^|]+)") do
                        if deviceName:lower():find(value:lower()) then
                            tbl2[tbl3.featureName] = true
                            return tbl2[tbl3.featureName]
                        end
                    end
                end

                local baseOs = systemInfo.baseOs or "UnknownOS"
                local systemVersion = systemInfo.systemVersion or "UnknownVersion"
                if typeof(baseOs) == "string" and typeof(systemVersion) == "string" then
                    local str1 = baseOs .. ":" .. systemVersion
                    for value in tbl3.osVersionBlackListString:gmatch("([^|]+)") do
                        if str1:lower():find(value:lower()) then
                            tbl2[tbl3.featureName] = true
                            return tbl2[tbl3.featureName]
                        end
                    end
                end

                tbl2[tbl3.featureName] = false
                return tbl2[tbl3.featureName]
            end)

            if tbl2[tbl3.featureName] == nil then
                tbl2[tbl3.featureName] = false
            end
        end
    else
        tbl2[tbl3.featureName] = false
    end

    return tbl2[tbl3.featureName]
end
