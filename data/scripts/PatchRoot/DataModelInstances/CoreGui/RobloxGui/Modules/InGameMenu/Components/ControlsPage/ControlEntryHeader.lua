-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:38Z
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

local var1 = t.strictInterface({ title = t.string, LayoutOrder = t.integer })

local function ControlEntry(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withLocalization({ title = arg1.title })(function(arg2)
        return Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 45),
                BackgroundTransparency = 1,
                LayoutOrder = arg1.LayoutOrder
            },
            {
                HeaderText = Roact.createElement(ThemedTextLabel, {
                    fontKey = "CaptionHeader",
                    themeKey = "TextMuted",
                    Text = arg2.title,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 0, 0, 20),
                    Size = UDim2.new(1, 0, 0, 17)
                })
            }
        )
    end)
end
return ControlEntry
