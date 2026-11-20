-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTopBanner = script:FindFirstAncestor("AppTopBanner")
local AppTopBannerParent = AppTopBanner.Parent

local Signals = require(AppTopBannerParent.Signals)
local SignalsExperimental = require(AppTopBannerParent.SignalsExperimental)
local SignalsUtils = require(AppTopBannerParent.SignalsUtils)

local AppTopBannerType = require(AppTopBanner.Enums.AppTopBannerType)
local Constants = require(AppTopBanner.Constants)

local function defaultOnAppTopBannerClick() end

return function()
    local getIsDisabled, var2 = SignalsUtils.createSessionScopedSignal(true)

    local getExpanded, var4 = SignalsUtils.createSessionScopedSignal(false)

    local getAppTopBannerType, var6 = SignalsUtils.createSessionScopedSignal(AppTopBannerType.None)

    local getAppTopBannerContentProps, var8 = SignalsUtils.createSessionScopedSignal(nil)

    local getAppTopBannerContentHeight, var10 = SignalsUtils.createSessionScopedSignal(0)

    local getOnAppTopBannerClick, var12 = SignalsUtils.createSessionScopedSignal({
        callback = defaultOnAppTopBannerClick
    }, function(arg1, arg2): boolean
        return arg1.callback == arg2.callback
    end)

    local getIsVisible = Signals.createComputed(function(arg1)
        return getExpanded(arg1) and not getIsDisabled(arg1)
    end)

    local function collapseToDefaults() -- Luacid: Inlined by compiler; 2 call sites recovered
        SignalsExperimental.batch(function()
            var4(false)
            var6(AppTopBannerType.None)
            var8(nil)
            var10(0)
            var12({ callback = defaultOnAppTopBannerClick })
        end)
    end

    return {
        getIsDisabled = getIsDisabled,
        getExpanded = getExpanded,
        getAppTopBannerType = getAppTopBannerType,
        getAppTopBannerContentProps = getAppTopBannerContentProps,
        getAppTopBannerContentHeight = getAppTopBannerContentHeight,
        getOnAppTopBannerClick = getOnAppTopBannerClick,
        getIsVisible = getIsVisible,
        setAppTopBanner = function(bool1: boolean?, arg1, arg2, callback: ((...any) -> (...any))?, num1: number?)
            if not bool1 then
                if getExpanded(false) ~= bool1 then
                    collapseToDefaults()
                end

                return
            end

            SignalsExperimental.batch(function()
                var4(bool1)
                if arg1 ~= nil then
                    var6(arg1)
                end
                if arg2 ~= nil then
                    var8(arg2)
                end
                if callback ~= nil then
                    var12({ callback = callback })
                end
                var10(num1 or Constants.CONTENT_HEIGHT)
            end)
        end,
        disableAppTopBanner = function(bool1: boolean)
            if getIsDisabled(false) ~= bool1 then
                var2(bool1)
            end
        end,
        reset = function()
            SignalsExperimental.batch(function()
                var2(true)
                collapseToDefaults()
            end)
        end
    }
end
