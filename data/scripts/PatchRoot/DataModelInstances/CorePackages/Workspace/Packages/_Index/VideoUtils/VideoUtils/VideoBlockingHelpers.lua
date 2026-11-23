-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    VideoBlockingTelemetryConfig = {
        eventName = "EdpVideoPreviewBlockingStatus",
        backends = { "Points", "EventIngest" },
        lastUpdated = { 26, 3, 25 },
        description = "Telemetry about whether or not the video is blocked by manufacturer/device/max memory",
        throttlingPercentage = game:DefineFastInt("VideoBlockingTelemetryThrottleHundredthsPercent", 10000)
    },
    isInPipeDenyList = function(str1: string?, str2: string?)
        if not str1 or not str2 or str2 == "" then
            return false
        end
        for value in str2:gmatch("([^|]+)") do
            if typeof(value) == "string" and string.lower(value) == string.lower(str1) then
                return true
            end
        end
        return false
    end
}
