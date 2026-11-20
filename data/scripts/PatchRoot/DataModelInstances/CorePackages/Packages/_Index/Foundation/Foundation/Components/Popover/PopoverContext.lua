-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Logger = require(Foundation.Utility.Logger)
local React = require(FoundationParent.React)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local _Types = require(Foundation.Components.Types)

return React.createContext({
    anchor = nil,
    setAnchor = function(_)
        Logger:warning("No PopoverProvider found for Popover")
    end,
    anchorUri = nil,
    setAnchorUri = function(_)
        Logger:warning("No PopoverProvider found for Popover")
    end,
    isOpen = false,
    testId = ""
})
