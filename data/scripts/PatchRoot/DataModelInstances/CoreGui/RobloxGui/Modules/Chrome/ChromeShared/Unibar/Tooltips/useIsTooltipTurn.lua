-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local TooltipContext = require(script.Parent.TooltipContext)
local _TooltipProvider = require(script.Parent.TooltipProvider)

function useIsTooltipTurn(str1: string)
    local var1 = React.useContext(TooltipContext)

    return var1 and var1.isCurrentTooltip(str1)
end

return useIsTooltipTurn
