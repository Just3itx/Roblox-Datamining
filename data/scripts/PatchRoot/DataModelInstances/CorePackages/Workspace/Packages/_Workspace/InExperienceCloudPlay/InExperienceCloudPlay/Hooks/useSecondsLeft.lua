-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local React = require(InExperienceCloudPlayParent.React)
local _getCloudClientService = require(InExperienceCloudPlay.getCloudClientService)

local function useSecondsLeft(num1: number?, num2: number?)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        if not num1 or not num2 or num2 <= 0 then
            var2(nil)
            return nil
        end

        local var3 = os.clock() + num2 - num1:GetSessionElapsedTime()
        local var4 = nil
        local function tick()
            local var5 = var3 - os.clock()
            local num3 = math.max(0, math.ceil(var5))
            var2(num3)
            var4 = if num3 > 0 then task.delay(var5 - (num3 - 1), tick) else nil
        end

        local var5 = var3 - os.clock()
        local num3 = math.max(0, math.ceil(var5))
        var2(num3)
        if num3 > 0 then
            var4 = task.delay(var5 - (num3 - 1), tick)
        else
            var4 = nil
        end

        return function()
            if var4 then
                task.cancel(var4)
            end
        end
    end, { num1, num2 })

    return var1
end

return useSecondsLeft
