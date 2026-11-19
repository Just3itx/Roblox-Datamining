-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetPlayerListVisibility = require(scriptParentParentParent.Actions.SetPlayerListVisibility)
local ClosePlayerDropDown = require(scriptParentParentParent.Actions.ClosePlayerDropDown)

local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav
local FFlagPlayerListUseMobileOnSmallDisplay = PlayerList.Flags.FFlagPlayerListUseMobileOnSmallDisplay

local var1 = Roact.PureComponent:extend("ContextActionsBinder")

local tbl1 = {
    Enum.UserInputType.Gamepad1,
    Enum.UserInputType.Gamepad2,
    Enum.UserInputType.Gamepad3,
    Enum.UserInputType.Gamepad4,
    Enum.UserInputType.Gamepad5,
    Enum.UserInputType.Gamepad6,
    Enum.UserInputType.Gamepad7,
    Enum.UserInputType.Gamepad8
}

function var1.init(arg1)
    arg1.boundPlayerListActions = false
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("RbxPlayerListToggle", function(_, userInputState, _)
        if FFlagPlayerListUseMobileOnSmallDisplay and arg1.props.displayOptions.isSmallTouchDevice then
            return Enum.ContextActionResult.Pass
        end

        if GuiService.MenuIsOpen then
            return Enum.ContextActionResult.Pass
        end

        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end
        arg1.props.setVisibility(not arg1.props.displayOptions.isVisible)
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Tab)
    ContextActionService:BindCoreAction("RbxPlayerListStopMovement", function(_, _, _): Enum.ContextActionResult
        return if arg1.props.displayOptions.isVisible and arg1.props.displayOptions.isTenFootInterface then Enum.ContextActionResult.Sink else Enum.ContextActionResult.Pass
    end, false, unpack(tbl1))
    ContextActionService:BindCoreAction("RbxPlayerListGamepadClose", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin
            or not (arg1.props.displayOptions.isTenFootInterface
                or FFlagAddNewPlayerListMobileFocusNav and arg1.props.displayOptions.isSmallTouchDevice)
        then
            return Enum.ContextActionResult.Pass
        elseif FFlagAddNewPlayerListMobileFocusNav and arg1.props.playerDropDown.isVisible then
            arg1.props.closePlayerDropDown()
            return Enum.ContextActionResult.Sink
        else
            if FFlagAddNewPlayerListMobileFocusNav then
                if arg1.props.displayOptions.isVisible then
                    arg1.props.setVisibility(false)
                    return Enum.ContextActionResult.Sink
                end
            elseif arg1.props.displayOptions.isVisible and arg1.props.displayOptions.isTenFootInterface then
                arg1.props.setVisibility(false)
                return Enum.ContextActionResult.Sink
            end

            return Enum.ContextActionResult.Pass
        end
    end, false, Enum.KeyCode.ButtonB, if FFlagAddNewPlayerListMobileFocusNav then Enum.KeyCode.ButtonB else Enum.KeyCode.ButtonStart)
    arg1.boundPlayerListActions = true
end

function var1.unbindActions(arg1)
    ContextActionService:UnbindCoreAction("RbxPlayerListToggle")
    ContextActionService:UnbindCoreAction("RbxPlayerListStopMovement")
    ContextActionService:UnbindCoreAction("RbxPlayerListGamepadClose")
    arg1.boundPlayerListActions = false
end

function var1.didMount(arg1)
    arg1:bindActions()
end

function var1.render(_)
    return nil
end

function var1.willUnmount(arg1)
    if arg1.boundPlayerListActions then
        arg1:unbindActions()
    end
end

local function mapStateToProps(arg1)
    return {
        displayOptions = arg1.displayOptions,
        playerDropDown = if FFlagAddNewPlayerListMobileFocusNav then arg1.playerDropDown else nil
    }
end

local function mapDispatchToProps(arg1)
    return {
        setVisibility = function(arg2)
            return arg1(SetPlayerListVisibility(arg2))
        end,
        closePlayerDropDown = FFlagAddNewPlayerListMobileFocusNav and function()
            return arg1(ClosePlayerDropDown())
        end or nil
    }
end

if FFlagPlayerListReduceRerenders then
    return React.memo(RoactRodux.connect(mapStateToProps, mapDispatchToProps)(var1))
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(var1)
