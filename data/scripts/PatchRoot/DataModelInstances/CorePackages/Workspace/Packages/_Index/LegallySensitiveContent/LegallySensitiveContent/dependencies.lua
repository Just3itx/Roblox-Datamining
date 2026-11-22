-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

return {
    Localization = require(scriptParentParent.Localization),
    Promise = require(scriptParentParent.Promise),
    UrlBuilder = require(scriptParentParent.UrlBuilder).UrlBuilder,
    UrlBase = require(scriptParentParent.UrlBuilder).UrlBase,
    Fetch = require(scriptParentParent.Fetch),
    Base64 = require(scriptParentParent.AuthCommon).Utils.Base64
}
