-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Parent.Roact)

local AppStyleProvider = require(scriptParentParent.App.Style.AppStyleProvider)
local FoundationProvider = require(scriptParentParent.Parent.Foundation).FoundationProvider

local _StyleTypes = require(scriptParentParent.App.Style.StyleTypes)

return function(arg1, settings)
    return Roact.createElement(
        FoundationProvider,
        {
            theme = "Dark",
            preferences = settings and {
                reducedMotion = settings.reducedMotion,
                preferredTransparency = settings.preferredTransparency
            } or nil
        },
        Roact.createElement(
            AppStyleProvider,
            {
                style = { themeName = "Dark", fontName = "Gotham", settings = settings }
            },
            {
                Content = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0) }, arg1)
            }
        )
    )
end
