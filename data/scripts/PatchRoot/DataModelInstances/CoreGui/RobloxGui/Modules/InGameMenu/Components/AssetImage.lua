-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local Cryo = InGameMenuDependencies.Cryo
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParent = script.Parent.Parent

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local Assets = require(scriptParentParent.Resources.Assets)

local function makeAssetImageComponent(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Roact.forwardRef(function(arg2, arg3)
        local imageKey = arg2.imageKey
        local image = Assets.Images[imageKey]

        local var2 = typeof(image) == "string" and { Image = image } or image

        local var3 = Cryo.Dictionary.join(arg2, { imageKey = Cryo.None }, var2, { BackgroundTransparency = 1 })

        return Roact.createElement(arg1, Cryo.Dictionary.join(var3, { [Roact.Ref] = arg3 }))
    end)
end

return {
    Label = makeAssetImageComponent(ImageSetLabel),
    Button = makeAssetImageComponent(ImageSetButton)
}
