-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Achievements = script:FindFirstAncestor("Achievements")
local AchievementsParent = Achievements.Parent

local LuauPolyfill = require(AchievementsParent.LuauPolyfill)
local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local Logger = require(Achievements.Logger)
local _Signal = require(AchievementsParent.Signal)

local module = ({})

function module.init(tbl1, fireDataChanged, intervalInSec: number)
    tbl1.fireDataChanged = fireDataChanged
    tbl1.intervalInSec = intervalInSec
end

function module.start(arg1)
    arg1.timerId = setInterval(arg1.check, arg1.intervalInSec * 1000, arg1)
    arg1.startTime = os.time()
end

function module.check(arg1)
    if arg1.startTime then
        local var1 = os.time() - arg1.startTime
        arg1.fireDataChanged(var1)
        return
    end
    Logger:error("No recorded start time")
end

function module.stop(arg1)
    if arg1.timerId then
        clearInterval(arg1.timerId)
        arg1.startTime = nil
    end
end

return module
