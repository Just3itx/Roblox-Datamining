-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local Signals = require(CollectionViewsParent.Signals)

local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)
local CollectionLayoutStoreContext = require(script.Parent.CollectionLayoutStoreContext)
local createCollectionLayoutStore = require(script.Parent.createCollectionLayoutStore)
local getMainCollectionLayoutStore = require(script.Parent.getMainCollectionLayoutStore)

local function CollectionLayoutStoreProvider(tbl1)
    local var1, var2 = React.useMemo(function()
        return Signals.createSignal(0)
    end, {})

    React.useEffect(function()
        local container = tbl1.container
        if not container then
            return
        end

        var2(container.AbsoluteSize.X)
        local connection = container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var2(container.AbsoluteSize.X)
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl1.container })

    local value = React.useMemo(function()
        return createCollectionLayoutStore(var1, getMainCollectionLayoutStore(false))
    end, { var1 })

    return React.createElement(CollectionLayoutStoreContext.Provider, { value = value }, tbl1.children)
end

return CollectionLayoutStoreProvider
