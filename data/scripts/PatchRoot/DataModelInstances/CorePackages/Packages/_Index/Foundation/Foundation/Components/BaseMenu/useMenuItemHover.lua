-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local function useMenuItemHover(tbl1)
    React.useEffect(function()
        if tbl1.itemRef.current == nil then
            return
        end
        if typeof(tbl1.itemRef.current) ~= "Instance" then
            return
        end

        local connection = tbl1.itemRef.current:GetPropertyChangedSignal("GuiState"):Connect(function()
            if not tbl1.isSubmenu then
                if tbl1.itemRef.current.GuiState == Enum.GuiState.Hover and tbl1.hoverCloseAtDepth then
                    tbl1.hoverCloseAtDepth(tbl1.depth)
                end

                return
            end

            if tbl1.isDisabled then
                return
            end

            if tbl1.itemRef.current.GuiState == Enum.GuiState.Hover then
                if tbl1.hoverOpenAtDepth then
                    tbl1.hoverOpenAtDepth(tbl1.depth, tbl1.id)
                end
            elseif tbl1.hoverCloseAtDepth then
                tbl1.hoverCloseAtDepth(tbl1.depth)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, {
        tbl1.isSubmenu,
        tbl1.isDisabled,
        tbl1.id,
        tbl1.depth,
        tbl1.hoverCloseAtDepth,
        tbl1.hoverOpenAtDepth,
        tbl1.itemRef
    })
end

return useMenuItemHover
