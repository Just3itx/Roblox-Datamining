-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local FFlagLuaAppGamepadSelectionRespectsInteractable = require(scriptParentParent.SharedFlags).FFlagLuaAppGamepadSelectionRespectsInteractable

local function isSelectableGuiObject(arg1)
    if not (arg1:IsA("GuiButton") or arg1:IsA("TextBox")) then
        return false
    end
    if not (arg1.Active and arg1.Selectable) then
        return false
    end
    if arg1.AbsoluteSize.Magnitude == 0 then
        return false
    end
    if FFlagLuaAppGamepadSelectionRespectsInteractable then
        while arg1 do
            if arg1:IsA("GuiObject") then
                if not arg1.Interactable then
                    return false
                end
            elseif not arg1:IsA("Folder") then
                break
            end

            arg1 = arg1.Parent
        end
    end
    return true
end

return isSelectableGuiObject
