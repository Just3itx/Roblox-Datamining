-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local MomentStatus = require(DataHydrationParent.MomentsTypes).Enums.MomentStatus

local tbl1 = {
    { placeId = 185655149, universeId = 8357232245 },
    { placeId = 920587237, universeId = 245662005 },
    { placeId = 6516141723, universeId = 2440500276 },
    { placeId = 4924922222, universeId = 1685831367 }
}

local tbl2 = {
    9113446962,
    1062804083,
    10067664364,
    11045762650,
    3358829679,
    2649867028,
    7715672989,
    3617978804,
    10378728341,
    10790642201,
    2539415890
}

local tbl3 = {
    5608386285,
    5608368298,
    5670824523,
    5608370112,
    5608330602,
    5608310319,
    5670809466,
    5608327482,
    5608304953,
    5608281849
}

local tbl4 = {
    8508980527,
    109251559,
    78447821,
    595029580,
    394647606,
    68073547,
    3537138
}
local tbl5 = {
    1848354536,
    5410086218,
    139180277700549,
    139434270800490
}

local tbl6 = {
    "first try, no way",
    "we actually cooked today",
    "had to clip this one",
    "caught it in 4k",
    "POV: the plan finally worked",
    "blink and you'll miss it",
    "best run i've had",
    "ok that was actually clean",
    "10/10 would run it back",
    "real ones were here",
    "the comeback nobody saw coming",
    "saving this forever",
    "certified moment fr",
    "me when it all comes together",
    "took way too many tries",
    "we move regardless",
    "outplayed and not sorry",
    "this one's going in the highlights",
    "trust the process they said",
    "peak gameplay right here"
}

local tbl7 = {
    "rbxasset://textures/ui/Moments/Reactions/thumbs-up-large.png",
    "rbxasset://textures/ui/Moments/Reactions/heart-large.png",
    "rbxasset://textures/ui/Moments/Reactions/laugh-joy-large.png",
    "rbxasset://textures/ui/Moments/Reactions/fire-large.png",
    "rbxasset://textures/ui/Moments/Reactions/crying-large.png",
    "rbxasset://textures/ui/Moments/Reactions/skull-large.png"
}

local function rngFor(num1: number): Random -- Luacid: Inlined by compiler; 1 call site recovered
    return Random.new(num1 * 2654435761 + 2026)
end

local function cycle<T>(tbl8, num1: number): T -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl8[(num1 - 1) % #tbl8 + 1]
end

local function makeMomentFeedItem(num1: number)
    local random = rngFor(num1)

    local num2 = random:NextNumber()
    local bool1 = num1 > 1 and num2 < 0.28
    local description = tbl6[random:NextInteger(1, #tbl6)]

    local tbl8 = tbl1[random:NextInteger(1, #tbl1)]
    local creatorId = tbl2[random:NextInteger(1, #tbl2)]

    local num4 = random:NextNumber()
    local startTime = random:NextInteger(0, 12)
    local music = #tbl5 > 0 and (bool1 or num4 < 0.45) and {
        assetId = cycle(tbl5, num1),
        startTime = startTime
    } or nil

    local stickerOverlays = random:NextNumber() < 0.6
        and {{
            stickerURI = cycle(tbl7, num1),
            position = UDim2.fromScale(random:NextNumber() * 0.6 + 0.2, random:NextNumber() * 0.5 + 0.25),
            stickerSize = random:NextInteger(50, 200),
            rotation = 0,
            scale = 1,
            zIndex = 1
        }}
        or nil

    return {
        kind = "moment",
        moment = {
            assetId = if bool1 then cycle(tbl4, num1) else cycle(tbl3, num1),
            creatorId = creatorId,
            isModerated = false,
            momentId = `mock-moment-{num1}`,
            status = MomentStatus.Public,
            metadata = {
                assetTotalDuration = 10,
                captureType = if bool1 then Enum.CaptureType.Screenshot else Enum.CaptureType.Video,
                description = description,
                placeId = tbl8.placeId,
                universeId = tbl8.universeId,
                edits = { music = music, stickerOverlays = stickerOverlays }
            },
            recommendationMetadata = {
                feedItemId = `mock-item-{num1}`,
                tracingId = `mock-trace-{num1}`,
                configName = "MaximizeJoins",
                locationId = "Trending"
            }
        }
    }
end
return {
    makeMomentFeedItem = makeMomentFeedItem,
    buildMomentFeedItems = function(num1: number, num2: number)
        local momentFeedItems = {}
        for i = 0, num2 - 1 do
            table.insert(momentFeedItems, (makeMomentFeedItem(num1 + i)))
        end
        return momentFeedItems
    end
}
