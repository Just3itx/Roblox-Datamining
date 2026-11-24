-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)
local _ExternalContentSharingProtocolTypes = require(script.Parent.ExternalContentSharingProtocolTypes)
local _MessageBus = require(scriptParentParent.MessageBus)

local validateParams = t.strictInterface({ text = t.string, context = t.optional(t.string) })

local var1 = t.strictInterface({ url = t.string, context = t.optional(t.string) })

local var2 = t.strictInterface(
    {
        context = t.optional(t.string),
        image = t.string,
        shareSheetTitle = t.optional(t.string),
        url = t.optional(t.string)
    }
)
local var3 = t.strictInterface(
    {
        context = t.optional(t.string),
        shareSheetTitle = t.optional(t.string),
        url = t.optional(t.string),
        video = t.string
    }
)
local var4 = t.strictInterface({ text = t.string, context = t.optional(t.string) })

local module = {
    EXTERNAL_CONTENT_SHARING_SHARE_TEXT_DESCRIPTOR = {
        mid = MessageBus.getMessageId("ExternalContentSharing", "shareText"),
        validateParams = validateParams
    },
    EXTERNAL_CONTENT_SHARING_SHARE_URL_DESCRIPTOR = {
        mid = MessageBus.getMessageId("ExternalContentSharing", "shareUrl"),
        validateParams = var1
    },
    EXTERNAL_CONTENT_SHARING_SHARE_IMAGE_DESCRIPTOR = {
        mid = MessageBus.getMessageId("ExternalContentSharing", "shareImage"),
        validateParams = var2
    },
    EXTERNAL_CONTENT_SHARING_SHARE_VIDEO_DESCRIPTOR = {
        mid = MessageBus.getMessageId("ExternalContentSharing", "shareVideo"),
        validateParams = var3
    },
    EXTERNAL_CONTENT_SHARING_SET_CLIPBOARD_TEXT_DESCRIPTOR = {
        mid = MessageBus.getMessageId("ExternalContentSharing", "setClipboardText"),
        validateParams = var4
    }
}
module.__index = module

function module.new(messageBus)
    return (setmetatable({ messageBus = messageBus or MessageBus }, module))
end

function module:shareText(arg1)
    self.messageBus.publish(self.EXTERNAL_CONTENT_SHARING_SHARE_TEXT_DESCRIPTOR, arg1)
end

function module:shareUrl(arg1)
    self.messageBus.publish(self.EXTERNAL_CONTENT_SHARING_SHARE_URL_DESCRIPTOR, arg1)
end

function module:shareImage(arg1)
    self.messageBus.publish(self.EXTERNAL_CONTENT_SHARING_SHARE_IMAGE_DESCRIPTOR, arg1)
end

function module:shareVideo(arg1)
    self.messageBus.publish(self.EXTERNAL_CONTENT_SHARING_SHARE_VIDEO_DESCRIPTOR, arg1)
end

function module:setClipboardText(arg1)
    self.messageBus.publish(self.EXTERNAL_CONTENT_SHARING_SET_CLIPBOARD_TEXT_DESCRIPTOR, arg1)
end

module.default = module.new()

return module
