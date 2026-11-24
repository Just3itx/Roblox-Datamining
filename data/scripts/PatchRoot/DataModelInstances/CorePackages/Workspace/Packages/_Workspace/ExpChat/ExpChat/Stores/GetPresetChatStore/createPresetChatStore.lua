-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

return function()
    local getIsEnabled, setIsEnabled = createSignal(false)
    local getIsLoading, setIsLoading = createSignal(true)
    local getIsTrayOpen, setIsTrayOpen = createSignal(false)
    local getCategoryGroups, setCategoryGroups = createSignal({})
    local getSelectedGroupIndex, setSelectedGroupIndex = createSignal(1)
    local getVersion, setVersion = createSignal("")
    local getAccessLevel, setAccessLevel = createSignal("Disabled")
    local getLayoutModeOverride, setLayoutModeOverride = createSignal(nil)
    local getPresetCooldownEndsAt, setPresetCooldownEndsAt = createSignal(nil)
    local getChatWindowBottomY, setChatWindowBottomY = createSignal(0)
    local getPresetClickCounts, setPresetClickCounts = createSignal({})
    local getViewedGroupIds, setViewedGroupIds = createSignal({})

    return {
        getIsEnabled = getIsEnabled,
        getIsLoading = getIsLoading,
        getIsTrayOpen = getIsTrayOpen,
        getCategoryGroups = getCategoryGroups,
        getSelectedGroupIndex = getSelectedGroupIndex,
        getVersion = getVersion,
        getAccessLevel = getAccessLevel,
        getLayoutModeOverride = getLayoutModeOverride,
        getPresetCooldownEndsAt = getPresetCooldownEndsAt,
        getChatWindowBottomY = getChatWindowBottomY,
        getPresetClickCounts = getPresetClickCounts,
        getViewedGroupIds = getViewedGroupIds,
        setIsEnabled = setIsEnabled,
        setIsLoading = setIsLoading,
        setIsTrayOpen = setIsTrayOpen,
        setCategoryGroups = setCategoryGroups,
        setSelectedGroupIndex = setSelectedGroupIndex,
        setVersion = setVersion,
        setAccessLevel = setAccessLevel,
        setLayoutModeOverride = setLayoutModeOverride,
        setPresetCooldownEndsAt = setPresetCooldownEndsAt,
        setChatWindowBottomY = setChatWindowBottomY,
        setPresetClickCounts = setPresetClickCounts,
        incrementPresetClickCount = function(str1: string)
            local var25 = table.clone(getPresetClickCounts(false))
            var25[str1] = if var25[str1] then var25[str1] + 1 else 1
            setPresetClickCounts(var25)
        end,
        setViewedGroupIds = setViewedGroupIds,
        markGroupViewed = function(str1: string)
            if getViewedGroupIds(false)[str1] then
                return
            end
            local var25 = table.clone(getViewedGroupIds(false))
            var25[str1] = true
            setViewedGroupIds(var25)
        end
    }
end
