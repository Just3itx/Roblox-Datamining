-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local RunService = game:GetService("RunService")

local React = require(GamePlayButtonParent.React)

local function formatRemaining(num1: number): string
    local num2 = math.max(math.floor(num1), 0)
    local num3 = math.floor(num2 / 86400)
    local num4 = math.floor(num2 % 86400 / 3600)
    local num5 = math.floor(num2 % 3600 / 60)
    local num6 = num2 % 60

    local tbl1 = {}
    if num3 > 0 then
        table.insert(tbl1, string.format("%dd", num3))
    end
    if num4 > 0 then
        table.insert(tbl1, string.format("%dh", num4))
    end
    if num5 > 0 then
        table.insert(tbl1, string.format("%dm", num5))
    end
    table.insert(tbl1, string.format("%ds", num6))
    return table.concat(tbl1, " ")
end

local function computeText(num1: number?)
    if num1 == nil then
        return ""
    end
    local num2 = num1 - DateTime.now().UnixTimestamp

    if num2 <= 0 then
        return ""
    end
    return formatRemaining(num2)
end

local function useCountdownText(num1: number?)
    local var1, var2 = React.useState(function(): string
        return computeText(num1)
    end)

    React.useEffect(function()
        var2(computeText(num1))

        if num1 == nil or num1 - DateTime.now().UnixTimestamp <= 0 then
            return
        end

        local connection = nil
        local num2 = 0
        connection = RunService.Heartbeat:Connect(function()
            local now = os.clock()
            if now - num2 < 1 then
                return
            end
            num2 = now
            var2(computeText(num1))
            if num1 - DateTime.now().UnixTimestamp <= 0 and connection then
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
    end, { num1 })

    return var1
end

return useCountdownText
