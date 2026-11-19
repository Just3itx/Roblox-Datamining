-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent
local IGMControllerBar2 = require(script.Parent.IGMControllerBar2)
local Constants = require(scriptParentParent.Resources.Constants)
local withLocalization = require(scriptParentParent.Localization.withLocalization)

local var1 = Roact.PureComponent:extend("IGMRespawnControllerBar")

var1.validateProps = t.strictInterface({ inputType = t.string })

function var1.render(arg1)
    if arg1.props.inputType ~= Constants.InputType.Gamepad then
        return nil
    end

    return withLocalization(
        {
            cancel = "CoreScripts.InGameMenu.ControllerBar.Cancel",
            respawn = "CoreScripts.InGameMenu.ControllerBar.Respawn"
        }
    )(
        function(arg2)
            return Roact.createElement(IGMControllerBar2, {
                leftHint = {
                    text = arg2.cancel,
                    keyCode = Enum.KeyCode.ButtonB
                },
                rightHints = {{
                    text = arg2.respawn,
                    keyCode = Enum.KeyCode.ButtonA
                }}
            })
        end
    )
end

return var1
