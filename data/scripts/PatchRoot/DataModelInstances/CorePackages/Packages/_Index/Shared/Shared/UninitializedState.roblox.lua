-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local console = require(script.Parent.console)

local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local tbl1 = {}

setmetatable(tbl1, {
    __index = function(_, _)
        if ReactGlobals.__DEV__ then
            console.warn("Attempted to access uninitialized state. Use setState to initialize state")
        end

        return nil
    end,
    __newindex = function(_, _)
        if ReactGlobals.__DEV__ then
            console.error("Attempted to directly mutate state. Use setState to assign new values to state.")
        end

        return nil
    end,
    __tostring = function(_): string
        return "<uninitialized component state>"
    end,
    __metatable = "UninitializedState"
})

return tbl1
