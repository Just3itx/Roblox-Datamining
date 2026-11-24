-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("ReactLowEndMemoryCutoff", 3500)
local num2 = game:DefineFastInt("ReactHighEndMemoryCutoff", 7500)

local DevicesParent = script:FindFirstAncestor("Devices").Parent
local SystemInfoProtocol = require(DevicesParent.SystemInfoProtocol).SystemInfoProtocol

local module = {}

function module.GetDeviceMemoryTier()
    local success, result = pcall(function()
        return SystemInfoProtocol.default:getSystemInfo({ SystemInfoProtocol.InfoNames.MAX_MEMORY })
    end)
    if not success or typeof(result) ~= "table" then
        return nil
    end

    local var1 = tonumber(result[SystemInfoProtocol.InfoNames.MAX_MEMORY])
    return if var1 then if var1 <= num1 then "LowEnd" elseif num2 <= var1 then "HighEnd" else "MidTier" else nil
end

return module
