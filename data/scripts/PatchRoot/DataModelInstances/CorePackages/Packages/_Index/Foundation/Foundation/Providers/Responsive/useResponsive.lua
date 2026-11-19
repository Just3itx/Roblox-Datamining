-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local ResponsiveContext = require(script.Parent.ResponsiveContext)

local function useResponsive()
    return React.useContext(ResponsiveContext)
end

return useResponsive
