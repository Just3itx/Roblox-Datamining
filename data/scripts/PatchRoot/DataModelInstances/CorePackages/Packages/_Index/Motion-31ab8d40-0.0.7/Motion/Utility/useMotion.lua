-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local useAnimatedValue = require(scriptParent.useAnimatedValue)
local _Types = require(scriptParentParent.Types)
local TimingConfigs = require(scriptParent.TimingConfigs)
local TransitionPreset = require(scriptParentParent.Enums.TransitionPreset)

local function useMotion(arg1)
    local tbl1 = ({})
    local tbl2 = ({})

    local var1 = React.useRef({})

    for value, value2 in arg1 do
        if type(value2) ~= "table" or value ~= "transition" then
            local var2, var3 = useAnimatedValue(value2)
            tbl1[value] = var2
            tbl2[value] = var3
        end
    end

    local function animate(arg2, tbl3)
        if not arg2 then
            return
        end

        local num1 = 0
        local tbl4 = ({})
        for value in tbl2 do
            if value ~= "transition" and arg2[value] ~= nil then
                num1 += 1
            end
        end

        local num2 = 0

        local function propertyOnComplete(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
            tbl4[str1] = arg2[str1]
            num2 += 1

            if tbl3 and tbl3.onAnimationComplete then
                tbl3.onAnimationComplete(str1)
            end

            if num2 == num1 and tbl3 and tbl3.onAnimationComplete then
                tbl3.onAnimationComplete(true)
            end
        end

        for value, value2 in tbl2 do
            if value == "transition" or arg2[value] == nil then
                continue
            end
            if var1.current[value] then
                local var2 = var1.current[value]
                if var2 then
                    task.cancel(var2)
                end
                var1.current[value] = nil
            end

            local transition = arg2.transition or {
                [TransitionPreset.Default] = TimingConfigs.getDefaultTransition()
            }
            local var2 = transition[value] or transition[TransitionPreset.Default] or TimingConfigs.getDefaultTransition()

            local var3 = table.clone(var2)

            function var3.onComplete()
                propertyOnComplete(value)
            end

            local delay = var3.delay or 0

            if delay > 0 then
                local var4 = task.delay(delay, function()
                    var1.current[value] = nil

                    value2(arg2[value], var3)
                end)

                var1.current[value] = var4
            else
                value2(arg2[value], var3)
            end
        end
    end

    return tbl1, animate
end

return useMotion
