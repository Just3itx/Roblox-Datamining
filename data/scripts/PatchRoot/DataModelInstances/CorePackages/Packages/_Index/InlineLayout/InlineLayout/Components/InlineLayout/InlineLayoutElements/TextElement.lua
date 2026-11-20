-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParentParent = script:FindFirstAncestor("Components").Parent.Parent
local InlineLayoutElements = script:FindFirstAncestor("InlineLayoutElements")

local Dash = require(ComponentsParentParent.Dash)
local Foundation = require(ComponentsParentParent.Foundation)

local BaseTextElement = require(InlineLayoutElements.BaseTextElement)
local FoundationText = Foundation.Text

local module = {}

function mapProps(arg1)
    return Dash.join(
        Dash.omit(arg1, { "id", "EngineTags" }),
        {
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
    )
end

function module.new(arg1)
    return BaseTextElement.new(FoundationText, arg1, mapProps)
end

return module
