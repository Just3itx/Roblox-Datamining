-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local Checkbox = require(script.Parent.Checkbox)
local _MainWindow = Constants.DefaultFontSize.MainWindow
local _ConstantsColorText = Constants.Color.Text
local _MainWindow2 = Constants.Font.MainWindow
local _MainWindowBold = Constants.Font.MainWindowBold
local CheckboxHeight = Constants.UtilityBarFormatting.CheckboxHeight
local _CheckboxInnerPadding = Constants.UtilityBarFormatting.CheckboxInnerPadding

local function CellCheckbox(tbl1)
    local isSelected = tbl1.isSelected
    local size = tbl1.size
    local pos = tbl1.pos
    local layoutOrder = tbl1.LayoutOrder

    return Roact.createElement(
        "Frame",
        { Size = size, Position = pos, BackgroundTransparency = 1, LayoutOrder = layoutOrder },
        {
            Checkbox = Roact.createElement(Checkbox, {
                Name = tbl1.name,
                IsSelected = isSelected,
                Size = UDim2.new(0, CheckboxHeight, 0, CheckboxHeight),
                Position = UDim2.new(0, 0, 0.5, -CheckboxHeight / 2),
                OnSelectedStateChanged = tbl1.OnCheckboxClicked
            })
        }
    )
end
return CellCheckbox
