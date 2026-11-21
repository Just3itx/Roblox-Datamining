-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local RunService = game:GetService("RunService")
local TelemetryService = game:GetService("TelemetryService")

local React = require(GameDetailParent.React)
local Logger = require(GameDetailParent.Loggers).Logger

local throttlingPercentage = game:DefineFastInt("ExperienceDetailsMotionJitterHundredthsPercent", 0)

local config = {
    eventName = "ExperienceDetailsMotionJitterPercent",
    backends = { "RobloxTelemetryStat" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 6, 18 },
    description = "Reverse movement as a percentage of total experience details surface motion"
}

local function readPositionY(current, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return current[str1].Y
end

local function logMotionJitter(tbl1, surface: string, str1: string)
    Logger:info("[useMotionJitterMetric] Logging motion jitter")
    if str1 ~= "settled" then
        Logger:warning("[useMotionJitterMetric] Should only log motion jitter for reason: settled")
        return
    end

    TelemetryService:LogStat(
        config,
        {
            standardizedFields = { "addOSInfo" },
            customFields = { surface = surface }
        },
        tbl1.jitterPx * 100 / tbl1.travelPx
    )
end

local function useMotionJitterMetric(arg1, surface: string, bool1: boolean, str1: string)
    React.useEffect(function()
        if throttlingPercentage <= 0 then
            return
        end

        local var1 = nil
        local var2 = nil

        local function flushMotion(str2: string) -- Luacid: unused: defined but never referenced
            Logger:info("[useMotionJitterMetric] Flushing motion metric for reason: " .. str2)
            if var2 then
                logMotionJitter(var2, surface, str2)
                var2 = nil
            end
        end

        local connection = nil
        connection = RunService.RenderStepped:Connect(function()
            local current = arg1.current
            if not current then
                Logger:info("[useMotionJitterMetric] Flushing motion metric for reason: missingContent")
                if var2 then
                    Logger:info("[useMotionJitterMetric] Logging motion jitter")

                    Logger:warning("[useMotionJitterMetric] Should only log motion jitter for reason: settled")

                    var2 = nil
                end

                var1 = nil
                return
            end

            local var3 = readPositionY(current, str1)
            if var1 == nil then
                if var3 >= 0 then
                    var1 = var3
                end
                return
            end

            local var4 = var3 - var1
            var1 = var3
            if not (math.abs(var4) <= 0.5) then
                var2 = var2 or { jitterPx = 0, travelPx = 0, settledFrames = 0 }

                local var5 = var2
                var5.travelPx += math.abs(var4)
                var5.settledFrames = 0
                if var4 * (if bool1 then 1 else -1) < -0.5 then
                    var5.jitterPx += math.abs(var4)
                end
                return
            end

            if not var2 then
                return
            end

            local var5 = var2
            var5.settledFrames += 1
            if not (var2.settledFrames >= 6) then
                return
            end

            Logger:info("[useMotionJitterMetric] Flushing motion metric for reason: settled")
            if var2 then
                logMotionJitter(var2, surface, "settled")
                var2 = nil
            end

            if connection then
                connection:Disconnect()
            end
        end)

        return function()
            Logger:info("[useMotionJitterMetric] Flushing motion metric for reason: unmount")
            if var2 then
                Logger:info("[useMotionJitterMetric] Logging motion jitter")

                Logger:warning("[useMotionJitterMetric] Should only log motion jitter for reason: settled")

                var2 = nil
            end

            if connection then
                connection:Disconnect()
            end
        end
    end, {
        arg1,
        surface,
        bool1,
        str1
    })
end
return useMotionJitterMetric
