-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

local TransitionPreset = require(script.Parent.Enums.TransitionPreset)

local presets = require(script.Parent.Utility.TimingConfigs).presets
local default = presets[TransitionPreset.Default]

local module = {}

local function getTransition(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.transition or { default = default }
end

function module.createState(tbl1, tbl2)
    local tbl3 = {
        transition = {
            default = tbl2 and tbl2.default or default
        }
    }

    for value, value2 in tbl1 do
        tbl3[value] = value2
        if tbl2 and tbl2[value] then
            getTransition(tbl3)[value] = tbl2[value]
        end
    end

    return tbl3
end

function module.transition(arg1, arg2)
    if type(arg1) == "string" then
        arg1 = presets[arg1] or default
    end

    local tbl1 = {
        duration = arg1 and arg1.duration or default.duration,
        easingStyle = arg1 and arg1.easingStyle or default.easingStyle,
        delay = arg1 and arg1.delay or default.delay
    }

    if arg2 then
        if arg2.duration then
            tbl1.duration = arg2.duration
        end
        if arg2.easingStyle then
            tbl1.easingStyle = arg2.easingStyle
        end
        if arg2.delay then
            tbl1.delay = arg2.delay
        end
    end

    return tbl1
end

function module.animate(arg1, tbl1)
    if not arg1 then
        return
    end

    local var1 = arg1.transition or { default = default }

    for value, value2 in tbl1 do
        local var2 = var1[value]

        if var2 == nil then
            var2 = var1.default
        end
        if var2.delay and var2.delay > 0 then
            local var3 = table.clone(var2)
            task.delay(var2.delay, function()
                value2(arg1[value], var3)
            end)
        else
            value2(arg1[value], var2)
        end
    end
end

return module
