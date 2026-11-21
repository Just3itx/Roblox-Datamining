-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)
local PlainTextTypes = require(script.Parent.ContentKinds.PlainText.PlainTextTypes)
local PresetTypes = require(script.Parent.ContentKinds.Preset.PresetTypes)
local EmojiTypes = require(script.Parent.ContentKinds.Emoji.EmojiTypes)
local SystemTypes = require(script.Parent.ContentKinds.System.SystemTypes)

local var1 = t.array(
    t.union(
        t.strictInterface({ plainText = PlainTextTypes.isValid }),
        t.strictInterface({ preset = PresetTypes.isValid }),
        t.strictInterface({ emoji = EmojiTypes.isValid }),
        t.strictInterface({ system = SystemTypes.isValid })
    )
)

local contents = t.array(
    t.union(
        t.strictInterface({ plainText = PlainTextTypes.isValidDraft }),
        t.strictInterface({ preset = PresetTypes.isValidDraft }),
        t.strictInterface({ emoji = EmojiTypes.isValidDraft })
    )
)

local var3 = t.interface({ userId = t.string, displayName = t.string })

local var4 = t.interface({ contents = contents, repliesToIds = t.optional(t.array(t.string)) })

local var5 = t.interface({
    id = t.string,
    sentAtUnixMilliseconds = t.number,
    author = t.optional(var3),
    contents = function(arg1) -- name: isValidMessageContent
        local var5, var6 = var1(arg1)
        if not var5 then
            return false, var6
        end
        if #arg1 > 1 then
            for _, value in arg1 do
                if value.system ~= nil then
                    return false, "a system content must be the message's only content"
                end
            end
        end
        return true
    end,
    repliesTo = t.optional(
        t.array(
            t.interface({
                id = t.string,
                preview = t.optional(t.interface({ author = t.optional(var3), fallbackText = t.string })),
                label = t.optional(t.string)
            })
        )
    )
})

local delivery = t.strictInterface({
    state = t.literal("sending"),
    attemptedAtUnixMilliseconds = t.number,
    resolvedAtUnixMilliseconds = t.optional(t.number)
})

local var2 = t.strictInterface({
    state = t.literal("failed"),
    attemptedAtUnixMilliseconds = t.number,
    resolvedAtUnixMilliseconds = t.optional(t.number)
})

local payload = t.strictInterface({ kind = t.literal("draft"), draft = var4, author = t.optional(var3) })

local var9 = t.union(
    t.strictInterface({
        direction = t.literal("incoming"),
        stableId = t.string,
        payload = t.strictInterface({ kind = t.literal("message"), message = var5 })
    }),
    t.strictInterface({ direction = t.literal("outgoing"), stableId = t.string, payload = payload, delivery = delivery }),
    t.strictInterface({ direction = t.literal("outgoing"), stableId = t.string, payload = payload, delivery = var2 }),
    t.strictInterface({
        direction = t.literal("outgoing"),
        stableId = t.string,
        payload = t.strictInterface({ kind = t.literal("message"), message = var5 }),
        delivery = t.strictInterface(
            {
                state = t.literal("acknowledged"),
                attemptedAtUnixMilliseconds = t.number,
                resolvedAtUnixMilliseconds = t.number
            }
        )
    })
)
return {
    isValidMessageDraft = var4,
    isValidMessage = var5,
    isValidMessageEnvelope = function(arg1)
        local var10, var11 = var9(arg1)
        if not var10 then
            return false, var11
        elseif arg1.direction == "incoming" and arg1.stableId ~= arg1.payload.message.id then
            return false, "incoming envelope stableId must equal message.id"
        end
        return true
    end
}
