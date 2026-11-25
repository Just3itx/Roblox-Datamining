-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local SharedFlags = require(VirtualCursorModularParent.SharedFlags)
local FFlagLuaAppGamepadSelectionRespectsInteractable = SharedFlags.FFlagLuaAppGamepadSelectionRespectsInteractable
local FFlagVirtualCursorInputSink = SharedFlags.FFlagVirtualCursorInputSink

local function isSelectableGuiObject(arg1, bool1: boolean?)
    if not (arg1:IsA("GuiButton") or arg1:IsA("TextBox")) then
        return false
    end

    local var1 = if FFlagVirtualCursorInputSink and bool1 then arg1.Interactable else arg1.Active

    if not (arg1.Visible and var1 and arg1.Selectable) then
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
