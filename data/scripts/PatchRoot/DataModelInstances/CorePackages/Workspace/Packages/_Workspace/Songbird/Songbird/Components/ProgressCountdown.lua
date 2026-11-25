-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)
local Foundation = require(Songbird.Parent.Foundation)

local useCallback = React.useCallback

local tbl1 = { counterType = "Remaining" }

local function secondsToHHM(num1: number): string
    local num2 = math.floor(num1 / 3600)
    local num3 = math.floor(num1 % 3600 / 60)
    local num4 = num1 % 60

    if num2 > 0 then
        return string.format("%i:%02i:%02i", num2, num3, num4)
    end
    return string.format("%i:%02i", num3, num4)
end

local function ProgressCountdown(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useCallback(function(num1: number)
        if var1.counterType ~= "Remaining" then
            return secondsToHHM(math.ceil(num1))
        end

        local num2 = math.floor(var1.timeLength - num1)
        return "-" .. secondsToHHM(num2)
    end, { var1.timeLength })

    return React.createElement(Foundation.Text, {
        tag = {
            ["auto-xy text-label-medium content-muted"] = true,
            ["align-x-right"] = var1.counterType == "Remaining"
        },
        Text = var1.timePosition:map(var2),
        LayoutOrder = var1.LayoutOrder
    })
end

return ProgressCountdown
