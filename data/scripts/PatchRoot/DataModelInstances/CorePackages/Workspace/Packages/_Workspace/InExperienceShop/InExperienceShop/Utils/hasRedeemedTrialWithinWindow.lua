-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local FIntRedeemedTrialBlueDotMaxSecondsUntilEnd = require(InExperienceShop.Flags.FIntRedeemedTrialBlueDotMaxSecondsUntilEnd)

local function hasRedeemedTrialWithinWindow(tbl1)
    local unixTimestamp = DateTime.now().UnixTimestamp
    for _, value in tbl1 do
        local endTime = value.endTime
        if endTime ~= nil and unixTimestamp < endTime.UnixTimestamp + FIntRedeemedTrialBlueDotMaxSecondsUntilEnd then
            return true
        end
    end
    return false
end

return hasRedeemedTrialWithinWindow
