-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local MediaGalleryParent = script:FindFirstAncestor("MediaGallery").Parent

local SystemInfoProtocol = require(MediaGalleryParent.SystemInfoProtocol).SystemInfoProtocol

local FStringLuaAppEdpAudioManufacturerDenyList = require(MediaGalleryParent.SharedFlags).FStringLuaAppEdpAudioManufacturerDenyList

local var1 = nil

local function isAudioPlaybackAllowedForDevice()
    if var1 ~= nil then
        return var1
    end

    var1 = true

    pcall(function()
        local systemInfo = SystemInfoProtocol.default:getSystemInfo({ SystemInfoProtocol.InfoNames.MANUFACTURER })
        if typeof(systemInfo.manufacturer) ~= "string" then
            return
        end

        for value in FStringLuaAppEdpAudioManufacturerDenyList:gmatch("(%w+)") do
            if typeof(value) == "string" and string.lower(value) == string.lower(systemInfo.manufacturer) then
                var1 = false
            end
        end
    end)

    return var1
end

return isAudioPlaybackAllowedForDevice
