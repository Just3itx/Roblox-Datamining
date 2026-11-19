-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParent = script.Parent.Parent

local Assets = require(scriptParentParent.Resources.Assets)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local var1 = t.strictInterface({ onClick = t.callback })

local function OpenMenuButton(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return Roact.createElement(ImageSetButton, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Assets.Images.RobloxLogo,
        Position = UDim2.new(0, 50, 0.5, 0),
        Size = UDim2.new(0, 32, 0, 32),
        [Roact.Event.Activated] = arg1.onClick
    })
end

return OpenMenuButton
