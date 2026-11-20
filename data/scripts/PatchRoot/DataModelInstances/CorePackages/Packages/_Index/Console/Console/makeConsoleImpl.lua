-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local inspect = require(scriptParentParent.Collections).inspect

return function()
    local module = {}
    local num1 = 0

    local function indent(): string -- Luacid: Inlined by compiler; 7 call sites recovered
        return string.rep("  ", num1)
    end

    function module.log(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        print(indent() .. var1)
    end

    function module.debug(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        print(indent() .. var1)
    end

    function module.info(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        print(indent() .. var1)
    end

    function module.warn(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        warn(indent() .. var1)
    end

    function module.error(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        warn(indent() .. var1)
    end

    function module.group(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        print(indent() .. var1)
        num1 += 1
    end

    function module.groupCollapsed(arg1, ...)
        local var1 = if typeof(arg1) == "string" then string.format(arg1, ...) else inspect(arg1)
        print(indent() .. var1)
        num1 += 1
    end

    function module.groupEnd()
        if num1 > 0 then
            num1 -= 1
        end
    end

    return module
end
