-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)
local useFocusGuiObject = require(FocusNavigationUtilsParent.ReactFocusNavigation).useFocusGuiObject

local tbl1 = {
    registered = function(tbl1, tbl2)
        local var1 = tbl1[tbl2.name] or {}

        for _, value in var1 do
            if value == tbl2.guiObject then
                return tbl1
            end
        end

        local var2 = table.clone(tbl1)
        local var3 = table.clone(var1)
        table.insert(var3, tbl2.guiObject)
        var2[tbl2.name] = var3
        return var2
    end,
    deRegistered = function(tbl1, tbl2)
        local var1 = tbl1[tbl2.name]
        if not var1 or #var1 == 0 then
            return tbl1
        end

        local tbl3 = {}
        for _, value in var1 do
            if value ~= tbl2.guiObject then
                table.insert(tbl3, value)
            end
        end

        local var2 = table.clone(tbl1)
        if #tbl3 == 0 then
            var2[tbl2.name] = nil
        else
            var2[tbl2.name] = tbl3
        end
        return var2
    end
}

local function registryReducer(tbl2, arg1)
    local var1 = tbl1[arg1.type]
    if var1 then
        return var1(tbl2, arg1.payload)
    end
    error("Unknown action: " .. arg1.type)
end

local registryContext = React.createContext(nil)

local function useRegistryEntry(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = React.useContext(registryContext)
    if var1 == nil then
        return nil
    end

    local var2 = var1.state[str1]

    return if var2 == nil or #var2 == 0 then nil else var2[#var2]
end

return {
    Provider = function(tbl2) -- name: FocusNavigableSurfaceRegistryProvider
        local state, dispatch = React.useReducer(registryReducer, {})
        return React.createElement(registryContext.Provider, { value = { state = state, dispatch = dispatch } }, tbl2.children)
    end,
    registryContext = registryContext,
    useRegisterFocusNavigableSurface = function()
        local var1 = React.useContext(registryContext)
        local dispatch = if var1 then var1.dispatch else nil

        return React.useCallback(function(name: string, guiObject)
            if not dispatch then
                return
            end

            dispatch({ type = "registered", payload = { name = name, guiObject = guiObject } })
        end, { dispatch })
    end,
    useDeRegisterFocusNavigableSurface = function()
        local var1 = React.useContext(registryContext)
        local dispatch = if var1 then var1.dispatch else nil

        return React.useCallback(function(name: string, guiObject)
            if not dispatch then
                return
            end

            dispatch({ type = "deRegistered", payload = { name = name, guiObject = guiObject } })
        end, { dispatch })
    end,
    useRegistryEntry = useRegistryEntry,
    useRegistryEntries = function(str1: string)
        local var1 = React.useContext(registryContext)
        return if var1 == nil then nil else var1.state[str1]
    end,
    useFocusRegistryEntry = function(str1: string)
        local var1 = useFocusGuiObject()
        local var2 = useRegistryEntry(str1)

        return React.useCallback(function()
            if var2 then
                var1(var2)
            end
        end, { var1, var2 })
    end
}
