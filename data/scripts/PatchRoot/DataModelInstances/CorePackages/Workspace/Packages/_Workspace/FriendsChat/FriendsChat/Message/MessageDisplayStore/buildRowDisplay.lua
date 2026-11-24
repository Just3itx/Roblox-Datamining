-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local ChatUIPrimitives = require(FriendsChatParent.ChatUIPrimitives)
local computeNameColor = ChatUIPrimitives.Utils.computeNameColor
local formatInlineIcon = ChatUIPrimitives.Utils.formatInlineIcon
local escapeRichText = ChatUIPrimitives.Utils.escapeRichText

local NameInfo = require(script.Parent.NameInfo)
local _classifyMessage = require(script.Parent.classifyMessage)
local rowCopy = require(script.Parent.rowCopy)
local _useLocalize = require(script.Parent.Parent.Parent.Utils.useLocalize)

local white = Color3.fromRGB(255, 255, 255)

local function ceilToEven(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = math.ceil(num1)
    if num2 % 2 == 1 then
        num2 += 1
    end
    return math.max(0, num2)
end

local function getSystemIconAttributes(systemTextSize: number?)
    if systemTextSize == nil then
        return { weight = "600" }
    end
    return {
        weight = "600",
        size = tostring((ceilToEven(systemTextSize * 3 / 4)))
    }
end

local function makeSystemRow(tbl1)
    local var1 = escapeRichText(tbl1.content)
    if tbl1.icon ~= nil then
        var1 = `{formatInlineIcon(tbl1.icon, (getSystemIconAttributes(tbl1.systemTextSize)))} {var1}`
    end
    return {
        content = var1,
        skeletonWidth = tbl1.skeletonWidth or "none",
        displayStyle = "system"
    }
end

local function buildReplyHeader(tbl1, tbl2, tbl3)
    local content = rowCopy.replyLabelText({
        senderUserId = tbl1.senderUserId,
        repliedToUserId = tbl1.repliedToUserId,
        localUserId = tbl2.localUserId,
        isGroup = tbl2.isGroup == true,
        namesByUserId = tbl2.namesByUserId or {},
        localize = tbl3.localize
    })
    if content == nil then
        return (makeSystemRow({ content = "", skeletonWidth = "full" }))
    end
    local systemTextSize = tbl3.systemTextSize
    return (makeSystemRow({ content = content, icon = rowCopy.REPLY_ICON, systemTextSize = systemTextSize }))
end

local function buildHiddenUser(arg1, tbl1)
    if NameInfo.isNameLoading(arg1) then
        return (makeSystemRow({ content = "", skeletonWidth = "full" }))
    end

    local localize = tbl1.localize
    local content = rowCopy.hiddenNoticeText(arg1.name, localize)
    return (makeSystemRow({ content = content, icon = rowCopy.HIDDEN_ICON, systemTextSize = tbl1.systemTextSize }))
end

local function buildUserText(tbl1, arg1)
    local var1 = if tbl1.moderated then rowCopy.maskedBody(tbl1) else escapeRichText(tbl1.body)

    if NameInfo.isNameLoading(arg1) then
        return {
            content = `: {var1}`,
            skeletonWidth = "prefix",
            displayStyle = "user"
        }
    end

    local username = arg1.username
    local var2 = if username ~= nil and username ~= "" then computeNameColor(username) else white
    return {
        content = string.format("<font color=\"#%s\">%s</font>: %s", var2:ToHex(), escapeRichText(arg1.name), var1),
        skeletonWidth = "none",
        displayStyle = "user"
    }
end

local function buildRowDisplay(arg1, tbl1, tbl2)
    local localize = tbl2.localize
    local systemTextSize = tbl2.systemTextSize
    local namesByUserId = tbl1.namesByUserId or {}
    if arg1.kind == "systemMessage" then
        return (makeSystemRow({ content = arg1.body, icon = rowCopy.systemIcon(arg1.variant), systemTextSize = systemTextSize }))
    elseif arg1.kind == "moderationNotice" then
        return (makeSystemRow(
            {
                content = rowCopy.moderatedNoticeText(localize),
                icon = rowCopy.MODERATED_ICON,
                systemTextSize = systemTextSize
            }
        ))
    elseif arg1.kind == "hiddenUser" then
        return (buildHiddenUser(namesByUserId[arg1.senderUserId] or {}, tbl2))
    elseif arg1.kind == "replyHeader" then
        return (buildReplyHeader(arg1, tbl1, tbl2))
    end
    return (buildUserText(arg1, namesByUserId[arg1.senderUserId] or {}))
end

return buildRowDisplay
