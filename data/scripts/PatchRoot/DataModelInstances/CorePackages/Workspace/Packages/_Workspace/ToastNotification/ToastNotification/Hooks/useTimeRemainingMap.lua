-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local dependencies = require(scriptParentParent.dependencies)
local utils = scriptParentParent.utils
local _type = require(scriptParentParent.type)
local toastNotificationHelper = require(utils.toastNotificationHelper)
local getNearestWholeNumber = toastNotificationHelper.getNearestWholeNumber
local calculateTimeRemaining = toastNotificationHelper.calculateTimeRemaining

local LuauPolyfill = dependencies.LuauPolyfill
local React = dependencies.React

local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local function useTimeRemainingMap(tbl1, arg1)
    local _, var1 = React.useState(0)
    local result = ({})
    local bool1 = true

    for k, value in pairs(tbl1) do
        local nearestWholeNumber = getNearestWholeNumber(
            calculateTimeRemaining(value, arg1.notificationReceivedTimestampMs, arg1.displayTimestampMs) / 1000
        )

        if nearestWholeNumber > 0 then
            bool1 = false
        end

        result[k] = math.max(0, nearestWholeNumber)
    end

    React.useEffect(function()
        local var2 = if bool1 then nil else setInterval(function()
            var1(os.clock())
        end, 100)

        return function()
            if var2 then
                clearInterval(var2)
            end
        end
    end, { bool1, var1 })

    return result
end

return useTimeRemainingMap
