-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindowHeader2 = Constants.DefaultFontSize.MainWindowHeader
local ConstantsColorText = Constants.Color.Text

local function HeaderButton(tbl1)
    local text = tbl1.text
    local size = tbl1.size
    local pos = tbl1.pos
    local sortfunction = tbl1.sortfunction

    local createElement = Roact.createElement
    local tbl2 = {
        Text = text,
        TextSize = MainWindowHeader2,
        TextColor3 = ConstantsColorText,
        Font = MainWindowHeader,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = size,
        Position = pos,
        BackgroundTransparency = 1
    }
    tbl2[Roact.Event.Activated] = function()
        if sortfunction then
            sortfunction(text)
        end
    end

    return createElement("TextButton", tbl2)
end

return HeaderButton
