-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent

local _ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)
local Cryo = require(FocusNavigationUtilsParent.Cryo)
local Navigation = require(FocusNavigationUtilsParent.Navigation)

local useFocusRoot = require(FocusNavigationUtils.useFocusRoot)
local useDefaultAppEventHandlers = require(FocusNavigationUtils.useDefaultAppEventHandlers)
local FocusNavigationDefaultEventMap = require(FocusNavigationUtils.FocusNavigationDefaultEventMap)

local tbl1 = {}

local function useAppFocusRoot(arg1)
    local var1 = arg1.customEventHandlers or tbl1
    local var2 = arg1.customEventMap or tbl1
    local var3 = Navigation.useNavigationFocus()

    local var4 = useDefaultAppEventHandlers()
    local eventHandlers = Cryo.Dictionary.union(var4, var1)
    local eventMap = Cryo.Dictionary.union(FocusNavigationDefaultEventMap, var2)

    local var7 = arg1.isFocusable == nil or arg1.isFocusable

    if var7 then
        if var3 == nil then
            var3 = true
        end
    else
        var3 = var7
    end

    local isAutoFocusRoot = not (arg1.isAutoFocusRoot == nil) and arg1.isAutoFocusRoot
    local var8 = Cryo.Dictionary.union(arg1, {
        customEventHandlers = Cryo.None,
        eventHandlers = eventHandlers,
        eventMap = eventMap,
        isFocusable = var3,
        isAutoFocusRoot = isAutoFocusRoot
    })
    return useFocusRoot(var8)
end

return useAppFocusRoot
