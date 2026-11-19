-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local ScreenshotFlowStepHandler = require(script.Parent.ScreenshotFlowStepHandler)

local var1 = React.PureComponent:extend("ScreenshotFlowStepHandlerContainer")

local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

function var1.render(arg1)
    return React.createElement(CoreScriptsRootProvider, {}, {
        FocusNavigationCoreScriptsWrapper = React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            {
                ScreenshotFlowStepHandlerContainer = React.createElement(ScreenshotFlowStepHandler, arg1.props)
            }
        )
    })
end
return var1
