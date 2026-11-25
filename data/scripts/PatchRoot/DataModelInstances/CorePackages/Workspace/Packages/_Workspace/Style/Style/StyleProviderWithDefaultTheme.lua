-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Style = script:FindFirstAncestor("Style")
local StyleParent = Style.Parent

local React = require(StyleParent.React)
local Cryo = require(StyleParent.Cryo)

local UIBlox = require(StyleParent.UIBlox)
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants
local UiModeStyleProvider = require(Style.UiModeStyleProvider)

local Foundation = require(StyleParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local useTokens = Foundation.Hooks.useTokens

local tbl1 = { withUiModeSupport = true, withDarkTheme = true }

return function(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    local bool1 = useTokens().Config ~= nil

    local element = React.createElement(
        if arg1.withUiModeSupport then UiModeStyleProvider else AppStyleProvider,
        {
            style = {
                themeName = if var1.withDarkTheme then ColorMode.Dark else ColorMode.Light,
                fontName = Constants.FontName.Gotham
            }
        },
        var1.children
    )

    if arg1.withUiModeSupport or bool1 then
        return element
    end

    return React.createElement(
        FoundationProvider,
        {
            colorMode = if var1.withDarkTheme then ColorMode.Dark else ColorMode.Light
        },
        element
    )
end
