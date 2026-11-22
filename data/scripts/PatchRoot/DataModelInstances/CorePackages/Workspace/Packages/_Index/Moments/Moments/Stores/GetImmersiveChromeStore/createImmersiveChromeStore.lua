-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local createSignal = require(MomentsParent.Signals).createSignal

local function createImmersiveChromeStore()
    local getChromeVisible, var2 = createSignal(true)

    local var3 = nil

    local getOverlayCovering, var5 = createSignal(false)

    return {
        getChromeVisible = getChromeVisible,
        setChromeVisible = function(bool1: boolean)
            var2(bool1)
        end,
        revealChrome = function()
            if var3 ~= nil then
                var3()
                return
            end
            var2(true)
        end,
        setRevealHandler = function(func1: ((...any) -> (...any))?)
            var3 = func1
        end,
        getOverlayCovering = getOverlayCovering,
        setOverlayCovering = function(bool1: boolean)
            var5(bool1)
        end
    }
end
return createImmersiveChromeStore
