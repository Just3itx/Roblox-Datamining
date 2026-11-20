-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _ES7Types = require(scriptParentParentParent.ES7Types)

local tbl1 = {}

tbl1.__index = tbl1
function tbl1.__tostring(arg1)
    return getmetatable(tbl1).__tostring(arg1)
end

local function __createError(message: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    local self = setmetatable({ name = "Error", message = message or "" }, tbl1)
    tbl1.__captureStackTrace(self, 4)
    return self
end

function tbl1.new(message: string?)
    return __createError(message)
end

function tbl1.captureStackTrace(tbl2, arg1)
    tbl1.__captureStackTrace(tbl2, 3, arg1)
end

function tbl1.__captureStackTrace(tbl2, num1: number, arg1)
    if typeof(arg1) == "function" then
        local var1 = debug.traceback(nil, num1)
        local var2 = debug.info(arg1, "n")
        local var3 = debug.info(arg1, "s")

        local var4 = string.gsub(var3, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. ":%d* function " .. var2
        local var5 = string.find(var1, var4)
        local var6

        if var5 == nil then
            var6 = nil
        else
            local _
            _, var6 = string.find(var1, "\n", var5 + 1)
        end
        if var6 ~= nil then
            var1 = string.sub(var1, var6 + 1)
        end
        tbl2.__stack = var1
    else
        tbl2.__stack = debug.traceback(nil, num1)
    end
    tbl1.__recalculateStacktrace(tbl2)
end

function tbl1.__recalculateStacktrace(tbl2)
    local message = tbl2.message
    tbl2.stack = ((tbl2.name or "Error") .. (if message == nil or message == "" then "" else ": " .. message)) .. "\n" .. (if tbl2.__stack then tbl2.__stack else "")
end

return (setmetatable(tbl1, {
    __call = function(_, ...)
        return __createError((...))
    end,
    __tostring = function(arg1)
        if arg1.name == nil then
            return tostring("Error")
        end

        if not arg1.message or arg1.message == "" then
            return tostring(arg1.name)
        end

        return string.format("%s: %s", tostring(arg1.name), tostring(arg1.message))
    end
}))
