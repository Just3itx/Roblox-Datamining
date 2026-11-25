-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Navigation = require(ProfilePlatformParent.Navigation)
local InputHandlers = require(ProfilePlatformParent.InputHandlers)
local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)

local ProfileContextualMenu = require(script.Parent.ProfileContextualMenu)
local useScreenSize = require(ProfilePlatformParent.RobloxAppHooks).useScreenSize
local useProfileActions = require(ProfilePlatform.Hooks.useProfileActions)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useNavigation = Navigation.useNavigation
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot
local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagProfilePlatformAddTC = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformAddTC
local FFlagProfileContextualMenuDisableFix = require(ProfilePlatformParent.SharedFlags).FFlagProfileContextualMenuDisableFix
local FFlagProfileFixMenuNavigation = require(ProfilePlatformParent.SharedFlags).FFlagProfileFixMenuNavigation

local function ProfileContextualMenuContainer(_)
    local screenSize = useScreenSize()
    local var2 = useNavigation()

    local param = var2.getParam(Constants.Navigation.ON_CLOSE)
    local param2 = var2.getParam(Constants.Navigation.GET_ROOT_ELEMENT_REF)
    local param3 = var2.getParam(Constants.Navigation.ON_DISMISS_REF)

    local current = param2()
    local rootElementPosition = if current then current.AbsolutePosition else Vector2.new(0, 0)
    local var5 = useProfileJsonComponent(Enums.Components.Actions) or {}

    local var6 = useProfileActions(Enums.ButtonSurface.ContextualMenu)
    local contextual = var5.contextual

    local var7, var8 = React.useState(true)

    local var9 = React.useCallback(function()
        var8(false)
        var2.pop()
        param()
    end, { var2, param })

    local var10

    if FFlagProfileFixMenuNavigation then
        local var11 = useAppFocusRoot

        local tbl1 = {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
            customEventHandlers = {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(function()
                        var9()
                    end)
                }
            },
            isAutoFocusRoot = true,
            isFocusable = var7
        }

        var10 = var11(tbl1)
    else
        var10 = nil
    end

    React.useEffect(function()
        if param3 then
            param3.current = var9
            return function()
                param3.current = nil
            end
        end
    end, { var9 })

    local buttonProps = React.useMemo(function()
        if not contextual then
            return {}
        end

        local result = {}
        for _, value in contextual do
            local var11 = var6[value]

            if not var11 then
                continue
            end

            local tbl1 = {
                text = var11.text,
                disabled = if FFlagProfileContextualMenuDisableFix or not FFlagProfilePlatformAddTC then nil else var11.isDisabled,
                isDisabled = if FFlagProfileContextualMenuDisableFix then var11.isDisabled else nil,
                onActivated = 0
            }

            function tbl1.onActivated()
                var9()
                var11.onActivated()
            end

            table.insert(result, tbl1)
        end

        return result
    end, { contextual, var9, var6 })

    if FFlagProfileFixMenuNavigation then
        return React.createElement(ProfileContextualMenu, {
            buttonProps = buttonProps,
            screenSize = screenSize,
            onDismiss = var9,
            rootElementPosition = rootElementPosition,
            rootElementRef = { current = current },
            isOpen = var7,
            menuRef = var10
        })
    end
    local createElement = React.createElement
    local var12 = FocusNavigableSurfaceWrapper

    local tbl1 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var9()
                    arg1:cancel()
                end)
            }
        }
    }

    return (createElement(var12, tbl1, { React.createElement(ProfileContextualMenu, {
            buttonProps = buttonProps,
            screenSize = screenSize,
            onDismiss = var9,
            rootElementPosition = rootElementPosition,
            rootElementRef = { current = current },
            isOpen = var7
        }) }))
end

return ProfileContextualMenuContainer
