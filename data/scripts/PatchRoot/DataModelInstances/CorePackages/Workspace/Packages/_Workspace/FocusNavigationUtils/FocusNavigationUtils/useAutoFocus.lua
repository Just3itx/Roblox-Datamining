-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)
local FocusNavigationContext = require(FocusNavigationUtilsParent.ReactFocusNavigation).FocusNavigationContext

local function func1(num1: number, tbl1, arg1)
    local bool1 = #tbl1 == 0
    local tbl2 = {}
    local tbl3 = {}

    local function disconnect() -- Luacid: Inlined by compiler; 4 call sites recovered
        if bool1 then
            return
        end

        bool1 = true
        for _, value in tbl2 do
            value:Disconnect()
        end
    end

    local function onFocusChange(_, _, arg2)
        if arg2 then
            disconnect()
        end
    end

    local function focus(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
        table.insert(tbl3, (task.delay(num1, function()
            if bool1 then
                return
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            if selectedCoreObject then
                for _, value in tbl1 do
                    if selectedCoreObject == value or selectedCoreObject:IsDescendantOf(value) then
                        disconnect()
                        return
                    end
                end
            end
            local var1 = tbl1[num2]
            if var1 and var1:IsDescendantOf(CoreGui) then
                arg1:focusGuiObject(var1, false)
            end
            local num3 = if num2 > #tbl1 then 1 else num2 % #tbl1 + 1
            focus(num3)
        end)))
    end
    for _, value in tbl1 do
        local selectionChanged = value.SelectionChanged
        table.insert(tbl2, selectionChanged:Connect(onFocusChange))
    end

    focus(1)

    return {
        cancel = function()
            for _, value in tbl3 do
                task.cancel(value)
            end
            table.clear(tbl3)
            disconnect()
        end
    }
end

return function(tbl1, num1: number)
    local var1 = React.useContext(FocusNavigationContext)
    return React.useCallback(function()
        if var1 then
            return (func1(num1, tbl1, var1))
        end
        return nil
    end, { var1, tbl1, num1 })
end
