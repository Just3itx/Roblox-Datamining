-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppCommonLib = require(AppChatParent.AppCommonLib)
local React = require(AppChatParent.React)

local useCallback = React.useCallback
local useReducer = React.useReducer
local Immutable = AppCommonLib.Immutable

local function externalNavigationByScreenReducer(tbl1, tbl2)
    if tbl2.callback == nil then
        return Immutable.RemoveFromDictionary(tbl1, tbl2.screen)
    end

    assert(tbl2.callback ~= nil, "")
    return Immutable.Set(tbl1, tbl2.screen, tbl2.callback)
end

return function()
    local var1, var2 = useReducer(externalNavigationByScreenReducer, {})
    return var1, (useCallback(function(callback: ((...any) -> (...any))?, screen: string)
        var2({ callback = callback, screen = screen })
    end, { var2 }))
end
