-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)

local Sizing = require(script.Parent.Parent.Sizing)

local function useBubbleTextConstraint()
    local contentMaxWidth = Sizing.useSizing().bubble.contentMaxWidth
    return React.useMemo(function()
        return {
            MinSize = Vector2.new(0, 0),
            MaxSize = Vector2.new(contentMaxWidth, math.huge)
        }
    end, { contentMaxWidth })
end

return useBubbleTextConstraint
