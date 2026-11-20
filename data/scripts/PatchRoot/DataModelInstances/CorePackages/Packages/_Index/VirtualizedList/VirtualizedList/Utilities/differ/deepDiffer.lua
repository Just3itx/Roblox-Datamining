-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local var1 = nil

local function deepDiffer(arg1, arg2, arg3, tbl1)
    local var2 = if arg3 == nil then -1 else arg3

    if typeof(var2) ~= "number" then
        tbl1 = var2
    end
    local var3 = if typeof(var2) ~= "number" then -1 else var2

    if var3 == 0 then
        return true
    end

    if arg1 == arg2 then
        return false
    end
    if typeof(arg1) == "function" and typeof(arg2) == "function" then
        local bool1 = not (tbl1 == nil) and tbl1.unsafelyIgnoreFunctions ~= nil
        local unsafelyIgnoreFunctions = if tbl1 == nil or not bool1 then nil else tbl1.unsafelyIgnoreFunctions

        if unsafelyIgnoreFunctions == nil then
            if var1 == nil or not Boolean.toJSBoolean(var1.onDifferentFunctionsIgnored) or Boolean.toJSBoolean(tbl1) and bool1 then
                unsafelyIgnoreFunctions = true
            else
                var1.onDifferentFunctionsIgnored(debug.info(arg1, "n"), debug.info(arg2, "n"))
                unsafelyIgnoreFunctions = true
            end
        end

        return not unsafelyIgnoreFunctions
    end
    if typeof(arg1) ~= "table" or arg1 == nil then
        return arg1 ~= arg2
    end
    if typeof(arg2) ~= "table" or arg2 == nil then
        return true
    end

    if Array.isArray(arg1) ~= Array.isArray(arg2) then
        return true
    end
    if Array.isArray(arg1) then
        if #arg2 ~= #arg1 then
            return true
        end

        for i = 1, #arg1 do
            if deepDiffer(arg1[i], arg2[i], var3 - 1, tbl1) then
                return true
            end
        end
    else
        for k in pairs(arg1) do
            if deepDiffer(arg1[k], arg2[k], var3 - 1, tbl1) then
                return true
            end
        end

        for k in pairs(arg2) do
            if arg1[k] == nil and arg2[k] ~= nil then
                return true
            end
        end
    end
    return false
end

return (setmetatable({
    unstable_setLogListeners = function(tbl1)
        var1 = tbl1
    end
}, {
    __call = function(_, arg1, arg2, arg3, tbl1): boolean
        return (deepDiffer(arg1, arg2, arg3, tbl1))
    end
}))
