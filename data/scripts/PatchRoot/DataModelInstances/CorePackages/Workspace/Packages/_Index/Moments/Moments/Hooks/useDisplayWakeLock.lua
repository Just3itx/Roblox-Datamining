-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local getDeviceDisplayService = require(Moments.Utils.getDeviceDisplayService)
local isDisplayWakeLockSupported = require(Moments.Utils.isDisplayWakeLockSupported)

local function useDisplayWakeLock(bool1: boolean)
    React.useEffect(function()
        if bool1 and isDisplayWakeLockSupported() then
            local var1 = getDeviceDisplayService():AcquireWakeLock("Moments.WatchFeed")
            return function()
                var1:Destroy()
            end
        end
    end, { bool1 })
end

return useDisplayWakeLock
