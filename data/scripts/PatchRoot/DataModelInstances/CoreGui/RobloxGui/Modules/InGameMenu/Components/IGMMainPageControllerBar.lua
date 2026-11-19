-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent
local IGMControllerBar2 = require(script.Parent.IGMControllerBar2)
local withLocalization = require(scriptParentParent.Localization.withLocalization)

local var1 = Roact.PureComponent:extend("IGMMainPageControllerBar")

var1.validateProps = t.strictInterface({ canCaptureFocus = t.boolean, isMainPageMoreMenuOpen = t.boolean })

function var1.render(arg1)
    if not arg1.props.canCaptureFocus then
        return nil
    end

    return withLocalization({
        openMoreMenu = "CoreScripts.InGameMenu.ControllerBar.OpenMoreMenu",
        closeMoreMenu = "CoreScripts.InGameMenu.ControllerBar.CloseMoreMenu",
        back = "CoreScripts.InGameMenu.ControllerBar.Back",
        respawnCharacter = "CoreScripts.InGameMenu.ControllerBar.RespawnCharacter",
        leave = "CoreScripts.InGameMenu.ControllerBar.Leave"
    })(
        function(arg2)
            local rightHints = VRService.VREnabled
                and {
                    {
                        text = arg2.respawnCharacter,
                        keyCode = Enum.KeyCode.ButtonY
                    },
                    {
                        text = arg2.leave,
                        keyCode = Enum.KeyCode.ButtonX
                    }
                }
                or {
                    {
                        text = arg1.props.isMainPageMoreMenuOpen and arg2.closeMoreMenu or arg2.openMoreMenu,
                        keyCode = Enum.KeyCode.ButtonL3
                    },
                    {
                        text = arg2.respawnCharacter,
                        keyCode = Enum.KeyCode.ButtonY
                    },
                    {
                        text = arg2.leave,
                        keyCode = Enum.KeyCode.ButtonX
                    }
                }

            return Roact.createElement(
                IGMControllerBar2,
                {
                    leftHint = {
                        text = arg2.back,
                        keyCode = Enum.KeyCode.ButtonB
                    },
                    rightHints = rightHints
                }
            )
        end
    )
end

return var1
