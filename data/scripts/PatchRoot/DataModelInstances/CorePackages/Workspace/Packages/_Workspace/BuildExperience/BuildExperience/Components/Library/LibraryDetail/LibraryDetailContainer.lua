-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local React = require(BuildExperience.Parent.React)

local LibraryDetailView = require(script.Parent.LibraryDetailView)
local useLibraryDetailViewModel = require(script.Parent.useLibraryDetailViewModel)

local function LibraryDetailContainer(arg1)
    local var1 = useLibraryDetailViewModel(arg1)
    return React.createElement(LibraryDetailView, var1)
end

return LibraryDetailContainer
