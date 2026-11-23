-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent
local Promise = require(AmpUpsellParent.Promise)

local module = {}

module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.registerURL(_, _: string) end

function module.detectURL(_, _: string) end

function module.isInternalDlicEnabled(_): boolean
    return false
end

function module.createInternalDlic(_, _: string, _: string): string
    return "mock-deeplink-id"
end

function module.detectDeeplinkIntent(_, _: string) end

function module.listenForLuaURLs(_, _: (...any) -> (...any)) end

function module.stopListeningForLuaURLs(_) end

function module.openURL(tbl1, lastOpenedUrl: string)
    tbl1.lastOpenedURL = lastOpenedUrl
    return Promise.resolve(true)
end

function module.isURLRegistered(_, _: string)
    return Promise.resolve(true)
end

return module
