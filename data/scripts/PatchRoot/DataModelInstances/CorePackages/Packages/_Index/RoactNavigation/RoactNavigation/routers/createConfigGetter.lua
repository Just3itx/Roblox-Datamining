-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Object = require(scriptParentParentParent.LuauPolyfill).Object

local getScreenForRouteName = require(scriptParent.getScreenForRouteName)
local validateScreenOptions = require(scriptParent.validateScreenOptions)
local invariant = require(scriptParentParent.utils.invariant)

local function applyConfig(arg1, navigationOptions, tbl1: {navigation: any, screenProps: any})
    navigationOptions = navigationOptions or {}

    local str1 = type(arg1)
    if str1 == "function" then
        return Object.assign({}, navigationOptions, arg1(Object.assign(table.clone(tbl1), { navigationOptions = navigationOptions })))
    elseif str1 == "table" then
        return Object.assign(table.clone(navigationOptions), arg1)
    end
    return navigationOptions
end

return function(arg1, arg2)
    return function(navigation, screenProps)
        screenProps = screenProps or {}
        local state = navigation.state

        invariant(type(state.routeName) == "string", "Cannot get config because the route does not have a routeName.")

        local screenForRouteName = getScreenForRouteName(arg1, state.routeName)
        local var1 = arg1[state.routeName]
        local navigationOptions = if var1 == screenForRouteName then nil else var1.navigationOptions
        local var2 = type(screenForRouteName) ~= "table" and {} or screenForRouteName.navigationOptions

        local tbl1 = { navigation = navigation, screenProps = screenProps }

        local var3 = applyConfig(arg2, {}, tbl1)
        local var4 = applyConfig(var2, var3, tbl1)
        local var5 = applyConfig(navigationOptions, var4, tbl1)

        validateScreenOptions(var5, state)
        return var5
    end
end
