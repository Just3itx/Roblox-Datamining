-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Cryo = require(scriptParentParentParentParent.Cryo)
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local getPageMargin = require(script.Parent.getPageMargin)

local var1 = Roact.Component:extend("PageMargin")

var1.validateProps = t.interface({
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    backgroundColor3 = t.optional(t.Color3),
    backgroundTransparency = t.optional(t.number),
    layoutOrder = t.optional(t.number),
    size = t.optional(t.UDim2),
    useAutomaticSizing = t.optional(t.boolean),
    zIndex = t.optional(t.number)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0, 0),
    position = UDim2.new(),
    size = UDim2.fromScale(1, 1),
    backgroundTransparency = 0,
    layoutOrder = 0,
    useAutomaticSizing = false
}

function var1.init(arg1)
    arg1.state = {}
    arg1.ref = Roact.createRef()
    function arg1.onResize(arg2)
        if not arg1.mounted then
            return
        end

        local absoluteSizeX = arg2.AbsoluteSize.X
        arg1:setState(function(arg3): {margin: any}?
            local margin = getPageMargin(absoluteSizeX)
            return if arg3.margin == margin then nil else { margin = margin }
        end)
    end
end

function var1.render(arg1)
    return Roact.createElement(
        "Frame",
        {
            AnchorPoint = arg1.props.anchorPoint,
            AutomaticSize = arg1.props.useAutomaticSizing and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
            BackgroundColor3 = arg1.props.backgroundColor3,
            BackgroundTransparency = arg1.props.backgroundTransparency,
            BorderSizePixel = 0,
            Position = arg1.props.position,
            Size = arg1.props.size,
            [Roact.Change.AbsoluteSize] = arg1.onResize,
            [Roact.Ref] = arg1.ref,
            LayoutOrder = arg1.props.layoutOrder,
            ZIndex = arg1.props.zIndex
        },
        Cryo.Dictionary.join(arg1.props[Roact.Children], {
            padding = Roact.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, arg1.state.margin),
                    PaddingRight = UDim.new(0, arg1.state.margin)
                }
            )
        })
    )
end

function var1.didMount(arg1)
    arg1.mounted = true
    if arg1.ref.current then
        arg1.onResize(arg1.ref.current)
    end
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return var1
