-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Signals = require(script:FindFirstAncestor("ChatUIPrimitives").Parent.Signals)
local PlainTextContentModel = require(script.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PresetContentModel = require(script.Parent.Parent.ContentKinds.Preset.PresetContentModel)
local EmojiContentModel = require(script.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)
local MessageEnvelopeModel = require(script.Parent.Parent.MessageEnvelopeModel)
local MessageModel = require(script.Parent.Parent.MessageModel)
local _Types = require(script.Parent.Parent.Types)

local senderPool = table.freeze({ { userId = "1", displayName = "Roblox" }, { userId = "156", displayName = "Builderman" } })

local function incomingPlainText(text: string) -- Luacid: unused: defined but never referenced
    return { kind = "plainText", text = text }
end

local function incomingPreset(presetId: string, displayText: string) -- Luacid: unused: defined but never referenced
    return { kind = "preset", presetId = presetId, displayText = displayText }
end

local function incomingEmoji(emojiId: string, unicode: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "emoji", emojiId = emojiId, unicode = unicode }
end

local incomingLines = table.freeze({
    "Switching to Bright blue, red team is stacked",
    "Who just bloxxed me off the tower??",
    "12 KOs and still top of the leaderboard, come get me",
    "gg! Sending you a friend request",
    "Where is everyone? The map is empty",
    "/regen the bridge is gone again",
    "Anyone on yellow want to team up?",
    "Got bloxxed by my own rocket lol",
    "Meet at the middle tower, bring a sword",
    "Friend request sent, let's run it back",
    "Changing teams, green has nobody",
    "Who keeps blowing up the house? /regen"
})

local incomingContents = table.freeze({
    {
        kind = "plainText",
        text = incomingLines[1]
    },
    {
        kind = "plainText",
        text = incomingLines[2]
    },
    {
        kind = "plainText",
        text = incomingLines[3]
    },
    {
        kind = "plainText",
        text = incomingLines[4]
    },
    {
        kind = "plainText",
        text = incomingLines[5]
    },
    {
        kind = "plainText",
        text = incomingLines[6]
    },
    {
        kind = "plainText",
        text = incomingLines[7]
    },
    {
        kind = "plainText",
        text = incomingLines[8]
    },
    {
        kind = "plainText",
        text = incomingLines[9]
    },
    {
        kind = "plainText",
        text = incomingLines[10]
    },
    {
        kind = "plainText",
        text = incomingLines[11]
    },
    {
        kind = "plainText",
        text = incomingLines[12]
    },
    { kind = "preset", presetId = "hello", displayText = "Hello" },
    { kind = "preset", presetId = "gg", displayText = "gg" },
    { kind = "emoji", emojiId = "party-popper", unicode = "🎉" }
})

local function acceptedSendOf(arg1)
    local content = arg1.contents[1]
    if content == nil then
        return nil
    end
    local draft = PlainTextContentModel.getDraft(content)
    if draft ~= nil then
        return if draft.text == "" then nil else {
            kind = "plainText",
            text = draft.text
        }
    end
    local draft2 = PresetContentModel.getDraft(content)
    if draft2 ~= nil then
        return if draft2.presetId == "" or draft2.displayText == "" then nil else {
            kind = "preset",
            presetId = draft2.presetId,
            displayText = draft2.displayText
        }
    end
    local draft3 = EmojiContentModel.getDraft(content)

    if draft3 == nil then
        return nil
    end

    if draft3.emojiId == "" or draft3.unicode == "" then
        return nil
    end

    return incomingEmoji(draft3.emojiId, draft3.unicode)
end

return {
    create = function(userId: string, tbl1)
        local tbl2 = { userId = userId, displayName = "You" }

        local random = Random.new()
        local function nextInteger(min: number, max: number) -- Luacid: Inlined by compiler; 8 call sites recovered
            local random2 = if tbl1 then tbl1.random else nil

            if random2 then
                return random2:NextInteger(min, max)
            end
            return random:NextInteger(min, max)
        end
        local function pick(tbl3) -- Luacid: Inlined by compiler; 7 call sites recovered
            return tbl3[nextInteger(1, #tbl3)]
        end

        local getMessageEnvelopes, var5 = Signals.createSignal({})
        local tbl3 = ({})

        local num1 = 0
        local function nowMs() -- Luacid: Inlined by compiler; 6 call sites recovered
            local getNowMs = if tbl1 then tbl1.getNowMs else nil

            if getNowMs then
                return getNowMs()
            end
            return DateTime.now().UnixTimestampMillis
        end

        local function appendEnvelope(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
            local var6 = table.clone(getMessageEnvelopes(false))
            table.insert(var6, arg1)
            var5(var6)
        end

        local function nextTimestamp(): number -- Luacid: Inlined by compiler; 4 call sites recovered
            num1 = math.max(nowMs(), num1 + 1)
            return num1
        end

        local function messageFromText(str1: string, author, sentAtUnixMilliseconds: number?) -- Luacid: unused: defined but never referenced
            return MessageModel.fromPlainText(
                str1,
                {
                    sentAtUnixMilliseconds = sentAtUnixMilliseconds or nextTimestamp(),
                    author = author
                }
            )
        end
        local function messageFromAcceptedSend(tbl4, author, sentAtUnixMilliseconds: number?)
            local tbl5 = {
                sentAtUnixMilliseconds = sentAtUnixMilliseconds or nextTimestamp(),
                author = author
            }
            if tbl4.kind == "preset" then
                return MessageModel.fromPreset(tbl4.presetId, tbl4.displayText, tbl5)
            elseif tbl4.kind == "emoji" then
                return MessageModel.fromEmoji(tbl4.emojiId, tbl4.unicode, tbl5)
            end
            return MessageModel.fromPlainText(tbl4.text, tbl5)
        end

        local function appendMessage(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
            appendEnvelope((MessageEnvelopeModel.incoming(arg1)))
        end

        local author = pick(senderPool)
        appendMessage(
            (MessageModel.fromPlainText(
                "Welcome to Crossroads! Type /regen if someone wrecks the map.",
                {
                    sentAtUnixMilliseconds = nextTimestamp(),
                    author = author
                }
            ))
        )

        local function replaceEnvelope(stableId: string, func1: (...any) -> (...any))
            local var7 = getMessageEnvelopes(false)
            local var8 = table.clone(var7)
            for value, value2 in var7 do
                if value2.stableId == stableId then
                    var8[value] = func1(value2)
                    var5(var8)
                    return
                end
            end
        end

        local function pushIncoming() -- Luacid: Inlined by compiler; 2 call sites recovered
            local var7 = pick(incomingContents)
            local var8 = pick(senderPool)
            appendMessage((messageFromAcceptedSend(var7, var8)))
        end

        return {
            getMessageEnvelopes = getMessageEnvelopes,
            sendMessageDraft = function(arg1)
                local var7 = acceptedSendOf(arg1)
                if var7 == nil then
                    return
                end

                local str1 = HttpService:GenerateGUID(false)
                local num2 = nextTimestamp()
                local deliveryOutcome = if tbl1 then tbl1.deliveryOutcome else nil
                local deliveryDelaySeconds = if tbl1 then tbl1.deliveryDelaySeconds else nil
                appendEnvelope((MessageEnvelopeModel.sending(str1, arg1, tbl2, num2)))

                local var8 = nil
                local function resolveDelivery()
                    tbl3[var8] = nil
                    replaceEnvelope(str1, function(arg2)
                        if arg2.direction ~= "outgoing" or arg2.payload.kind ~= "draft" or arg2.delivery.state ~= "sending" then
                            return arg2
                        end

                        local num3 = math.max(nowMs(), arg2.delivery.attemptedAtUnixMilliseconds)
                        if deliveryOutcome == "fail" then
                            return MessageEnvelopeModel.failed(arg2, num3)
                        end
                        return MessageEnvelopeModel.acknowledged(arg2, messageFromAcceptedSend(var7, tbl2, num2), num3)
                    end)
                end

                if deliveryDelaySeconds ~= nil then
                    var8 = task.delay(deliveryDelaySeconds, resolveDelivery)
                else
                    var8 = task.defer(resolveDelivery)
                end
                tbl3[var8] = true
            end,
            startIncomingTraffic = function()
                local bool1 = false
                local var7 = nil

                local function scheduleNext() -- Luacid: Inlined by compiler; 1 call site recovered
                    var7 = task.delay(2, function()
                        var7 = nil
                        if bool1 then
                            return
                        end

                        pushIncoming()
                        scheduleNext()
                    end)
                end

                scheduleNext()

                return function()
                    bool1 = true
                    if var7 ~= nil then
                        task.cancel(var7)
                        var7 = nil
                    end
                end
            end,
            destroy = function()
                for value in tbl3 do
                    task.cancel(value)
                end
                table.clear(tbl3)
            end
        }
    end,
    incomingIntervalSeconds = 2,
    senderPool = senderPool,
    welcomeText = "Welcome to Crossroads! Type /regen if someone wrecks the map.",
    incomingLines = incomingLines,
    incomingContents = incomingContents
}
