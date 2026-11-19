-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParent = script.Parent.Parent
local withLocalization = require(scriptParentParent.Localization.withLocalization)
local SetMenuIconTooltipOpen = require(scriptParentParent.Actions.SetMenuIconTooltipOpen)
local Constants = require(scriptParentParent.Parent.TopBar.Constants)
local Tooltip = UIBlox.App.Dialog.Tooltip

local var1 = Roact.PureComponent:extend("MenuIconTooltip")

var1.validateProps = t.strictInterface({ isTooltipOpen = t.boolean, onDismiss = t.callback })

function var1.init(arg1)
    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)
end

function var1.render(arg1)
    return withLocalization({ bodyText = "CoreScripts.InGameMenu.EducationalPopup.MenuIconTooltip" })(function(arg2)
        local var2 = Constants.TopBarHeight * arg1.state.UiScale
        local x = Constants.ScreenSideOffset * arg1.state.UiScale
        local vector2 = Vector2.new(x, var2 - 32)
        return arg1.props.isTooltipOpen
            and Roact.createElement(Roact.Portal, { target = CoreGui }, {
                TooltipScreenGui = Roact.createElement(
                    "ScreenGui",
                    {
                        IgnoreGuiInset = true,
                        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    },
                    {
                        Tooltip = Roact.createElement(Tooltip, {
                            triggerPosition = vector2,
                            triggerSize = Vector2.new(32, 32),
                            bodyText = arg2.bodyText,
                            onDismiss = arg1.props.onDismiss,
                            forceClickTriggerPoint = true
                        })
                    }
                )
            })
    end)
end

function var1.willUnmount(arg1)
    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isTooltipOpen = arg1.nativeClosePrompt.menuIconTooltipOpen
    }
end, function(callback)
    return {
        onDismiss = function()
            callback(SetMenuIconTooltipOpen(false))
        end
    }
end)(var1)
