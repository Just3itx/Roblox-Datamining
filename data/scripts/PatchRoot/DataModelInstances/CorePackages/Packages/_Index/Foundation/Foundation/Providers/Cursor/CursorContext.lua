-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Logger = require(Foundation.Utility.Logger)
local React = require(FoundationParent.React)

local _CursorType = require(Foundation.Enums.CursorType)

local _Types = require(Foundation.Components.Types)

return (React.createContext({
    refCache = {},
    setMountedCursors = function(_: (...any) -> (...any))
        Logger:warning("No Cursor Provider found")
    end,
    getCursor = function(_)
        Logger:warning("No Cursor Provider found")
    end
}))
