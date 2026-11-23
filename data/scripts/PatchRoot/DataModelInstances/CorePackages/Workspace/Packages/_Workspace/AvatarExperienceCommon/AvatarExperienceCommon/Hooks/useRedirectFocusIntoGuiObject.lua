-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)

local function getSelectionIsOutsideGuiObject(selectedCoreObject): boolean | GuiObject -- Luacid: Inlined by compiler; 2 call sites recovered
    return GuiService.SelectedCoreObject
        and not GuiService.SelectedCoreObject:IsDescendantOf(selectedCoreObject)
        and not (GuiService.SelectedCoreObject == selectedCoreObject)
end

local function useRedirectFocusIntoGuiObject(tbl1)
    React.useEffect(function()
        local current = tbl1.current
        if current then
            if getSelectionIsOutsideGuiObject(current) then
                current.Selectable = true
            else
                current.Selectable = false
            end
        end

        local connection = GuiService.Changed:Connect(function(property: string)
            if property ~= "SelectedCoreObject" then
                return
            end

            local current2 = tbl1.current
            if not current2 then
                return
            end

            if getSelectionIsOutsideGuiObject(current2) then
                current2.Selectable = true
                return
            end

            if GuiService.SelectedCoreObject == current2 then
                current2.Selectable = false
                GuiService:Select(current2)
                return
            end
            if GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(current2) then
                current2.Selectable = false
            end
        end)

        return function()
            return connection:Disconnect()
        end
    end, {})
end

return useRedirectFocusIntoGuiObject
