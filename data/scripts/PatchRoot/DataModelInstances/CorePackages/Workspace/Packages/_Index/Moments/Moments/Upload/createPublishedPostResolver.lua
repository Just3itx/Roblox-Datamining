-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local Promise = require(MomentsParent.Promise)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)
local getLocalUserId = require(Moments.Utils.getLocalUserId)
local shouldShowMomentInFeed = require(Moments.Stores.GetMomentsStore.shouldShowMomentInFeed)
local postLifecycleSubscription = require(script.Parent.postLifecycleSubscription)

game:DefineFastInt("MomentsPublishedPostPollIntervalSeconds", 10)
game:DefineFastInt("MomentsPublishedPostMaxPollAttempts", 30)

local var1 = nil
local function getLogger() -- Luacid: Inlined by compiler; 14 call sites recovered
    if var1 == nil then
        var1 = require(MomentsParent.Loggers).Logger:new("Moments.Upload")
    end
    return var1
end

local num1 = 0

local function waitForLifecycleChange(num2: number, num3: number, num4: number, callback: (...any) -> (...any)): boolean
    local function func1() end
    local var2 = nil
    local promise = Promise.new(function(callback2)
        func1 = Signals.createEffect(function(arg1)
            if postLifecycleSubscription.getWakeVersion(arg1, num3) ~= num2 and var2 == nil then
                var2 = task.defer(function()
                    var2 = nil
                    callback2(true)
                end)
            end
        end)
    end)
    local promise2 = Promise.new(function(callback2)
        callback(num4)
        callback2(false)
    end)
    local _, var3 = Promise.race({ promise, promise2 }):await()
    func1()
    if var2 ~= nil then
        task.cancel(var2)
    end
    return var3 == true
end

