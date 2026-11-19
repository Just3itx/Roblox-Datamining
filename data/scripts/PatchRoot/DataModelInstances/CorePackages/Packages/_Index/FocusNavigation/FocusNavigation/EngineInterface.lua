-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:10:32Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local mockableWarn = require(scriptParentParent.FocusNavigationUtils).mockableWarn

local _types = require(script.Parent.types)

local success, result = pcall(function(): RBXScriptSignal
    return GuiService:GetPropertyChangedSignal("SelectedCoreObject")
end)

local success2, result2 = pcall(function(): CoreGui
    return game:GetService("CoreGui")
end)

return {
    CoreGui = {
        getSelection = function(): GuiObject
            return GuiService.SelectedCoreObject
        end,
        setSelection = function(selectionParent: Instance)
            if _G.__DEV__ and success2 and selectionParent ~= nil and not selectionParent:IsDescendantOf(result2) then
                mockableWarn(
                    string.format(
                        "Attempting to focus non-CoreGui descendant '%s' from a CoreGui FocusNavigationService instance. Consider creating this FocusNavigationService with `FocusNavigation.EnginInterface.PlayerGui` instead",
                        selectionParent:GetFullName()
                    )
                )
            end

            if selectionParent and not selectionParent.Selectable then
                GuiService:Select(selectionParent)
                return
            end
            GuiService.SelectedCoreObject = selectionParent
        end,
        SelectionChanged = not success and {
            Connect = function()
                error("Could not access SelectedCoreObject signal; you may not have the correct permissions")
            end
        } or result,
        InputBegan = UserInputService.InputBegan,
        InputChanged = UserInputService.InputChanged,
        InputEnded = UserInputService.InputEnded,
        LastInputTypeChanged = UserInputService.LastInputTypeChanged
    },
    PlayerGui = {
        getSelection = function(): GuiObject
            return GuiService.SelectedObject
        end,
        setSelection = function(selectionParent: Instance)
            if _G.__DEV__ and success2 and selectionParent ~= nil and selectionParent:IsDescendantOf(result2) then
                mockableWarn(
                    string.format(
                        "Attempting to focus CoreGui descendant '%s' from a non-CoreGui FocusNavigationService instance.Consider creating this FocusNavigationService with `FocusNavigation.EnginInterface.CoreGui` instead",
                        selectionParent:GetFullName()
                    )
                )
            end

            if selectionParent and not selectionParent.Selectable then
                GuiService:Select(selectionParent)
                return
            end
            GuiService.SelectedObject = selectionParent
        end,
        SelectionChanged = GuiService:GetPropertyChangedSignal("SelectedObject"),
        InputBegan = UserInputService.InputBegan,
        InputChanged = UserInputService.InputChanged,
        InputEnded = UserInputService.InputEnded,
        LastInputTypeChanged = UserInputService.LastInputTypeChanged
    }
}
