-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local InputHandlers = require(AvatarExperienceProfilePictureEditorParent.InputHandlers)
local FocusNavigationUtils = require(AvatarExperienceProfilePictureEditorParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local FFlagAXFixPPEV2ConsoleSidebarNav = require(AvatarExperienceProfilePictureEditor.Flags.FFlagAXFixPPEV2ConsoleSidebarNav)

local function FocusNavigatorWrapper(tbl1)
    local createElement = React.createElement
    local var1 = FocusNavigableSurfaceWrapper

    local tbl2 = {
        surfaceIdentifier = if FFlagAXFixPPEV2ConsoleSidebarNav then FocusNavigableSurfaceIdentifierEnum.SubRouterView else FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = not FFlagAXFixPPEV2ConsoleSidebarNav,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    tbl1.onClose()
                    arg1:cancel()
                end)
            }
        }
    }

    return createElement(var1, tbl2, tbl1.children)
end

return FocusNavigatorWrapper
