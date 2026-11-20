-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object
local NavigationSymbol = require(scriptParentParent.NavigationSymbol)

local var1 = NavigationSymbol("POP")
local var2 = NavigationSymbol("POP_TO_TOP")
local var3 = NavigationSymbol("PUSH")
local var4 = NavigationSymbol("RESET")
local var5 = NavigationSymbol("REPLACE")
local var6 = NavigationSymbol("COMPLETE_TRANSITION")

local module = {
    Pop = var1,
    PopToTop = var2,
    Push = var3,
    Reset = var4,
    Replace = var5,
    CompleteTransition = var6
}

setmetatable(module, {
    __index = function(_, arg1)
        error(("%q is not a valid member of StackActions"):format(tostring(arg1)), 2)
    end
})

function module.pop(arg1)
    local tbl1 = { type = var1 }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

function module.popToTop(arg1)
    local tbl1 = { type = var2 }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

function module.push(arg1)
    local tbl1 = { type = var3 }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

function module.reset(arg1)
    local tbl1 = { type = var4 }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

function module.replace(arg1)
    local tbl1 = { type = var5, preserveFocus = true }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

function module.completeTransition(arg1)
    local tbl1 = { type = var6, preserveFocus = true }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

return module
