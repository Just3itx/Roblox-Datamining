-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local t = dependencies.t
local Cryo = dependencies.Cryo

local withStyle = UIBlox.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local ExternalEventConnection = require(script.Parent.ExternalEventConnection)

local var1 = Roact.PureComponent:extend("Spinner")

var1.defaultProps = {
    Size = UDim2.new(0, 20, 0, 20),
    spinSpeed = 540
}

var1.validateProps = t.interface({
    isSpinning = t.optional(t.boolean),
    spinSpeed = t.optional(t.number),
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    AnchorPoint = t.optional(t.Vector2),
    ImageColor3 = t.optional(t.Color3),
    ImageTransparency = t.optional(t.number),
    forwardRef = t.optional(t.table)
})

function var1.init(arg1)
    function arg1.renderSteppedCallback(arg2)
        local isSpinning = arg1.props.isSpinning
        local spinSpeed = arg1.props.spinSpeed

        if isSpinning and arg1.ref.current then
            arg1.ref.current.Rotation = arg1.ref.current.Rotation + spinSpeed * arg2
        end
    end
end

function var1.render(arg1)
    local propsSize = arg1.props.Size
    local propsPosition = arg1.props.Position
    local anchorPoint = arg1.props.AnchorPoint
    local imageColor3 = arg1.props.ImageColor3
    local imageTransparency = arg1.props.ImageTransparency
    local isSpinning = arg1.props.isSpinning

    arg1.ref = arg1.props.forwardRef or arg1.ref or Roact.createRef()

    return withStyle(function(arg2)
        return Roact.createElement(ImageSetLabel, {
            Size = propsSize,
            Position = propsPosition,
            AnchorPoint = anchorPoint,
            BackgroundTransparency = 1,
            Image = Images["icons/common/refresh"],
            ImageColor3 = imageColor3 or arg2.Theme.SystemPrimaryDefault.Color,
            ImageTransparency = imageTransparency or arg2.Theme.SystemPrimaryDefault.Transparency,
            [Roact.Ref] = arg1.ref
        }, {
            renderStepped = isSpinning
                and Roact.createElement(
                    ExternalEventConnection,
                    {
                        event = RunService.renderStepped,
                        callback = arg1.renderSteppedCallback
                    }
                )
        })
    end)
end
return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
