-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local console = LuauPolyfill.console
local Error = LuauPolyfill.Error

local InvariantError = setmetatable({}, { __index = Error })
InvariantError.__index = InvariantError

function InvariantError.new(arg1)
    local var2 = if arg1 == nil then "Invariant Violation" else arg1

    if typeof(var2) == "number" then
        var2 = ("%s: %s (see https://github.com/apollographql/invariant-packages)"):format("Invariant Violation", tostring(var2))
    end

    local error = Error.new(var2)
    error.framesToPop = 1
    error.name = "Invariant Violation"

    return (setmetatable(error, InvariantError))
end

local function invariant(arg1, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not Boolean.toJSBoolean(arg1) then
        error(InvariantError.new(str1))
    end
end

local tbl1 = {
    "debug",
    "log",
    "warn",
    "error",
    "silent"
}
local var2 = Array.indexOf(tbl1, "log")

local function wrapConsoleMethod(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return function(...)
        if Array.indexOf(tbl1, str1) >= var2 then
            return (Boolean.toJSBoolean(console[str1]) and console[str1] or console.log)(...)
        end
    end
end

local module = {
    invariant = setmetatable({
        debug = wrapConsoleMethod("debug"),
        log = wrapConsoleMethod("log"),
        warn = wrapConsoleMethod("warn"),
        error = wrapConsoleMethod("error")
    }, {
        __call = function(_, arg1, str1: string?)
            invariant(arg1, str1)
        end
    }),
    InvariantError = InvariantError,
    setVerbosity = 0
}

function module.setVerbosity(str1: string)
    local var3 = tbl1[var2]
    var2 = math.max(1, Array.indexOf(tbl1, str1))
    return var3
end

return module
