-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)

local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)

local function getBuilderIconVariant(arg1)
    if not pcall(function()
        return arg1.Text
    end) then
        return nil
    end

    if isBuilderIcon(arg1.Text) then
        if arg1.FontFace.Weight == Enum.FontWeight.Bold then
            return BuilderIcons.IconVariant.Filled
        end

        return BuilderIcons.IconVariant.Regular
    end

    return nil
end

return getBuilderIconVariant
