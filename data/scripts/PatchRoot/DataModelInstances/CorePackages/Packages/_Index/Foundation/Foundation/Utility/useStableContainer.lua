-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function useStableContainer()
    local var1 = React.useMemo(function(): Folder
        return Instance.new("Folder")
    end, {})

    React.useEffect(function()
        return function()
            var1:Destroy()
        end
    end, { var1 })

    return var1, (React.useCallback(function(arg1)
        var1.Parent = arg1
    end, { var1 }))
end

return useStableContainer
