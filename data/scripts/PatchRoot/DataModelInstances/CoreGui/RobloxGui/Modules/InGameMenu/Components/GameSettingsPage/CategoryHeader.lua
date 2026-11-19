-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local ThemedTextLabel = require(script.Parent.Parent.ThemedTextLabel)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local var1 = t.strictInterface({ LayoutOrder = t.integer, localizationKey = t.string })

return function(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = arg1.LayoutOrder,
            Size = UDim2.new(1, 0, 0, 36)
        },
        {
            Label = withLocalization({ text = arg1.localizationKey })(function(arg2)
                return Roact.createElement(ThemedTextLabel, {
                    fontKey = "Footer",
                    themeKey = "TextEmphasis",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(1, -48, 0, 14),
                    Text = arg2.text,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            end)
        }
    )
end
