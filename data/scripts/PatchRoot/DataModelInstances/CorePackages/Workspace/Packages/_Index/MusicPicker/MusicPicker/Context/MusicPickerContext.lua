-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local React = require(MusicPickerParent.React)

local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

return (React.createContext({
    previewingId = nil,
    togglePreview = function() end,
    savedIds = {},
    toggleSaved = function() end
}))
