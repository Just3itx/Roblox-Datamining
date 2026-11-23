-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local useOverlay = require(AvatarExperienceCommonParent.Foundation).Hooks.useOverlay
local useFocusGuiObject = require(AvatarExperienceCommonParent.ReactFocusNavigation).useFocusGuiObject

local FocusNavigationUtils = require(AvatarExperienceCommonParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusNavigableSurfaceRegistryConnection = FocusNavigationUtils.useFocusNavigableSurfaceRegistryConnection
local wasLastInputGamepad = require(AvatarExperienceCommonParent.RoactUtils).wasLastInputGamepad

return function(arg1)
    local var1 = useOverlay()

    useFocusNavigableSurfaceRegistryConnection(arg1.current, FocusNavigableSurfaceIdentifierEnum.CentralOverlay)

    local var2 = useFocusGuiObject()
    local var3 = wasLastInputGamepad()

    React.useEffect(function()
        if arg1.current and var1 == nil and var3 then
            task.delay(0.1, function()
                var2(arg1.current)
            end)
        end
    end, { var2, var1, var3 })

    return var1
end
