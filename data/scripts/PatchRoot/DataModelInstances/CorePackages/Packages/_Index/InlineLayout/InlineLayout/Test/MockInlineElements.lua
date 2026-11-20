-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineLayout = script:FindFirstAncestor("InlineLayout")
local InlineLayoutParent = InlineLayout.Parent

local React = require(InlineLayoutParent.React)
local InlineElementType = require(InlineLayout.Utils.InlineElementType)

local MockInlineElement = {}
MockInlineElement.__index = MockInlineElement
MockInlineElement.__type = InlineElementType

function MockInlineElement.new(width: number, canForceSplit: boolean?)
    local self = setmetatable({}, MockInlineElement)
    self.width = width
    self.canForceSplit = canForceSplit
    return self
end

function MockInlineElement:getWidth()
    return self.width
end

function MockInlineElement:split(_: number, _: boolean?)
    return MockInlineElement.new(self.width, self.canForceSplit)
end

function MockInlineElement:render(arg1, layoutOrder: number)
    return React.createElement("TextLabel", {
        key = tostring(layoutOrder),
        LayoutOrder = layoutOrder,
        Size = UDim2.fromOffset(self.width, 20),
        Text = `{arg1}`
    })
end

local SplittableMockInlineElement = {}
SplittableMockInlineElement.__index = SplittableMockInlineElement
SplittableMockInlineElement.__type = InlineElementType

function SplittableMockInlineElement.new(width: number, canForceSplit: boolean?)
    local self = setmetatable({}, SplittableMockInlineElement)
    self.width = width
    self.canForceSplit = canForceSplit
    return self
end

function SplittableMockInlineElement:getWidth()
    return self.width
end

function SplittableMockInlineElement:split(num1: number, bool1: boolean?)
    local num2 = math.floor(self.width / 2)

    local var1 = self.width - num2

    if bool1 and num1 < num2 then
        var1 = self.width - num1
    else
        num1 = num2
    end

    return SplittableMockInlineElement.new(num1, self.canForceSplit), (SplittableMockInlineElement.new(var1, self.canForceSplit))
end

function SplittableMockInlineElement:render(arg1, layoutOrder: number)
    return React.createElement("TextLabel", {
        key = tostring(layoutOrder),
        LayoutOrder = layoutOrder,
        Size = UDim2.fromOffset(self.width, 20),
        Text = `{arg1}`
    })
end

return {
    MockInlineElement = MockInlineElement,
    SplittableMockInlineElement = SplittableMockInlineElement
}
