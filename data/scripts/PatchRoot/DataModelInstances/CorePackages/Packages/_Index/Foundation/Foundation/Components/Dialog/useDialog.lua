-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _DialogSize = require(Foundation.Enums.DialogSize)

local DialogContext = require(script.Parent.DialogContext)

local function useDialog()
    return React.useContext(DialogContext)
end

return useDialog
