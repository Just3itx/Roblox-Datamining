-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParent.Parent.t)

local Label = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent).Label

local var1 = Roact.PureComponent:extend("SpinningImage")

var1.validateProps = t.strictInterface({
    image = t.table,
    size = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.union(t.UDim2, t.table)),
    rotationRate = t.optional(t.number)
})

var1.defaultProps = { rotationRate = 360 }

function var1.init(arg1)
    local angle, updateAngle = Roact.createBinding(0)
    arg1.angle = angle
    arg1.updateAngle = updateAngle
end

function var1.didMount(arg1)
    arg1.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime: number)
        local var2 = arg1.angle:getValue() + arg1.props.rotationRate * deltaTime
        if var2 > 360 then
            var2 -= 360
        elseif var2 < 0 then
            var2 += 360
        end
        arg1.updateAngle(var2)
    end)
end

function var1.willUnmount(arg1)
    arg1.heartbeatConnection:Disconnect()
end

function var1.getDerivedStateFromProps(arg1, _)
    local imageRectSize = arg1.image.ImageRectSize
    return {
        size = arg1.size or UDim2.fromOffset(imageRectSize.X, imageRectSize.Y)
    }
end

function var1.render(arg1)
    return Roact.createElement("Frame", {
        Size = arg1.state.size,
        AnchorPoint = arg1.props.anchorPoint,
        Position = arg1.props.position,
        BackgroundTransparency = 1
    }, {
        inner = Roact.createElement(Label, {
            Size = arg1.state.size,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = arg1.props.image,
            Rotation = arg1.angle,
            BackgroundTransparency = 1
        })
    })
end

return var1
