-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local function useMenuItemCursor()
    local var1 = Foundation.Hooks.useTokens()
    return React.useMemo(function()
        return {
            radius = UDim.new(0, var1.Radius.Small),
            offset = var1.Size.Size_200,
            borderWidth = var1.Stroke.Thicker
        }
    end, { var1 })
end

return useMenuItemCursor
