-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAgeMilliseconds(num1: number, num2: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.max(num2 - num1, 0)
end

local function getNextBucketBoundary(num1: number, ageMilliseconds: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 6 call sites recovered
    return num1 + math.min((math.floor(ageMilliseconds / num2) + 1) * num2, num3)
end

return {
    parseTimestamp = function(str1: string)
        if str1 == "" then
            return nil
        end

        local success, result = pcall(DateTime.fromIsoDate, str1)
        return if success and result ~= nil then result.UnixTimestampMillis else nil
    end,
    getRelativeAge = function(num1: number?, num2: number)
        if num1 == nil then
            return nil
        end

        local ageMilliseconds = getAgeMilliseconds(num1, num2)

        if ageMilliseconds < 60000 then
            return { unit = "now", count = 0 }
        elseif ageMilliseconds < 3600000 then
            return {
                unit = "minutes",
                count = math.floor(ageMilliseconds / 60000)
            }
        elseif ageMilliseconds < 86400000 then
            return {
                unit = "hours",
                count = math.floor(ageMilliseconds / 3600000)
            }
        elseif ageMilliseconds < 604800000 then
            return {
                unit = "days",
                count = math.floor(ageMilliseconds / 86400000)
            }
        elseif ageMilliseconds < 2592000000 then
            return {
                unit = "weeks",
                count = math.floor(ageMilliseconds / 604800000)
            }
        elseif ageMilliseconds < 31536000000 then
            return {
                unit = "months",
                count = math.floor(ageMilliseconds / 2592000000)
            }
        end

        return {
            unit = "years",
            count = math.floor(ageMilliseconds / 31536000000)
        }
    end,
    getNextChangeTimestamp = function(num1: number?, num2: number)
        if num1 == nil then
            return nil
        end

        local ageMilliseconds = getAgeMilliseconds(num1, num2)

        if ageMilliseconds < 60000 then
            return num1 + 60000
        elseif ageMilliseconds < 3600000 then
            return getNextBucketBoundary(num1, ageMilliseconds, 60000, 3600000)
        elseif ageMilliseconds < 86400000 then
            return getNextBucketBoundary(num1, ageMilliseconds, 3600000, 86400000)
        elseif ageMilliseconds < 604800000 then
            return getNextBucketBoundary(num1, ageMilliseconds, 86400000, 604800000)
        elseif ageMilliseconds < 2592000000 then
            return getNextBucketBoundary(num1, ageMilliseconds, 604800000, 2592000000)
        elseif ageMilliseconds < 31536000000 then
            return getNextBucketBoundary(num1, ageMilliseconds, 2592000000, 31536000000)
        end

        return getNextBucketBoundary(num1, ageMilliseconds, 31536000000, math.huge)
    end
}
