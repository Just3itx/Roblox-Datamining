-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console
local module = {}

local log = nil

local _ReactFiberLane = require(script.Parent.ReactFiberLane)

local enableDebugTracing = require(scriptParentParent.Shared).ReactFeatureFlags.enableDebugTracing

local log2 = nil

local tbl1 = {}

local num1 = 0

function decimalToBinaryString(num2: number): string
    local str1 = ""

    repeat
        local num3 = num2 / 2
        local var1
        num2, var1 = math.modf(num3)

        str1 = math.ceil(var1) .. str1
    until num2 == 0

    local num3 = 31 - string.len(str1)
    return string.rep("0", num3) .. str1
end

local function formatLanes(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return "0b" .. decimalToBinaryString(arg1)
end

local function group(...)
    for _, value in { ... } do
        table.insert(tbl1, value)
    end
    if log2 == nil then
        log2 = console.log
        console.log = log
    end
end

local function groupEnd()
    table.remove(tbl1, 1)
    while num1 > #tbl1 do
        console.groupEnd()
        num1 -= 1
    end
    if #tbl1 == 0 then
        console.log = log2
        log2 = nil
    end
end

log = function(...)
    if num1 < #tbl1 then
        for i = num1 + 1, #tbl1 do
            local var1 = tbl1[i]
            console.group(var1)
        end
        num1 = #tbl1
    end
    if typeof(log2) == "function" then
        log2(...)
        return
    end
    console.log(...)
end

function module.logCommitStarted(arg1)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        group(string.format("* commit (%s)", (formatLanes(arg1))), "", "", "")
    end
end

function module.logCommitStopped()
    if ReactGlobals.__DEV__ and enableDebugTracing then
        groupEnd()
    end
end

function module.logComponentSuspended(str1: string, arg1)
    if not ReactGlobals.__DEV__ or not enableDebugTracing then
        return
    end

    log(string.format("* %s suspended", str1))

    arg1:andThen(function()
        log(string.format("* %s resolved", str1))
    end, function()
        log(string.format("* %s rejected", str1))
    end)
end

function module.logLayoutEffectsStarted(arg1)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        group(string.format("* layout effects (%s)", (formatLanes(arg1))))
    end
end

function module.logLayoutEffectsStopped()
    if ReactGlobals.__DEV__ and enableDebugTracing then
        groupEnd()
    end
end

function module.logPassiveEffectsStarted(arg1)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        group(string.format("* passive effects (%s)", (formatLanes(arg1))))
    end
end

function module.logPassiveEffectsStopped()
    if ReactGlobals.__DEV__ and enableDebugTracing then
        groupEnd()
    end
end

function module.logRenderStarted(arg1)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        group(string.format("* render (%s)", (formatLanes(arg1))))
    end
end

function module.logRenderStopped()
    if ReactGlobals.__DEV__ and enableDebugTracing then
        groupEnd()
    end
end

function module.logForceUpdateScheduled(str1: string, arg1)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        log(string.format("* %s forced update (%s)", str1, (formatLanes(arg1))))
    end
end

function module.logStateUpdateScheduled(str1: string, arg1, _)
    if ReactGlobals.__DEV__ and enableDebugTracing then
        log(string.format("* %s updated state (%s)", str1, (formatLanes(arg1))))
    end
end

return module
