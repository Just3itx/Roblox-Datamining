-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local function useScrollToTopAfterRestore()
    local scrollingFrameRef = React.useRef(nil)

    local scrollToTopAfterRestore = React.useCallback(function()
        local current = scrollingFrameRef.current
        if current == nil then
            return
        end

        task.defer(function()
            if scrollingFrameRef.current ~= current then
                return
            end

            current.CanvasPosition = Vector2.new(0, 0)
        end)
    end, {})

    return React.useMemo(function()
        return {
            scrollingFrameRef = scrollingFrameRef,
            scrollToTopAfterRestore = scrollToTopAfterRestore
        }
    end, { scrollingFrameRef, scrollToTopAfterRestore })
end

return useScrollToTopAfterRestore
