-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:21:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local function equal(arg1, arg2)
    if typeof(arg1) ~= typeof(arg2) then
        return false
    end
    if arg1 == arg2 then
        return true
    end
    if typeof(arg1) ~= "table" then
        if typeof(arg1) == "string" or typeof(arg1) == "number" or typeof(arg1) == "boolean" then
            return arg1 == arg2
        end

        if typeof(arg1) == "function" then
            if debug.info(arg1, "n") == debug.info(arg2, "n")
                and debug.info(arg1, "s") == debug.info(arg2, "s")
                and debug.info(arg1, "l") == debug.info(arg2, "l")
            then
                return debug.info(arg1, "a") == debug.info(arg2, "a")
            end

            return false
        end

        if typeof(arg1) == "thread" then
            error("unhandled equality check for type 'thread'")
        elseif typeof(arg1) == "userdata" then
            error("unhandled equality check for type 'userdata'")
        end
        error("unhandled equality check for type " .. typeof(arg1))
        return
    end

    if Array.isArray(arg1) and not Array.isArray(arg2) then
        return false
    end
    if #arg1 ~= #arg2 or #Object.keys(arg1) ~= #Object.keys(arg2) then
        return false
    end
    if Array.isArray(arg1) then
        for i, _ in ipairs(arg1) do
            if not equal(arg1[i], arg2[i]) then
                return false
            end
        end
    else
        for k in pairs(arg1) do
            if not equal(arg1[tostring(k)], arg2[tostring(k)]) then
                return false
            end
        end
    end
    return true
end

return equal
