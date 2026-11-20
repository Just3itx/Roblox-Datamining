-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _Types = require(script.Parent.Types)
local WidgetsContext = require(script.Parent.WidgetsContext)

local function useWidgetsContext()
    local var1 = React.useContext(WidgetsContext)
    if var1 == nil then
        error("useWidgetsContext must be used within a WidgetsProvider")
    end
    return var1
end

return useWidgetsContext
