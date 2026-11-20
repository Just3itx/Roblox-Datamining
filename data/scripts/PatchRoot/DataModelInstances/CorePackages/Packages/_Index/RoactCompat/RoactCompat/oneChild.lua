-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local warnOnce = require(script.Parent.warnOnce)

local function oneChild(arg1)
    if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
        warnOnce(
            "oneChild",
            "You likely don't need this at all! If you were assigning children via `React.oneChild(someChildren)`, you can simply use `someChildren` directly."
        )
    end

    if not arg1 then
        return nil
    end

    local var1, var2 = next(arg1)

    if not var2 then
        return nil
    end

    if next(arg1, var1) then
        error("Expected at most one child, had more than one child.", 2)
    end

    return React.Children.only(var2)
end

return oneChild
