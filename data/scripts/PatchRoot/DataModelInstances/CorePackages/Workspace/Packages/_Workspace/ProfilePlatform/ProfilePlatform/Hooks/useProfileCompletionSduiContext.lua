-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Signals = require(ProfilePlatformParent.Signals)
local Foundation = require(ProfilePlatformParent.Foundation)
local SduiCoreSystem = require(ProfilePlatformParent.SduiCoreSystem)
local calculateItemWidth = require(ProfilePlatformParent.CollectionViews).calculateItemWidth
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local useTokens = Foundation.Hooks.useTokens

local getSduiServiceDependenciesStore = SduiCoreSystem.getSduiServiceDependenciesStore

local function computePeekFraction(num1: number, num2: number, num3: number, num4: number, num5: number): number -- Luacid: unused: defined but never referenced
    local num6 = num5 - num4
    if num6 <= 0 then
        return 0
    end
    local num7 = num1 - num2 - (num3 - 1) * num4 - num5
    if num7 <= 0 then
        return 0
    end
    return math.clamp(num3 * num6 / num7, 0, 0.5)
end

local function useProfileCompletionSduiContext(tbl1)
    local var1 = useTokens()
    local medium = var1.Gap.Medium
    local size1500 = var1.Size.Size_1500

    local fractionalItemAmount = React.useMemo(function(): number
        local containerWidth = tbl1.containerWidth
        local sideMargin = tbl1.sideMargin
        local var2 = medium
        local var3 = size1500
        local var4 = var3 - var2
        if var4 <= 0 then
            return 0
        end
        local var5 = containerWidth - sideMargin - var2 * 0 - var3
        if var5 <= 0 then
            return 0
        end
        return math.clamp(var4 * 1 / var5, 0, 0.5)
    end, {
        tbl1.containerWidth,
        tbl1.sideMargin,
        medium,
        size1500
    })
    local itemWidth = React.useMemo(function()
        return calculateItemWidth(1, medium, tbl1.sideMargin, tbl1.containerWidth, fractionalItemAmount)
    end, {
        medium,
        tbl1.sideMargin,
        tbl1.containerWidth,
        fractionalItemAmount
    })
    local var4, var5 = React.useMemo(function()
        return Signals.createSignal({
            numColumns = 1,
            fractionalItemAmount = fractionalItemAmount,
            columnGap = medium,
            sideMargin = tbl1.sideMargin,
            verticalPadding = 0,
            itemWidth = itemWidth
        })
    end, {})

    React.useEffect(function()
        var5({
            numColumns = 1,
            fractionalItemAmount = fractionalItemAmount,
            columnGap = medium,
            sideMargin = tbl1.sideMargin,
            verticalPadding = 0,
            itemWidth = itemWidth
        })
    end, {
        fractionalItemAmount,
        medium,
        tbl1.sideMargin,
        itemWidth,
        var5
    })
    local getPageLayoutConfig = React.useCallback(function(_)
        return Signals.createComputed(function(arg1)
            return var4(arg1)
        end)
    end, { var4 })

    local profilePlatform = AppPage.ProfilePlatform
    return (React.useMemo(function()
        return {
            dependencies = getSduiServiceDependenciesStore().getDependencies(profilePlatform),
            appPage = profilePlatform,
            getPageLayoutConfig = getPageLayoutConfig
        }
    end, { profilePlatform, getPageLayoutConfig }))
end

return useProfileCompletionSduiContext
