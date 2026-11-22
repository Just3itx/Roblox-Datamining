-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = dependencies.React
local usePYMKCarouselUserButtons = require(scriptParentParentParent.Components.PYMKUser.usePYMKCarouselUserButtons)
local _DirectRecommendationTypes = require(scriptParentParentParent.Common.DirectRecommendationTypes)

local FFlagLuaAppEnableSduiHomePage = require(scriptParentParentParentParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = require(scriptParentParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps

local EntityType = require(scriptParentParentParentParent.UserList).Enums.EntityType

local function usePrimaryCta(tbl1)
    local var1 = usePYMKCarouselUserButtons({
        userId = tbl1.entityId,
        showToast = tbl1.showToast,
        fireAnalyticsEvent = tbl1.fireAnalyticsEvent,
        absolutePosition = tbl1.absolutePosition,
        contactId = if tbl1.entityType == EntityType.Contact then tbl1.entityId else nil,
        recommendation = if FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage then tbl1.recommendation else nil
    })

    return React.useMemo(function()
        local var2 = var1()[1]

        if not var2 then
            return nil
        end

        return {
            type = var2.buttonType,
            onActivated = var2.onActivated,
            isDisabled = var2.isDisabled,
            isLoading = var2.isLoading,
            icon = nil,
            focusEventName = var2.focusEvent,
            disabledReason = nil
        }
    end, { var1 })
end

return usePrimaryCta
