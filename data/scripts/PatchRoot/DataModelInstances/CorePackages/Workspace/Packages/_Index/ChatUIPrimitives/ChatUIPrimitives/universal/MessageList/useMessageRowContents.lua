-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Types)
local getReplyPreview = require(script.Parent.Reply.getReplyPreview)
local _groupMessages = require(script.Parent.groupMessages)
local unpackContent = require(script.Parent.Parent.ContentKinds.unpackContent)

local function contentKindsKey(arg1): string
    local tbl1 = {}
    for _, content in arg1.message.contents do
        local var1 = unpackContent(content)
        if var1 ~= nil then
            table.insert(tbl1, var1)
        end
    end
    return table.concat(tbl1, ",")
end

local function useMessageRowContents(arg1)
    local getIdentity = React.useMemo(function()
        return function(arg2)
            local author = arg1(arg2).message.author

            if author == nil then
                return nil
            end

            return {
                userId = author.userId,
                displayName = author.displayName,
                isRobloxVerified = false,
                avatarContent = `rbxthumb://type=AvatarHeadShot&id={author.userId}&w=150&h=150`
            }
        end
    end, { arg1 })

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg2): string
            return contentKindsKey(arg1(arg2))
        end)
    end, { arg1 })
    local kindsKey = SignalsReact.useSignalState(var2)

    local contents = React.useMemo(function()
        local result = {}

        for k, content in arg1(false).message.contents do
            local kind = unpackContent(content)
            if kind == nil then
                continue
            end

            table.insert(result, {
                kind = kind,
                getContent = function(arg2)
                    local content2 = arg1(arg2).message.contents[k]
                    return if unpackContent(content2) == kind then content2 else content
                end
            })
        end

        return result
    end, { arg1, kindsKey })

    local var5 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            return getReplyPreview.getReplyText(arg1(arg2).message)
        end)
    end, { arg1 })
    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            return getReplyPreview.getReplyLabel(arg1(arg2).message)
        end)
    end, { arg1 })

    return {
        getIdentity = getIdentity,
        contents = contents,
        kindsKey = kindsKey,
        replyText = SignalsReact.useSignalState(var5),
        replyLabel = SignalsReact.useSignalState(var6)
    }
end

return useMessageRowContents
