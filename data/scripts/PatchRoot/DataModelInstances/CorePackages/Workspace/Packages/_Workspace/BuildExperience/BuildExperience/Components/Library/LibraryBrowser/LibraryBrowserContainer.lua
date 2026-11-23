-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local LibraryBrowserView = require(script.Parent.LibraryBrowserView)
local useLibraryBrowserViewModel = require(script.Parent.useLibraryBrowserViewModel)

local function LibraryBrowserContainer(arg1)
    local var1 = useLibraryBrowserViewModel(arg1)
    return React.createElement(LibraryBrowserView, var1)
end

return LibraryBrowserContainer
