-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local createImageSetComponent = require(script.Parent.createImageSetComponent)

local scriptParentParentParent = script.Parent.Parent.Parent
local ImagesResolutionScale = require(scriptParentParentParent.App.ImageSet.Images).ImagesResolutionScale

return {
    Button = createImageSetComponent("ImageButton", ImagesResolutionScale),
    Label = createImageSetComponent("ImageLabel", ImagesResolutionScale)
}
