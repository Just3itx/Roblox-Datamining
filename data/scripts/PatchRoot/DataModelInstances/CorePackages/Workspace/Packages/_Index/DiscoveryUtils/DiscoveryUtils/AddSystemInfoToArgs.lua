-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local SystemInfoProtocol = require(DiscoveryUtilsParent.SystemInfoProtocol).SystemInfoProtocol
local ArgCheck = require(DiscoveryUtilsParent.ArgCheck)

local tbl1 = {
    [SystemInfoProtocol.InfoNames.MANUFACTURER] = "deviceManufacturer",
    [SystemInfoProtocol.InfoNames.BASE_OS] = "operatingSystemVersion",
    [SystemInfoProtocol.InfoNames.IS_64BIT] = "if64Bit",
    [SystemInfoProtocol.InfoNames.CPU_CORE_COUNT] = "cpuCores"
}

return function(tbl2, tbl3)
    local var1 = tbl3 or SystemInfoProtocol.ALL_INFO_NAMES

    local success, result = pcall(function()
        return SystemInfoProtocol.default:getSystemInfo(var1)
    end)
    if not success or typeof(result) ~= "table" then
        return
    end

    for k, value in pairs(result) do
        local var2 = tbl1[k] or k
        ArgCheck.assert(
            tbl2[var2] == nil,
            "Field '" .. tostring(var2) .. "' already exists in argument table!  Will be overwritten."
        )
        tbl2[var2] = value
    end
end
