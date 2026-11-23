-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")

local AuthAnalyticsParent = script:FindFirstAncestor("AuthAnalytics").Parent

local LoggingProtocol = require(AuthAnalyticsParent.LoggingProtocol)
local TelemetryConfigs = require(script.Parent.TelemetryConfigs)

local function getWallClockMillis(): number
    return DateTime.now().UnixTimestampMillis
end

local function createTimeToLoginTracker(tbl1, func1: ((...any) -> (...any))?, tbl2, tbl3)
    local var1 = func1 or getWallClockMillis
    local var2 = tbl2 or MemStorageService
    local var3 = tbl3 or HttpService

    local function readPendingAttempt()
        local item = var2:GetItem("TimeToLoginPending")
        if item == nil or item == "" then
            return nil
        end

        local success, result = pcall(function()
            return var3:JSONDecode(item)
        end)
        if not success or type(result) ~= "table" then
            return nil
        end

        local loginType = result.loginType
        local identifierType = result.identifierType
        local startTimeMillis = result.startTimeMillis
        return if type(loginType) == "string" and type(identifierType) == "string" and type(startTimeMillis) == "number" then {
            loginType = loginType,
            identifierType = identifierType,
            startTimeMillis = startTimeMillis,
            twoStepVerification = result.twoStepVerification == true
        } else nil
    end

    local function writePendingAttempt(tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
        var2:SetItem(
            "TimeToLoginPending",
            var3:JSONEncode({
                loginType = tbl4.loginType,
                identifierType = tbl4.identifierType,
                startTimeMillis = tbl4.startTimeMillis,
                twoStepVerification = tbl4.twoStepVerification
            })
        )
    end

    local function cancel() -- Luacid: Inlined by compiler; 1 call site recovered
        var2:SetItem("TimeToLoginPending", "")
    end

    local function pendingAgeMillis(tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
        return var1() - tbl4.startTimeMillis
    end

    local function reportInvalidDuration(tbl4, reason: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl1:logRobloxTelemetryCounter(
            TelemetryConfigs.TimeToLoginInvalidDurationConfig,
            1,
            {
                loginType = tbl4.loginType,
                reason = reason
            }
        )
    end
    return {
        start = function(loginType: string, identifierType: string?)
            if loginType == nil or loginType == "" then
                return
            end

            writePendingAttempt({
                loginType = loginType,
                identifierType = identifierType or "Unknown",
                startTimeMillis = var1(),
                twoStepVerification = false
            })
        end,
        markTwoStepVerification = function()
            local var4 = readPendingAttempt()
            if var4 == nil or var4.twoStepVerification then
                return
            end

            var4.twoStepVerification = true
            writePendingAttempt(var4)
        end,
        cancel = cancel,
        finish = function()
            local var4 = readPendingAttempt()
            if var4 == nil then
                return
            end

            cancel()
            local var5 = pendingAgeMillis(var4)

            if var5 < 0 then
                reportInvalidDuration(var4, "negative")
                return
            end

            if var5 > 600000 then
                reportInvalidDuration(var4, "stale")
                return
            end

            tbl1:logRobloxTelemetryStat(TelemetryConfigs.TimeToLoginStatConfig, math.floor(var5), {
                loginType = var4.loginType,
                identifierType = var4.identifierType,
                twoStepVerification = tostring(var4.twoStepVerification)
            })
        end
    }
end

return {
    create = createTimeToLoginTracker,
    default = createTimeToLoginTracker(LoggingProtocol.default)
}
