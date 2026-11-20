-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)

local _RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local module = {}
module.__index = module

function module.new(_statType, _valueName)
    local result = {}
    setmetatable(result, module)

    result._frame = Instance.new("Frame")
    result._frame.Name = "PS_DecoratedValueLabel"
    result._frame.BackgroundTransparency = 1
    result._valueName = _valueName
    result._statType = _statType

    result._decorationFrame = Instance.new("Frame")
    result._decorationFrame.Name = "PS_Decoration"
    result._decorationFrame.Parent = result._frame
    result._decorationFrame.Position = UDim2.new(0, 0, 0.5, -StatsUtils.DecorationSize / 2)
    result._decorationFrame.Size = UDim2.new(0, StatsUtils.DecorationSize, 0, StatsUtils.DecorationSize)
    result._decorationFrame.BackgroundTransparency = 1

    result._label = Instance.new("TextLabel")
    result._label.Name = "Label"
    result._label.Parent = result._frame
    result._label.Position = UDim2.new(0, StatsUtils.DecorationSize + StatsUtils.DecorationMargin, 0, 0)
    result._label.Size = UDim2.new(1, -(StatsUtils.DecorationSize + StatsUtils.DecorationMargin), 1, 0)
    result._label.FontSize = StatsUtils.PanelValueFontSize
    result._label.TextXAlignment = Enum.TextXAlignment.Left
    result._label.TextYAlignment = Enum.TextYAlignment.Center

    StatsUtils.StyleTextWidget(result._label)

    return result
end

function module:SetZIndex(zIndex)
    self._frame.ZIndex = zIndex
    self._decorationFrame.ZIndex = zIndex
    self._label.ZIndex = zIndex
end

function module:PlaceInParent(arg1, size, position)
    self._frame.Parent = arg1
    self._frame.Size = size
    self._frame.Position = position
end

function module:GetDecorationFrame()
    return self._decorationFrame
end

function module:SetValue(arg1)
    local var1 = StatsUtils.FormatTypedValue(arg1, self._statType)
    self._label.Text = string.format("%s: %s", self._valueName, var1)
end

return module
