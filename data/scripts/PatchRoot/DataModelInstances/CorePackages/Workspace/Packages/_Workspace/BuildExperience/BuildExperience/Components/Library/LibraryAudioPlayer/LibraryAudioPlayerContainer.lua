-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local React = require(BuildExperience.Parent.React)
local LibraryAudioPlayerView = require(script.Parent.LibraryAudioPlayerView)
local useLibraryAudioPlayerViewModel = require(script.Parent.useLibraryAudioPlayerViewModel)

local function LibraryAudioPlayerContainer(arg1)
    local var1 = useLibraryAudioPlayerViewModel(arg1)
    return React.createElement(LibraryAudioPlayerView, var1)
end

return LibraryAudioPlayerContainer
