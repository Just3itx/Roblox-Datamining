-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(SocialUpsellParent.React)
local Rodux = require(SocialUpsellParent.Rodux)
local Foundation = require(SocialUpsellParent.Foundation)
local InputHandlers = require(SocialUpsellParent.InputHandlers)
local SignalsReact = require(SocialUpsellParent.SignalsReact)
local ReactRoblox = require(SocialUpsellParent.ReactRoblox)
local RoactRodux = require(SocialUpsellParent.RoactRodux)
local createLazyComponent = require(SocialUpsellParent.RoactUtils).Components.createLazyComponent
local Localization = require(SocialUpsellParent.InExperienceLocales).Localization
local LocalizationProvider = require(SocialUpsellParent.Localization).LocalizationProvider
local localization = Localization.new(LocalizationService.RobloxLocaleId)
local getOverlayStore = require(SocialUpsell.Store.getOverlayStore)

local ReactFocusNavigation = require(SocialUpsellParent.ReactFocusNavigation)
local FocusNavigationUtils = require(SocialUpsellParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local FoundationProvider = Foundation.FoundationProvider
local useOverlay = Foundation.Hooks.useOverlay

local OVERLAY_TYPES = require(SocialUpsell.Constants).OVERLAY_TYPES

local _Types = require(SocialUpsell.Types)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

function OverlayContent(_)
    local var1 = useOverlay()

    local var2 = SignalsReact.useSignalState(getOverlayStore(false).getCurrentOverlay)

    local var3 = React.useMemo(function()
        return {
            [OVERLAY_TYPES.SocialUpsell] = {
                Component = createLazyComponent(function()
                    return require(SocialUpsell.Components.InAppSocialUpsellOverlayWrapper)
                end)
            }
        }
    end, {})

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    getOverlayStore(false).dismissCurrentOverlay()
                    arg1:cancel()
                end)
            }
        }
    end, {})

    if not (var1 and var2 and var2.overlayType and var3[var2.overlayType]) then
        return nil
    end

    return ReactRoblox.createPortal(
        React.createElement(
            FocusRoot,
            {
                eventHandlers = eventHandlers,
                eventMap = eventMap,
                isAutoFocusRoot = true,
                isIsolated = true,
                shouldRestoreFocus = true,
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay
            },
            {
                Content = React.createElement(var3[var2.overlayType].Component, var2.overlayProps or {})
            }
        ),
        var1
    )
end
return function(_)
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    React.useEffect(function()
        return function()
            if value then
                value:teardown()
            end
        end
    end, { value })

    return React.createElement(
        RoactRodux.StoreProvider,
        {
            store = Rodux.Store.new(Rodux.createReducer({}, {}), nil, { Rodux.thunkMiddleware })
        },
        {
            LocalizationProvider = React.createElement(LocalizationProvider, {
                localization = localization
            }, {
                FoundationProvider = React.createElement(FoundationProvider, nil, {
                    FocusProvider = React.createElement(ReactFocusNavigation.FocusNavigationContext.Provider, {
                        value = value
                    }, {
                        FocusNavigationRegistryProvider = React.createElement(Provider, nil, { Content = React.createElement(OverlayContent) })
                    })
                })
            })
        }
    )
end
