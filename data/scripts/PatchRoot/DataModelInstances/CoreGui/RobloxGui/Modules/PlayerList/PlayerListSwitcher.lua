-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local UiModeStyleProvider = require(CorePackages.Workspace.Packages.Style).UiModeStyleProvider

local scriptParent = script.Parent
local Connection = scriptParent.Components.Connection

local PlayerListApp = require(scriptParent.Components.Presentation.PlayerListApp)
local PlayerListApp2 = require(scriptParent.Components.PresentationMobile.PlayerListApp)

local Provider = require(Connection.LayoutValues).Provider
local CreateLayoutValues = require(scriptParent.CreateLayoutValues)
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local SetPlayerListVisibility = require(scriptParent.Actions.SetPlayerListVisibility)
local PlayerListInitialVisibleState = require(scriptParent.PlayerListInitialVisibleState)

local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagPlayerListTwoTabsOnLegacy = PlayerList.Flags.FFlagPlayerListTwoTabsOnLegacy
local FFlagPlayerListKeepModalHiddenOnRemount = require(scriptParent.Flags.FFlagPlayerListKeepModalHiddenOnRemount)
local PlatformLeaderboardContainer = PlayerList.Container.PlatformLeaderboardContainer

local var1 = Roact.PureComponent:extend("PlayerListSwitcher")

function var1.didMount(arg1)
    if FFlagPlayerListKeepModalHiddenOnRemount and arg1.props.isSmallTouchDevice then
        arg1.props.setPlayerListVisible(false)
        return
    end
    arg1.props.setPlayerListVisible(PlayerListInitialVisibleState())
end

function var1.wrapWithUiModeStyleProvider(arg1, arg2)
    return {
        ThemeProvider = Roact.createElement(UiModeStyleProvider, {
            style = {
                themeName = arg1.props.appStyleForUiModeStyleProvider.themeName,
                fontName = arg1.props.appStyleForUiModeStyleProvider.fontName
            }
        }, arg2)
    }
end

function var1.render(arg1)
    local element = Roact.createElement(
        Provider,
        {
            layoutValues = CreateLayoutValues(not FFlagEnableMobilePlayerListOnConsole and TenFootInterface:IsEnabled())
        },
        arg1:wrapWithUiModeStyleProvider({
            PlayerListApp = arg1.props.isSmallTouchDevice
                and Roact.createElement(PlayerListApp2, { setLayerCollectorEnabled = arg1.props.setLayerCollectorEnabled })
                or Roact.createElement(PlayerListApp, { setLayerCollectorEnabled = arg1.props.setLayerCollectorEnabled })
        })
    )

    if FFlagPlayerListTwoTabsOnLegacy then
        return Roact.createElement(PlatformLeaderboardContainer, {}, element)
    end
    return element
end

function var1.didUpdate(arg1)
    arg1.props.setPlayerListVisible(not arg1.props.isSmallTouchDevice)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        setPlayerListVisible = function(arg2)
            return arg1(SetPlayerListVisibility(arg2))
        end
    }
end)(var1)
