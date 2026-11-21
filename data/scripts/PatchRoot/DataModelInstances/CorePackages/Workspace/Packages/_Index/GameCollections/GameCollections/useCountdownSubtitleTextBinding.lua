-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent
local React = require(GameCollectionsParent.React)
local calculateCountdownTime = require(GameCollections.calculateCountdownTime)

local function validateTimeValues(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1.days < 0) and not (arg1.hours < 0 or arg1.hours > 23) and not (arg1.minutes < 0 or arg1.minutes > 59)
end

local function getUpdateFrequency(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 < 15 then 1 else 15
end

local function useCountdownSubtitleTextBinding(num1: number?, str1: string?, str2: string?)
    local var1, var2 = React.useState("")
    local var3 = React.useCallback(function(): number
        if str2 == nil or str2 == "" or num1 == nil or str1 == nil or str1 == "" then
            return 0
        end

        local str3 = str2
        local dateTime = DateTime.now()
        local num2 = num1 - dateTime.UnixTimestamp
        local countdownTime = calculateCountdownTime(num2)

        if validateTimeValues(countdownTime) then
            if countdownTime.days > 0 then
                str3 = str2
            else
                local var3 = str1:gsub("{hours}", tostring(countdownTime.hours))
                local minutes = countdownTime.minutes
                str3 = var3:gsub("{minutes}", tostring(minutes))
            end
        end
        var2(str3)
        return num2
    end, { str2, num1, str1 })

    React.useEffect(function()
        var3()
    end, { var3 })

    React.useEffect(function()
        local connection = nil

        if str2 ~= nil and str2 ~= "" and num1 ~= nil and str1 ~= nil and str1 ~= "" then
            local dateTime = DateTime.now()
            local num2 = num1 - dateTime.UnixTimestamp

            if num2 > 0 then
                local num3 = 0
                local updateFrequency = getUpdateFrequency(num2)
                connection = RunService.Heartbeat:Connect(function()
                    local now = os.clock()
                    if now - num3 < updateFrequency then
                        return
                    end
                    num3 = now
                    num2 = var3()
                    updateFrequency = getUpdateFrequency(num2)
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

return useCountdownSubtitleTextBinding
