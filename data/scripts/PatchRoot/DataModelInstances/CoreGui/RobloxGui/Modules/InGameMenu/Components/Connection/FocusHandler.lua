-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local Cryo = InGameMenuDependencies.Cryo

local GetFFlagIGMGamepadSelectionHistory = require(script.Parent.Parent.Parent.Flags.GetFFlagIGMGamepadSelectionHistory)
local FocusHandlerContext = require(script.Parent.FocusHandlerUtils.FocusHandlerContext)

local num1 = 1

local var1 = Roact.PureComponent:extend("FocusHandler")

local strictInterface = t.strictInterface
local tbl1 = {
    isFocused = t.boolean,
    didFocus = t.optional(t.callback),
    didBlur = t.optional(t.callback),
    shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.boolean) or nil else nil,
    currentHandlerId = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.number) or nil else nil,
    candidateHandlerId = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.number) or nil else nil,
    previousSelections = if GetFFlagIGMGamepadSelectionHistory() then t.table or nil else nil,
    requestFocusForHandlerId = if GetFFlagIGMGamepadSelectionHistory() then t.callback or nil else nil,
    forgetLastSelectionForHandlerId = if GetFFlagIGMGamepadSelectionHistory() then t.callback or nil else nil,
    blurCurrentFocusHandler = if GetFFlagIGMGamepadSelectionHistory() then t.callback or nil else nil,
    [Roact.Children] = t.optional(t.table)
}
var1.validateProps = strictInterface(tbl1)

if GetFFlagIGMGamepadSelectionHistory() then
    function var1.init(arg1)
        arg1.id = num1
        num1 += 1
    end
end

function var1.render(arg1)
    return Roact.createFragment(arg1.props[Roact.Children])
end

if GetFFlagIGMGamepadSelectionHistory() then
    function var1.didMount(arg1)
        if arg1.props.isFocused then
            arg1.props.requestFocusForHandlerId(arg1.id)
        end
    end
else
    function var1.didMount(arg1)
        if arg1.props.isFocused then
            arg1.props.didFocus()
        end
    end
end

if GetFFlagIGMGamepadSelectionHistory() then
    function var1.didUpdate(arg1, arg2)
        local var2 = arg1.props.shouldForgetPreviousSelection and not arg2.shouldForgetPreviousSelection

        local previousSelection = arg1.props.previousSelections[arg1.id]
        if var2 or previousSelection ~= nil and not previousSelection:IsDescendantOf(game) then
            arg1.props.forgetLastSelectionForHandlerId(arg1.id)
            previousSelection = nil
        end

        local bool1 = not (arg1.props.candidateHandlerId == arg1.id) and arg1.props.candidateHandlerId ~= nil
        local bool2 = not (arg2.candidateHandlerId == arg1.id) and arg2.candidateHandlerId ~= nil
        local bool3 = arg1.props.currentHandlerId == arg1.id and arg2.currentHandlerId ~= arg1.id
        local isFocused = arg1.props.currentHandlerId == nil
            and arg2.currentHandlerId ~= nil
            and arg2.currentHandlerId ~= arg1.id
            and not bool1
            and arg1.props.isFocused
        local isFocused2 = not arg2.isFocused and arg1.props.isFocused

        local bool4 = arg2.isFocused and not arg1.props.isFocused or bool1 and not bool2
        local bool5 = arg2.currentHandlerId == arg1.id and arg1.props.currentHandlerId ~= arg1.id

        if isFocused2 or isFocused then
            arg1.props.requestFocusForHandlerId(arg1.id)
        elseif bool3 and arg1.props.didFocus then
            arg1.props.didFocus(previousSelection)
        end

        if bool4 and arg1.props.currentHandlerId == arg1.id then
            arg1.props.blurCurrentFocusHandler(arg1.id, arg1.props.shouldForgetPreviousSelection)
        end

        if bool5 and arg1.props.didBlur then
            arg1.props.didBlur()
        end
    end
else
    function var1.didUpdate(arg1, arg2)
        if arg1.props.isFocused and not arg2.isFocused and arg1.props.didFocus then
            arg1.props.didFocus()
        elseif not arg1.props.isFocused and arg2.isFocused and arg1.props.didBlur then
            arg1.props.didBlur()
        end
    end
end

if GetFFlagIGMGamepadSelectionHistory() then
    function var1.willUnmount(arg1)
        if arg1.props.isFocused then
            arg1.props.blurCurrentFocusHandler(arg1.id, true)
            if arg1.props.didBlur then
                arg1.props.didBlur()
            end
        else
            arg1.props.forgetLastSelectionForHandlerId(arg1.id)
        end
    end
else
    function var1.willUnmount(arg1)
        if arg1.props.isFocused and arg1.props.didBlur then
            arg1.props.didBlur()
        end
    end
end

if not GetFFlagIGMGamepadSelectionHistory() then
    return var1
end

local function FocusHandlerWithContext(arg1)
    return Roact.createElement(FocusHandlerContext.Consumer, {
        render = function(arg2)
            return Roact.createElement(
                var1,
                Cryo.Dictionary.join(arg1, {
                    currentHandlerId = arg2.currentHandlerId,
                    previousSelections = arg2.previousSelections,
                    requestFocusForHandlerId = arg2.requestFocusForHandlerId,
                    forgetLastSelectionForHandlerId = arg2.forgetLastSelectionForHandlerId,
                    blurCurrentFocusHandler = arg2.blurCurrentFocusHandler,
                    candidateHandlerId = arg2.candidateHandlerId
                })
            )
        end
    })
end
return FocusHandlerWithContext
