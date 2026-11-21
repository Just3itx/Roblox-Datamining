-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize

local useCollectionLayoutParamsComputed = require(CollectionViews.useCollectionLayoutParamsComputed)

local function useCollectionLayoutConfig(arg1, num1: number?)
    local var1 = useCollectionLayoutParamsComputed(arg1, num1)

    return (React.useMemo(function()
        local result = ({})

        for _, value in CollectionItemSize do
            result[value] = var1(value)
        end

        return result
    end, { var1 }))
end

return useCollectionLayoutConfig
