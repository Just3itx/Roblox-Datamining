-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent
local React = require(CustomFormsParent.React)
local Foundation = require(CustomFormsParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local ReactRoblox = require(CustomFormsParent.Dev.ReactRoblox)
local LocalizationProvider = require(CustomFormsParent.Localization).LocalizationProvider
local CustomFormTestlocalization = require(script.Parent.Form["CustomForm.testlocalization"])

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

return {
    name = "CustomForms",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1
                },
                {
                    UIPadding = React.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, 10),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingLeft = UDim.new(0, 10),
                        PaddingRight = UDim.new(0, 10)
                    }),
                    LocalizationContext = React.createElement(LocalizationProvider, {
                        localization = CustomFormTestlocalization
                    }, {
                        FoundationContext = React.createElement(FoundationProvider, {
                            colorMode = tbl1[arg2.theme],
                            device = Device[arg2.platform],
                            preferences = arg2.settings,
                            scale = arg2.settings and arg2.settings.scale
                        }, {
                            Child = React.createElement(arg1, arg2)
                        })
                    })
                }
            )
        end
    end
}
