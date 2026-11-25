-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local React = require(SocialCommonParent.React)

local InputUtilities = require(SocialCommon.Utils.InputUtilities)

return function()
    local var1, var2 = React.useState(false)

    return var1, React.useCallback(function(_, arg1)
        if InputUtilities.isPointerInput(arg1) then
            var2(true)
        end
    end, { var2 }), (React.useCallback(function(_, arg1)
        if InputUtilities.isPointerInput(arg1) then
            var2(false)
        end
    end, { var2 }))
end
