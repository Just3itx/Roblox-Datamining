-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredAdViewabilityParent = script:FindFirstAncestor("SponsoredAdViewability").Parent

local React = require(SponsoredAdViewabilityParent.React)
local useViewportBounds = require(SponsoredAdViewabilityParent.ViewportUtils).useViewportBounds

local SponsoredAdViewabilityDetector = require(script.Parent.SponsoredAdViewabilityDetector)
local sponsoredAdViewabilityTelemetry = require(script.Parent.sponsoredAdViewabilityTelemetry)

local function useSponsoredAdViewabilityDetector(arg1, current: string?, tbl1)
    local var1 = useViewportBounds()

    local var2 = React.useRef(nil)
    if var2.current == nil then
        var2.current = SponsoredAdViewabilityDetector.new({
            onSessionStart = sponsoredAdViewabilityTelemetry.logSponsoredAdLoad,
            onMilestone = sponsoredAdViewabilityTelemetry.logSponsoredAdViewableImpression,
            onVideoProgress = sponsoredAdViewabilityTelemetry.logSponsoredAdVideoProgress,
            onUnload = sponsoredAdViewabilityTelemetry.logSponsoredAdUnload
        })
    end

    React.useEffect(function()
        local current = var2.current
        if current ~= nil then
            current:setViewportBounds(var1)
        end
    end, { var1 })

    React.useEffect(function()
        local current = var2.current
        if current == nil then
            return
        end

        current:setSurfaceScope(arg1)
        if arg1 ~= nil then
            current:start()

            return function()
                current:reset()
            end
        end
    end, { arg1 })

    React.useEffect(function()
        if tbl1 == nil then
            return
        end
        local current = var2.current
        if current == nil then
            return
        end

        local tbl2 = {
            tbl1.OnHide:Connect(function()
                current:pause()
            end),
            tbl1.OnUnhide:Connect(function()
                current:resume()
            end)
        }
        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { tbl1 })

    local var3 = React.useRef(current)
    React.useEffect(function()
        local current3 = var2.current
        local current2 = var3.current
        var3.current = current
        if current3 ~= nil and current2 ~= nil and current2 ~= current then
            current3:onFeedRefresh()
        end
    end, { current })
end

return useSponsoredAdViewabilityDetector
