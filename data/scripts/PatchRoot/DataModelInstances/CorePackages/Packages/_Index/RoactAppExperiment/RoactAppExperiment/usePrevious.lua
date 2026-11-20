-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactAppExperiment = script:FindFirstAncestor("RoactAppExperiment")

local React = require(RoactAppExperiment.Parent.React)

local function usePrevious(current)
    local var1 = React.useRef(nil)
    React.useEffect(function()
        var1.current = current
    end)
    return var1.current
end

return usePrevious
