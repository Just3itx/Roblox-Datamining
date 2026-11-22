-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local usePreferences = Foundation.Hooks.usePreferences

local tbl1 = { dampingRatio = 1, frequency = 3 }

local function usePostStatusCardMotion(str1: string?)
    local reducedMotion = usePreferences().reducedMotion
    local var1 = React.useRef(nil)

    local function finishHiding() -- Luacid: Inlined by compiler; 2 call sites recovered
        local current = var1.current
        var1.current = nil
        if current ~= nil then
            current()
        end
    end

    local var2 = React.useCallback(function(num1: number)
        if num1 <= 0 then
            finishHiding()
        end
    end, {})

    local shown, var4 = ReactOtter.useAnimatedBinding(0, var2)

    React.useEffect(function()
        finishHiding()

        if str1 == nil then
            var4(ReactOtter.instant(0))
        elseif reducedMotion then
            var4(ReactOtter.instant(1))
        else
            var4(ReactOtter.spring(1, tbl1))
        end
    end, { str1, reducedMotion })

    React.useEffect(function()
        return finishHiding
    end, {})

    return {
        shown = shown,
        hide = React.useCallback(function(current: (...any) -> (...any))
            if reducedMotion then
                current()
                return
            end
            var1.current = current
            var4(ReactOtter.spring(0, tbl1))
        end, { reducedMotion, var4 })
    }
end

return usePostStatusCardMotion
