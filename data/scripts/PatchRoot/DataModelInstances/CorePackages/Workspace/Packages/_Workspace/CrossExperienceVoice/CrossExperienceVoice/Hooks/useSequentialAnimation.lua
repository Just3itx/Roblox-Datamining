-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)

local React = dependencies.React
local ReactOtter = dependencies.ReactOtter

local _Types = require(CrossExperienceVoice.Common.Types)

return function(num1: number)
    local var1 = React.useRef(nil)
    local var2, var3 = ReactOtter.useAnimatedBinding(num1, function()
        if var1.current then
            var1.current()
            var1.current = nil
        end
    end)

    return var2, (React.useCallback(function(tbl1, func1: ((...any) -> (...any))?)
        local function animateStep(arg1, current: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
            var1.current = current
            var3(ReactOtter.ease(arg1.value, { duration = arg1.durationInMs / 1000, easingStyle = arg1.easingStyle }))
        end

        local function animateImpl(tbl2, num2: number, callback: ((...any) -> (...any))?)
            local var4 = tbl2[num2]
            if var4 == nil then
                return
            end

            animateStep(var4, function()
                if callback then
                    callback(num2)
                end
                animateImpl(tbl2, num2 + 1, callback)
            end)
        end

        return animateImpl(tbl1, 1, func1)
    end, {}))
end
