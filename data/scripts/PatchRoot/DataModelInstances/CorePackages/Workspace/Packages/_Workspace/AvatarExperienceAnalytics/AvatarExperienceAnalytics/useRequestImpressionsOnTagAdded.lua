-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local React = require(AvatarExperienceAnalyticsParent.React)
local RobloxAppEnums = require(AvatarExperienceAnalyticsParent.RobloxAppEnums)
local AvatarScreen = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.AvatarScreen
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventPageStore = require(script.Parent.Store.UnifiedEventPageStore)

local tbl1 = {
    [RobloxAppEnums.AppPage.AvatarExperienceWrapper] = true,
    [RobloxAppEnums.AppPage.AvatarExperienceWrapperTransparent] = true,
    [RobloxAppEnums.SwitchTab.AvatarExperienceTab] = true
}
for _, value in AvatarScreen do
    tbl1[value] = true
end

local function isAppOnOtherPage(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local navigationPage = UnifiedEventPageStore.getPageFields().navigationPage
    return not (navigationPage == UnifiedEventPageStore.UNKNOWN) and not tbl1[navigationPage]
end

local function useRequestImpressionsOnTagAdded(tbl2, arg1)
    React.useEffect(function()
        local var1 = nil
        local connection = CollectionService:GetInstanceAddedSignal(UnifiedEventLogConstants.TAG_NAME):Connect(function(arg2)
            local current = tbl2.current
            if var1 or not (current and arg2:IsDescendantOf(current)) then
                return
            end

            var1 = task.delay(0, function()
                var1 = nil

                if isAppOnOtherPage() then
                    return
                end
                arg1:fire()
            end)
        end)

        return function()
            connection:Disconnect()
            if var1 then
                task.cancel(var1)
            end
        end
    end, { tbl2, arg1 })
end

return useRequestImpressionsOnTagAdded
