-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local function useExpressionTrayController(tbl1)
    local categoryGroups = tbl1.categoryGroups

    local isOpen, var2 = React.useState(false)
    local activeGroupId, onGroupActivated = React.useState("")

    React.useEffect(function()
        onGroupActivated(function(categoryGroupId: string)
            for _, categoryGroup in categoryGroups do
                if categoryGroup.categoryGroupId == categoryGroupId then
                    return categoryGroupId
                end
            end
            return if #categoryGroups > 0 then categoryGroups[1].categoryGroupId else ""
        end)
    end, { categoryGroups })

    return {
        isOpen = isOpen,
        activeGroupId = activeGroupId,
        onEntryActivated = React.useCallback(function()
            var2(function(bool1: boolean): boolean
                return not bool1
            end)
        end, {}),
        onGroupActivated = onGroupActivated,
        close = React.useCallback(function()
            var2(false)
        end, {})
    }
end

return useExpressionTrayController
