-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local BaseMenu = UIBlox.App.Menu.BaseMenu

local scriptParentParent = script.Parent.Parent

local FocusHandler = require(script.Parent.Connection.FocusHandler)
local RootedConnection = require(script.Parent.Connection.RootedConnection)

local Flags = scriptParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)

local var1 = Roact.PureComponent:extend("PlayerContextualMenu")

var1.validateProps = t.strictInterface({
    moreActions = t.table,
    actionWidth = t.number,
    xOffset = t.number,
    yOffset = t.number,
    onClose = t.callback,
    canCaptureFocus = t.boolean
})

function var1.init(arg1)
    arg1.firstOptionRef = Roact.createRef()
    arg1.containerRef = Roact.createRef()
end

function var1.renderContextualMenuFocusHandler(arg1, arg2, arg3)
    local isFocused = arg1.props.canCaptureFocus and arg2

    return Roact.createElement(FocusHandler, {
        isFocused = isFocused,
        didFocus = function(selectedCoreObject)
            ContextActionService:BindCoreAction("player_contextual_menu_close_action", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.End or not arg1.props.onClose then
                    return Enum.ContextActionResult.Pass
                end

                arg1.props.onClose()
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonB)

            GuiService:RemoveSelectionGroup("player_contextual_menu_selection_parent")

            GuiService:AddSelectionParent("player_contextual_menu_selection_parent", arg1.containerRef:getValue())

            if GetFFlagIGMGamepadSelectionHistory() then
                GuiService.SelectedCoreObject = selectedCoreObject or arg1.firstOptionRef:getValue()
                return
            end
            GuiService.SelectedCoreObject = arg1.firstOptionRef:getValue()
        end,
        didBlur = function()
            ContextActionService:UnbindCoreAction("player_contextual_menu_close_action")
        end
    }, arg3)
end

function var1.render(arg1)
    return Roact.createElement(Roact.Portal, { target = CoreGui }, {
        InGameMenuContextGui = Roact.createElement(
            "ScreenGui",
            {
                DisplayOrder = 2,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            },
            {
                RootedConnection = Roact.createElement(RootedConnection, {
                    render = function(arg2)
                        local var2 = arg1
                        local tbl1 = {
                            MoreActionsMenu = Roact.createElement(
                                "Frame",
                                {
                                    Size = UDim2.fromScale(1, 1),
                                    BackgroundTransparency = 1,
                                    [Roact.Ref] = arg1.containerRef
                                },
                                {
                                    BaseMenu = Roact.createElement(BaseMenu, {
                                        buttonProps = arg1.props.moreActions,
                                        setFirstItemRef = arg1.firstOptionRef,
                                        width = UDim.new(0, arg1.props.actionWidth),
                                        position = UDim2.fromOffset(arg1.props.xOffset, arg1.props.yOffset)
                                    })
                                }
                            )
                        }
                        return var2:renderContextualMenuFocusHandler(arg2, tbl1)
                    end
                })
            }
        )
    })
end

return var1
