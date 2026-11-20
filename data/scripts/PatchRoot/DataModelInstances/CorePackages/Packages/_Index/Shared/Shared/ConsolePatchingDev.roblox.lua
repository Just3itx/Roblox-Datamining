-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(script.Parent.console)

local num1 = 0
local log = nil
local info = nil
local warn = nil
local error = nil
local group = nil
local groupCollapsed = nil
local groupEnd = nil

local function func1() end

local module = { disabledLog = func1 }

function module.disableLogs()
    if not ReactGlobals.__DEV__ then
        return
    end

    if num1 == 0 then
        log = console.log
        info = console.info
        warn = console.warn
        error = console.error
        group = console.group
        groupCollapsed = console.groupCollapsed
        groupEnd = console.groupEnd

        console.info = func1
        console.log = func1
        console.warn = func1
        console.error = func1
        console.group = func1
        console.groupCollapsed = func1
        console.groupEnd = func1
    end

    num1 += 1
end

function module.reenableLogs()
    if not ReactGlobals.__DEV__ then
        return
    end

    num1 -= 1

    if num1 == 0 then
        console.log = log
        console.info = info
        console.warn = warn
        console.error = error
        console.group = group
        console.groupCollapsed = groupCollapsed
        console.groupEnd = groupEnd
    end

    if num1 < 0 then
        console.error("disabledDepth fell below zero. This is a bug in React. Please file an issue.")
    end
end

return module
