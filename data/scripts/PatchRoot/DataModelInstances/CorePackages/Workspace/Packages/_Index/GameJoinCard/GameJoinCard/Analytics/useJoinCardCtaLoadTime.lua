-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)

local GameJoinCardTTI = require(GameJoinCard.Telemetry.GameJoinCardTTI)
local useGameJoinCardAnalytics = require(script.Parent.useGameJoinCardAnalytics)
local FFlagGameJoinCardOptionalActions = require(GameJoinCardParent.SharedFlags).FFlagGameJoinCardOptionalActions
local FFlagGameJoinCardContent = require(GameJoinCardParent.SharedFlags).FFlagGameJoinCardContent

local function useJoinCardCtaLoadTime(tbl1)
    local var1 = React.useRef(tick())
    local var2 = React.useRef(nil)
    local var3 = React.useRef(false)
    local var4 = React.useRef(false)

    local var5 = React.useRef(tbl1.ctaType)
    var5.current = tbl1.ctaType
    local var6 = React.useRef(tbl1.wasCached)
    var6.current = tbl1.wasCached

    React.useEffect(function()
        if (FFlagGameJoinCardOptionalActions or FFlagGameJoinCardContent) and tbl1.isDisabled then
            return
        end
        if not var3.current then
            var3.current = true
            var2.current = GameJoinCardTTI.consumeMobileCardClickStartMs()
        end

        if var4.current or tbl1.isLoading then
            return
        end
        var4.current = true

        local var7 = tick() * 1000
        local var8 = var2.current or var1.current * 1000
        useGameJoinCardAnalytics.logJoinCardCtaLoadTime(
            {
                durationMs = var7 - var8,
                ctaType = var5.current,
                wasCached = var6.current == true
            }
        )
    end, { tbl1.isLoading, if FFlagGameJoinCardOptionalActions or FFlagGameJoinCardContent then tbl1.isDisabled else nil })
end

return useJoinCardCtaLoadTime
