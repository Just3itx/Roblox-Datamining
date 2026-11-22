-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)

local default = require(MomentsParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local makeFeedActionFields = require(Moments.Analytics.makeFeedActionFields)
local fetchShareLink = require(script.Parent.fetchShareLink)
local GetShareCountsStore = require(Moments.Stores.GetShareCountsStore)
local GetToastStore = require(Moments.Stores.GetToastStore)
local readAppPolicy = require(script.Parent.readAppPolicy)
local FFlagMomentsLinkCopiedOnlyWhenCopied = require(Moments.Flags.FFlagMomentsLinkCopiedOnlyWhenCopied)

local function shareMoment(tbl1)
    local momentId = tbl1.momentId
    local strings = tbl1.strings

    task.spawn(function()
        local function notifyFailure() -- Luacid: Inlined by compiler; 3 call sites recovered
            GetToastStore(false).triggerToast({ title = strings.linkCopyFailed, text = "" })
        end

        if tbl1.feedItemId == nil or tbl1.feedItemId == "" then
            notifyFailure()
            return
        end

        local success, result = pcall(
            fetchShareLink,
            {
                momentId = momentId,
                feedItemId = tbl1.feedItemId,
                description = tbl1.description,
                title = strings.linkPreviewTitle
            }
        )

        if not (success and result) then
            notifyFailure()
            return
        end

        local bool1 = not FFlagMomentsLinkCopiedOnlyWhenCopied and nil

        if not pcall(function()
            local var1 = readAppPolicy()
            if var1 and var1.EnableShareCaptureCTA and var1.EligibleForCapturesFeature then
                default:shareUrl({ url = result, context = "MomentsFeed" })

                return
            end

            default:setClipboardText({ text = result, context = "MomentsFeed" })

            if FFlagMomentsLinkCopiedOnlyWhenCopied then
                bool1 = true
            end
        end) then
            notifyFailure()
            return
        end

        GetShareCountsStore(false).markShared(momentId)

        if tbl1.logAction then
            tbl1.logAction({})
        end

        local feedActionFields = makeFeedActionFields(momentId, tbl1.feedItemId, tbl1.feedSessionId, "share")
        if feedActionFields then
            Analytics.fireAnalyticsEvent(EventNames.FeedShareButtonPressed, feedActionFields)
        end

        if not FFlagMomentsLinkCopiedOnlyWhenCopied or bool1 then
            GetToastStore(false).triggerToast({ title = strings.linkCopied, text = "" })
        end
    end)
end

return shareMoment
