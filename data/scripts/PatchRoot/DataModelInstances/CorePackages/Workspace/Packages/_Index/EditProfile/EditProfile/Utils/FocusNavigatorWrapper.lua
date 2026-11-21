-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local React = require(EditProfileParent.React)
local InputHandlers = require(EditProfileParent.InputHandlers)
local FocusNavigationUtils = require(EditProfileParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local function FocusNavigatorWrapper(tbl1, arg1)
    local createElement = React.createElement
    local var1 = FocusNavigableSurfaceWrapper

    local tbl2 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg2)
                    tbl1.onClose()
                    arg2:cancel()
                end)
            }
        }
    }

    return createElement(var1, tbl2, arg1)
end

return FocusNavigatorWrapper
