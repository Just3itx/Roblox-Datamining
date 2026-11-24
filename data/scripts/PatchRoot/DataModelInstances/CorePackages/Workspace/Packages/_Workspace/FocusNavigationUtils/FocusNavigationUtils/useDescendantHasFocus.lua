-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)

local function hasFocus(ancestor: Instance): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    local selectedCoreObject = GuiService.SelectedCoreObject
    return if ancestor and selectedCoreObject then (selectedCoreObject == ancestor or selectedCoreObject:IsDescendantOf(ancestor))
        and selectedCoreObject:FindFirstAncestorOfClass("CoreGui") ~= nil else false
end

local function useDescendantHasFocus(ancestor)
    local bool1 = hasFocus(ancestor)
    local var1, var2 = React.useState(bool1)

    React.useEffect(function()
        local connection = nil
        local connection2 = nil

        if ancestor then
            var2((hasFocus(ancestor)))
            connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                if connection2 then
                    connection2:Disconnect()
                end

                local bool2 = hasFocus(ancestor)
                local selectedCoreObject = GuiService.SelectedCoreObject
                if bool2 and selectedCoreObject then
                    connection2 = selectedCoreObject.AncestryChanged:Connect(function()
                        if selectedCoreObject:FindFirstAncestorOfClass("CoreGui") == nil then
                            connection2:Disconnect()
                            var2((hasFocus(ancestor)))
                        end
                    end)
                end

                var2(bool2)
            end)
        else
            var2(false)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, { ancestor })

    return var1
end

return useDescendantHasFocus
