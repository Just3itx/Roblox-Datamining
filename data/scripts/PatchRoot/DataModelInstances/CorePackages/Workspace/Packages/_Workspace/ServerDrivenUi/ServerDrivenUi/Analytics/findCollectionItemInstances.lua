-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CollectionService = game:GetService("CollectionService")
local ItemIndex = require(ServerDrivenUiParent.Impressions).Constants.ItemIndex

local function findCollectionItemInstances(str1: string?)
    local collectionItemInstances = ({})
    if not str1 then
        return collectionItemInstances
    end
    for _, value in CollectionService:GetTagged(str1) do
        if not value:IsA("GuiObject") then
            continue
        end

        local var1 = value:GetAttribute(ItemIndex)
        if typeof(var1) == "number" then
            collectionItemInstances[var1] = value
        end
    end

    return collectionItemInstances
end

return findCollectionItemInstances
