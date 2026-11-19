-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

local function useDialogSize(tbl1)
    local var1, var2 = React.useBinding(Vector2.new(0, 0))

    React.useEffect(function()
        local current = tbl1.current
        if not current then
            return
        end

        local function updateDialogSize() -- Luacid: Inlined by compiler; 1 call site recovered
            local absoluteSize = current.AbsoluteSize
            if absoluteSize.X == 0 or absoluteSize.Y == 0 then
                return
            end
            var2(absoluteSize)
        end

        updateDialogSize()
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateDialogSize)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useDialogSize
