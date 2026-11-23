-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Motion = require(BuildExperienceParent.Motion)
local React = require(BuildExperienceParent.React)

local FIntBuildExperienceHomeTabsSlideMilliseconds = require(BuildExperience.Flags.FIntBuildExperienceHomeTabsSlideMilliseconds)

local function useBuildHomeTabsPageLayout(tbl1)
    local num1 = math.max(0, FIntBuildExperienceHomeTabsSlideMilliseconds) / 1000

    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion

    local tabOrder = React.useMemo(function()
        local result = {}
        for k, tab in tbl1.tabs do
            local id = tab.id
            result[tostring(id)] = k - 1
        end
        return result
    end, { tbl1.tabs })

    local page = tabOrder[tbl1.activeTab] or 0
    local var3, var4 = Motion.useMotion({ page = page })

    local var5 = React.useRef(tbl1.showTabs)
    local showTabs = tbl1.showTabs
    React.useLayoutEffect(function()
        local var6 = showTabs and var5.current and not reducedMotion
        var5.current = showTabs
        var4(
            Motion.createState(
                { page = page },
                {
                    default = Motion.transition({ duration = if var6 then num1 else 0, easingStyle = Enum.EasingStyle.Quad })
                }
            )
        )
    end, {
        page,
        var4,
        reducedMotion,
        showTabs,
        num1
    })
    return {
        pageOffset = var3.page,
        tabOrder = tabOrder
    }
end

return useBuildHomeTabsPageLayout
