-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:50:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}

tbl1.__index = tbl1
function tbl1.__tostring(arg1)
    return getmetatable(tbl1).__tostring(arg1)
end

function tbl1.new(message: string?)
    return (setmetatable({ name = "Error", message = message or "", stack = debug.traceback(nil, 2) }, tbl1))
end

return (setmetatable(tbl1, {
    __call = function(_, ...)
        local var1 = tbl1.new(...)
        var1.stack = debug.traceback(nil, 2)
        return var1
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
