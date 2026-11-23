-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)
local Responsive = require(AvatarExperienceCommonParent.Responsive)
local useFocusGuiObject = require(AvatarExperienceCommonParent.ReactFocusNavigation).useFocusGuiObject
local inputModeStore = Responsive.GetInputModeStore(false)

local FFlagLuaSupportMicroGamepadPreferredInput = require(AvatarExperienceCommonParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function useFocusOnMountEffect(arg1, num1: number?)
    local var1 = useFocusGuiObject()
    local var2 = Responsive.useIsSpatial()

    React.useEffect(function()
        local var3 = task.delay(num1 or 0, function()
            local bool1 = inputModeStore.getLastInputType(false) == Responsive.Input.Directional
            local var3 = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
                or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad

            if not arg1.current or not var3 and not bool1 or not var1 or var2 then
                return
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            if selectedCoreObject ~= arg1.current
                and not (selectedCoreObject and selectedCoreObject:IsDescendantOf(arg1.current))
                and arg1.current:IsDescendantOf(game)
            then
                var1(arg1.current)
            end
        end)

        return function()
            task.cancel(var3)
        end
    end, {})
end
return useFocusOnMountEffect
