-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local ControllerBar = require(CorePackages.Packages.UIBlox).App.Bar.ControllerBar

local SetControllerBarHeight = require(script.Parent.Parent.Actions.SetControllerBarHeight)
local scriptParentParent = script.Parent.Parent
local withLocalization = require(scriptParentParent.Localization.withLocalization)

local Constants = require(script.Parent.Parent.Resources.Constants)

local var1 = Roact.PureComponent:extend("IGMControllerBar")

local tbl1 = {
    cancel = "CoreScripts.InGameMenu.ControllerBar.Cancel",
    respawn = "CoreScripts.InGameMenu.ControllerBar.Respawn",
    openMoreMenu = "CoreScripts.InGameMenu.ControllerBar.OpenMoreMenu",
    closeMoreMenu = "CoreScripts.InGameMenu.ControllerBar.CloseMoreMenu",
    back = "CoreScripts.InGameMenu.ControllerBar.Back",
    respawnCharacter = "CoreScripts.InGameMenu.ControllerBar.RespawnCharacter",
    leave = "CoreScripts.InGameMenu.ControllerBar.Leave"
}

var1.validateProps = t.strictInterface({
    isMenuOpen = t.boolean,
    isMainPageMoreMenuOpen = t.boolean,
    currentPage = t.string,
    respawnDialogOpen = t.boolean,
    inputType = t.string,
    screenSize = t.Vector2,
    setControllerBarHeight = t.callback
})

function var1.didMount(arg1)
    if arg1:getHints(tbl1) then
        arg1.props.setControllerBarHeight(Constants.ControllerBarHeight)
        return
    end
    arg1.props.setControllerBarHeight(0)
end

function var1.didUpdate(arg1)
    if arg1:getHints(tbl1) then
        arg1.props.setControllerBarHeight(Constants.ControllerBarHeight)
        return
    end
    arg1.props.setControllerBarHeight(0)
end

function var1.willUnmount(arg1)
    arg1.props.setControllerBarHeight(0)
end

function var1.getHints(arg1, arg2)
    if arg1.props.inputType == Constants.InputType.Gamepad then
        if arg1.props.respawnDialogOpen then
            return {
                leftHint = {
                    text = arg2.cancel,
                    keyCode = Enum.KeyCode.ButtonB
                },
                rightHints = {{
                    text = arg2.respawn,
                    keyCode = Enum.KeyCode.ButtonA
                }}
            }
        end

        if arg1.props.isMenuOpen and arg1.props.currentPage == "MainPage" then
            local text = if arg1.props.isMainPageMoreMenuOpen then arg2.closeMoreMenu else arg2.openMoreMenu
            return {
                leftHint = {
                    text = arg2.back,
                    keyCode = Enum.KeyCode.ButtonB
                },
                rightHints = {
                    {
                        text = text,
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
            }
        end
    end

    return nil
end

function var1.render(arg1)
    return withLocalization(tbl1)(function(arg2)
        local hints = arg1:getHints(arg2)
        if hints then
            return Roact.createElement(ControllerBar, hints)
        end
        return nil
    end)
end

return RoactRodux.connect(function(arg1, _) -- name: mapStateToProps
    return {
        isMenuOpen = arg1.isMenuOpen,
        isMainPageMoreMenuOpen = arg1.isMainPageMoreMenuOpen,
        currentPage = arg1.menuPage,
        respawnDialogOpen = arg1.respawn.dialogOpen,
        inputType = arg1.displayOptions.inputType,
        screenSize = arg1.screenSize
    }
end, function(callback)
    return {
        setControllerBarHeight = function(arg1)
            callback(SetControllerBarHeight(arg1))
        end
    }
end)(var1)
