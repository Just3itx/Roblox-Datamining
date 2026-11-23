-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local GetBuildPillMenuPortalStore = require(BuildExperience.Stores.GetBuildPillMenuPortalStore)

local View = Foundation.View

return React.memo(function(tbl1) -- name: BuildPillMenuPortalHost
    local buildPillMenuPortalStore = GetBuildPillMenuPortalStore()

    local ref = React.useCallback(function(arg1)
        buildPillMenuPortalStore.setPortalTarget(arg1)
    end, { buildPillMenuPortalStore })

    React.useEffect(function()
        return function()
            buildPillMenuPortalStore.setPortalTarget(nil)
        end
    end, { buildPillMenuPortalStore })

    return React.createElement(View, {
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        ref = ref,
        tag = "auto-xy",
        testId = tbl1.testId or "build-pill-menu-portal-host"
    })
end)
