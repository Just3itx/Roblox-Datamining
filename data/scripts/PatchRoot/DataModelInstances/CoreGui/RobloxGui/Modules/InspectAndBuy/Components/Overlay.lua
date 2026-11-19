-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector

local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle

local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local scriptParentParent = script.Parent.Parent
local Colors = require(scriptParentParent.Colors)
local OverlayComponents = require(scriptParentParent.Components.OverlayComponents)

local function selectOverlayComponent(arg1)
    return OverlayComponents[arg1.overlay.overlay]
end

local function selectOverlayProps(arg1)
    return arg1.overlay.overlayProps
end

local function Overlay(_)
    local var1 = useSelector(selectOverlayComponent)
    local var2 = useSelector(selectOverlayProps)
    local var3 = useStyle()

    return React.createElement(ReactFocusNavigation.FocusNavigationContext.Provider, {
        value = focusNavigationService
    }, {
        FocusNavigationRegistryProvider = React.createElement(Provider, nil, {
            FocusNavigationCoreScriptsWrapper = React.createElement(
                FocusRoot,
                {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                    isIsolated = true,
                    isAutoFocusRoot = true
                },
                {
                    OverlayContainer = React.createElement("Frame", {
                        BackgroundTransparency = var3.Tokens.Color.Common.Scrim.Transparency,
                        BackgroundColor3 = Colors.Black,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        Visible = var1 ~= nil
                    }, {
                        Overlay = var1 and React.createElement(var1, var2) or nil
                    })
                }
            )
        })
    })
end
return Overlay
