-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

local CloseOpenPrompt = require(scriptParentParentParent.Thunks.CloseOpenPrompt)

local var1 = Roact.PureComponent:extend("ContextActionsBinder")

var1.validateProps = t.strictInterface({ promptOpen = t.boolean, closeOpenPrompt = t.callback })

function var1.init(arg1)
    arg1.actionsBound = false
end

function var1.bindActions(arg1)
    if arg1.actionsBound then
        return
    end

    arg1.actionsBound = true

    ContextActionService:BindCoreAction("CloseAvatarEditorPrompt", function(_, userInputState, _)
        if GuiService.MenuIsOpen then
            return Enum.ContextActionResult.Pass
        end

        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end
        arg1.props.closeOpenPrompt()
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Escape)
end

function var1.unbindActions(arg1)
    if not arg1.actionsBound then
        return
    end

    arg1.actionsBound = false

    ContextActionService:UnbindCoreAction("CloseAvatarEditorPrompt")
end

function var1.didMount(arg1)
    if arg1.props.promptOpen then
        arg1:bindActions()
    end
end

function var1.render(_)
    return nil
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.promptOpen == arg2.promptOpen then
        return
    end

    if arg1.props.promptOpen then
        arg1:bindActions()
        return
    end
    arg1:unbindActions()
end

function var1.willUnmount(arg1)
    if arg1.actionsBound then
        arg1:unbindActions()
    end
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        promptOpen = arg1.promptInfo.promptType ~= nil
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closeOpenPrompt = function()
            return arg1(CloseOpenPrompt)
        end
    }
end)(var1)
