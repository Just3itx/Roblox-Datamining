-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local InputHandlers = require(AppChatParent.InputHandlers)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local autoFocusNavigation = require(script.Parent.autoFocusNavigation)

local function isolatedAutoFocusNavigation(arg1, surfaceIdentifier, callback: ((...any) -> (...any))?)
    return function(arg2)
        local var1 = React.useMemo(function()
            return {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(function(arg3)
                        if callback then
                            callback(arg2)
                            arg3:cancel()
                        end
                    end)
                }
            }
        end, { callback })

        local createElement = React.createElement
        local focusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
        local tbl1 = {
            surfaceIdentifier = surfaceIdentifier,
            isIsolated = true,
            shouldRestoreFocus = true,
            isAutoFocusRoot = false,
            isFocusable = true,
            customEventHandlers = 0
        }

        if not callback then
            var1 = nil
        end

        tbl1.customEventHandlers = var1
        return createElement(focusNavigableSurfaceWrapper, tbl1, { content = React.createElement(autoFocusNavigation(arg1), arg2) })
    end
end

return isolatedAutoFocusNavigation
