-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local Cryo = InGameMenuDependencies.Cryo
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParent = script.Parent.Parent

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local var1 = t.strictInterface({
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    AnchorPoint = t.optional(t.Vector2),
    LayoutOrder = t.optional(t.integer),
    Visible = t.optional(t.boolean)
})

local function Divider(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                Divider = {
                    Color = arg2.Color.Stroke.Emphasis.Color3,
                    Transparency = arg2.Color.Stroke.Emphasis.Transparency
                }
            }
        }
    end, function(arg2)
        return Roact.createElement(
            "Frame",
            Cryo.Dictionary.join({
                Size = UDim2.new(1, 0, 0, 1)
            }, arg1, {
                BorderSizePixel = 0,
                BackgroundColor3 = arg2.Theme.Divider.Color,
                BackgroundTransparency = arg2.Theme.Divider.Transparency
            })
        )
    end)
end

return Divider
