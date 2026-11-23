-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local GalleryButtonContentView = require(script.Parent.GalleryButtonContentView)
local _Types = require(scriptParentParentParent.Types)

local useGalleryButtonContentViewModel = require(script.Parent.useGalleryButtonContentViewModel)

return React.memo(function(tbl1) -- name: GalleryButtonContent
    local var1 = useGalleryButtonContentViewModel(tbl1.latestCapture)

    return React.createElement(GalleryButtonContentView, var1)
end)
