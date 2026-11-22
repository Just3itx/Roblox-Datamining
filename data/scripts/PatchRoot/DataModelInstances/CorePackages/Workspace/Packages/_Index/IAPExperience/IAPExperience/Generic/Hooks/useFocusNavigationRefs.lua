-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local FocusNavigationUtils = require(scriptParentParentParentParent.FocusNavigationUtils)
local InputHandlers = require(scriptParentParentParentParent.InputHandlers)
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useDefaultFocusBehavior = require(scriptParentParentParentParent.ReactFocusNavigation).useDefaultFocusBehavior

local function mergeRefs(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(current)
        if type(arg1) == "function" then
            arg1(current)
        elseif arg1 ~= nil then
            arg1.current = current
        end

        if type(arg2) == "function" then
            arg2(current)
        elseif arg2 ~= nil then
            arg2.current = current
        end
    end
end

local function useFocusNavigationRefs(arg1, callback)
    local var1, var2 = useDefaultFocusBehavior()
    local var3 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(arg1)
            }
        },
        isAutoFocusRoot = true
    })

    local var4 = React.useMemo(function()
        return mergeRefs(var3, var2)
    end, { var3, var2 })

    local var5 = React.useRef(nil)
    local var6 = React.useMemo(function()
        return mergeRefs(var5, var1)
    end, { var1 })

    local var7 = React.useRef(false)
    React.useEffect(function()
        local current = var5.current
        if not current or var7.current then
            return
        end

        var7.current = true
        if callback then
            callback(current)
        end
    end, { var5.current, callback })

    return var4, var6
end

return useFocusNavigationRefs
