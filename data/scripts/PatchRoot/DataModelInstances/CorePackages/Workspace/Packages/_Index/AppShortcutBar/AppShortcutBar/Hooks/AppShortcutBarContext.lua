-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local React = require(AppShortcutBarParent.React)
local _FocusNavigationUtils = require(AppShortcutBarParent.FocusNavigationUtils)

local var1 = require(AppShortcutBar.Stores.GetButtonHoldStore)(false)

local AppShortcutBarStateActionEnum = {
    ButtonHoldStarted = "ButtonHoldStarted",
    ButtonHoldEnded = "ButtonHoldEnded"
}

local tbl2 = {}
tbl2[AppShortcutBarStateActionEnum.ButtonHoldStarted] = function(tbl3, tbl4)
    local var2 = table.clone(tbl3)
    var2.heldProgress[tbl4.eventName] = tbl4.progress
    return var2
end

tbl2[AppShortcutBarStateActionEnum.ButtonHoldEnded] = function(tbl3, tbl4)
    local var2 = table.clone(tbl3)
    var2.heldProgress[tbl4.eventName] = nil
    return var2
end

local function registryReducer(tbl3, arg1)
    local var2 = tbl2[arg1.type]
    if var2 then
        return var2(tbl3, arg1.payload)
    end
    error("Unknown action: " .. arg1.type)
end

local Context = React.createContext(nil)
return {
    Context = Context,
    Provider = function(tbl3) -- name: AppShortcutBarStateProvider
        local state, dispatch = React.useReducer(registryReducer, { heldProgress = {} })
        return React.createElement(Context.Provider, { value = { state = state, dispatch = dispatch } }, tbl3.children)
    end,
    useDispatchButtonHoldStarted = var1.useDispatchButtonHoldStarted,
    useDispatchButtonHoldEnded = var1.useDispatchButtonHoldEnded,
    useHeldProgressByEvent = var1.useHeldProgressByEvent,
    AppShortcutBarStateActionEnum = AppShortcutBarStateActionEnum
}
