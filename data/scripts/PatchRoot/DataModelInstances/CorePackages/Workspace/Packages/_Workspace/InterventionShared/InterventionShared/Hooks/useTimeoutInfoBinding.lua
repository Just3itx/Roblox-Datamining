-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local RunService = game:GetService("RunService")

local React = require(InterventionSharedParent.React)
local useBinding = React.useBinding
local useEffect = React.useEffect

local determineChatTimeoutInfo = require(InterventionShared.Utils.determineChatTimeoutInfo)

local function useTimeoutInfoBinding(isoDate: string?, num1: number?)
    local heading, var2 = useBinding("")
    local description, var4 = useBinding("")
    local isoDate2 = if isoDate and isoDate ~= "" then DateTime.fromIsoDate(isoDate) else nil

    useEffect(function()
        local _, var5, var6 = determineChatTimeoutInfo(isoDate2, num1)
        var2(var5)
        var4(var6)
    end, { isoDate2, num1 })

    useEffect(function()
        local connection = nil

        if isoDate2 == nil then
            return
        end

        local dateTime = DateTime.now()
        if isoDate2.UnixTimestamp - dateTime.UnixTimestamp <= 0 then
            return
        end

        local num2 = 0

        connection = RunService.Heartbeat:Connect(function()
            local now = os.clock()

            if now - num2 < 1 then
                return
            end

            num2 = now

            local var5, var6, var7 = determineChatTimeoutInfo(isoDate2, num1)
            var2(var6)
            var4(var7)

            if var5 <= 0 and connection then
                connection:Disconnect()
            end
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { isoDate2 })

    return { heading = heading, description = description }
end

return useTimeoutInfoBinding
