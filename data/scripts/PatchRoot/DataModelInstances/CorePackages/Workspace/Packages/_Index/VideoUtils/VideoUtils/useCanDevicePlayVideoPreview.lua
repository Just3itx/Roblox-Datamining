-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)
local LoggingProtocol = require(VideoUtilsParent.LoggingProtocol)
local reportWarning = require(VideoUtilsParent.DiscoveryAnalytics).Points.reportWarning
local SystemInfoProtocol = require(VideoUtilsParent.SystemInfoProtocol).SystemInfoProtocol

local VideoBlockingHelpers = require(VideoUtils.VideoBlockingHelpers)

local VideoBlockingTelemetryConfig = VideoBlockingHelpers.VideoBlockingTelemetryConfig

local var1 = nil

local function getSystemInfoLazy()
    if var1 then
        return var1
    end

    local tbl1 = { manufacturer = nil, deviceName = nil, maxMemory = nil }

    local success, result = pcall(function()
        local systemInfo = SystemInfoProtocol.default:getSystemInfo({ SystemInfoProtocol.InfoNames.MANUFACTURER, SystemInfoProtocol.InfoNames.DEVICE_NAME, SystemInfoProtocol.InfoNames.MAX_MEMORY })

        return {
            manufacturer = systemInfo.manufacturer,
            deviceName = systemInfo.deviceName,
            maxMemory = systemInfo.maxMemory
        }
    end)

    if success then
        tbl1 = result
    else
        reportWarning(
            LoggingProtocol.default,
            "EdpVideoPreviewBlocking",
            `Error retrieving device info for video preview blocking check: {result}`
        )
    end

    var1 = tbl1
    return tbl1
end

local function useCanDevicePlayVideoPreview(tbl1, universeId: string, pageContext: string)
    local var2 = React.useMemo(function()
        return (getSystemInfoLazy())
    end, {})

    local var3 = React.useMemo(function()
        if not (tbl1.enableManufacturerDeny and tbl1.manufacturerDenyList) then
            return false
        end
        return VideoBlockingHelpers.isInPipeDenyList(var2.manufacturer, tbl1.manufacturerDenyList)
    end, { tbl1.enableManufacturerDeny, tbl1.manufacturerDenyList, var2.manufacturer })

    local var4 = React.useMemo(function()
        if not (tbl1.enableDeviceDeny and tbl1.deviceDenyList) then
            return false
        end
        return VideoBlockingHelpers.isInPipeDenyList(var2.deviceName, tbl1.deviceDenyList)
    end, { tbl1.enableDeviceDeny, tbl1.deviceDenyList, var2.deviceName })

    local var5 = React.useMemo(function()
        if not tbl1.enableMaxMemoryDeny then
            return false
        end

        local maxMemoryThresholdMb = tbl1.maxMemoryThresholdMb or -1
        if maxMemoryThresholdMb > 0 and typeof(var2.maxMemory) == "string" then
            local var5 = tonumber(var2.maxMemory:match("(%d+)"))
            if var5 and var5 < maxMemoryThresholdMb then
                return true
            end
        end

        return false
    end, { tbl1.enableMaxMemoryDeny, tbl1.maxMemoryThresholdMb, var2.maxMemory })

    return (React.useCallback(function(): boolean
        local bool1 = false
        local var6 = nil

        if tbl1.enableAvailableRamDeny and tbl1.availableRamThresholdMb and tbl1.availableRamThresholdMb > 0 then
            local success, result = pcall(function()
                local systemInfo = SystemInfoProtocol.default:getSystemInfo({ SystemInfoProtocol.InfoNames.AVAIL_RAM })

                if typeof(systemInfo.availRAM) == "string" then
                    var6 = tonumber(systemInfo.availRAM)

                    if var6 and var6 < tbl1.availableRamThresholdMb then
                        return true
                    end
                end

                return false
            end)

            if success then
                bool1 = result
            else
                reportWarning(
                    LoggingProtocol.default,
                    "EdpVideoPreviewBlocking",
                    `Error retrieving available RAM for video preview blocking check: {result}`
                )
            end
        end

        TelemetryService:LogEvent(VideoBlockingTelemetryConfig, {
            standardizedFields = { "addOSInfo", "addSessionInfo" },
            customFields = {
                pageContext = pageContext,
                universeId = universeId,
                isBlockedByManufacturer = if tbl1.enableManufacturerDeny then var3 else nil,
                isBlockedByDevice = if tbl1.enableDeviceDeny then var4 else nil,
                isBlockedByMaxMemory = if tbl1.enableMaxMemoryDeny then var5 else nil,
                isBlockedByAvailableRam = if tbl1.enableAvailableRamDeny then bool1 else nil,
                availableRam = if tbl1.enableAvailableRamDeny then var6 else nil
            }
        })

        return not (tbl1.enableManufacturerDeny and var3
            or tbl1.enableDeviceDeny and var4
            or tbl1.enableMaxMemoryDeny and var5
            or tbl1.enableAvailableRamDeny and bool1)
    end, {
        tbl1.enableManufacturerDeny,
        tbl1.enableDeviceDeny,
        tbl1.enableMaxMemoryDeny,
        tbl1.enableAvailableRamDeny,
        tbl1.availableRamThresholdMb,
        var3,
        var4,
        var5,
        universeId,
        pageContext
    }))
end
return useCanDevicePlayVideoPreview
