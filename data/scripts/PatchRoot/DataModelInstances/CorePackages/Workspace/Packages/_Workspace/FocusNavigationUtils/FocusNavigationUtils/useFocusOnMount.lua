-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)
local useFocusGuiObject = require(FocusNavigationUtilsParent.ReactFocusNavigation).useFocusGuiObject
local Responsive = require(FocusNavigationUtilsParent.Responsive)
local useIsSpatial = Responsive.useIsSpatial
local usePreferredInput = Responsive.usePreferredInput
local Input = Responsive.Input
local useDescendantHasFocus = require(script.Parent.useDescendantHasFocus)

local function useFocusOnMount(arg1, bool1: boolean?)
    if bool1 == nil then
        bool1 = true
    end

    local var1 = useFocusGuiObject()
    local var2, var3 = React.useState(nil)

    local var4 = React.useCallback(function(current)
        if arg1 then
            if type(arg1) == "function" then
                arg1(current)
            elseif type(arg1) == "table" then
                arg1.current = current
            end
        end

        if current == nil then
            var3(nil)
            return
        end

        if not current:IsA("GuiObject") then
            warn("useFocusOnMount: ref is not a GuiObject")
        else
            var3(current)
        end
    end, { arg1 })

    local bool2 = usePreferredInput() == Input.Directional
    local var5 = useIsSpatial()

    local var6 = React.useCallback(function(arg2)
        if not arg2:IsDescendantOf(CoreGui) then
            return
        end
        if bool2 and not var5 then
            var1(arg2)
        end
    end, { bool2, var5, var1 })

    local var7 = React.useRef(false)
    local var8 = React.useRef(false)
    local var9 = useDescendantHasFocus(var2)
    local var10 = React.useRef(nil)

    React.useEffect(function()
        if not var2 then
            var7.current = false
            var8.current = false
            return
        end

        if not var7.current then
            var6(var2)
            var7.current = true
        end

        if bool1 and not var8.current and var9 then
            var8.current = true
        end

        local connection = if bool1 and not var8.current then var2.DescendantAdded:Connect(function(descendant: Instance)
            if not var10.current and descendant:IsA("GuiObject") and descendant.Selectable then
                var10.current = task.delay(0.1, function()
                    var6(var2)
                    var10.current = nil
                end)
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
            if var10.current then
                task.cancel(var10.current)
                var10.current = nil
            end
        end
    end, {
        var2,
        bool1,
        var6,
        var9
    })
    return var4
end

return useFocusOnMount
