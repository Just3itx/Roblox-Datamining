-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum

local FIntAXLookImpressionDeferTimeoutMs = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FIntAXLookImpressionDeferTimeoutMs

local useStore = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useStore

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)
local selectHydratedLookType = require(AvatarExperienceCatalog.State.Selectors.selectHydratedLookType)

local function useDeferLooksWithoutHydrationFilter(arg1)
    local var1 = useStore()
    local content = if arg1 then arg1.content else nil
    local var2 = React.useRef(false)

    React.useEffect(function()
        var2.current = false

        local num1 = math.max(0, FIntAXLookImpressionDeferTimeoutMs) / 1000
        local var3 = task.delay(num1, function()
            var2.current = true
        end)

        return function()
            task.cancel(var3)
        end
    end, {})

    return React.useCallback(function(num1: number): boolean
        if var2.current then
            return true
        end

        local var3 = content and content[num1] or nil
        if var3 == nil then
            return true
        end

        if var3.type ~= ItemTypeEnum.Look then
            return true
        end

        local id = var3.id
        return id == nil or selectHydratedLookType(var1:getState(), tostring(id)) ~= nil
    end, { content, var1 })
end

return useDeferLooksWithoutHydrationFilter
