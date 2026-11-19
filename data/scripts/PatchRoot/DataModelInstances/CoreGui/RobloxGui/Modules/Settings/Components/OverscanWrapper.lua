-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider

local FocusRoot = require(CorePackages.Workspace.Packages.FocusNavigationUtils).FocusRoot

local React = require(CorePackages.Packages.React)
local RobloxAppEnums = require(CorePackages.Workspace.Packages.RobloxAppEnums)

local FocusNavigableSurfaceIdentifierEnum = require(CorePackages.Workspace.Packages.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local DeviceType = RobloxAppEnums.DeviceType

function OverscanWrapper(arg1)
    return function(arg2)
        local styleOverride = {
            deviceType = DeviceType.Console
        }

        return React.createElement(CoreScriptsRootProvider, { styleOverride = styleOverride }, {
            FocusNavigationCoreScriptsWrapper = React.createElement(
                FocusRoot,
                {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                    isIsolated = true,
                    isAutoFocusRoot = true
                },
                {
                    Overscan = React.createElement(arg1, arg2)
                }
            )
        })
    end
end

return OverscanWrapper
