-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent

local React = require(ComponentsParentParent.React)
local Dash = require(ComponentsParentParent.Dash)

local InlineElementType = require(ComponentsParent.Utils.InlineElementType)
local _RenderableInlineElement = require(ComponentsParent.Components.InlineLayout.InlineLayoutElements.RenderableInlineElement)
local HardBreakElement = require(ComponentsParent.Components.InlineLayout.InlineLayoutElements.HardBreakElement)
local isInlineElement = require(ComponentsParent.Utils.isInlineElement)
local renderInMeasuredFrame = require(ComponentsParent.Utils.renderInMeasuredFrame)

local module = {}
module.__index = module
module.__type = InlineElementType

local function getSplitPoint(elements, num1: number)
    local num2 = 0
    for k, element in elements do
        local width = element:getWidth()
        if num1 < num2 + width then
            return k, num1 - num2
        end
        num2 += width
    end
    return -1, -1
end

local function handleSplitTrailingElement(arg1, arg2, arg3, num1: number, bool1: boolean, bool2: boolean?) -- Luacid: unused: defined but never referenced
    local var1 = nil

    if bool1 then
        return var1, arg3
    end

    if not (arg3.canForceSplit and bool2) then
        return arg1, arg2
    end

    local var2, var3 = arg3:split(num1, true)
    return var2, var3
end

function module.new(wrapperElement: (...any) -> (...any), wrapperElementProps, tbl1, startingIndex: number?)
    local self = setmetatable({}, module)
    self.WrapperElement = wrapperElement
    self.wrapperElementProps = wrapperElementProps
    self.Elements = {}
    self.startingIndex = startingIndex or 1
    for _, value in tbl1 do
        if not isInlineElement(value) or value == HardBreakElement then
            warn("InlineSpanElement: invalid element provided. Only non inline elements, excluding HardBreakElement, are allowed.")
        else
            table.insert(self.Elements, value)
        end
    end

    if #self.Elements == 0 then
        warn("InlineSpanElement: no elements provided")
    end
    self.canForceSplit = #self.Elements > 0 and self.Elements[#self.Elements].canForceSplit
    return self
end

function module:getWidth()
    return Dash.sum(Dash.map(self.Elements, function(arg1)
        return arg1:getWidth()
    end))
end

function module:_splitChildAtIndex(num1: number, num2: number)
    local var1, var2 = self.Elements[num1]:split(num2, false)

    return var1, var2, var1:getWidth() <= num2
end

function module:split(num1: number, bool1: boolean?)
    local tbl1 = {}
    local tbl2 = {}

    local var1, num2 = getSplitPoint(self.Elements, num1)
    if var1 == -1 then
        return self, nil
    end
    local var2 = var1 + 1

    local var3, var4, var5 = self:_splitChildAtIndex(var1, num2)
    if not var5 then
        local element = self.Elements[var1]

        if var1 > 1 then
            var4 = element
            var3 = nil
        elseif element.canForceSplit and bool1 then
            var3, var4 = element:split(num2, true)
        end
    end

    if var1 > 1 then
        table.move(self.Elements, 1, var1 - 1, 1, tbl1)
    end
    if var3 then
        table.insert(tbl1, var3)

        var2 -= 1
    end
    if var4 then
        table.insert(tbl2, var4)
    end
    if var1 < #self.Elements then
        table.move(self.Elements, var1 + 1, #self.Elements, #tbl2 + 1, tbl2)
    end

    local module2 = module.new(self.WrapperElement, self.wrapperElementProps, tbl1, self.startingIndex)
    if #tbl2 > 0 then
        return module2, (module.new(self.WrapperElement, self.wrapperElementProps, tbl2, var2))
    end

    return module2, nil
end

function module:trimStart()
    for k, element in self.Elements do
        local var1 = if element.trimStart then element:trimStart() else element

        if var1 == element and k == 1 then
            return self
        end
        if var1 == nil then
            continue
        end

        local tbl1 = { var1 }
        table.move(self.Elements, k + 1, #self.Elements, 2, tbl1)
        return module.new(self.WrapperElement, self.wrapperElementProps, tbl1, self.startingIndex + k - 1)
    end

    return nil
end

function module:render(id, layoutOrder: number)
    local var1 = Dash.map(self.Elements, function(arg2, arg3)
        return renderInMeasuredFrame(arg2:render(`{id}-{self.startingIndex + arg3 - 1}`, arg3), arg2:getWidth(), arg3)
    end)

    return React.createElement(
        self.WrapperElement,
        Dash.join(self.wrapperElementProps, { id = id, LayoutOrder = layoutOrder }),
        var1
    )
end

return module
