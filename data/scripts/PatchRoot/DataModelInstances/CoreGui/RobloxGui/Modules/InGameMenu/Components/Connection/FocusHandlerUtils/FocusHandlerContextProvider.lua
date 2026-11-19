-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.InGameMenuDependencies).Roact
local FocusHandlerContext = require(script.Parent.FocusHandlerContext)

local var1 = Roact.PureComponent:extend("FocusHandlerContextProvider")

function var1.init(arg1)
    arg1.state = { candidateHandlerId = nil, currentHandlerId = nil }

    arg1.previousSelections = {}
end

function var1.requestFocusForHandlerId(arg1, currentHandlerId)
    arg1:setState(function(arg2): nil | {candidateHandlerId: any} | {currentHandlerId: any}
        return if arg2.currentHandlerId == nil then { currentHandlerId = currentHandlerId } elseif currentHandlerId == arg2.currentHandlerId then nil else {
            candidateHandlerId = currentHandlerId
        }
    end)
end

function var1.blurCurrentFocusHandler(arg1, currentHandlerId, arg2)
    arg1:setState(function(arg3)
        if arg3.currentHandlerId ~= currentHandlerId then
            return nil
        end

        local selectedCoreObject = if arg2 then nil else GuiService.SelectedCoreObject
        arg1.previousSelections[currentHandlerId] = selectedCoreObject

        return if arg3.candidateHandlerId == nil then {
            currentHandlerId = Roact.None
        } else {
            currentHandlerId = arg3.candidateHandlerId,
            candidateHandlerId = Roact.None
        }
    end)
end

function var1.forgetLastSelectionForHandlerId(arg1, arg2)
    arg1.previousSelections[arg2] = nil
end

function var1.render(arg1)
    return Roact.createElement(FocusHandlerContext.Provider, {
        value = {
            currentHandlerId = arg1.state.currentHandlerId,
            candidateHandlerId = arg1.state.candidateHandlerId,
            previousSelections = arg1.previousSelections,
            requestFocusForHandlerId = function(arg2)
                arg1:requestFocusForHandlerId(arg2)
            end,
            forgetLastSelectionForHandlerId = function(arg2)
                arg1:forgetLastSelectionForHandlerId(arg2)
            end,
            blurCurrentFocusHandler = function(arg2, arg3)
                arg1:blurCurrentFocusHandler(arg2, arg3)
            end
        }
    }, arg1.props[Roact.Children])
end

return var1
