-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local React = require(FoundationParent.React)

local context = React.createContext({ isIconSize = false, colorNamespace = ColorNamespace.Color })

return {
    Provider = context.Provider,
    usePresentationContext = function()
        return React.useContext(context)
    end
}
