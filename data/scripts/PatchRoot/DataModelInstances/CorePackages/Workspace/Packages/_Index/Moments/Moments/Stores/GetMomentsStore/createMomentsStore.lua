-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local HttpService = game:GetService("HttpService")

local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)

local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)

local createSignal = Signals.createSignal

local function createMomentsStore()
    local getMomentsSessionId, var2 = createSignal(HttpService:GenerateGUID(false))
    local getSessionSource, setSessionSource = createSignal("watch_tab")
    local getSessionStartTime, var6 = createSignal(os.clock())

    local function resetSession()
        var2(HttpService:GenerateGUID(false))
        var6(os.clock())
        GetMomentsPreferencesStore(false).setTeleporting(false)
    end

    local getHideDetails, var8 = createSignal(false)

    local getPendingDeletion, var10 = createSignal(nil)

    return {
        getMomentsSessionId = getMomentsSessionId,
        getSessionSource = getSessionSource,
        setSessionSource = setSessionSource,
        getSessionStartTime = getSessionStartTime,
        resetSession = resetSession,
        getHideDetails = getHideDetails,
        toggleFeedDetailVisibility = function()
            if FFlagEnableArgus then
                var8(not getHideDetails(false))
            end
        end,
        getPendingDeletion = getPendingDeletion,
        requestDeletion = function(momentId: string, feedItemId: string?, feedSessionId: string?)
            if not FFlagEnableArgus then
                return
            end

            var10({ momentId = momentId, feedItemId = feedItemId, feedSessionId = feedSessionId })
        end,
        clearPendingDeletion = function()
            var10(nil)
        end
    }
end
return createMomentsStore
