-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationSymbol = require(script.Parent.NavigationSymbol)

local var1 = NavigationSymbol("BACK")
local var2 = NavigationSymbol("INIT")
local var3 = NavigationSymbol("NAVIGATE")
local var4 = NavigationSymbol("SET_PARAMS")

local module = { Back = var1, Init = var2, Navigate = var3, SetParams = var4 }

setmetatable(module, {
    __index = function(_, arg1)
        error(("%q is not a valid member of NavigationActions"):format(tostring(arg1)), 2)
    end
})

function module.back(arg1)
    local var5 = arg1 or {}
    return {
        type = var1,
        key = var5.key,
        immediate = var5.immediate
    }
end

function module.init(arg1)
    return {
        type = var2,
        params = (arg1 or {}).params
    }
end

function module.navigate(arg1)
    local var5 = arg1 or {}
    return {
        type = var3,
        routeName = var5.routeName,
        params = var5.params,
        action = var5.action,
        key = var5.key
    }
end

function module.setParams(arg1)
    local var5 = arg1 or {}
    return {
        type = var4,
        preserveFocus = true,
        key = var5.key,
        params = var5.params
    }
end

return module
