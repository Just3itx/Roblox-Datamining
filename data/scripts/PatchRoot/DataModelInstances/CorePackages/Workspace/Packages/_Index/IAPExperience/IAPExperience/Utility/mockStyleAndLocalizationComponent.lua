-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local UIBlox = require(scriptParentParentParent.UIBlox)
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants
local Dark = require(scriptParentParentParent.Foundation).Enums.ColorMode.Dark
local Gotham = Constants.FontName.Gotham

local LocaleProvider = require(scriptParentParent.Locale.LocaleProvider)

return function(arg1)
    return Roact.createElement(LocaleProvider, {
        locale = "en-us",
        render = function()
            return Roact.createElement(
                AppStyleProvider,
                {
                    style = { themeName = Dark, fontName = Gotham }
                },
                { Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0) }, arg1) }
            )
        end
    })
end
