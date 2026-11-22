-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SiteMessageStoreParent = script:FindFirstAncestor("SiteMessageStore").Parent
local Signals = require(SiteMessageStoreParent.Signals)
local SignalsExperimental = require(SiteMessageStoreParent.SignalsExperimental)
local SignalsUtils = require(SiteMessageStoreParent.SignalsUtils)

return Signals.createComputed(function()
    local getText, var2 = SignalsUtils.createSessionScopedSignal(nil)
    local getLink, var4 = SignalsUtils.createSessionScopedSignal(nil)
    local getTimestamp, var6 = SignalsUtils.createSessionScopedSignal(nil)
    local getUpdateRequested, var8 = SignalsUtils.createSessionScopedSignal(false)

    return {
        getText = getText,
        getLink = getLink,
        getTimestamp = getTimestamp,
        getUpdateRequested = getUpdateRequested,
        processSiteAlertInfoPayload = function(tbl1)
            SignalsExperimental.batch(function()
                var2(tbl1.visible and tbl1.text or nil)
                var4(tbl1.visible and tbl1.link or nil)
                var6(tbl1.timestamp or nil)
                var8(false)
            end)
        end,
        refreshSiteAlertInfo = function(bool1: boolean?)
            if bool1 == nil then
                bool1 = true
            end

            var8(bool1)
        end,
        reset = function()
            SignalsExperimental.batch(function()
                var2(nil)
                var4(nil)
                var6(nil)
                var8(false)
            end)
        end
    }
end)
