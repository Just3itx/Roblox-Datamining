-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getToolAsset(arg1, arg2)
    return arg1.loadAssetForEquip(arg2):andThen(function(arg3)
        if arg3:IsA("Tool") then
            return arg3
        end
        local children = arg3:GetChildren()
        for _, child in ipairs(children) do
            if child:IsA("Tool") then
                return child
            end
        end
    end):catch(function(_)
        return nil
    end)
end

return getToolAsset
