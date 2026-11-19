-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local GlobalConfig = require(scriptParentParentParent.GlobalConfig)
local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local var1 = t.strictInterface({ Position = t.UDim2, Size = t.UDim2, AnchorPoint = t.Vector2 })

return function(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withLocalization({ lockedText = "CoreScripts.InGameMenu.GameSettings.LockedByDeveloper" })(function(arg2)
        return Roact.createElement(ThemedTextLabel, {
            themeKey = "TextDefault",
            fontKey = "CaptionBody",
            TextTransparency = 0.5,
            Text = arg2.lockedText,
            Size = UDim2.new(1, -72, 0.25, 0),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom
        })
    end)
end
