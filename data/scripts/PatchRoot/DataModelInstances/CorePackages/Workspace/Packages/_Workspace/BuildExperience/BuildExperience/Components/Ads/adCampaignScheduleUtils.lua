-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toStartMs(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(str1) ~= "string" then
        return 0
    end
    local success, result = pcall(DateTime.fromIsoDate, str1)
    return if success and result ~= nil then result.UnixTimestampMillis else 0
end

return {
    MS_PER_DAY = 86400000,
    toStartMs = toStartMs,
    campaignEndMs = function(num1: number, num2: number): number
        return num1 + math.max(0, num2 - 1) * 86400000
    end,
    campaignEndExclusiveMs = function(num1: number, num2: number): number
        return num1 + math.max(0, num2) * 86400000
    end,
    hasActiveCampaign = function(tbl1, num1: number?, num2: number)
        if tbl1 == nil or num1 == nil or num1 == 0 then
            return false
        end
        local str1 = tostring(num1)
        for _, value in tbl1 do
            if value.targetUniverseId ~= str1 or value.status == "CANCELLED" or value.deliveryStatus == "REJECTED" then
                continue
            end

            if value.deliveryStatus == "IN_REVIEW" then
                return true
            end

            if value.status == "PAUSED" then
                continue
            end

            local var1 = toStartMs(value.schedule.startTime)
            local bool1 = var1 > 0 and value.schedule.durationInDays > 0

            if value.deliveryStatus == "SERVING" and not bool1 then
                return true
            end

            if num2 < var1 + math.max(0, value.schedule.durationInDays) * 86400000 then
                return true
            end
        end
        return false
    end
}
