-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local shamrock = Color3.new(0.35, 0.55, 0.35)
local earthGreen = Color3.new(0.15, 0.35, 0.15)
local white = Color3.new(1, 1, 1)
local white2 = Color3.new(1, 1, 1)
local white3 = Color3.new(1, 1, 1)

local uDim2 = UDim2.new(0, 0, 0, 0)

local uDim2_2 = UDim2.new(1, -18, 0, 2)
local uDim2_3 = UDim2.new(0, 16, 0, 16)

local uDim2_4 = UDim2.new(1, -100, 0, 0)
local uDim2_5 = UDim2.new(0, 100, 0, 20)

local _CoreGui = game:GetService("CoreGui")

local function __StyleAndSizeButton(_button) -- Luacid: Inlined by compiler; 1 call site recovered
    _button.TextXAlignment = Enum.TextXAlignment.Center
    _button.TextColor3 = white
    _button.BackgroundTransparency = 1
    _button.BorderColor3 = white3
    _button.BorderSizePixel = 1

    _button.Position = uDim2_2
    _button.Size = uDim2_3
end

local function __StyleAndSizeLabel(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1.TextXAlignment = Enum.TextXAlignment.Left
    arg1.TextColor3 = white
    arg1.BackgroundTransparency = 1

    arg1.Position = UDim2.new(0, 5, 0, 0)
    arg1.Size = UDim2.new(1, -10, 1, 0)
end

local function __StyleRowCellFrame(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.BorderColor3 = white2
    arg1.BorderSizePixel = 1
    arg1.BackgroundTransparency = 0.6
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(_treeViewItem)
    local result = {}
    setmetatable(result, tbl1)

    result._treeViewItem = _treeViewItem

    result._expanded = true
    result._expansionToggleCallback = nil

    result._frame = Instance.new("Frame")
    result._frame.Name = "MemoryAnalyzerRowClassFrame"
    result._frame.BackgroundTransparency = 1

    result._buttonFrame = Instance.new("Frame")
    result._buttonFrame.Name = "ButtonFrame"
    result._buttonFrame.Parent = result._frame
    result._buttonFrame.Position = uDim2
    local xOffset = (1 + _treeViewItem:getStackDepth()) * 20
    result._buttonFrame.Size = UDim2.new(0, xOffset, 0, 20)
    __StyleRowCellFrame(result._buttonFrame)

    result._button = Instance.new("TextButton")
    result._button.Name = "Button"
    result._button.Parent = result._buttonFrame
    __StyleAndSizeButton(result._button)

    result._button.MouseButton1Click:connect(function()
        result:__toggleExpansion()
    end)

    result:__updateButtonState()

    result._labelFrame = Instance.new("Frame")
    result._labelFrame.Name = "LabelFrame"
    result._labelFrame.Parent = result._frame

    result._labelFrame.Position = UDim2.new(0, xOffset, 0, 0)
    result._labelFrame.Size = UDim2.new(1, -xOffset - 100, 0, 20)
    __StyleRowCellFrame(result._labelFrame)

    result._labelTextLabel = Instance.new("TextLabel")
    result._labelTextLabel.Name = "Label"
    result._labelTextLabel.Parent = result._labelFrame
    __StyleAndSizeLabel(result._labelTextLabel)

    result._labelTextLabel.Text = _treeViewItem:getLabel()

    result._valueFrame = Instance.new("Frame")
    result._valueFrame.Name = "ValueFrame"
    result._valueFrame.Parent = result._frame
    result._valueFrame.Position = uDim2_4
    result._valueFrame.Size = uDim2_5
    __StyleRowCellFrame(result._valueFrame)

    result._valueTextLabel = Instance.new("TextLabel")
    result._valueTextLabel.Name = "Value"
    result._valueTextLabel.Parent = result._valueFrame
    __StyleAndSizeLabel(result._valueTextLabel)

    result._valueHasBeenNonZero = false
    result:updateValue()

    return result
end

function tbl1:isExpanded()
    return self._expanded
end

function tbl1:valueHasBeenNonZero()
    return self._valueHasBeenNonZero
end

function tbl1:setExpansionToggleCallback(_expansionToggleCallback)
    self._expansionToggleCallback = _expansionToggleCallback
end

function tbl1:__toggleExpansion()
    self._expanded = not self._expanded
    self:__updateButtonState()
    if self._expansionToggleCallback ~= nil then
        self._expansionToggleCallback()
    end
end

function tbl1:__updateButtonState()
    if #self._treeViewItem:getChildren() == 0 then
        self._button.Visible = false
        return
    end
    self._button.Visible = true
    if self._expanded then
        self._button.Text = "-"
        return
    end
    self._button.Text = "+"
end

function tbl1:updateValue()
    if self._treeViewItem:getValue() >= 0.001 then
        self._valueHasBeenNonZero = true
    end

    self._valueTextLabel.Text = string.format("%.3f", self._treeViewItem:getValue())
end

function tbl1:setZIndex(zIndex)
    self._frame.ZIndex = zIndex
    self._labelTextLabel.ZIndex = zIndex
    self._valueTextLabel.ZIndex = zIndex
end

function tbl1:setRowValue(arg1)
    self._valueTextLabel.Text = string.format("%.3f", arg1)
end

function tbl1:getFrame()
    return self._frame
end

function tbl1:setRowNumber(arg1)
    if arg1 % 2 == 1 then
        self._buttonFrame.BackgroundColor3 = shamrock
        self._labelFrame.BackgroundColor3 = shamrock
        self._valueFrame.BackgroundColor3 = shamrock
        return
    end
    self._buttonFrame.BackgroundColor3 = earthGreen
    self._labelFrame.BackgroundColor3 = earthGreen
    self._valueFrame.BackgroundColor3 = earthGreen
end

local module = {}
module.__index = module

module.Indent = string.rep(" ", 4)

function module.new(arg1)
    local result = {}
    setmetatable(result, module)

    result._frame = Instance.new("Frame")
    result._frame.Name = "MemoryAnalyzerClassFrame"
    result._frame.ZIndex = arg1.ZIndex
    result._frame.BackgroundTransparency = 1

    result._rowsByTreeViewItem = {}

    result._layoutDirty = false

    result._heightChangedCallback = nil
    result._heightInPix = 0

    result._frame.Parent = arg1

    return result
end

function module:getMemoryUsageTree()
    return nil
end

function module:setHeightChangedCallback(_heightChangedCallback)
    self._heightChangedCallback = _heightChangedCallback
end

function module:__getOrMakeRowForTreeViewItem(arg1)
    if self._rowsByTreeViewItem[arg1] == nil then
        local var1 = tbl1.new(arg1)
        var1:setExpansionToggleCallback(function()
            self:__layoutRows()
        end)
        var1:getFrame().Parent = self._frame

        self._rowsByTreeViewItem[arg1] = var1
        self._layoutDirty = true
    end
    return self._rowsByTreeViewItem[arg1]
end

function module:__recursiveUpdateStatValue(arg1)
    self:__getOrMakeRowForTreeViewItem(arg1):updateValue()

    local children = arg1:getChildren()
    for _, child in ipairs(children) do
        self:__recursiveUpdateStatValue(child)
    end
end

function module:renderUpdates()
    local memoryUsageTree = self:getMemoryUsageTree()
    if memoryUsageTree ~= nil then
        self:__recursiveUpdateStatValue(memoryUsageTree)
    end

    if self._layoutDirty then
        self:__layoutRows()
    end
end

function module:__layoutRows()
    self._layoutDirty = false
    self._heightInPix = 0

    if self:getMemoryUsageTree() ~= nil then
        self:__recursiveLayoutTreeViewItem(self:getMemoryUsageTree(), true)
    end

    self._frame.Size = UDim2.new(1, 0, 0, self._heightInPix)
    self._frame.Position = UDim2.new(0, 0, 0, 0)

    if self._heightChangedCallback then
        self._heightChangedCallback(self._heightInPix)
    end
end

function module:__recursiveLayoutTreeViewItem(arg1, arg2)
    local var1 = self:__getOrMakeRowForTreeViewItem(arg1)
    local frame = var1:getFrame()

    arg2 = arg2 and var1:valueHasBeenNonZero()

    if arg2 then
        frame.Visible = true
        frame.Size = UDim2.new(1, 0, 0, 20)
        frame.Position = UDim2.new(0, 0, 0, self._heightInPix)
        var1:setZIndex(self._frame.ZIndex)
        var1:setRowNumber(self._heightInPix / 20)

        self._heightInPix += 20
    else
        frame.Visible = false
    end

    local children = arg1:getChildren()
    for _, child in ipairs(children) do
        self:__recursiveLayoutTreeViewItem(child, var1:isExpanded() and arg2)
    end
end

function module:getHeightInPix()
    return self._heightInPix
end

return module
