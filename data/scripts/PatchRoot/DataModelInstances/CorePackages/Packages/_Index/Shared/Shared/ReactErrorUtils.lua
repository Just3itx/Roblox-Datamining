-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local invariant = require(script.Parent.invariant)
local invokeGuardedCallbackImpl = require(script.Parent.invokeGuardedCallbackImpl)

local var1 = nil

local hasCaughtError = false
local var2 = nil

local bool2 = false
local var3 = nil
local tbl1 = {
    onError = function(arg1)
        hasCaughtError = true
        var2 = arg1
    end
}
local module = {}

function module.invokeGuardedCallback(...)
    hasCaughtError = false
    var2 = nil

    invokeGuardedCallbackImpl(tbl1, ...)
end

function module.invokeGuardedCallbackAndCatchFirstError(...)
    module.invokeGuardedCallback(...)

    if not hasCaughtError then
        return
    end

    local var4 = var1()

    if not bool2 then
        bool2 = true
        var3 = var4
    end
end

function module.rethrowCaughtError()
    if bool2 then
        local var4 = var3
        bool2 = false
        var3 = nil
        error(var4)
    end
end

function module.hasCaughtError()
    return hasCaughtError
end

var1 = function()
    if not hasCaughtError then
        invariant(
            false,
            "clearCaughtError was called but no error was captured. This error is likely caused by a bug in React. Please file an issue."
        )

        return nil
    end

    local var4 = var2
    hasCaughtError = false
    var2 = nil
    return var4
end

module.clearCaughtError = var1

return module
