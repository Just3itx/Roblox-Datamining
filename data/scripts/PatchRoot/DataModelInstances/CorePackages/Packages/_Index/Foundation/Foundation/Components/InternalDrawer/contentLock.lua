-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    lock = function(arg1, arg2, arg3)
        local tbl1 = ({})
        local tbl2 = {}
        local bool1 = false

        local tbl3 = ({})

        local function writeLocked(arg4) -- Luacid: Inlined by compiler; 2 call sites recovered
            if not arg4.Active then
                return
            end
            tbl3[arg4] = false
            arg4.Active = false
        end

        local function suppress(arg4)
            if tbl1[arg4] ~= nil then
                return
            end
            tbl1[arg4] = arg4.Active

            local tbl4 = tbl2
            local activeChanged = arg4:GetPropertyChangedSignal("Active")

            table.insert(tbl4, activeChanged:Connect(function()
                if tbl3[arg4] == arg4.Active then
                    tbl3[arg4] = nil
                    return
                end
                tbl1[arg4] = arg4.Active
                if not bool1 and arg4.Active then
                    writeLocked(arg4)
                end
            end))

            local tbl5 = tbl2
            local interactableChanged = arg4:GetPropertyChangedSignal("Interactable")

            table.insert(tbl5, interactableChanged:Connect(function()
                tbl1[arg4] = arg4.Interactable
            end))

            writeLocked(arg4)
        end

        local parent = if arg3 == nil or arg3.Parent == arg1 then nil else arg3.Parent

        if arg1 ~= nil then
            if arg1:IsA("GuiButton") then
                suppress(arg1)
            end
            for _, descendant in arg1:GetDescendants() do
                if descendant:IsA("GuiButton") and descendant ~= parent then
                    suppress(descendant)
                end
            end

            local descendantAdded = arg1.DescendantAdded

            table.insert(tbl2, descendantAdded:Connect(function(descendant: Instance)
                if descendant:IsA("GuiButton") and descendant ~= parent then
                    suppress(descendant)
                end
            end))
        end

        if arg2 ~= nil and arg2:IsA("GuiButton") then
            suppress(arg2)
        end

        local scrollingEnabled = if arg3 == nil then nil else arg3.ScrollingEnabled

        if arg3 ~= nil then
            arg3.ScrollingEnabled = false
        end

        return function()
            bool1 = true
            for _, value in tbl2 do
                value:Disconnect()
            end
            for value, active in tbl1 do
                if value.Parent ~= nil then
                    value.Active = active
                end
            end
            table.clear(tbl1)
            if arg3 ~= nil and arg3.Parent ~= nil and scrollingEnabled ~= nil then
                arg3.ScrollingEnabled = scrollingEnabled
            end
        end
    end
}
