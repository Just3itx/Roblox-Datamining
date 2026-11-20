-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent

local React = require(ComponentsParentParent.React)

local Dash = require(ComponentsParentParent.Dash)

local InlineElementType = require(ComponentsParent.Utils.InlineElementType)

local join = Dash.join

local module = {}
module.__index = module
module.__type = InlineElementType

function module.new(element, props, mapProps)
    local self = setmetatable({}, module)
    self.props = props
    self.mapProps = mapProps or Dash.identity
    self.Element = element
    return self
end

function module:getWidth()
    return self.props.Size.Width.Offset
end

function module:split()
    return module.new(self.Element, join(self.props))
end

function module:render(id: string, layoutOrder: number)
    return React.createElement(
        self.Element,
        self.mapProps(Dash.assign(self.props, { id = id, key = tostring(layoutOrder), LayoutOrder = layoutOrder }))
    )
end

return module
