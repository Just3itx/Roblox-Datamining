-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")

local React = require(InterventionSharedParent.React)
local useEffect = React.useEffect
local useMemo = React.useMemo
local useState = React.useState

local dependencyArray = require(InterventionSharedParent.RoactUtils).Hooks.dependencyArray

local var1 = require(InterventionSharedParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)

local function formatCountdown(num1: number)
    if num1 <= 0 then
        return nil
    end

    local unixTimestamp = math.ceil(num1 / 60) * 60

    if not (unixTimestamp >= 86400) then
        local time = DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime("HH:mm", LocalizationService.RobloxLocaleId)

        return var1:Format("Feature.InExperienceIntervention.Label.TimeLeft.Hours", { time = time })
    end

    local number = math.ceil(unixTimestamp / 86400)

    if number == 1 then
        return (var1:Format("Feature.InExperienceIntervention.Label.TimeLeft.Day.Singular"))
    end

    return (var1:Format("Feature.InExperienceIntervention.Label.TimeLeft.Day.Plural", { number = number }))
end

local function useRestrictionEndDateInfo(isoDate: string?)
    local isoDate2 = if isoDate and isoDate ~= "" then DateTime.fromIsoDate(isoDate) else nil

    local formattedEndDate = useMemo(function()
        if isoDate2 then
            return (isoDate2:FormatLocalTime("LLL", LocalizationService.RobloxLocaleId))
        end

        return nil
    end, dependencyArray(isoDate2))

    local countdownText, var4 = useState(function()
        if isoDate2 == nil then
            return nil
        end

        local num1 = math.max(isoDate2.UnixTimestamp - DateTime.now().UnixTimestamp, 0)
        return formatCountdown(num1)
    end)

    useEffect(function()
        if isoDate2 == nil then
            var4(nil)
            return
        end

        local dateTime = DateTime.now()
        local num1 = isoDate2.UnixTimestamp - dateTime.UnixTimestamp

        if num1 <= 0 then
            var4(nil)
            return
        end

        var4(formatCountdown(num1))

        local num2 = 0
        local connection = nil

        connection = RunService.Heartbeat:Connect(function()
            local now = os.clock()

            if now - num2 < 1 then
                return
            end

            num2 = now

            local num3 = math.max(isoDate2.UnixTimestamp - DateTime.now().UnixTimestamp, 0)
            var4(formatCountdown(num3))

            if num3 <= 0 and connection then
                connection:Disconnect()
                connection = nil
            end
        end)

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, dependencyArray(isoDate2, var4))

    return { formattedEndDate = formattedEndDate, countdownText = countdownText }
end

return useRestrictionEndDateInfo
