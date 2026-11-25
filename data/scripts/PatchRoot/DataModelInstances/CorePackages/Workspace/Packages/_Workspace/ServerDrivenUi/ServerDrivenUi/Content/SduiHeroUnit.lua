-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local Cryo = require(ServerDrivenUiParent.Cryo)
local React = require(ServerDrivenUiParent.React)

local HeroUnitContainer = require(ServerDrivenUiParent.DiscoveryHeroUnit).HeroUnitContainer
local SduiAttributionRow = require(ServerDrivenUiParent.SduiSharedContent).SduiAttributionRow
local SduiTextPill = require(ServerDrivenUi.Content.SduiTextPill)

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

return React.memo(function(tbl1) -- name: SduiHeroUnit
    local children = tbl1.children

    local bottomRowComponent = React.useMemo(function()
        if not tbl1.asset then
            return nil
        end

        return React.createElement(SduiAttributionRow, {
            image = tbl1.asset.image,
            title = tbl1.asset.title,
            subtitle = tbl1.asset.subtitle,
            rightButtonContent = tbl1.ctaButtonComponent,
            sduiContext = tbl1.sduiContext,
            onActivated = tbl1.onActivated
        })
    end, {
        tbl1.asset,
        tbl1.ctaButtonComponent,
        tbl1.sduiContext,
        tbl1.onActivated
    })

    local overlayComponent = React.useMemo(function()
        if tbl1.badgeText then
            return React.createElement(SduiTextPill, { sduiContext = tbl1.sduiContext, text = tbl1.badgeText })
        end

        return nil
    end, { tbl1.badgeText, tbl1.sduiContext })

    local var3 = React.useMemo(function()
        return (Cryo.Dictionary.join(
            {
                bottomRowComponent = bottomRowComponent,
                overlayComponent = overlayComponent,
                sideMargin = tbl1.pageSideMargin
            },
            tbl1
        ))
    end, {
        tbl1,
        bottomRowComponent,
        overlayComponent,
        tbl1.pageSideMargin
    })
    return React.createElement(HeroUnitContainer, var3, children)
end)
