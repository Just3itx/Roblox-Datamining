-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local Constants = require(script.Parent.Constants)

return {
    AddTag = function(arg1, tag, arg2)
        local current = arg1 and arg1.current or nil
        if not tag or not current then
            return
        end

        if arg2 then
            current:SetAttribute(Constants.ItemIndex, arg2)
            if not CollectionService:HasTag(current, tag) then
                CollectionService:AddTag(current, tag)
            end
        else
            warn("addTag: impression instance not tagged, missing index")
        end
    end,
    RemoveTag = function(arg1, tag, arg2)
        local current = arg1 and arg1.current or nil
        if not tag or not current then
            return
        end

        if arg2 then
            current:SetAttribute(Constants.ItemIndex, nil)
        end
        CollectionService:RemoveTag(current, tag)
    end
}
