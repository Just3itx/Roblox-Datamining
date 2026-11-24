-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CoreGui = game:GetService("CoreGui")

local Constants = require(scriptParentParent.Constants)
local bool1 = game:DefineFastFlag("CapturesRecursiveCoreUIRemoval", false)

return function()
    local tbl1 = {}

    local function shouldRemoveUI(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        return if arg1:IsA("LayerCollector") then not arg1:IsA("BillboardGui") and (if arg1.Enabled then arg1.Name ~= Constants.OverlayName else false) else false
    end

    if bool1 then
        local function searchInstance(arg1)
            if not (arg1:IsA("Folder") or arg1:IsA("CoreGui")) then
                if shouldRemoveUI(arg1) then
                    arg1.Enabled = false
                    table.insert(tbl1, arg1)
                end
                return
            end

            for _, child in arg1:GetChildren() do
                searchInstance(child)
            end
        end

        searchInstance(CoreGui)
    else
        for _, child in CoreGui:GetChildren() do
            if child:IsA("Folder") then
                for _, child2 in child:GetChildren() do
                    if shouldRemoveUI(child2) then
                        child2.Enabled = false
                        table.insert(tbl1, child2)
                    end
                end
            end

            if shouldRemoveUI(child) then
                child.Enabled = false
                table.insert(tbl1, child)
            end
        end
    end

    local function restoreCoreUI()
        for _, value in tbl1 do
            value.Enabled = true
        end
    end

    return restoreCoreUI
end
