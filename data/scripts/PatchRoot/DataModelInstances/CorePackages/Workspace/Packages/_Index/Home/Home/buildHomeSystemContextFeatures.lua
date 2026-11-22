-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HomeParent = script:FindFirstAncestor("Home").Parent

local AddSystemInfoToArgs = require(HomeParent.DiscoveryUtils).AddSystemInfoToArgs

local tbl1 = {
    cpuCores = "cpucore",
    deviceManufacturer = "manufacturer",
    if64Bit = "if_64bit",
    maxMemory = "deviceram",
    systemVersion = "osversion",
    networkType = "networktype",
    cpuMake = "cpu_make",
    cpuSpeed = "cpu_speed",
    GPU = "gpu_adapter",
    availRAM = "avail_ram"
}

local function buildHomeSystemContextFeatures()
    local tbl2 = {}
    AddSystemInfoToArgs(tbl2)

    local homeSystemContextFeatures = {}

    for value, value2 in tbl1 do
        local var1 = tbl2[value]
        if var1 ~= nil and var1 ~= "" then
            homeSystemContextFeatures[value2] = tostring(var1)
        end
    end

    local maxResolution = tbl2.maxResolution
    if typeof(maxResolution) == "string" then
        local screenwidth, screenheight = string.match(maxResolution, "^(%d+)x(%d+)$")
        if screenwidth and screenheight then
            homeSystemContextFeatures.screenwidth = screenwidth
            homeSystemContextFeatures.screenheight = screenheight
        end
    end

    return homeSystemContextFeatures
end

return buildHomeSystemContextFeatures