local function fetchPage(arg1, num2: number, str1: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2, var3 = arg1.getFreshUserMoments(num2, str1):await()
    return if var2 then var3 else nil
end

local function addToSnapshot(tbl1, arg1)
    for _, moment in arg1.moments do
        tbl1.knownMomentIds[moment.momentId] = true
        local feedItemId = moment.recommendationMetadata.feedItemId
        if feedItemId ~= nil then
            tbl1.knownMomentIds[feedItemId] = true
        end
    end
    for _, value in arg1.excludedMomentIds or {} do
        tbl1.knownMomentIds[value] = true
    end
end

local function isKnown(tbl1, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local feedItemId = arg1.recommendationMetadata.feedItemId

    return tbl1.knownMomentIds[arg1.momentId] == true or not (feedItemId == nil) and tbl1.knownMomentIds[feedItemId] == true
end

local function trim(str1: string?) -- Luacid: Inlined by compiler; 5 call sites recovered
    return string.match(str1 or "", "^%s*(.-)%s*$") or ""
end

local function textMatches(str1: string?, str2: string?)
    local var2 = trim(str1)
    local var3 = trim(str2)

    if var2 == var3 then
        return true
    end
    local var4 = utf8.len(var2)
    if var4 == nil or var4 ~= utf8.len(var3) then
        return false
    end
    local tbl1 = {}
    for _, value in utf8.codes(var2) do
        table.insert(tbl1, value)
    end
    local num2 = 0
    for _, value in utf8.codes(var3) do
        num2 += 1
        if value ~= tbl1[num2] and value ~= 35 then
            return false
        end
    end
    return true
end

local function getMusicAssetId(edits) -- Luacid: Inlined by compiler; 4 call sites recovered
    local music = if edits == nil then nil else edits.music

    if music == nil then
        return nil
    end

    return tonumber(music.assetId)
end

local function getOverlayTexts(edits)
    local overlayTexts = {}
    for _, value in (edits == nil or edits.textOverlays == nil) and {} or edits.textOverlays do
        table.insert(overlayTexts, value.text)
    end
    return overlayTexts
end

local function getTextLength(description: string?): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    return (utf8.len((trim(description))))
end

local function overlayTextsMatch(edits, edits2)
    local overlayTexts = getOverlayTexts(edits)
    local overlayTexts2 = getOverlayTexts(edits2)
    if #overlayTexts ~= #overlayTexts2 then
        return false
    end
    for k, overlayText in overlayTexts do
        if not textMatches(overlayText, overlayTexts2[k]) then
            return false
        end
    end
    return true
end

local function isKnownPlace(num2: number?): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return not (num2 == nil) and num2 > 0
end

local function placeMatches(placeId: number?, placeId2: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not isKnownPlace(placeId) or not isKnownPlace(placeId2) or placeId == placeId2
end

local function evaluate(moment, position: number, tbl1)
    local metadata = moment.metadata
    return {
        moment = moment,
        position = position,
        visible = shouldShowMomentInFeed(moment),
        captureType = metadata.captureType == tbl1.captureType,
        caption = textMatches(tbl1.description, metadata.description),
        music = getMusicAssetId(tbl1.edits) == getMusicAssetId(metadata.edits),
        overlays = overlayTextsMatch(tbl1.edits, metadata.edits),
        place = placeMatches(tbl1.placeId, metadata.placeId)
    }
end

local function isMatch(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1.visible and tbl1.captureType and tbl1.caption and tbl1.music and tbl1.overlays and tbl1.place
end

local function findPublishedPost(arg1, tbl1, tbl2)
    local var2 = nil
    local tbl3 = {}
    for k, moment in arg1.moments do
        if isKnown(tbl1, moment) then
            continue
        end

        local tbl4 = evaluate(moment, k, tbl2)
        table.insert(tbl3, tbl4)

        if var2 == nil and isMatch(tbl4) then
            var2 = moment
        end
    end

    return var2, tbl3
end

local function logIds(str1: string, tbl1)
    for i = 1, #tbl1, 6 do
        local num2 = math.min(i + 6 - 1, #tbl1)
        getLogger():debug("event={} from={} ids=[{}]", str1, tostring(i), table.concat(tbl1, ",", i, num2))
    end
end

local function logSnapshotPage(num2: number, num3: number, arg1)
    local var2 = arg1.excludedMomentIds or {}
    getLogger()
    local var3 = var1

    local str1 = tostring(num2)
    local str2 = tostring(num3)
    local str3 = tostring(#arg1.moments)
    local str4 = tostring(#var2)
    local bool1 = arg1.nextCursor ~= nil
    var3:debug(
        "event=published_post_snapshot_page resolverId={} page={} moments={} excluded={} hasNext={}",
        str1,
        str2,
        str3,
        str4,
        tostring(bool1)
    )
    local tbl1 = {}
    for _, moment in arg1.moments do
        table.insert(tbl1, `{moment.momentId}:{moment.assetId}`)
    end
    logIds("published_post_snapshot_moments", tbl1)
    logIds("published_post_snapshot_excluded", var2)
end

local function logExpectation(tbl1)
    local logger = getLogger()
    local captureTypeName = tbl1.captureType.Name
    local str1 = tostring((getTextLength(tbl1.description)))
    local str2 = tostring((getMusicAssetId(tbl1.edits)))
    local str3 = tostring(#getOverlayTexts(tbl1.edits))
    local placeId = tbl1.placeId
    logger:debug(
        "event=published_post_expectation captureType={} captionLength={} musicAssetId={} overlayCount={} placeId={}",
        captureTypeName,
        str1,
        str2,
        str3,
        tostring(placeId)
    )
end

local function logCandidate(num2: number, tbl1)
    local moment = tbl1.moment
    local metadata = moment.metadata
    local logger = getLogger()
    local str1 = tostring(num2)
    local str2 = tostring(tbl1.position)
    local momentId = moment.momentId
    local str3 = tostring(moment.recommendationMetadata.feedItemId)
    local str4 = tostring(moment.assetId)
    local str5 = tostring(moment.status)
    local str6 = tostring((isMatch(tbl1)))
    local str7 = tostring(tbl1.visible)
    local str8 = tostring(tbl1.captureType)
    local str9 = tostring(tbl1.caption)
    local str10 = tostring(tbl1.music)
    local str11 = tostring(tbl1.overlays)
    local str12 = tostring(tbl1.place)
    local captureTypeName = metadata.captureType.Name
    local str13 = tostring((getTextLength(metadata.description)))
    local str14 = tostring((getMusicAssetId(metadata.edits)))
    local str15 = tostring(#getOverlayTexts(metadata.edits))
    local placeId = metadata.placeId
    logger:debug(
        "event=published_post_candidate attempt={} position={} momentId={} feedItemId={} assetId={} status={} matched={} visible={} captureType={} caption={} music={} overlays={} place={} storedCaptureType={} storedCaptionLength={} storedMusicAssetId={} storedOverlayCount={} storedPlaceId={}",
        str1,
        str2,
        momentId,
        str3,
        str4,
        str5,
        str6,
        str7,
        str8,
        str9,
        str10,
        str11,
        str12,
        captureTypeName,
        str13,
        str14,
        str15,
        tostring(placeId)
    )
end

local function createPublishedPostResolver(tbl1, tbl2)
    local tbl3 = tbl2 or {}
    local var2 = if tbl3.userStore ~= nil then tbl3.userStore else MomentsGetMomentsUserStore(false)

    local var3 = tbl3.wait or function(num2: number)
        task.wait(num2)
    end

    local num2 = 0
    local localUserId = nil
    local promise = nil

    local function isCurrent(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return not (num2 == 0) and num2 == num1
    end

    local function takeSnapshot(num3: number): {knownMomentIds: {[any]: any}}?
        local var4 = nil
        for i = 1, 3 do
            if i > 1 then
                var3(2)
            end
            var4 = fetchPage(var2, num3, nil)
            if var4 ~= nil then
                break
            end

            getLogger():debug("event=published_post_snapshot_read_failed resolverId={} attempt={}", tostring(num2), tostring(i))
        end

        if var4 == nil then
            return nil
        end

        local tbl4 = {
            knownMomentIds = {}
        }
        addToSnapshot(tbl4, var4)
        logSnapshotPage(num2, 1, var4)

        local nextCursor = var4.nextCursor
        for i = 2, 3 do
            if nextCursor == nil then
                break
            end

            local var5 = fetchPage(var2, num3, nextCursor)
            if var5 == nil then
                break
            end

            addToSnapshot(tbl4, var5)
            logSnapshotPage(num2, i, var5)

            if var5.nextCursor ~= nextCursor then
                nextCursor = var5.nextCursor
            else
                nextCursor = nil
            end
        end

        return tbl4
    end

    return {
        captureSnapshot = function()
            num1 += 1
            num2 = num1

            if tbl3.getLocalUserId ~= nil then
                localUserId = tbl3.getLocalUserId()
            else
                localUserId = getLocalUserId()
            end

            getLogger():debug(
                "event=published_post_snapshot_started resolverId={} hasUser={}",
                tostring(num2),
                tostring(localUserId ~= nil)
            )
            logExpectation(tbl1)

            local var4 = localUserId
            promise = Promise.new(function(callback: (...any) -> (...any))
                callback(if var4 == nil then nil else takeSnapshot(var4))
            end)
        end,
        resolve = function(momentId: string?)
            if promise == nil then
                getLogger():debug("event=published_post_unresolved reason=no_snapshot_started")
                return nil
            end
            local var4, var5 = promise:await()
            local var6 = localUserId

            if not var4 or var5 == nil or var6 == nil then
                getLogger():debug("event=published_post_unresolved resolverId={} reason=snapshot_unavailable", tostring(num2))

                return nil
            end

            local fastInt = game:GetFastInt("MomentsPublishedPostPollIntervalSeconds")
            local fastInt2 = game:GetFastInt("MomentsPublishedPostMaxPollAttempts")
            getLogger():debug(
                "event=published_post_polling resolverId={} intervalSeconds={} maxAttempts={}",
                tostring(num2),
                tostring(fastInt),
                tostring(fastInt2)
            )
            local var7 = SharedFlags.FFlagMomentsOptimisticProfilePending and momentId ~= nil
            local var8 = if var7 then postLifecycleSubscription.getWakeVersion(false, var6) else 0

            local num3 = os.clock() + fastInt
            local num4 = 0
            local num5 = 0

            while true do
                if not (num4 < fastInt2) then
                    getLogger():debug(
                        "event=published_post_unresolved resolverId={} reason=budget_exhausted attempts={}",
                        tostring(num2),
                        tostring(fastInt2)
                    )
                    return nil
                end

                if var7 then
                    if num5 > 0 then
                        local func1 = waitForLifecycleChange
                        local num6 = num3 - os.clock()

                        if not func1(var8, var6, math.max(0, num6), var3) then
                            num4 += 1
                            num3 = os.clock() + fastInt
                        end
                    end
                    var8 = postLifecycleSubscription.getWakeVersion(false, var6)
                else
                    var3(fastInt)
                    num4 += 1
                end
                num5 += 1

                if not isCurrent() and (not SharedFlags.FFlagMomentsOptimisticProfilePending or momentId == nil) then
                    getLogger():debug(
                        "event=published_post_unresolved resolverId={} reason=superseded attempt={}",
                        tostring(num2),
                        tostring(num5)
                    )
                    return nil
                end
                if SharedFlags.FFlagMomentsOptimisticProfilePending and momentId ~= nil then
                    local bool1 = false
                    for _, value in var2.getPendingUserMoments(false)[var6] or {} do
                        if value.moment.momentId ~= momentId then
                            continue
                        end

                        if value.publishedMoment ~= nil then
                            return value.publishedMoment
                        end

                        bool1 = true
                        break
                    end

                    if not bool1 then
                        return nil
                    end
                end
                local var9 = fetchPage(var2, var6, nil)
                if SharedFlags.FFlagMomentsOptimisticProfilePending and momentId ~= nil and var9 ~= nil then
                    local tbl4 = ({})

                    for _, value in var2.getPendingUserMoments(false)[var6] or {} do
                        local publishedMoment = value.publishedMoment
                        if publishedMoment == nil then
                            continue
                        end

                        tbl4[publishedMoment.momentId] = true
                        local feedItemId = publishedMoment.recommendationMetadata.feedItemId
                        if feedItemId ~= nil and feedItemId ~= "" then
                            tbl4[feedItemId] = true
                        end
                    end

                    local moments = {}
                    for _, moment in var9.moments do
                        local feedItemId = moment.recommendationMetadata.feedItemId
                        if not tbl4[moment.momentId] and (feedItemId == nil or not tbl4[feedItemId]) then
                            table.insert(moments, moment)
                        end
                    end
                    var9 = table.clone(var9)
                    var9.moments = moments
                end
                if var9 == nil then
                    getLogger():debug("event=published_post_poll_read_failed resolverId={} attempt={}", tostring(num2), tostring(num5))
                else
                    local var10, tbl4 = findPublishedPost(var9, var5, tbl1)
                    local var11 = var9.excludedMomentIds or {}
                    local logger = getLogger()
                    local str1 = tostring(num2)
                    local str2 = tostring(num5)
                    local str3 = tostring(#var9.moments)
                    local str4 = tostring(#var11)
                    local num6 = #tbl4
                    logger:debug(
                        "event=published_post_poll resolverId={} attempt={} moments={} excluded={} unknown={}",
                        str1,
                        str2,
                        str3,
                        str4,
                        tostring(num6)
                    )
                    for _, value in tbl4 do
                        logCandidate(num5, value)
                    end
                    if var10 ~= nil then
                        if SharedFlags.FFlagMomentsOptimisticProfilePending
                            and momentId ~= nil
                            and not var2.resolvePendingUserMoment(var6, momentId, var10)
                        then
                            return nil
                        end

                        var2.invalidateUser(var6)
                        local logger2 = getLogger()
                        local str5 = tostring(num2)
                        local str6 = tostring(num5)
                        local momentId2 = var10.momentId
                        local str7 = tostring(var10.recommendationMetadata.feedItemId)
                        local assetId = var10.assetId
                        logger2:debug(
                            "event=published_post_resolved resolverId={} attempt={} momentId={} feedItemId={} assetId={}",
                            str5,
                            str6,
                            momentId2,
                            str7,
                            tostring(assetId)
                        )
                        return var10
                    end
                end
            end
        end,
        isCurrent = isCurrent
    }
end

return createPublishedPostResolver
