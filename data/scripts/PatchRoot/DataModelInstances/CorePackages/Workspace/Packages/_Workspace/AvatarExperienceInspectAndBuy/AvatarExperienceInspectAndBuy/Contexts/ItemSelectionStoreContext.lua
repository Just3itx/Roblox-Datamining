-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local createItemSelectionStore = require(AvatarExperienceInspectAndBuy.Stores.createItemSelectionStore)

local context = React.createContext(nil)

return {
    Provider = function(tbl1) -- name: ItemSelectionStoreProvider
        local value = React.useMemo(function()
            return createItemSelectionStore()
        end, {})

        return React.createElement(context.Provider, { value = value }, tbl1.children)
    end,
    useItemSelectionStore = function()
        local var1 = React.useContext(context)
        if not var1 then
            error("useItemSelectionStore must be used within an ItemSelectionStoreProvider")
        end
        return var1
    end
}
