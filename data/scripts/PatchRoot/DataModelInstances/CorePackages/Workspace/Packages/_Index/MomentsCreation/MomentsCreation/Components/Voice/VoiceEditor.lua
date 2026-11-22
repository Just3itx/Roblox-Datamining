-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local React = require(MomentsCreationParent.React)

local VoiceEditorView = require(script.Parent.VoiceEditorView)
local useVoiceEditorViewModel = require(script.Parent.useVoiceEditorViewModel)

local function VoiceEditor(arg1)
    local var1 = useVoiceEditorViewModel(arg1)
    return React.createElement(VoiceEditorView, var1)
end

return VoiceEditor
