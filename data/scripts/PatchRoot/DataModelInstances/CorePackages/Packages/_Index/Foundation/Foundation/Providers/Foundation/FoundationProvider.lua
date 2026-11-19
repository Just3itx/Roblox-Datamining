-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local ContextStack = require(scriptParentParentParentParent.ReactUtils).ContextStack
local Flags = require(scriptParentParentParent.Utility.Flags)

local Cursor = require(scriptParentParent.Cursor)
local Overlay = require(scriptParentParent.Overlay)
local PanelsProvider = require(scriptParentParent.StudioPanels.PanelsProvider)
local PluginProvider = require(scriptParentParent.Plugin.PluginProvider)
local PreferencesProvider = require(scriptParentParent.Preferences.PreferencesProvider)
local _ResponsiveContext = require(scriptParentParent.Responsive.ResponsiveContext)
local ResponsiveProvider = require(scriptParentParent.Responsive.ResponsiveProvider)
local StyleProvider = require(scriptParentParent.Style.StyleProvider)
local _Types = require(scriptParentParentParent.Components.Types)
local WidgetsProvider = require(scriptParentParent.StudioWidgets.WidgetsProvider)
local ElevationProvider = require(scriptParentParent.Elevation.ElevationProvider).ElevationProvider
local isPluginElevated = require(scriptParentParent.Plugin.isPluginElevated)

local var1 = table.freeze({})

local function FoundationProvider(arg1)
    local var2 = if arg1.preferences then arg1.preferences else not Flags.FoundationProviderStableEmptyTable and {} or var1
    local config = if arg1.responsiveConfig then arg1.responsiveConfig else not Flags.FoundationProviderStableEmptyTable and {} or var1
    local providers = {
        React.createElement(PluginProvider, { plugin = arg1.plugin }),
        React.createElement(ElevationProvider, nil),
        React.createElement(PreferencesProvider, var2),
        React.createElement(StyleProvider, {
            themeName = arg1.themeName,
            colorMode = arg1.colorMode,
            theme = arg1.theme,
            device = arg1.device,
            derives = arg1.derives,
            scale = var2.scale,
            tokenOverrides = arg1.tokenOverrides
        }),
        React.createElement(ResponsiveProvider, { config = config }),
        React.createElement(
            Overlay,
            typeof(arg1.overlayGui) == "table" and {
                DisplayOrder = arg1.overlayGui.DisplayOrder
            } or {
                gui = arg1.overlayGui
            }
        ),
        React.createElement(Cursor)
    }

    if arg1.plugin and isPluginElevated(arg1.plugin) then
        table.insert(providers, React.createElement(WidgetsProvider, {}))
        table.insert(providers, React.createElement(PanelsProvider, {}))
    end

    return React.createElement(ContextStack, { providers = providers }, arg1.children)
end

return FoundationProvider
