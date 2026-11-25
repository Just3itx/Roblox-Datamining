-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local ReactUtils = require(scriptParentParentParent.ReactUtils)
local Cryo = require(scriptParentParentParent.Cryo)

local Foundation = require(scriptParentParentParent.Foundation)
local Toast = Foundation.Toast
local KeyLabel = Foundation.KeyLabel
local View = Foundation.View
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local ControlState = Foundation.Enums.ControlState

local InputTypeConstants = require(scriptParentParentParent.InputType).InputTypeConstants
local useInputType = RoactUtils.Hooks.useInputType
local EventConnection = ReactUtils.EventConnection

local useFocusGuiObject = require(scriptParentParentParent.ReactFocusNavigation).useFocusGuiObject

local constants = require(scriptParentParent.constants)

return React.memo(React.forwardRef(function(tbl1, _) -- name: ClientNotificationWrapper
    local ref = React.useRef(nil)
    local selectionGroup, var3 = React.useBinding(false)
    local var4, var5 = React.useBinding(Enum.SelectionBehavior.Escape)

    local var6 = useInputType()
    local var7 = useFocusGuiObject()

    local onStateChanged = if tbl1.onHover then React.useCallback(function(arg1)
        tbl1.onHover(arg1 == ControlState.Hover or arg1 == ControlState.Pressed or arg1 == ControlState.SelectedPressed)
    end, { tbl1.onHover }) else nil

    local var9 = HttpService:JSONDecode(tbl1.notificationInfo)
    local actions = {}
    if var9.Buttons then
        for i, button in ipairs(var9.Buttons) do
            local tbl3 = {
                text = button.Text,
                variant = button.ButtonType,
                onActivated = 0
            }

            function tbl3.onActivated()
                GuiService:OnNotificationInteraction(tbl1.notificationId, i - 1)
            end

            table.insert(actions, tbl3)
        end
    end

    local createElement = React.createElement
    local var10 = View
    local tbl3 = {
        tag = "auto-xy",
        GroupTransparency = if tbl1.transparency == nil then nil else tbl1.transparency,
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        SelectionGroup = selectionGroup,
        SelectionBehaviorUp = var4,
        SelectionBehaviorDown = var4,
        SelectionBehaviorLeft = var4,
        SelectionBehaviorRight = var4,
        ref = ref
    }
    local join = Cryo.Dictionary.join
    local var11 = tbl1.children or {}
    local tbl4 = {
        Toast = React.createElement(
            Toast,
            {
                title = var9.Title,
                text = var9.Text,
                icon = var9.Icon,
                actions = actions,
                width = tbl1.width
            }
        ),
        KeyLabelView = 0
    }
    local element

    if var6 == InputTypeConstants.Gamepad and #actions > 0 then
        element = React.createElement(View, {
            tag = "size-1400-1400 padding-medium anchor-top-right position-top-right"
        }, {
            EventConnection = React.createElement(EventConnection, {
                event = UserInputService.InputBegan,
                callback = function(arg1)
                    if arg1.KeyCode == Enum.KeyCode.ButtonB then
                        var7(nil)
                        tbl1.onPause(false)
                    end
                end
            }),
            KeyLabel = React.createElement(KeyLabel, {
                Size = UDim2.fromScale(1, 1),
                keyCode = Enum.KeyCode.ButtonStart,
                holdBehavior = {
                    holdTime = constants.MenuButtonPressHoldTime,
                    resetTime = constants.MenuButtonPressResetTime,
                    onBeginHold = function()
                        tbl1.onPause(true)
                    end,
                    onEndHold = function(bool1: boolean)
                        if not bool1 then
                            tbl1.onPause(false)

                            return
                        end

                        if #actions == 1 then
                            tbl1.onPause(false)
                            actions[1].onActivated()
                            return
                        end
                        var3(true)
                        var5(Enum.SelectionBehavior.Stop)
                        var7(ref.current)
                    end
                }
            })
        })
    else
        element = nil
    end

    tbl4.KeyLabelView = element
    return createElement(var10, tbl3, join(var11, tbl4))
end))
