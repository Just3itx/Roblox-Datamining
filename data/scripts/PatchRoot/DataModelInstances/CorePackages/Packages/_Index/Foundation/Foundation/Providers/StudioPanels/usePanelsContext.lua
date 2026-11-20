-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local PanelsContext = require(script.Parent.PanelsContext)
local _Types = require(script.Parent.Types)

local function usePanelsContext()
    local var1 = React.useContext(PanelsContext)
    if var1 == nil then
        error("usePanelsContext must be used within a PanelsContext")
    end
    return var1
end

return usePanelsContext
