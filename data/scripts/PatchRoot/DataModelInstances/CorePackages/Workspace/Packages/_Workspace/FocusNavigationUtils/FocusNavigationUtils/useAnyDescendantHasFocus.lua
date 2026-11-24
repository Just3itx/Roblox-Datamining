-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)

local function hasFocus(tbl1)
    local selectedCoreObject = GuiService.SelectedCoreObject
    if selectedCoreObject == nil or tbl1 == nil then
        return false
    end

    if selectedCoreObject:FindFirstAncestorOfClass("CoreGui") == nil then
        return false
    end

    for _, value in tbl1 do
        if selectedCoreObject == value or selectedCoreObject:IsDescendantOf(value) then
            return true
        end
    end

    return false
end

local function useAnyDescendantHasFocus(tbl1)
    local bool1 = hasFocus(tbl1)
    local var1, var2 = React.useState(bool1)

    React.useEffect(function()
        local connection = nil
        local connection2 = nil

        if tbl1 ~= nil and #tbl1 > 0 then
            var2((hasFocus(tbl1)))
            connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                if connection2 then
                    connection2:Disconnect()
                end

                local bool2 = hasFocus(tbl1)
                local selectedCoreObject = GuiService.SelectedCoreObject
                if bool2 and selectedCoreObject then
                    connection2 = selectedCoreObject.AncestryChanged:Connect(function()
                        if selectedCoreObject:FindFirstAncestorOfClass("CoreGui") == nil then
                            connection2:Disconnect()
                            var2((hasFocus(tbl1)))
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
    end, { tbl1 })

    return var1
end

return useAnyDescendantHasFocus
