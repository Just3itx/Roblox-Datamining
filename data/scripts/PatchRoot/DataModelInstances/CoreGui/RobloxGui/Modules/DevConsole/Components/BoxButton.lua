-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindowHeader2 = Constants.DefaultFontSize.MainWindowHeader
local ConstantsColorText = Constants.Color.Text
local UnselectedGray = Constants.Color.UnselectedGray
local InactiveBox = Constants.Color.InactiveBox

local function BoxButton(tbl1)
    local text = tbl1.text
    local size = tbl1.size
    local pos = tbl1.pos
    local _onClicked = tbl1.onClicked
    local var1 = typeof(tbl1.enabled) ~= "boolean" or tbl1.enabled

    local var2 = React.useCallback(function()
        tbl1.onClicked(tbl1.text)
    end, { tbl1.onClicked, tbl1.text })

    return Roact.createElement("TextButton", {
        Text = text,
        TextSize = MainWindowHeader2,
        TextColor3 = ConstantsColorText,
        Font = MainWindowHeader,
        Size = size,
        Position = pos,
        AutoButtonColor = var1,
        BackgroundColor3 = if var1 then UnselectedGray else InactiveBox,
        Active = var1,
        BackgroundTransparency = 0,
        [Roact.Event.Activated] = var2
    })
end

return BoxButton
