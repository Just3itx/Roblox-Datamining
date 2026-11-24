-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")

local Localization = require(InterventionSharedParent.RobloxAppLocales).Localization
local React = require(InterventionSharedParent.React)

local FFlagAppChatReactiveFeatureRestrictions = require(InterventionSharedParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local localization = if FFlagAppChatReactiveFeatureRestrictions then Localization.new(LocalizationService.RobloxLocaleId) else nil

local function useCountdownBinding(num1: number?, str1: string?)
    local var1, var2 = React.useBinding(str1 or "")
    local var3 = React.useCallback(function(): number
        if num1 == nil then
            var2(str1 or "")

            return 0
        end

        local dateTime = DateTime.now()
        local unixTimestamp = math.max(num1 - dateTime.UnixTimestamp, 0)
        local var3

        if FFlagAppChatReactiveFeatureRestrictions and localization ~= nil and unixTimestamp >= 86400 then
            local number = math.ceil(unixTimestamp / 86400)
            if number == 1 then
                var3 = localization:Format("Feature.InExperienceIntervention.Label.TimeLeft.Day.Singular")
            else
                var3 = localization:Format("Feature.InExperienceIntervention.Label.TimeLeft.Day.Plural", { number = number })
            end
        elseif unixTimestamp >= 3600 then
            var3 = DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime(
                if FFlagAppChatReactiveFeatureRestrictions then "HH:mm:ss" else "h:mm:ss",
                LocalizationService.RobloxLocaleId
            )
        else
            var3 = DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime("m:ss", LocalizationService.RobloxLocaleId)
        end

        var2(var3)
        return unixTimestamp
    end, { str1, num1 })

    React.useEffect(function()
        var3()
    end, { var3 })

    React.useEffect(function()
        local connection = nil
        if num1 ~= nil then
            local dateTime = DateTime.now()
            local num2 = num1 - dateTime.UnixTimestamp

            if num2 > 0 then
                local num3 = 0

                connection = RunService.Heartbeat:Connect(function()
                    local now = os.clock()
                    if now - num3 < 1 then
                        return
                    end
                    num3 = now
                    num2 = var3()
                    if num2 <= 0 and connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end)
            end
        end
        return function()
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { num1, var3 })

    return var1
end

return useCountdownBinding
