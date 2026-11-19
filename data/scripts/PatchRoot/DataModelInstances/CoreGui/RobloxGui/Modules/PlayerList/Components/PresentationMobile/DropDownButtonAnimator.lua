-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local Otter = require(CorePackages.Packages.Otter)
local useLayoutValues = require(CorePackages.Workspace.Packages.PlayerList).Common.useLayoutValues

local Connection = script.Parent.Parent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local DropDownButton = require(script.Parent.DropDownButton)

local tbl1 = { dampingRatio = 1, frequency = 4 }

local tbl2 = { dampingRatio = 1, frequency = 4 }

local var1 = Roact.PureComponent:extend("DropDownAnimator")

var1.validateProps = t.strictInterface({
    text = t.string,
    icon = t.union(t.string, t.table),
    lastButton = t.boolean,
    layoutOrder = t.integer,
    onActivated = t.callback,
    forceShowOptions = t.boolean,
    selectedPlayer = t.optional(t.instanceIsA("Player")),
    onDecline = t.optional(t.callback),
    onDismiss = t.optional(t.callback),
    contentVisible = t.boolean,
    layoutValues = t.optional(t.table),
    onAnimationComplete = t.optional(t.callback),
    forwardRef = t.optional(t.callback)
})

function var1.init(arg1)
    arg1.state = {
        lastButtonProps = nil,
        onDeclineCalled = nil,
        onActivatedCalled = nil,
        overlayPercentage = 0
    }

    local currentButtonPosition, updateCurrentButtonPosition = Roact.createBinding(UDim2.new(0, 0, 0, 0))
    arg1.currentButtonPosition = currentButtonPosition
    arg1.updateCurrentButtonPosition = updateCurrentButtonPosition
    local lastButtonPosition, updateLastButtonPosition = Roact.createBinding(UDim2.new(0, 0, 0, 0))
    arg1.lastButtonPosition = lastButtonPosition
    arg1.updateLastButtonPosition = updateLastButtonPosition

    arg1.positionMotor = Otter.createSingleMotor(0)
    arg1.positionMotor:onStep(function(xScale: number?)
        arg1.updateCurrentButtonPosition(UDim2.new(xScale, 0, 0, 0))
        if arg1.animatingRight then
            arg1.updateLastButtonPosition(UDim2.new(xScale + 1, 0, 0, 0))
            return
        end
        arg1.updateLastButtonPosition(UDim2.new(xScale - 1, 0, 0, 0))
    end)

    arg1.positionMotor:onComplete(function(arg2)
        if arg2 ~= 0 then
            return
        end

        arg1:setState({ lastButtonProps = Roact.None, onDeclineCalled = Roact.None, onActivatedCalled = Roact.None })
    end)

    arg1.overlayMotor = Otter.createSingleMotor(0)
    arg1.overlayMotor:onStep(function(overlayPercentage)
        arg1:setState({ overlayPercentage = overlayPercentage })
    end)

    arg1.overlayMotor:onComplete(function(arg2)
        if arg2 == 1 then
            arg1.positionMotor:setGoal(Otter.spring(0, tbl1))
        end
    end)
end

function var1.getButtonProps(arg1, arg2, arg3)
    local tbl3 = {
        text = arg2.text,
        icon = arg2.icon,
        lastButton = arg2.lastButton,
        forceShowOptions = arg2.forceShowOptions,
        onDismiss = arg2.onDismiss
    }
    if arg1.state.lastButtonProps ~= nil then
        if arg3 then
            tbl3.animatingAccept = arg1.state.onActivatedCalled
            tbl3.animatingDecline = arg1.state.onDeclineCalled
            tbl3.animatingPercentage = arg1.state.overlayPercentage
            return tbl3
        end
    else
        if arg2.onActivated and (arg2.onDecline or arg1.props.forceShowOptions) then
            function tbl3.onActivated()
                arg1:setState({ onActivatedCalled = true, onDeclineCalled = false })

                arg2.onActivated()
            end
        elseif arg2.onActivated then
            tbl3.onActivated = arg2.onActivated
        end
        if arg2.onDecline then
            function tbl3.onDecline()
                arg1:setState({ onActivatedCalled = false, onDeclineCalled = true })

                arg2.onDecline()
            end
        end
    end

    return tbl3
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        arg2 = arg1.props.layoutValues
        local tbl3 = {
            CurrentButtonContainer = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = arg1.currentButtonPosition,
                    BackgroundTransparency = 1
                },
                {
                    DropDownButton = Roact.createElement(DropDownButton, arg1:getButtonProps(arg1.props))
                }
            )
        }

        if arg1.state.lastButtonProps then
            tbl3.LastButtonContainer = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = arg1.lastButtonPosition,
                    BackgroundTransparency = 1
                },
                {
                    DropDownButton = Roact.createElement(DropDownButton, arg1:getButtonProps(arg1.state.lastButtonProps, true))
                }
            )
        end

        return Roact.createElement("Frame", {
            Visible = arg1.props.contentVisible,
            ZIndex = 2,
            Size = UDim2.new(1, 0, 0, arg2.DropDownButtonSizeY),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            [Roact.Ref] = arg1.props.forwardRef
        }, tbl3)
    end)
end

function var1.didUpdate(arg1, lastButtonProps, arg2)
    local bool1 = arg1.props.text ~= lastButtonProps.text
    local var2 = lastButtonProps.onDecline ~= nil or arg1.props.forceShowOptions
    local var3 = arg1.state.onDeclineCalled or arg1.state.onActivatedCalled
    local bool2 = arg1.state.lastButtonProps == nil and arg2.lastButtonProps ~= nil

    if bool1 and var2 and var3 then
        if arg1.state.onActivatedCalled and not arg1.props.forceShowOptions then
            arg1.animatingRight = true
            arg1.positionMotor:setGoal(Otter.instant(-1))
        else
            arg1.animatingRight = false
            arg1.positionMotor:setGoal(Otter.instant(1))
        end
        arg1.overlayMotor:setGoal(Otter.instant(0))
        arg1.positionMotor:step(0)
        arg1.overlayMotor:step(0)

        arg1:setState({ lastButtonProps = lastButtonProps })

        arg1.overlayMotor:setGoal(Otter.spring(1, tbl2))
    end

    if bool2 and arg1.props.onAnimationComplete then
        arg1.props.onAnimationComplete()
    end

    if arg1.props.selectedPlayer == lastButtonProps.selectedPlayer then
        return
    end

    arg1.positionMotor:setGoal(Otter.instant(0))
    arg1.overlayMotor:setGoal(Otter.instant(0))
    arg1.positionMotor:step(0)
    arg1.overlayMotor:step(0)

    arg1:setState({ lastButtonProps = Roact.None })
end

function var1.willUnmount(arg1)
    arg1.positionMotor:destroy()
    arg1.positionMotor = nil
    arg1.overlayMotor:destroy()
    arg1.overlayMotor = nil
end

return function(arg1)
    local layoutValues = useLayoutValues()

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { layoutValues = layoutValues }))
end
