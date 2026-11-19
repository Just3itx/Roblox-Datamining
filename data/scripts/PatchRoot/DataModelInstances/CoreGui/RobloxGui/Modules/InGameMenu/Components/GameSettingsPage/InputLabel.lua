-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent
local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local var1 = t.strictInterface({
    AnchorPoint = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    Size = t.optional(t.UDim2),
    localizationKey = t.string,
    LayoutOrder = t.optional(t.number)
})

return function(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withLocalization({ text = arg1.localizationKey })(function(arg2)
        return Roact.createElement(ThemedTextLabel, {
            fontKey = "Body",
            themeKey = "TextDefault",
            LayoutOrder = arg1.LayoutOrder,
            AnchorPoint = arg1.AnchorPoint or Vector2.new(0, 0.5),
            Position = arg1.Position or UDim2.new(0, 0, 0.5, 0),
            Size = arg1.Size or UDim2.new(1, -72, 0.5, 0),
            Text = arg2.text,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end)
end
