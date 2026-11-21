-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local SlotBasedEditorContext = require(script.Parent.SlotBasedEditorContext)

local function useSlotBasedEditorContext()
    return (React.useContext(SlotBasedEditorContext))
end

return useSlotBasedEditorContext
