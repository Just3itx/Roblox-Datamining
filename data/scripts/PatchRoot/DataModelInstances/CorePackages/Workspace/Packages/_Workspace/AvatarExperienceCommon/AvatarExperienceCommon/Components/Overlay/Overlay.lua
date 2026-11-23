-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)

local useFocusNavigableSurfaceRegistryConnection = require(AvatarExperienceCommonParent.FocusNavigationUtils).useFocusNavigableSurfaceRegistryConnection
local FocusNavigableSurfaceIdentifierEnum = require(AvatarExperienceCommonParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local function Overlay(arg1)
    local var1, ref = React.useState(nil)

    useFocusNavigableSurfaceRegistryConnection(var1, FocusNavigableSurfaceIdentifierEnum.CentralOverlay)
    local var3 = table.clone(arg1)
    var3.ref = ref
    var3.SelectionGroup = true
    var3.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    var3.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    var3.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    var3.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    return React.createElement("Frame", var3)
end

return Overlay
